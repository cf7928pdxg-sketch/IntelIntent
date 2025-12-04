# Install-MVP.ps1
# Minimum Viable Product installation for IntelIntent
# Progressive installation: Core → Foundation → Stable

param(
    [ValidateSet('Core', 'Foundation', 'Stable', 'All')]
    [string]$Phase = 'Core',
    [switch]$DryRun
)

Write-Host "`n🎯 IntelIntent MVP Installation" -ForegroundColor Cyan
Write-Host "Phase: $Phase`n" -ForegroundColor Yellow

# === PHASE 1: CORE (Absolute Minimum) ===
function Install-CoreMVP {
    Write-Host '═══ PHASE 1: CORE MVP ═══' -ForegroundColor Cyan
    Write-Host "Goal: Run Week1_Automation.ps1 in DryRun mode`n" -ForegroundColor Gray

    # PowerShell 7+
    Write-Host '📦 PowerShell 7+' -ForegroundColor Yellow
    Write-Host '   Why: Required for modern syntax (&&, ||), .psm1 modules' -ForegroundColor Gray
    if ($DryRun) {
        Write-Host "   [DRY RUN] winget install Microsoft.PowerShell`n" -ForegroundColor Cyan
    } else {
        winget install Microsoft.PowerShell --silent --accept-package-agreements --accept-source-agreements
        if ($LASTEXITCODE -eq 0) { Write-Host "   ✅ Installed`n" -ForegroundColor Green }
    }

    # Azure CLI
    Write-Host '📦 Azure CLI' -ForegroundColor Yellow
    Write-Host '   Why: Azure resource provisioning and automation' -ForegroundColor Gray
    if ($DryRun) {
        Write-Host "   [DRY RUN] winget install Microsoft.AzureCLI`n" -ForegroundColor Cyan
    } else {
        winget install Microsoft.AzureCLI --silent --accept-package-agreements --accept-source-agreements
        if ($LASTEXITCODE -eq 0) { Write-Host "   ✅ Installed`n" -ForegroundColor Green }
    }

    Write-Host '✅ CORE MVP Complete!' -ForegroundColor Green
    Write-Host "Next: Restart VS Code, then run with -Phase Foundation`n" -ForegroundColor Yellow
}

# === PHASE 2: FOUNDATION (Stable Development) ===
function Install-FoundationMVP {
    Write-Host "`n═══ PHASE 2: FOUNDATION MVP ═══" -ForegroundColor Cyan
    Write-Host "Goal: Full Week1 automation + GitHub integration`n" -ForegroundColor Gray

    # GitHub CLI
    Write-Host '📦 GitHub CLI' -ForegroundColor Yellow
    Write-Host '   Why: GitHub MCP server, issue/PR management from chat' -ForegroundColor Gray
    if ($DryRun) {
        Write-Host "   [DRY RUN] winget install GitHub.cli`n" -ForegroundColor Cyan
    } else {
        winget install GitHub.cli --silent --accept-package-agreements --accept-source-agreements
        if ($LASTEXITCODE -eq 0) { Write-Host "   ✅ Installed`n" -ForegroundColor Green }
    }

    # Git (if not present)
    Write-Host '📦 Git' -ForegroundColor Yellow
    Write-Host '   Why: Version control, checkpoint tracking' -ForegroundColor Gray
    if ($DryRun) {
        Write-Host "   [DRY RUN] winget install Git.Git`n" -ForegroundColor Cyan
    } else {
        $gitExists = Get-Command git -ErrorAction SilentlyContinue
        if (-not $gitExists) {
            winget install Git.Git --silent --accept-package-agreements --accept-source-agreements
            if ($LASTEXITCODE -eq 0) { Write-Host "   ✅ Installed`n" -ForegroundColor Green }
        } else {
            Write-Host "   ✅ Already installed`n" -ForegroundColor Green
        }
    }

    Write-Host '✅ FOUNDATION MVP Complete!' -ForegroundColor Green
    Write-Host "Next: Run with -Phase Stable for production-ready setup`n" -ForegroundColor Yellow
}

