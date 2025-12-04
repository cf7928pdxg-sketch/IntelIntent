<#
.SYNOPSIS
    Circuit breaker pattern implementation for resilience and fault tolerance.

.DESCRIPTION
    Implements circuit breaker pattern with:
    - Exponential backoff retry logic
    - Three states: Closed, Open, HalfOpen
    - Configurable thresholds and timeouts
    - Fallback handlers for graceful degradation
    - Service-specific circuit tracking

.NOTES
    Module:         CircuitBreaker.psm1
    Author:         IntelIntent Orchestration Team
    Created:        2025-11-29
    Phase:          Phase 4 - Production Hardening
    Pattern:        Circuit Breaker (Resilience Pattern)

.EXAMPLE
    Import-Module .\IntelIntent_Seeding\CircuitBreaker.psm1

    Set-CircuitBreakerConfig -ServiceName "MicrosoftGraph" -Config @{
        MaxRetries = 3
        TimeoutSeconds = 10
        BackoffMultiplier = 2
        FailureThreshold = 5
    }

    $result = Invoke-WithCircuitBreaker -ServiceName "MicrosoftGraph" -ScriptBlock {
        Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/users"
    } -FallbackScriptBlock {
        Write-Warning "Using cached data"
        Get-Content .\cache\users.json | ConvertFrom-Json
    }
#>

# === Module State ===
$script:CircuitBreakerState = @{}
$script:SessionID = (New-Guid).ToString()
$script:CallHistory = @()

# === Circuit Breaker States ===
enum CircuitState {
    Closed    # Normal operation, requests allowed
    Open      # Failure threshold exceeded, requests blocked
    HalfOpen  # Testing if service recovered
}

# === Core Functions ===

function Set-CircuitBreakerConfig {
    <#
    .SYNOPSIS
        Configures circuit breaker for a service.

    .DESCRIPTION
        Initializes or updates circuit breaker configuration for external service.
        Must be called before using Invoke-WithCircuitBreaker for that service.

    .PARAMETER ServiceName
        Unique service identifier (e.g., "MicrosoftGraph", "AzureOpenAI", "PowerBI").

    .PARAMETER Config
        Configuration hashtable with optional keys:
        - MaxRetries: Number of retry attempts (default: 3)
        - TimeoutSeconds: Request timeout (default: 10)
        - BackoffMultiplier: Exponential backoff multiplier (default: 2)
        - FailureThreshold: Failures before opening circuit (default: 5)
        - ResetTimeoutSeconds: Time before attempting HalfOpen (default: 60)
        - SuccessThreshold: Successes to close circuit from HalfOpen (default: 2)

    .EXAMPLE
        Set-CircuitBreakerConfig -ServiceName "MicrosoftGraph" -Config @{
            MaxRetries = 3
            TimeoutSeconds = 10
            BackoffMultiplier = 2
            FailureThreshold = 5
            ResetTimeoutSeconds = 60
        }

    .EXAMPLE
        # Quick config with defaults
        Set-CircuitBreakerConfig -ServiceName "AzureSQL" -Config @{}
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ServiceName,

        [Parameter(Mandatory=$true)]
        [hashtable]$Config
    )

    $script:CircuitBreakerState[$ServiceName] = @{
        # Configuration
        MaxRetries = $Config.MaxRetries ?? 3
        TimeoutSeconds = $Config.TimeoutSeconds ?? 10
        BackoffMultiplier = $Config.BackoffMultiplier ?? 2
        FailureThreshold = $Config.FailureThreshold ?? 5
        ResetTimeoutSeconds = $Config.ResetTimeoutSeconds ?? 60
        SuccessThreshold = $Config.SuccessThreshold ?? 2

        # Runtime state
        State = [CircuitState]::Closed
        FailureCount = 0
        SuccessCount = 0
        LastFailureTime = $null
        LastSuccessTime = $null
        StateChangedAt = Get-Date

        # Metrics
        TotalCalls = 0
        TotalFailures = 0
        TotalSuccesses = 0
        TotalFastFails = 0  # Requests blocked by open circuit
    }

    Write-Verbose "Circuit breaker configured for $ServiceName"
}

