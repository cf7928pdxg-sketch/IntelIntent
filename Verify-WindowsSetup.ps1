# Verify-WindowsSetup.ps1
# Quick validation script for IntelIntent prerequisites on Windows

Write-Host "`n=== IntelIntent Windows Setup Verification ===" -ForegroundColor Cyan

# Check PowerShell Version
Write-Host "`n1️⃣ Checking PowerShell Version..." -ForegroundColor Yellow
$psVersion = $PSVersionTable.PSVersion
if ($psVersion.Major -ge 7) {
    Write-Host "   ✅ PowerShell $psVersion (REQUIRED 7.0+)" -ForegroundColor Green
} else {
    Write-Host "   ❌ PowerShell $psVersion (UPGRADE REQUIRED)" -ForegroundColor Red
    Write-Host "   → Install: winget install Microsoft.PowerShell" -ForegroundColor Yellow
}

# Check Azure CLI
Write-Host "`n2️⃣ Checking Azure CLI..." -ForegroundColor Yellow
try {
    $azVersion = az --version 2>&1 | Select-String "azure-cli" | Select-Object -First 1
    if ($azVersion) {
        Write-Host "   ✅ Azure CLI installed: $azVersion" -ForegroundColor Green

        # Check Azure authentication
        Write-Host "`n3️⃣ Checking Azure Authentication..." -ForegroundColor Yellow
        $azAccount = az account show 2>&1
        if ($LASTEXITCODE -eq 0) {
            $accountInfo = $azAccount | ConvertFrom-Json
            Write-Host "   ✅ Logged in as: $($accountInfo.user.name)" -ForegroundColor Green
            Write-Host "   ✅ Subscription: $($accountInfo.name)" -ForegroundColor Green
        } else {
            Write-Host "   ⚠️  Not logged in to Azure" -ForegroundColor Yellow
            Write-Host "   → Run: az login" -ForegroundColor Cyan
        }
    }
} catch {
    Write-Host "   ❌ Azure CLI not found" -ForegroundColor Red
    Write-Host "   → Install: winget install Microsoft.AzureCLI" -ForegroundColor Yellow
}

# Check Git
Write-Host "`n4️⃣ Checking Git..." -ForegroundColor Yellow
try {
    $gitVersion = git --version
    Write-Host "   ✅ $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "   ⚠️  Git not found (optional)" -ForegroundColor Yellow
}

# Check Module Files
Write-Host "`n5️⃣ Checking IntelIntent Modules..." -ForegroundColor Yellow
$modules = @(
    ".\IntelIntent_Seeding\AgentBridge.psm1",
    ".\IntelIntent_Seeding\SecureSecretsManager.psm1",
    ".\IntelIntent_Seeding\CircuitBreaker.psm1",
    ".\IntelIntent_Seeding\CodexRenderer.psm1",
    ".\IntelIntent_Seeding\ManifestReader.ps1"
)

$foundModules = 0
foreach ($module in $modules) {
    if (Test-Path $module) {
        $foundModules++
        $lines = (Get-Content $module).Count
        Write-Host "   ✅ $(Split-Path $module -Leaf) ($lines lines)" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️  $(Split-Path $module -Leaf) (not found)" -ForegroundColor Yellow
    }
}

# Check Manifest Files
Write-Host "`n6️⃣ Checking Manifest Files..." -ForegroundColor Yellow
if (Test-Path ".\IntelIntent-Seed\sample_manifest.json") {
    Write-Host "   ✅ sample_manifest.json found" -ForegroundColor Green
} else {
    Write-Host "   ⚠️  sample_manifest.json not found" -ForegroundColor Yellow
}

# Summary
Write-Host "`n=== Summary ===" -ForegroundColor Cyan
Write-Host "Modules found: $foundModules / $($modules.Count)" -ForegroundColor $(if ($foundModules -eq $modules.Count) { "Green" } else { "Yellow" })

Write-Host "`n=== Next Steps ===" -ForegroundColor Cyan
if ($psVersion.Major -lt 7) {
    Write-Host "1. Install PowerShell 7+: winget install Microsoft.PowerShell" -ForegroundColor Yellow
}
if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
    Write-Host "2. Install Azure CLI: winget install Microsoft.AzureCLI" -ForegroundColor Yellow
}
Write-Host "3. Run safe test: .\Week1_Automation.ps1 -DryRun -SkipEmail" -ForegroundColor Cyan
Write-Host "4. Launch menu: .\IntelIntent_Launcher.ps1" -ForegroundColor Cyan

Write-Host "`n✨ Setup verification complete!" -ForegroundColor Green
