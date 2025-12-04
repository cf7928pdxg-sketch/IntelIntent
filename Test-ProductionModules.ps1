<#
.SYNOPSIS
    Test suite for production-ready IntelIntent modules.

.DESCRIPTION
    Validates SecureSecretsManager.psm1 and CircuitBreaker.psm1 functionality
    with both unit tests and integration scenarios.

.PARAMETER DryRun
    Skip actual Azure operations (test logic only).

.PARAMETER TestModule
    Specific module to test (SecureSecretsManager, CircuitBreaker, All).

.EXAMPLE
    .\Test-ProductionModules.ps1 -DryRun

.EXAMPLE
    .\Test-ProductionModules.ps1 -TestModule "SecretManager"
#>

param(
    [switch]$DryRun,

    [ValidateSet("SecureSecretsManager", "CircuitBreaker", "All")]
    [string]$TestModule = "All"
)

$ErrorActionPreference = "Stop"

Write-Host @"

╔══════════════════════════════════════════════════════════╗
║   IntelIntent Production Module Test Suite              ║
╚══════════════════════════════════════════════════════════╝

"@ -ForegroundColor Cyan

# === Test Results Tracking ===
$script:TestResults = @{
    Passed = 0
    Failed = 0
    Skipped = 0
    Tests = @()
}

function Test-Assertion {
    param(
        [string]$TestName,
        [scriptblock]$Condition,
        [string]$ExpectedResult
    )

    try {
        $result = & $Condition

        if ($result) {
            Write-Host "  ✅ PASS: $TestName" -ForegroundColor Green
            $script:TestResults.Passed++
            $script:TestResults.Tests += @{ Name = $TestName; Result = "PASS" }
        } else {
            Write-Host "  ❌ FAIL: $TestName (Expected: $ExpectedResult)" -ForegroundColor Red
            $script:TestResults.Failed++
            $script:TestResults.Tests += @{ Name = $TestName; Result = "FAIL"; Expected = $ExpectedResult }
        }
    }
    catch {
        Write-Host "  ❌ FAIL: $TestName - $_" -ForegroundColor Red
        $script:TestResults.Failed++
        $script:TestResults.Tests += @{ Name = $TestName; Result = "FAIL"; Error = $_.Exception.Message }
    }
}

# === SecureSecretsManager Tests ===
function Test-SecureSecretsManager {
    Write-Host "`n🔐 Testing SecureSecretsManager.psm1" -ForegroundColor Yellow
    Write-Host "═════════════════════════════════════" -ForegroundColor Yellow

    # Import module
    Import-Module .\IntelIntent_Seeding\SecureSecretsManager.psm1 -Force -ErrorAction Stop
    Write-Host "  ✅ Module imported successfully" -ForegroundColor Green

    # Test 1: Module functions exported
    Test-Assertion -TestName "New-SecretVault function exists" -Condition {
        Get-Command New-SecretVault -ErrorAction SilentlyContinue
    }

    Test-Assertion -TestName "Set-SecretValue function exists" -Condition {
        Get-Command Set-SecretValue -ErrorAction SilentlyContinue
    }

    Test-Assertion -TestName "Get-SecretValue function exists" -Condition {
        Get-Command Get-SecretValue -ErrorAction SilentlyContinue
    }

    Test-Assertion -TestName "Grant-VaultAccess function exists" -Condition {
        Get-Command Grant-VaultAccess -ErrorAction SilentlyContinue
    }

    Test-Assertion -TestName "Test-VaultConnection function exists" -Condition {
        Get-Command Test-VaultConnection -ErrorAction SilentlyContinue
    }

    # Test 2: Vault context management
    Set-VaultContext -VaultName "TestVault123"
    $context = Get-VaultContext

    Test-Assertion -TestName "Vault context set correctly" -Condition {
        $context.VaultName -eq "TestVault123"
    }

    Test-Assertion -TestName "Session ID generated" -Condition {
        $context.SessionID -match '^[a-f0-9-]{36}$'
    }

    # Test 3: Parameter validation
    try {
        New-SecretVault -VaultName "Invalid_Name!" -ResourceGroup "TestRG" -ErrorAction Stop
        Write-Host "  ❌ FAIL: Invalid vault name accepted" -ForegroundColor Red
        $script:TestResults.Failed++
    }
    catch {
        Write-Host "  ✅ PASS: Invalid vault name rejected" -ForegroundColor Green
        $script:TestResults.Passed++
    }

    if (-not $DryRun) {
        # Test 4: Azure CLI integration
        $azAccount = az account show 2>$null | ConvertFrom-Json

        Test-Assertion -TestName "Azure CLI authenticated" -Condition {
            $azAccount -ne $null
        }

        if ($azAccount) {
            Write-Host "`n  🔍 Testing with Azure subscription: $($azAccount.name)" -ForegroundColor Cyan

            # Test vault creation (requires real Azure resources)
            Write-Host "  ⚠️ Skipping live vault creation test (would incur costs)" -ForegroundColor Yellow
            $script:TestResults.Skipped++
        }
    } else {
        Write-Host "`n  ℹ️ DryRun mode - Skipping Azure operations" -ForegroundColor Yellow
        $script:TestResults.Skipped++
    }
}