function Invoke-WithCircuitBreaker {
    <#
    .SYNOPSIS
        Executes script block with circuit breaker protection.

    .DESCRIPTION
        Wraps external service calls with:
        - Automatic retry with exponential backoff
        - Circuit breaker state management
        - Fallback execution on failure
        - Detailed error tracking

    .PARAMETER ServiceName
        Service name (must be configured via Set-CircuitBreakerConfig).

    .PARAMETER ScriptBlock
        Code to execute with protection.

    .PARAMETER FallbackScriptBlock
        Optional fallback code if all retries fail or circuit is open.

    .PARAMETER OperationName
        Optional operation descriptor for logging.

    .EXAMPLE
        Invoke-WithCircuitBreaker -ServiceName "MicrosoftGraph" -ScriptBlock {
            Invoke-MgGraphRequest -Uri "https://graph.microsoft.com/v1.0/users" -Method GET
        }

    .EXAMPLE
        $users = Invoke-WithCircuitBreaker -ServiceName "GraphAPI" -ScriptBlock {
            Get-MgUser -Top 10
        } -FallbackScriptBlock {
            Write-Warning "Using cached user data"
            Get-Content .\cache\users.json | ConvertFrom-Json
        } -OperationName "FetchUsers"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ServiceName,

        [Parameter(Mandatory=$true)]
        [scriptblock]$ScriptBlock,

        [scriptblock]$FallbackScriptBlock,

        [string]$OperationName = "Operation"
    )

    # Validate configuration exists
    if (-not $script:CircuitBreakerState.ContainsKey($ServiceName)) {
        throw "Circuit breaker not configured for service: $ServiceName. Call Set-CircuitBreakerConfig first."
    }

    $config = $script:CircuitBreakerState[$ServiceName]
    $config.TotalCalls++

    $startTime = Get-Date

    # === Check Circuit State ===
    switch ($config.State) {
        'Open' {
            # Circuit is open - check if ready for HalfOpen
            $timeSinceFailure = (Get-Date) - $config.LastFailureTime

            if ($timeSinceFailure.TotalSeconds -lt $config.ResetTimeoutSeconds) {
                # Still in timeout period - fail fast
                $config.TotalFastFails++

                Write-Warning "⚡ Circuit breaker OPEN for $ServiceName - failing fast (timeout: $($config.ResetTimeoutSeconds)s)"

                # Log fast fail
                Add-CircuitBreakerLog -ServiceName $ServiceName -Operation $OperationName -Result "FastFail" -Duration 0

                if ($FallbackScriptBlock) {
                    Write-Host "  🔄 Executing fallback handler..." -ForegroundColor Cyan
                    return & $FallbackScriptBlock
                }

                throw "Circuit breaker open for $ServiceName - service unavailable"
            }
            else {
                # Timeout expired - enter HalfOpen state
                $config.State = [CircuitState]::HalfOpen
                $config.StateChangedAt = Get-Date
                $config.SuccessCount = 0

                Write-Host "🔶 Circuit breaker entering HALF-OPEN state for $ServiceName" -ForegroundColor Yellow
            }
        }

        'HalfOpen' {
            Write-Verbose "Circuit in HALF-OPEN state - testing service recovery"
        }

        'Closed' {
            Write-Verbose "Circuit CLOSED - normal operation"
        }
    }

    # === Retry Loop ===
    for ($attempt = 1; $attempt -le $config.MaxRetries; $attempt++) {
        try {
            Write-Verbose "Attempt $attempt/$($config.MaxRetries) for $ServiceName"

            # Execute with timeout
            $job = Start-Job -ScriptBlock $ScriptBlock
            $completed = Wait-Job -Job $job -Timeout $config.TimeoutSeconds

            if (-not $completed) {
                # Timeout occurred
                Stop-Job -Job $job
                Remove-Job -Job $job -Force
                throw "Operation timed out after $($config.TimeoutSeconds) seconds"
            }

            # Get result
            $result = Receive-Job -Job $job -ErrorAction Stop
            Remove-Job -Job $job -Force

            # === Success Path ===
            $config.FailureCount = 0
            $config.SuccessCount++
            $config.TotalSuccesses++
            $config.LastSuccessTime = Get-Date

            # Update circuit state based on current state
            switch ($config.State) {
                'HalfOpen' {
                    if ($config.SuccessCount -ge $config.SuccessThreshold) {
                        # Enough successes - close circuit
                        $config.State = [CircuitState]::Closed
                        $config.StateChangedAt = Get-Date
                        Write-Host "  ✅ Circuit breaker CLOSED for $ServiceName (service recovered)" -ForegroundColor Green
                    }
                }
                'Closed' {
                    Write-Verbose "Success in closed state"
                }
            }

            # Log success
            $duration = ((Get-Date) - $startTime).TotalSeconds
            Add-CircuitBreakerLog -ServiceName $ServiceName -Operation $OperationName -Result "Success" -Duration $duration -Attempt $attempt

            return $result
        }
        catch {
            $config.FailureCount++
            $config.TotalFailures++
            $config.LastFailureTime = Get-Date
            $errorMessage = $_.Exception.Message

            Write-Warning "⚠️ Attempt $attempt failed for $ServiceName : $errorMessage"

            # Check if threshold exceeded
            if ($config.FailureCount -ge $config.FailureThreshold) {
                # Open circuit
                $config.State = [CircuitState]::Open
                $config.StateChangedAt = Get-Date

                Write-Error "🔴 Circuit breaker OPEN for $ServiceName (threshold: $($config.FailureThreshold) failures)"

                # Log circuit open
                $duration = ((Get-Date) - $startTime).TotalSeconds
                Add-CircuitBreakerLog -ServiceName $ServiceName -Operation $OperationName -Result "CircuitOpened" -Duration $duration -Error $errorMessage

                # Execute fallback
                if ($FallbackScriptBlock) {
                    Write-Host "  🔄 Executing fallback handler..." -ForegroundColor Cyan
                    return & $FallbackScriptBlock
                }

                throw "Circuit breaker open for $ServiceName - all retries exhausted"
            }

            # Retry with backoff (if not last attempt)
            if ($attempt -lt $config.MaxRetries) {
                $backoffSeconds = [Math]::Pow($config.BackoffMultiplier, $attempt - 1)
                Write-Host "  ⏳ Retrying in $backoffSeconds seconds..." -ForegroundColor Yellow
                Start-Sleep -Seconds $backoffSeconds
            }
        }
    }

    # === All Retries Failed ===
    $duration = ((Get-Date) - $startTime).TotalSeconds
    Add-CircuitBreakerLog -ServiceName $ServiceName -Operation $OperationName -Result "AllRetriesFailed" -Duration $duration

    Write-Error "❌ All retries exhausted for $ServiceName after $($config.MaxRetries) attempts"

    if ($FallbackScriptBlock) {
        Write-Host "  🔄 Executing fallback handler..." -ForegroundColor Cyan
        return & $FallbackScriptBlock
    }

    throw "All retries exhausted for $ServiceName"
}

