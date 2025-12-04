<#
.SYNOPSIS
    Checks for missing/unimplemented modules referenced in Week1_Automation.ps1

.DESCRIPTION
    Scans IntelIntent_Seeding directory to identify placeholder modules that need implementation.
    Provides status report with line counts for existing modules.
#>

$requiredModules = @(
    "SecureSecretsManager.psm1",
    "RBACManager.psm1",
    "CertificateAuthBridge.psm1",
    "CircuitBreaker.psm1",
    "HealthCheckAPI.ps1",
    "CodexRenderer.psm1"
)

$implementedModules = @(
    "AgentBridge.psm1",
    "Get-CodexEmailBody.psm1",
    "ManifestReader.ps1",
    "Orchestrator.ps1",
    "CopilotLifecycleTracker.psm1"
)

Write-Host "`n═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  IntelIntent Module Implementation Status" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════`n" -ForegroundColor Cyan

Write-Host "✅ Implemented Modules:" -ForegroundColor Green
foreach ($module in $implementedModules) {
    $path = ".\IntelIntent_Seeding\$module"
    if (Test-Path $path) {
        $lineCount = (Get-Content $path).Count
        Write-Host "   $module" -NoNewline -ForegroundColor Green
        Write-Host " → $lineCount lines" -ForegroundColor Gray
    }
}

Write-Host "`n⚠️  Required Modules (To Be Implemented):" -ForegroundColor Yellow
$missingCount = 0
foreach ($module in $requiredModules) {
    $path = ".\IntelIntent_Seeding\$module"
    $exists = Test-Path $path

    if ($exists) {
        $lineCount = (Get-Content $path).Count
        if ($lineCount -lt 10) {
            Write-Host "   ⚠️  $module" -NoNewline -ForegroundColor Yellow
            Write-Host " → $lineCount lines (stub/placeholder)" -ForegroundColor DarkYellow
            $missingCount++
        } else {
            Write-Host "   ✅ $module" -NoNewline -ForegroundColor Green
            Write-Host " → $lineCount lines" -ForegroundColor Gray
        }
    } else {
        Write-Host "   ❌ $module" -NoNewline -ForegroundColor Red
        Write-Host " → Missing (not in repository)" -ForegroundColor DarkRed
        $missingCount++
    }
}

Write-Host "`n📊 Summary:" -ForegroundColor Cyan
Write-Host "   Implemented: " -NoNewline
Write-Host "$($implementedModules.Count)" -ForegroundColor Green
Write-Host "   Missing/Stub: " -NoNewline
Write-Host "$missingCount" -ForegroundColor Yellow
Write-Host "   Total Required: " -NoNewline
Write-Host "$($requiredModules.Count)" -ForegroundColor Cyan

if ($missingCount -eq 0) {
    Write-Host "`n🎉 All required modules implemented!" -ForegroundColor Green
} else {
    Write-Host "`n💡 Tip: Use 'Week1_Automation.ps1 -DryRun' to test without these modules" -ForegroundColor Yellow
    Write-Host "   Module imports use '-ErrorAction SilentlyContinue' for graceful degradation`n" -ForegroundColor Gray
}