# === CircuitBreaker Tests ===
function Test-CircuitBreaker {
    Write-Host "`n⚡ Testing CircuitBreaker.psm1" -ForegroundColor Yellow
    Write-Host "═════════════════════════════════════" -ForegroundColor Yellow

    # Import module
    Import-Module .\IntelIntent_Seeding\CircuitBreaker.psm1 -Force -ErrorAction Stop
    Write-Host "  ✅ Module imported successfully" -ForegroundColor Green

    # Test 1: Module functions exported
    Test-Assertion -TestName "Set-CircuitBreakerConfig function exists" -Condition {
        Get-Command Set-CircuitBreakerConfig -ErrorAction SilentlyContinue
    }

    Test-Assertion -TestName "Invoke-WithCircuitBreaker function exists" -Condition {
        Get-Command Invoke-WithCircuitBreaker -ErrorAction SilentlyContinue
    }

    Test-Assertion -TestName "Get-CircuitBreakerStatus function exists" -Condition {
        Get-Command Get-CircuitBreakerStatus -ErrorAction SilentlyContinue
    }

    Test-Assertion -TestName "Reset-CircuitBreaker function exists" -Condition {
        Get-Command Reset-CircuitBreaker -ErrorAction SilentlyContinue
    }

    Test-Assertion -TestName "Get-CircuitBreakerMetrics function exists" -Condition {
        Get-Command Get-CircuitBreakerMetrics -ErrorAction SilentlyContinue
    }

    # Test 2: Configuration
    Set-CircuitBreakerConfig -ServiceName "TestService" -Config @{
        MaxRetries = 3
        TimeoutSeconds = 5
        BackoffMultiplier = 2
        FailureThreshold = 3
    }

    $status = Get-CircuitBreakerStatus -ServiceName "TestService"

    Test-Assertion -TestName "Service configured" -Condition {
        $status -ne $null
    }

    Test-Assertion -TestName "Initial state is Closed" -Condition {
        $status.State.State -eq "Closed"
    }

    Test-Assertion -TestName "Failure count initialized to 0" -Condition {
        $status.State.FailureCount -eq 0
    }

    # Test 3: Success scenario
    Write-Host "`n  🧪 Test Scenario 1: Successful operation" -ForegroundColor Cyan

    $result = Invoke-WithCircuitBreaker -ServiceName "TestService" -ScriptBlock {
        return "Success"
    }

    Test-Assertion -TestName "Successful operation returns result" -Condition {
        $result -eq "Success"
    }

    $metrics = Get-CircuitBreakerMetrics
    $testMetric = $metrics | Where-Object { $_.Service -eq "TestService" }

    Test-Assertion -TestName "Total calls incremented" -Condition {
        $testMetric.TotalCalls -eq 1
    }

    Test-Assertion -TestName "Success count incremented" -Condition {
        $testMetric.Successes -eq 1
    }

    # Test 4: Retry scenario
    Write-Host "`n  🧪 Test Scenario 2: Retry with eventual success" -ForegroundColor Cyan

    $script:attemptCount = 0
    $result = Invoke-WithCircuitBreaker -ServiceName "TestService" -ScriptBlock {
        $script:attemptCount++
        if ($script:attemptCount -lt 2) {
            throw "Simulated failure"
        }
        return "Success after retry"
    }

    Test-Assertion -TestName "Operation succeeded after retry" -Condition {
        $result -eq "Success after retry"
    }

    Test-Assertion -TestName "Multiple attempts made" -Condition {
        $script:attemptCount -eq 2
    }

    # Test 5: Fallback scenario
    Write-Host "`n  🧪 Test Scenario 3: Fallback execution" -ForegroundColor Cyan

    # Configure new service for fallback test
    Set-CircuitBreakerConfig -ServiceName "FallbackTest" -Config @{
        MaxRetries = 1
        FailureThreshold = 1
    }

    $result = Invoke-WithCircuitBreaker -ServiceName "FallbackTest" -ScriptBlock {
        throw "Always fails"
    } -FallbackScriptBlock {
        return "Fallback executed"
    }

    Test-Assertion -TestName "Fallback handler executed" -Condition {
        $result -eq "Fallback executed"
    }

    # Test 6: Circuit opens after threshold
    Write-Host "`n  🧪 Test Scenario 4: Circuit opens after threshold" -ForegroundColor Cyan

    Set-CircuitBreakerConfig -ServiceName "ThresholdTest" -Config @{
        MaxRetries = 1
        FailureThreshold = 2
        ResetTimeoutSeconds = 5
    }

    # Cause failures to open circuit
    try {
        Invoke-WithCircuitBreaker -ServiceName "ThresholdTest" -ScriptBlock {
            throw "Failure 1"
        }
    } catch {}

    try {
        Invoke-WithCircuitBreaker -ServiceName "ThresholdTest" -ScriptBlock {
            throw "Failure 2"
        }
    } catch {}

    $status = Get-CircuitBreakerStatus -ServiceName "ThresholdTest"

    Test-Assertion -TestName "Circuit opened after threshold" -Condition {
        $status.State.State -eq "Open"
    }

    # Test 7: Fast fail when circuit open
    Write-Host "`n  🧪 Test Scenario 5: Fast fail when circuit open" -ForegroundColor Cyan

    $fastFailOccurred = $false
    try {
        Invoke-WithCircuitBreaker -ServiceName "ThresholdTest" -ScriptBlock {
            return "Should not execute"
        }
    }
    catch {
        if ($_.Exception.Message -match "Circuit breaker open") {
            $fastFailOccurred = $true
        }
    }

    Test-Assertion -TestName "Fast fail executed when circuit open" -Condition {
        $fastFailOccurred
    }

    # Test 8: Manual reset
    Write-Host "`n  🧪 Test Scenario 6: Manual circuit reset" -ForegroundColor Cyan

    Reset-CircuitBreaker -ServiceName "ThresholdTest" -Confirm:$false
    $status = Get-CircuitBreakerStatus -ServiceName "ThresholdTest"

    Test-Assertion -TestName "Circuit reset to Closed" -Condition {
        $status.State.State -eq "Closed"
    }
}

