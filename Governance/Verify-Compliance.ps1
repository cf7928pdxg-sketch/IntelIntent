# Governance Compliance Verification Script
# Purpose: Automate pre-deployment compliance checks for IntelIntent
# Usage: .\Governance\Verify-Compliance.ps1 [-ResourceGroupLocation <location>] [-Verbose]

<#
.SYNOPSIS
    Verifies IntelIntent compliance with licensing and governance requirements.

.DESCRIPTION
    Automates the 5-step compliance verification workflow:
    1. License Attribution Check
    2. Usage Scope Validation (ARM Tools dev/test only)
    3. Telemetry Settings Verification (GDPR)
    4. Export Compliance (EAR/ITAR)
    5. Checkpoint Schema Audit

.PARAMETER ResourceGroupLocation
    Azure region for export compliance check (e.g., "centralus", "eastasia").

.PARAMETER SkipExportCheck
    Skip EAR/ITAR export compliance validation.

.EXAMPLE
    .\Governance\Verify-Compliance.ps1 -ResourceGroupLocation "centralus"

.EXAMPLE
    .\Governance\Verify-Compliance.ps1 -Verbose -SkipExportCheck
#>

param(
    [string]$ResourceGroupLocation = 'centralus',
    [switch]$SkipExportCheck
)

# Initialize results tracking
$results = @{
    LicenseAttribution = $false
    UsageScope         = $false
    TelemetrySettings  = $false
    ExportCompliance   = $false
    CheckpointSchema   = $false
    Errors             = @()
    Warnings           = @()
}

Write-Host '🔍 IntelIntent Compliance Verification' -ForegroundColor Cyan
Write-Host "Started: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host ('-' * 60) -ForegroundColor Gray

# =============================================================================
# 1. LICENSE ATTRIBUTION CHECK
# =============================================================================
Write-Host "`n[1/5] Checking License Attribution..." -ForegroundColor Yellow

try {
    $readmeContent = Get-Content .\README.txt -ErrorAction Stop
    $licenseContent = Get-Content .\LICENSE -ErrorAction SilentlyContinue

    $hasMitInReadme = $readmeContent | Select-String 'MIT License'
    $hasCopyrightInReadme = $readmeContent | Select-String 'Microsoft Corporation'

    if ($hasMitInReadme -and $hasCopyrightInReadme) {
        Write-Host '  ✅ License attribution found in README.txt' -ForegroundColor Green
        $results.LicenseAttribution = $true
    } else {
        $results.Errors += '❌ Missing MIT License or Microsoft Corporation attribution in README.txt'
        Write-Host '  ❌ Missing attribution in README.txt' -ForegroundColor Red
    }

    if ($licenseContent) {
        Write-Host '  ✅ LICENSE file exists' -ForegroundColor Green
    } else {
        $results.Warnings += '⚠️ LICENSE file not found (recommended for distribution)'
        Write-Host '  ⚠️ LICENSE file not found' -ForegroundColor Yellow
    }
} catch {
    $results.Errors += "❌ License attribution check failed: $($_.Exception.Message)"
    Write-Host "  ❌ Check failed: $_" -ForegroundColor Red
}

# =============================================================================
# 2. USAGE SCOPE VALIDATION (ARM TOOLS)
# =============================================================================
Write-Host "`n[2/5] Validating Usage Scope (ARM Tools)..." -ForegroundColor Yellow

try {
    $environment = $env:INTELINTENT_ENVIRONMENT

    if ($environment -eq 'Production') {
        $results.Errors += "❌ INTELINTENT_ENVIRONMENT set to 'Production' - ARM Tools only licensed for dev/test"
        Write-Host '  ❌ Environment: Production (ARM Tools license violation)' -ForegroundColor Red
    } else {
        $displayEnv = if ($environment) { $environment } else { 'Not set (defaults to dev/test)' }
        Write-Host "  ✅ Environment: $displayEnv" -ForegroundColor Green
        $results.UsageScope = $true
    }
} catch {
    $results.Warnings += '⚠️ Could not determine environment scope'
    Write-Host '  ⚠️ Environment check inconclusive' -ForegroundColor Yellow
}

# =============================================================================
# 3. TELEMETRY SETTINGS (GDPR)
# =============================================================================
Write-Host "`n[3/5] Checking Telemetry Settings (GDPR)..." -ForegroundColor Yellow

try {
    $settingsPath = '.\.vscode\settings.json'

    if (Test-Path $settingsPath) {
        $settings = Get-Content $settingsPath | ConvertFrom-Json
        $telemetryDisabled = $settings.'dotnetAcquisitionExtension.enableTelemetry' -eq $false

        if ($telemetryDisabled) {
            Write-Host '  ✅ Telemetry disabled (dotnetAcquisitionExtension.enableTelemetry: false)' -ForegroundColor Green
            $results.TelemetrySettings = $true
        } else {
            $results.Warnings += '⚠️ Telemetry enabled - ensure user disclosure for GDPR compliance'
            Write-Host '  ⚠️ Telemetry enabled (user disclosure required)' -ForegroundColor Yellow
            $results.TelemetrySettings = $true  # Not an error, just needs disclosure
        }
    } else {
        $results.Warnings += '⚠️ settings.json not found - cannot verify telemetry configuration'
        Write-Host '  ⚠️ settings.json not found' -ForegroundColor Yellow
    }
} catch {
    $results.Warnings += "⚠️ Telemetry check failed: $($_.Exception.Message)"
    Write-Host "  ⚠️ Check failed: $_" -ForegroundColor Yellow
}

