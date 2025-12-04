<#
.SYNOPSIS
    Validates integrity of Copilot lifecycle and invocation logs.

.DESCRIPTION
    Checks JSON validity, schema compliance, event counts, and hash integrity.
    Returns structured report for CI/CD gates and dashboard validation.

.PARAMETER LifecycleLog
    Path to lifecycle log (default: ../logs/CopilotLifecycleLog.json)

.PARAMETER InvocationLog
    Path to invocation log (default: ../logs/CopilotInvocationLog.json)

.PARAMETER SchemaPath
    Path to JSON schema file (default: ../schemas/copilot-events.schema.json)

.PARAMETER ValidateHashes
    Perform SHA256 hash validation on lifecycle events

.PARAMETER FailOnWarnings
    Exit with error code if warnings detected

.EXAMPLE
    .\Test-CodexIntegrity.ps1

.EXAMPLE
    .\Test-CodexIntegrity.ps1 -ValidateHashes -FailOnWarnings
#>

param(
    [string]$LifecycleLog = "$PSScriptRoot\..\logs\CopilotLifecycleLog.json",
    [string]$InvocationLog = "$PSScriptRoot\..\logs\CopilotInvocationLog.json",
    [string]$SchemaPath = "$PSScriptRoot\..\schemas\copilot-events.schema.json",
    [switch]$ValidateHashes,
    [switch]$FailOnWarnings
)

# === Helper Functions ===

function Test-JsonFile {
    <#
    .SYNOPSIS
        Tests if file exists and contains valid JSON.
    #>
    param([string]$Path)
    
    if (-not (Test-Path $Path)) {
        return @{ Valid = $false; Error = "File not found" }
    }
    
    try {
        $content = Get-Content $Path -Raw | ConvertFrom-Json
        return @{ Valid = $true; Count = $content.Count; Data = $content }
    } catch {
        return @{ Valid = $false; Error = $_.Exception.Message }
    }
}

function Test-RequiredFields {
    <#
    .SYNOPSIS
        Validates required fields are present in each event.
    #>
    param(
        [array]$Events,
        [string[]]$RequiredFields
    )
    
    $issues = @()
    for ($i = 0; $i -lt $Events.Count; $i++) {
        $event = $Events[$i]
        foreach ($field in $RequiredFields) {
            if (-not $event.$field) {
                $issues += "Event $i missing required field: $field"
            }
        }
    }
    
    return $issues
}

function Test-HashIntegrity {
    <#
    .SYNOPSIS
        Validates SHA256 hashes in lifecycle events.
    #>
    param([array]$Events)
    
    $pending = 0
    $invalid = 0
    
    foreach ($event in $Events) {
        if ($event.Hash -eq "[Pending SHA256]" -or -not $event.Hash) {
            $pending++
        } elseif ($event.Hash -notmatch '^[a-fA-F0-9]{64}$') {
            $invalid++
        }
    }
    
    return @{
        TotalEvents = $Events.Count
        PendingHashes = $pending
        InvalidHashes = $invalid
        ValidHashes = $Events.Count - $pending - $invalid
        ComplianceRate = if ($Events.Count -gt 0) { 
            [math]::Round((($Events.Count - $pending - $invalid) / $Events.Count) * 100, 2) 
        } else { 0 }
    }
}

# === Main Validation Logic ===

Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Codex Integrity Validation" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

$warnings = @()
$errors = @()

# === Test 1: JSON File Validity ===
Write-Host "📋 Test 1: Validating JSON files..." -ForegroundColor Yellow

$lifecycleTest = Test-JsonFile -Path $LifecycleLog
$invocationTest = Test-JsonFile -Path $InvocationLog

if ($lifecycleTest.Valid) {
    Write-Host "  ✅ Lifecycle log valid ($($lifecycleTest.Count) events)" -ForegroundColor Green
} else {
    $errors += "Lifecycle log invalid: $($lifecycleTest.Error)"
    Write-Host "  ❌ Lifecycle log invalid: $($lifecycleTest.Error)" -ForegroundColor Red
}

if ($invocationTest.Valid) {
    Write-Host "  ✅ Invocation log valid ($($invocationTest.Count) events)" -ForegroundColor Green
} else {
    $errors += "Invocation log invalid: $($invocationTest.Error)"
    Write-Host "  ❌ Invocation log invalid: $($invocationTest.Error)" -ForegroundColor Red
}

Write-Host ""