function Get-CircuitBreakerStatus {
    <#
    .SYNOPSIS
        Returns current circuit breaker state for all or specific services.

    .DESCRIPTION
        Retrieves circuit state, metrics, and configuration for monitoring.

    .PARAMETER ServiceName
        Optional service name. Returns all services if omitted.

    .EXAMPLE
        Get-CircuitBreakerStatus

    .EXAMPLE
        Get-CircuitBreakerStatus -ServiceName "MicrosoftGraph"
    #>
    [CmdletBinding()]
    param(
        [string]$ServiceName
    )

    if ($ServiceName) {
        if (-not $script:CircuitBreakerState.ContainsKey($ServiceName)) {
            Write-Warning "Service not found: $ServiceName"
            return $null
        }

        return @{
            ServiceName = $ServiceName
            State = $script:CircuitBreakerState[$ServiceName]
        }
    }

    # Return all services
    $status = @{}
    foreach ($svc in $script:CircuitBreakerState.Keys) {
        $status[$svc] = $script:CircuitBreakerState[$svc]
    }

    return $status
}

function Reset-CircuitBreaker {
    <#
    .SYNOPSIS
        Resets circuit breaker to closed state (manual recovery).

    .DESCRIPTION
        Forces circuit to closed state and resets failure counters.
        Use cautiously - bypasses automatic recovery logic.

    .PARAMETER ServiceName
        Service name to reset.

    .PARAMETER ResetMetrics
        Also reset success/failure counters.

    .EXAMPLE
        Reset-CircuitBreaker -ServiceName "MicrosoftGraph"

    .EXAMPLE
        Reset-CircuitBreaker -ServiceName "AzureSQL" -ResetMetrics
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ServiceName,

        [switch]$ResetMetrics
    )

    if (-not $script:CircuitBreakerState.ContainsKey($ServiceName)) {
        throw "Service not found: $ServiceName"
    }

    if ($PSCmdlet.ShouldProcess($ServiceName, "Reset circuit breaker")) {
        $config = $script:CircuitBreakerState[$ServiceName]

        $config.State = [CircuitState]::Closed
        $config.FailureCount = 0
        $config.SuccessCount = 0
        $config.StateChangedAt = Get-Date

        if ($ResetMetrics) {
            $config.TotalCalls = 0
            $config.TotalFailures = 0
            $config.TotalSuccesses = 0
            $config.TotalFastFails = 0
        }

        Write-Host "✅ Circuit breaker reset for $ServiceName" -ForegroundColor Green
    }
}