# =============================================================================
# 4. EXPORT COMPLIANCE (EAR/ITAR)
# =============================================================================
Write-Host "`n[4/5] Verifying Export Compliance (EAR/ITAR)..." -ForegroundColor Yellow

if ($SkipExportCheck) {
    Write-Host '  ⏭️ Export check skipped (SkipExportCheck flag)' -ForegroundColor Gray
    $results.ExportCompliance = $true
} else {
    try {
        $restrictedRegions = @('CN', 'RU', 'IR', 'KP', 'SY')

        # Extract region code from location string (e.g., "centralus" → "US")
        $regionMatch = $ResourceGroupLocation -match '([a-z]{2})$'
        $regionCode = if ($regionMatch) { $matches[1].ToUpper() } else { '' }

        if ($restrictedRegions -contains $regionCode) {
            $results.Errors += "❌ Deployment to $ResourceGroupLocation (region: $regionCode) requires EAR/ITAR compliance review"
            Write-Host "  ❌ Restricted region detected: $regionCode" -ForegroundColor Red
        } else {
            Write-Host "  ✅ Target location: $ResourceGroupLocation (no restrictions)" -ForegroundColor Green
            $results.ExportCompliance = $true
        }
    } catch {
        $results.Warnings += "⚠️ Export compliance check failed: $($_.Exception.Message)"
        Write-Host "  ⚠️ Check failed: $_" -ForegroundColor Yellow
    }
}

# =============================================================================
# 5. CHECKPOINT SCHEMA AUDIT
# =============================================================================
Write-Host "`n[5/5] Auditing Checkpoint Schema..." -ForegroundColor Yellow

try {
    $checkpointPath = '.\Week1_Checkpoints.json'

    if (Test-Path $checkpointPath) {
        $checkpoints = Get-Content $checkpointPath | ConvertFrom-Json
        $totalCheckpoints = $checkpoints.Checkpoints.Count
        $missingSignatures = $checkpoints.Checkpoints | Where-Object { -not $_.Signature }

        Write-Host "  📊 Total checkpoints: $totalCheckpoints" -ForegroundColor Cyan

        if ($missingSignatures) {
            $results.Warnings += "⚠️ $($missingSignatures.Count) checkpoints missing signature placeholders"
            Write-Host "  ⚠️ Missing signatures: $($missingSignatures.Count)" -ForegroundColor Yellow
        } else {
            Write-Host '  ✅ All checkpoints have signature placeholders' -ForegroundColor Green
        }

        $results.CheckpointSchema = $true
    } else {
        $results.Warnings += '⚠️ Week1_Checkpoints.json not found (run Week1_Automation.ps1 first)'
        Write-Host '  ⚠️ Checkpoint file not found' -ForegroundColor Yellow
    }
} catch {
    $results.Warnings += "⚠️ Checkpoint schema audit failed: $($_.Exception.Message)"
    Write-Host "  ⚠️ Check failed: $_" -ForegroundColor Yellow
}

# =============================================================================
# RESULTS SUMMARY
# =============================================================================
Write-Host "`n" ('-' * 60) -ForegroundColor Gray
Write-Host '📊 COMPLIANCE VERIFICATION SUMMARY' -ForegroundColor Cyan
Write-Host ('-' * 60) -ForegroundColor Gray

$passedChecks = ($results.LicenseAttribution -as [int]) +
($results.UsageScope -as [int]) +
($results.TelemetrySettings -as [int]) +
($results.ExportCompliance -as [int]) +
($results.CheckpointSchema -as [int])

$totalChecks = 5
$passRate = [math]::Round(($passedChecks / $totalChecks) * 100, 1)

Write-Host "`n✅ Passed: $passedChecks / $totalChecks ($passRate%)" -ForegroundColor Green
Write-Host "⚠️ Warnings: $($results.Warnings.Count)" -ForegroundColor Yellow
Write-Host "❌ Errors: $($results.Errors.Count)" -ForegroundColor Red

if ($results.Warnings.Count -gt 0) {
    Write-Host "`nWarnings:" -ForegroundColor Yellow
    $results.Warnings | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
}

if ($results.Errors.Count -gt 0) {
    Write-Host "`nErrors:" -ForegroundColor Red
    $results.Errors | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
}

# Export results to JSON
$resultsPath = '.\Governance\Compliance_Verification_Results.json'
$results | ConvertTo-Json -Depth 3 | Set-Content $resultsPath
Write-Host "`n💾 Results saved to: $resultsPath" -ForegroundColor Cyan

# Final status
Write-Host "`n" ('-' * 60) -ForegroundColor Gray
if ($results.Errors.Count -eq 0) {
    Write-Host '🎉 COMPLIANCE VERIFICATION PASSED' -ForegroundColor Green
    exit 0
} else {
    Write-Host '🚨 COMPLIANCE VERIFICATION FAILED' -ForegroundColor Red
    Write-Host 'Review errors above and consult Governance/Compliance_Summary.md' -ForegroundColor Yellow
    exit 1
}