# === PHASE 3: STABLE (Production-Ready) ===
function Install-StableMVP {
    Write-Host "`n═══ PHASE 3: STABLE MVP ═══" -ForegroundColor Cyan
    Write-Host "Goal: Production-ready with testing + quality tools`n" -ForegroundColor Gray

    # .NET SDK 8
    Write-Host '📦 .NET SDK 8' -ForegroundColor Yellow
    Write-Host '   Why: Bicep CLI, C# extensions, .NET Install Tool dependency' -ForegroundColor Gray
    if ($DryRun) {
        Write-Host "   [DRY RUN] winget install Microsoft.DotNet.SDK.8`n" -ForegroundColor Cyan
    } else {
        winget install Microsoft.DotNet.SDK.8 --silent --accept-package-agreements --accept-source-agreements
        if ($LASTEXITCODE -eq 0) { Write-Host "   ✅ Installed`n" -ForegroundColor Green }
    }

    # PowerShell Modules
    Write-Host "`n📦 PowerShell Modules (Pester, PSScriptAnalyzer)" -ForegroundColor Yellow
    Write-Host '   Why: Testing framework, code quality analysis' -ForegroundColor Gray

    if ($DryRun) {
        Write-Host "   [DRY RUN] Install-Module Pester, PSScriptAnalyzer`n" -ForegroundColor Cyan
    } else {
        # Pester
        if (-not (Get-Module -ListAvailable -Name Pester)) {
            Write-Host '   Installing Pester...' -ForegroundColor Cyan
            Install-Module -Name Pester -Force -SkipPublisherCheck -Scope CurrentUser
            Write-Host '   ✅ Pester installed' -ForegroundColor Green
        } else {
            Write-Host '   ✅ Pester already installed' -ForegroundColor Green
        }

        # PSScriptAnalyzer
        if (-not (Get-Module -ListAvailable -Name PSScriptAnalyzer)) {
            Write-Host '   Installing PSScriptAnalyzer...' -ForegroundColor Cyan
            Install-Module -Name PSScriptAnalyzer -Force -Scope CurrentUser
            Write-Host "   ✅ PSScriptAnalyzer installed`n" -ForegroundColor Green
        } else {
            Write-Host "   ✅ PSScriptAnalyzer already installed`n" -ForegroundColor Green
        }
    }

    Write-Host '✅ STABLE MVP Complete!' -ForegroundColor Green
    Write-Host "You now have a production-ready IntelIntent environment!`n" -ForegroundColor Yellow
}

# === EXECUTION ===
switch ($Phase) {
    'Core' {
        Install-CoreMVP
    }
    'Foundation' {
        Install-CoreMVP
        Install-FoundationMVP
    }
    'Stable' {
        Install-CoreMVP
        Install-FoundationMVP
        Install-StableMVP
    }
    'All' {
        Install-CoreMVP
        Install-FoundationMVP
        Install-StableMVP
    }
}

# === FINAL INSTRUCTIONS ===
Write-Host "`n═══════════════════════════════════" -ForegroundColor Cyan
Write-Host '📋 NEXT STEPS' -ForegroundColor Yellow
Write-Host "═══════════════════════════════════`n" -ForegroundColor Cyan

if ($Phase -eq 'Core') {
    Write-Host '1. 🔄 Close VS Code completely' -ForegroundColor White
    Write-Host '2. 🔄 Reopen VS Code' -ForegroundColor White
    Write-Host '3. ✅ Verify: .\Verify-WindowsSetup.ps1' -ForegroundColor Cyan
    Write-Host '4. 🔐 Login: az login' -ForegroundColor Cyan
    Write-Host '5. 🧪 Test: .\Week1_Automation.ps1 -DryRun -SkipEmail' -ForegroundColor Cyan
    Write-Host "`n6. 📈 Next Phase: .\Install-MVP.ps1 -Phase Foundation`n" -ForegroundColor Yellow
} elseif ($Phase -eq 'Foundation') {
    Write-Host '1. 🔄 Restart VS Code' -ForegroundColor White
    Write-Host '2. ✅ Verify: .\Verify-WindowsSetup.ps1' -ForegroundColor Cyan
    Write-Host '3. 🔐 Login: gh auth login' -ForegroundColor Cyan
    Write-Host '4. 🧪 Test GitHub: gh repo view' -ForegroundColor Cyan
    Write-Host "`n5. 📈 Next Phase: .\Install-MVP.ps1 -Phase Stable`n" -ForegroundColor Yellow
} else {
    Write-Host '1. 🔄 Restart VS Code' -ForegroundColor White
    Write-Host '2. ✅ Verify: .\Verify-WindowsSetup.ps1' -ForegroundColor Cyan
    Write-Host '3. 🧪 Run Tests: Invoke-Pester' -ForegroundColor Cyan
    Write-Host '4. 🔍 Analyze Code: Invoke-ScriptAnalyzer -Path .\Week1_Automation.ps1' -ForegroundColor Cyan
    Write-Host "5. 🚀 Deploy: .\Week1_Automation.ps1 (without -DryRun)`n" -ForegroundColor Green
}