function Add-CircuitBreakerLog {
    <#
    .SYNOPSIS
        Internal function to log circuit breaker events.
    #>
    [CmdletBinding()]
    param(
        [string]$ServiceName,
        [string]$Operation,
        [string]$Result,
        [double]$Duration,
        [int]$Attempt = 1,
        [string]$Error
    )

    $logEntry = @{
        Timestamp = Get-Date -Format "o"
        SessionID = $script:SessionID
        ServiceName = $ServiceName
        Operation = $Operation
        Result = $Result
        Duration = $Duration
        Attempt = $Attempt
        Error = $Error
    }

    $script:CallHistory += $logEntry

    Write-Verbose "Circuit breaker log: $ServiceName - $Result"
}

function Export-CircuitBreakerLogs {
    <#
    .SYNOPSIS
        Exports circuit breaker call history to JSON.

    .DESCRIPTION
        Saves all logged events for analysis and monitoring.

    .PARAMETER OutputPath
        Path to save JSON file.

    .EXAMPLE
        Export-CircuitBreakerLogs -OutputPath ".\Logs\circuit-breaker-$(Get-Date -Format 'yyyyMMdd').json"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$OutputPath
    )

    $logData = @{
        SessionID = $script:SessionID
        ExportedAt = Get-Date -Format "o"
        TotalEvents = $script:CallHistory.Count
        Services = $script:CircuitBreakerState.Keys
        CallHistory = $script:CallHistory
    }

    $logData | ConvertTo-Json -Depth 10 | Set-Content -Path $OutputPath

    Write-Host "✅ Exported $($script:CallHistory.Count) log entries to: $OutputPath" -ForegroundColor Green
}

function Get-CircuitBreakerMetrics {
    <#
    .SYNOPSIS
        Returns aggregated metrics for all services.

    .DESCRIPTION
        Provides health summary with success rates, failure counts, and circuit states.

    .EXAMPLE
        Get-CircuitBreakerMetrics | Format-Table
    #>
    [CmdletBinding()]
    param()

    $metrics = @()

    foreach ($serviceName in $script:CircuitBreakerState.Keys) {
        $config = $script:CircuitBreakerState[$serviceName]

        $successRate = if ($config.TotalCalls -gt 0) {
            [Math]::Round(($config.TotalSuccesses / $config.TotalCalls) * 100, 2)
        } else {
            0
        }

        $metrics += [PSCustomObject]@{
            Service = $serviceName
            State = $config.State.ToString()
            SuccessRate = "$successRate%"
            TotalCalls = $config.TotalCalls
            Successes = $config.TotalSuccesses
            Failures = $config.TotalFailures
            FastFails = $config.TotalFastFails
            LastFailure = if ($config.LastFailureTime) { $config.LastFailureTime.ToString("yyyy-MM-dd HH:mm:ss") } else { "Never" }
            StateChangedAt = $config.StateChangedAt.ToString("yyyy-MM-dd HH:mm:ss")
        }
    }

    return $metrics
}

# Export module members
Export-ModuleMember -Function @(
    'Set-CircuitBreakerConfig',
    'Invoke-WithCircuitBreaker',
    'Get-CircuitBreakerStatus',
    'Reset-CircuitBreaker',
    'Export-CircuitBreakerLogs',
    'Get-CircuitBreakerMetrics'
)