# === Run Tests ===
try {
    if ($TestModule -eq "All" -or $TestModule -eq "SecureSecretsManager") {
        Test-SecureSecretsManager
    }

    if ($TestModule -eq "All" -or $TestModule -eq "CircuitBreaker") {
        Test-CircuitBreaker
    }

    # === Test Summary ===
    Write-Host @"

╔══════════════════════════════════════════════════════════╗
║                    Test Summary                          ║
╚══════════════════════════════════════════════════════════╝

"@ -ForegroundColor Cyan

    $totalTests = $script:TestResults.Passed + $script:TestResults.Failed + $script:TestResults.Skipped
    $passRate = if ($totalTests -gt 0) { [Math]::Round(($script:TestResults.Passed / $totalTests) * 100, 2) } else { 0 }

    Write-Host "Total Tests: $totalTests" -ForegroundColor White
    Write-Host "✅ Passed: $($script:TestResults.Passed)" -ForegroundColor Green
    Write-Host "❌ Failed: $($script:TestResults.Failed)" -ForegroundColor Red
    Write-Host "⏭️  Skipped: $($script:TestResults.Skipped)" -ForegroundColor Yellow
    Write-Host "Pass Rate: $passRate%" -ForegroundColor $(if ($passRate -ge 80) { "Green" } else { "Yellow" })

    if ($script:TestResults.Failed -gt 0) {
        Write-Host "`n⚠️ FAILED TESTS:" -ForegroundColor Red
        $script:TestResults.Tests | Where-Object { $_.Result -eq "FAIL" } | ForEach-Object {
            Write-Host "  • $($_.Name)" -ForegroundColor Red
            if ($_.Error) {
                Write-Host "    Error: $($_.Error)" -ForegroundColor Yellow
            }
        }
        exit 1
    } else {
        Write-Host "`n🎉 All tests passed!" -ForegroundColor Green
        exit 0
    }
}
catch {
    Write-Error "❌ Test suite failed: $_"
    exit 1
}