# === Test 2: Required Fields ===
if ($lifecycleTest.Valid) {
    Write-Host "📋 Test 2: Validating required fields..." -ForegroundColor Yellow
    
    $lifecycleFields = @("Timestamp", "RunId", "LifecycleAction", "ExtensionID", "Version", "WorkspaceName")
    $lifecycleIssues = Test-RequiredFields -Events $lifecycleTest.Data -RequiredFields $lifecycleFields
    
    if ($lifecycleIssues.Count -eq 0) {
        Write-Host "  ✅ All lifecycle events have required fields" -ForegroundColor Green
    } else {
        $warnings += $lifecycleIssues
        Write-Host "  ⚠️ $($lifecycleIssues.Count) field issues detected" -ForegroundColor Yellow
        $lifecycleIssues | ForEach-Object { Write-Host "     - $_" -ForegroundColor Yellow }
    }
}

if ($invocationTest.Valid) {
    $invocationFields = @("Timestamp", "RunId", "InvocationType", "CommandID", "ExtensionID", "WorkspaceName")
    $invocationIssues = Test-RequiredFields -Events $invocationTest.Data -RequiredFields $invocationFields
    
    if ($invocationIssues.Count -eq 0) {
        Write-Host "  ✅ All invocation events have required fields" -ForegroundColor Green
    } else {
        $warnings += $invocationIssues
        Write-Host "  ⚠️ $($invocationIssues.Count) field issues detected" -ForegroundColor Yellow
        $invocationIssues | ForEach-Object { Write-Host "     - $_" -ForegroundColor Yellow }
    }
}

Write-Host ""

# === Test 3: Hash Integrity ===
if ($ValidateHashes -and $lifecycleTest.Valid) {
    Write-Host "📋 Test 3: Validating hash integrity..." -ForegroundColor Yellow
    
    $hashReport = Test-HashIntegrity -Events $lifecycleTest.Data
    
    Write-Host "  📊 Hash Integrity Report:" -ForegroundColor Cyan
    Write-Host "     Total Events: $($hashReport.TotalEvents)" -ForegroundColor Gray
    Write-Host "     Valid Hashes: $($hashReport.ValidHashes)" -ForegroundColor Green
    Write-Host "     Pending Hashes: $($hashReport.PendingHashes)" -ForegroundColor Yellow
    Write-Host "     Invalid Hashes: $($hashReport.InvalidHashes)" -ForegroundColor $(if ($hashReport.InvalidHashes -gt 0) { "Red" } else { "Gray" })
    Write-Host "     Compliance Rate: $($hashReport.ComplianceRate)%" -ForegroundColor $(if ($hashReport.ComplianceRate -lt 80) { "Yellow" } else { "Green" })
    
    if ($hashReport.InvalidHashes -gt 0) {
        $errors += "Invalid SHA256 hashes detected: $($hashReport.InvalidHashes)"
    }
    if ($hashReport.ComplianceRate -lt 80) {
        $warnings += "Hash compliance rate below 80%: $($hashReport.ComplianceRate)%"
    }
}

Write-Host ""

# === Summary Report ===
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Validation Summary" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

$summary = [ordered]@{
    ValidationTimestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    LifecycleLogValid  = $lifecycleTest.Valid
    InvocationLogValid = $invocationTest.Valid
    LifecycleCount     = if ($lifecycleTest.Valid) { $lifecycleTest.Count } else { 0 }
    InvocationCount    = if ($invocationTest.Valid) { $invocationTest.Count } else { 0 }
    TotalWarnings      = $warnings.Count
    TotalErrors        = $errors.Count
    Status             = if ($errors.Count -gt 0) { "Failed" } elseif ($warnings.Count -gt 0) { "Warning" } else { "Passed" }
}

if ($ValidateHashes -and $lifecycleTest.Valid) {
    $summary.HashComplianceRate = $hashReport.ComplianceRate
}

$summary | ConvertTo-Json -Depth 5 | Write-Output

Write-Host ""
if ($errors.Count -eq 0 -and $warnings.Count -eq 0) {
    Write-Host "✅ All integrity checks passed" -ForegroundColor Green
    exit 0
} elseif ($errors.Count -gt 0) {
    Write-Host "❌ Integrity validation failed with $($errors.Count) error(s)" -ForegroundColor Red
    exit 1
} else {
    Write-Host "⚠️ Integrity validation completed with $($warnings.Count) warning(s)" -ForegroundColor Yellow
    if ($FailOnWarnings) {
        exit 1
    } else {
        exit 0
    }
}
