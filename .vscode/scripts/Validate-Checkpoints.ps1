<#
.SYNOPSIS
    Validates checkpoint JSON structure and schema compliance

.DESCRIPTION
    Loads Week1_Checkpoints.json and validates each checkpoint against IntelIntent schema requirements.
    Reports validation errors with specific field issues.
#>

function Test-CheckpointSchema {
    param([PSCustomObject]$Checkpoint)

    $errors = @()

    # Validate TaskID format (e.g., "KV-001", "RBAC-002")
    if ($Checkpoint.TaskID -notmatch '^[A-Z]+-\d{3}$') {
        $errors += "TaskID format invalid: $($Checkpoint.TaskID) (expected: PREFIX-NNN)"
    }

    # Validate timestamp is ISO 8601
    try {
        [DateTime]::Parse($Checkpoint.Timestamp) | Out-Null
    }
    catch {
        $errors += "Timestamp not valid ISO 8601: $($Checkpoint.Timestamp)"
    }

    # Validate Status enum
    if ($Checkpoint.Status -notin @("Success", "Failed", "Skipped")) {
        $errors += "Status invalid: $($Checkpoint.Status) (expected: Success, Failed, or Skipped)"
    }

    # Validate Signature placeholder or SHA256 format
    if ($Checkpoint.Signature -ne "[Pending SHA256]" -and
        $Checkpoint.Signature -notmatch '^[a-fA-F0-9]{64}$') {
        $errors += "Signature invalid format: $($Checkpoint.Signature)"
    }

    # Validate Duration is positive integer
    if ($Checkpoint.Duration -lt 0) {
        $errors += "Duration cannot be negative: $($Checkpoint.Duration)"
    }

    # Validate SessionID exists
    if (-not $Checkpoint.SessionID) {
        $errors += "SessionID is missing"
    }

    return @{
        IsValid = ($errors.Count -eq 0)
        Errors  = $errors
    }
}

# Main validation logic
$checkpointPath = ".\Week1_Checkpoints.json"

Write-Host "`n═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  IntelIntent Checkpoint Validation" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════`n" -ForegroundColor Cyan

if (-not (Test-Path $checkpointPath)) {
    Write-Host "❌ Checkpoint file not found: $checkpointPath" -ForegroundColor Red
    Write-Host "   Run 'Week1_Automation.ps1 -DryRun' to generate checkpoints`n" -ForegroundColor Yellow
    exit 1
}

try {
    $checkpointData = Get-Content $checkpointPath | ConvertFrom-Json

    Write-Host "📋 Session Information:" -ForegroundColor Cyan
    Write-Host "   Session ID: $($checkpointData.SessionID)" -ForegroundColor Gray
    Write-Host "   Total Checkpoints: $($checkpointData.Checkpoints.Count)`n" -ForegroundColor Gray

    $validCount = 0
    $invalidCount = 0

    foreach ($checkpoint in $checkpointData.Checkpoints) {
        $validation = Test-CheckpointSchema -Checkpoint $checkpoint

        if ($validation.IsValid) {
            $validCount++
            $statusColor = switch ($checkpoint.Status) {
                "Success" { "Green" }
                "Failed" { "Red" }
                "Skipped" { "Yellow" }
                default { "Gray" }
            }
            Write-Host "   ✅ $($checkpoint.TaskID)" -NoNewline -ForegroundColor Green
            Write-Host " - $($checkpoint.Status)" -ForegroundColor $statusColor
        }
        else {
            $invalidCount++
            Write-Host "   ❌ $($checkpoint.TaskID)" -NoNewline -ForegroundColor Red
            Write-Host " - VALIDATION FAILED" -ForegroundColor Red
            foreach ($error in $validation.Errors) {
                Write-Host "      → $error" -ForegroundColor DarkRed
            }
        }
    }

    Write-Host "`n📊 Validation Summary:" -ForegroundColor Cyan
    Write-Host "   Valid Checkpoints: " -NoNewline
    Write-Host "$validCount" -ForegroundColor Green
    Write-Host "   Invalid Checkpoints: " -NoNewline
    Write-Host "$invalidCount" -ForegroundColor $(if ($invalidCount -eq 0) { "Green" } else { "Red" })

    if ($invalidCount -eq 0) {
        Write-Host "`n🎉 All checkpoints passed validation!" -ForegroundColor Green
    }
    else {
        Write-Host "`n⚠️  Fix validation errors before Power BI ingestion`n" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "❌ Failed to parse checkpoint file: $_" -ForegroundColor Red
    Write-Host "   Ensure JSON is valid (check for trailing commas, quotes)`n" -ForegroundColor Yellow
    exit 1
}
