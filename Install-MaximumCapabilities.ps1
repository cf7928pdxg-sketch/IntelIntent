# Install-MaximumCapabilities.ps1
# Automated installation for maximum IntelIntent capabilities
# Run as Administrator in PowerShell

param(
    [ValidateSet('Core', 'Enhanced', 'Ultimate', 'Enterprise')]
    [string]$Tier = 'Enhanced',

    [switch]$DryRun
)

Write-Host "`n🚀 IntelIntent Maximum Capabilities Installer" -ForegroundColor Cyan
Write-Host "Installation Tier: $Tier`n" -ForegroundColor Yellow

function Install-Tool {
    param(
        [string]$Name,
        [string]$WingetId,
        [string]$Description,
        [switch]$Required
    )

    $status = if ($Required) { "REQUIRED" } else { "OPTIONAL" }
    Write-Host "[$status] $Name" -ForegroundColor $(if ($Required) { "Red" } else { "Yellow" })
    Write-Host "   → $Description" -ForegroundColor Gray

    if ($DryRun) {
        Write-Host "   [DRY RUN] Would install: winget install $WingetId`n" -ForegroundColor Cyan
        return
    }

    # Check if already installed
    $installed = winget list --id $WingetId --exact 2>&1
    if ($installed -match $WingetId) {
        Write-Host "   ✅ Already installed`n" -ForegroundColor Green
        return
    }

    Write-Host "   📦 Installing..." -ForegroundColor Cyan
    winget install $WingetId --silent --accept-package-agreements --accept-source-agreements

    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✅ Installed successfully`n" -ForegroundColor Green
    } else {
        Write-Host "   ❌ Installation failed (exit code: $LASTEXITCODE)`n" -ForegroundColor Red
    }
}

function Install-PowerShellModule {
    param(
        [string]$Name,
        [string]$Description
    )

    Write-Host "[OPTIONAL] $Name (PowerShell Module)" -ForegroundColor Yellow
    Write-Host "   → $Description" -ForegroundColor Gray

    if ($DryRun) {
        Write-Host "   [DRY RUN] Would install: Install-Module -Name $Name`n" -ForegroundColor Cyan
        return
    }

    if (Get-Module -ListAvailable -Name $Name) {
        Write-Host "   ✅ Already installed`n" -ForegroundColor Green
        return
    }

    Write-Host "   📦 Installing..." -ForegroundColor Cyan
    try {
        Install-Module -Name $Name -Force -SkipPublisherCheck -Scope CurrentUser -ErrorAction Stop
        Write-Host "   ✅ Installed successfully`n" -ForegroundColor Green
    } catch {
        Write-Host "   ❌ Installation failed: $_`n" -ForegroundColor Red
    }
}

# === TIER 1: CORE (Required) ===
Write-Host "`n═══ TIER 1: CORE PREREQUISITES ═══`n" -ForegroundColor Cyan

Install-Tool -Name "PowerShell 7+" `
    -WingetId "Microsoft.PowerShell" `
    -Description "Modern PowerShell with cross-platform support" `
    -Required

Install-Tool -Name "Azure CLI" `
    -WingetId "Microsoft.AzureCLI" `
    -Description "Azure resource management and automation" `
    -Required

if ($Tier -eq 'Core') {
    Write-Host "`n✨ Core installation complete!" -ForegroundColor Green
    Write-Host "Next: Restart VS Code and run .\Verify-WindowsSetup.ps1`n" -ForegroundColor Yellow
    exit 0
}

# === TIER 2: ENHANCED (Recommended) ===
Write-Host "`n═══ TIER 2: ENHANCED CAPABILITIES ═══`n" -ForegroundColor Cyan

Install-Tool -Name "GitHub CLI" `
    -WingetId "GitHub.cli" `
    -Description "GitHub MCP server tools in VS Code"

Install-Tool -Name "Docker Desktop" `
    -WingetId "Docker.DockerDesktop" `
    -Description "Container management tools"

Install-Tool -Name ".NET SDK 8" `
    -WingetId "Microsoft.DotNet.SDK.8" `
    -Description "Required for Bicep, C# extensions"

Install-Tool -Name "Azure Functions Core Tools" `
    -WingetId "Microsoft.Azure.FunctionsCoreTools" `
    -Description "Phase 3+ agent deployment"

if ($Tier -eq 'Enhanced') {
    Write-Host "`n✨ Enhanced installation complete!" -ForegroundColor Green
    Write-Host "Next: Restart VS Code and run .\Verify-WindowsSetup.ps1`n" -ForegroundColor Yellow
    exit 0
}

# === TIER 3: ULTIMATE (Maximum Power) ===
Write-Host "`n═══ TIER 3: ULTIMATE DEVELOPER STACK ═══`n" -ForegroundColor Cyan

Install-Tool -Name "VS Code Insiders" `
    -WingetId "Microsoft.VisualStudioCode.Insiders" `
    -Description "November 2025 features (tree-sitter, GitHub MCP)"

Install-PowerShellModule -Name "Pester" `
    -Description "PowerShell testing framework"

Install-PowerShellModule -Name "PSScriptAnalyzer" `
    -Description "Code quality and linting"

Install-PowerShellModule -Name "Az" `
    -Description "Azure PowerShell modules (advanced automation)"

Install-PowerShellModule -Name "Microsoft.Graph" `
    -Description "Microsoft Graph SDK for IdentityAgent"

if ($Tier -eq 'Ultimate') {
    Write-Host "`n✨ Ultimate installation complete!" -ForegroundColor Green
    Write-Host "Next: Restart VS Code and run .\Verify-WindowsSetup.ps1`n" -ForegroundColor Yellow
    exit 0
}

# === TIER 4: ENTERPRISE (Optional) ===
Write-Host "`n═══ TIER 4: ENTERPRISE SCALE ═══`n" -ForegroundColor Cyan

Install-Tool -Name "Kubernetes CLI (kubectl)" `
    -WingetId "Kubernetes.kubectl" `
    -Description "Container orchestration"

Install-Tool -Name "Terraform" `
    -WingetId "Hashicorp.Terraform" `
    -Description "Infrastructure as code"

Install-Tool -Name "Git Credential Manager" `
    -WingetId "Microsoft.GitCredentialManagerCore" `
    -Description "Seamless authentication"

Write-Host "`n📦 Installing Bicep CLI..." -ForegroundColor Cyan
if (-not $DryRun) {
    az bicep install
    Write-Host "   ✅ Bicep installed`n" -ForegroundColor Green
} else {
    Write-Host "   [DRY RUN] Would run: az bicep install`n" -ForegroundColor Cyan
}

# === FINAL SUMMARY ===
Write-Host "`n═══════════════════════════════════" -ForegroundColor Cyan
Write-Host "✨ Installation Complete!" -ForegroundColor Green
Write-Host "═══════════════════════════════════`n" -ForegroundColor Cyan

Write-Host "🔄 CRITICAL: Restart VS Code completely" -ForegroundColor Yellow
Write-Host "   Close all windows, reopen, open new terminal`n" -ForegroundColor Gray

Write-Host "✅ Next Steps:" -ForegroundColor Cyan
Write-Host "   1. Close and reopen VS Code" -ForegroundColor White
Write-Host "   2. Run: .\Verify-WindowsSetup.ps1" -ForegroundColor White
Write-Host "   3. Run: az login" -ForegroundColor White
Write-Host "   4. Run: .\Week1_Automation.ps1 -DryRun -SkipEmail`n" -ForegroundColor White
