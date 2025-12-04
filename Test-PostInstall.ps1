<#
.SYNOPSIS
    Post-installation verification script for IntelIntent Phase 4 environment.

.DESCRIPTION
    Verifies critical tools and connectivity after Deploy-IntelIntentPhase4.ps1 execution:
    - Azure CLI version and authentication status
    - PowerShell 7+ installation and version
    - Chocolatey, Python, pip, Git, VS Code, Node.js
    - IntelIntent repository structure and production modules
    - Azure connectivity (optional)
    - Calculates readiness score (0-100%)
    - Exports detailed JSON report

.PARAMETER ExportReport
    Export verification results to JSON file.

.PARAMETER TestAzureConnectivity
    Test Azure CLI connectivity with 'az account show'.

.EXAMPLE
    .\Test-PostInstall.ps1
    Run basic post-install verification.

.EXAMPLE
    .\Test-PostInstall.ps1 -ExportReport -TestAzureConnectivity
    Full verification with Azure connectivity check and JSON export.

.NOTES
    Author: IntelIntent Orchestration Team
    Version: 1.0.0
    Created: 2025-11-30
#>

param(
    [switch]$ExportReport,
    [switch]$TestAzureConnectivity
)

# === Configuration ===
$ErrorActionPreference = "Continue"

$script:VerificationResults = @{
    Timestamp = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")
    Tools = @{}
    IntelIntent = @{}
    Azure = @{}
    ReadinessScore = 0
}

# === Helper Functions ===

function Write-SectionHeader {
    param([string]$Title)
    Write-Host "`n╔══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║  $($Title.PadRight(56))║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
}

function Test-Tool {
    param(
        [string]$Name,
        [string]$Command,
        [string]$VersionArg = "--version",
        [scriptblock]$CustomCheck = $null,
        [string]$ExpectedVersion = $null
    )

    try {
        if ($CustomCheck) {
            $result = & $CustomCheck
            $installed = $result -ne $null
            $version = if ($installed) { $result } else { "N/A" }
        } else {
            $cmd = Get-Command $Command -ErrorAction SilentlyContinue
            $installed = $cmd -ne $null

            if ($installed) {
                $versionOutput = & $Command $VersionArg 2>&1 | Select-Object -First 1
                $version = $versionOutput -replace '.*?(\d+\.\d+\.\d+).*', '$1'
            } else {
                $version = "Not Installed"
            }
        }

        $status = if ($installed) { "✅" } else { "❌" }
        $color = if ($installed) { "Green" } else { "Red" }

        Write-Host "  $status $Name - $version" -ForegroundColor $color

        $script:VerificationResults.Tools[$Name] = @{
            Installed = $installed
            Version = $version
            Command = $Command
        }

        return $installed
    }
    catch {
        Write-Host "  ❌ $Name - Error: $_" -ForegroundColor Red
        $script:VerificationResults.Tools[$Name] = @{
            Installed = $false
            Version = "Error"
            Error = $_.Exception.Message
        }
        return $false
    }
}

function Test-AzureAuthentication {
    try {
        $accountInfo = az account show 2>&1 | ConvertFrom-Json

        if ($accountInfo) {
            Write-Host "  ✅ Azure CLI authenticated" -ForegroundColor Green
            Write-Host "    • Subscription: $($accountInfo.name)" -ForegroundColor Gray
            Write-Host "    • Tenant: $($accountInfo.tenantId)" -ForegroundColor Gray

            $script:VerificationResults.Azure = @{
                Authenticated = $true
                Subscription = $accountInfo.name
                SubscriptionId = $accountInfo.id
                TenantId = $accountInfo.tenantId
                User = $accountInfo.user.name
            }

            return $true
        }
    }
    catch {
        Write-Host "  ❌ Azure CLI not authenticated" -ForegroundColor Red
        Write-Host "    💡 Run: az login" -ForegroundColor Yellow

        $script:VerificationResults.Azure = @{
            Authenticated = $false
            Error = "Not authenticated"
        }

        return $false
    }
}

# === Main Verification ===

Write-SectionHeader "IntelIntent Phase 4 Post-Install Verification"

# === Tool Verification ===
Write-Host "`n🔍 Verifying Development Tools..." -ForegroundColor Cyan

$toolChecks = @(
    @{ Name = "Chocolatey"; Command = "choco"; VersionArg = "--version" },
    @{ Name = "PowerShell 7+"; Command = "pwsh"; VersionArg = "--version" },
    @{ Name = "Azure CLI"; Command = "az"; VersionArg = "--version" },
    @{ Name = "Python"; Command = "python"; VersionArg = "--version" },
    @{ Name = "pip"; Command = "pip"; VersionArg = "--version" },
    @{ Name = "Git"; Command = "git"; VersionArg = "--version" },
    @{ Name = "VS Code"; Command = "code"; VersionArg = "--version" },
    @{ Name = "Node.js"; Command = "node"; VersionArg = "--version" }
)

$installedCount = 0
foreach ($check in $toolChecks) {
    if (Test-Tool @check) {
        $installedCount++
    }
}

# === PowerShell Version Check ===
Write-Host "`n🔍 PowerShell Version Details..." -ForegroundColor Cyan
$psVersion = $PSVersionTable.PSVersion
Write-Host "  Current Session: PowerShell $($psVersion.Major).$($psVersion.Minor).$($psVersion.Patch)" -ForegroundColor $(if ($psVersion.Major -ge 7) { "Green" } else { "Yellow" })

if ($psVersion.Major -lt 7) {
    Write-Host "  ⚠️ Running Windows PowerShell 5.1. PowerShell 7+ recommended for IntelIntent." -ForegroundColor Yellow
    Write-Host "    💡 Launch PowerShell 7+: pwsh" -ForegroundColor Yellow
}

$script:VerificationResults.Tools["Current PowerShell Session"] = @{
    Version = "$($psVersion.Major).$($psVersion.Minor).$($psVersion.Patch)"
    IsCore = $psVersion.Major -ge 7
}

# === IntelIntent Repository Check ===
Write-Host "`n🔍 IntelIntent Repository Status..." -ForegroundColor Cyan

$intelIntentMarker = ".\IntelIntent_Seeding"
if (Test-Path $intelIntentMarker) {
    Write-Host "  ✅ Running in IntelIntent repository" -ForegroundColor Green
    $script:VerificationResults.IntelIntent["Repository"] = $true

    # Check production modules
    $modules = @(
        ".\IntelIntent_Seeding\SecureSecretsManager.psm1",
        ".\IntelIntent_Seeding\CircuitBreaker.psm1",
        ".\IntelIntent_Seeding\AgentBridge.psm1",
        ".\IntelIntent_Seeding\CopilotLifecycleTracker.psm1",
        ".\IntelIntent_Seeding\Get-CodexEmailBody.psm1"
    )

    foreach ($module in $modules) {
        if (Test-Path $module) {
            $moduleName = [System.IO.Path]::GetFileNameWithoutExtension($module)
            $lineCount = (Get-Content $module).Count
            Write-Host "  ✅ $moduleName.psm1 ($lineCount lines)" -ForegroundColor Green

            $script:VerificationResults.IntelIntent[$moduleName] = @{
                Present = $true
                LineCount = $lineCount
                Path = $module
            }
        } else {
            $moduleName = [System.IO.Path]::GetFileNameWithoutExtension($module)
            Write-Host "  ❌ $moduleName.psm1 not found" -ForegroundColor Red

            $script:VerificationResults.IntelIntent[$moduleName] = @{
                Present = $false
                Path = $module
            }
        }
    }
} else {
    Write-Host "  ❌ Not running in IntelIntent repository" -ForegroundColor Red
    $script:VerificationResults.IntelIntent["Repository"] = $false
}

# === Azure Connectivity Check ===
if ($TestAzureConnectivity) {
    Write-Host "`n🔍 Azure Connectivity..." -ForegroundColor Cyan
    Test-AzureAuthentication
}

# === Readiness Score Calculation ===
Write-Host "`n📊 Readiness Score Calculation..." -ForegroundColor Cyan

$totalTools = $toolChecks.Count
$readinessScore = [math]::Round(($installedCount / $totalTools) * 100)

Write-Host "  Tools Installed: $installedCount / $totalTools ($readinessScore%)" -ForegroundColor $(if ($readinessScore -ge 80) { "Green" } elseif ($readinessScore -ge 60) { "Yellow" } else { "Red" })

$script:VerificationResults.ReadinessScore = $readinessScore

# === Recommendations ===
Write-Host "`n💡 Recommendations..." -ForegroundColor Cyan

$recommendations = @()

if (-not $script:VerificationResults.Tools["PowerShell 7+"].Installed) {
    $recommendations += "Install PowerShell 7+: choco install powershell-core -y"
}

if (-not $script:VerificationResults.Tools["Azure CLI"].Installed) {
    $recommendations += "Install Azure CLI: choco install azure-cli -y"
}

if ($TestAzureConnectivity -and -not $script:VerificationResults.Azure.Authenticated) {
    $recommendations += "Authenticate to Azure: az login"
}

if ($psVersion.Major -lt 7) {
    $recommendations += "Launch PowerShell 7+ session: pwsh"
}

if ($recommendations.Count -eq 0) {
    Write-Host "  ✅ Environment fully configured!" -ForegroundColor Green
} else {
    foreach ($rec in $recommendations) {
        Write-Host "  • $rec" -ForegroundColor Yellow
    }
}

# === Next Steps ===
Write-Host "`n📋 Next Steps..." -ForegroundColor Cyan

if ($readinessScore -ge 80) {
    Write-Host "  1️⃣ Restart PowerShell to apply PATH changes: exit" -ForegroundColor Green
    Write-Host "  2️⃣ Authenticate to Azure: az login" -ForegroundColor Green
    Write-Host "  3️⃣ Run production module tests: .\Test-ProductionModules.ps1 -DryRun" -ForegroundColor Green
    Write-Host "  4️⃣ Execute Week 1 automation: .\Week1_Automation.ps1 -DryRun -SkipEmail" -ForegroundColor Green
    Write-Host "  5️⃣ Deploy universal integration: .\IntelIntent-Seed\scripts\Deploy-UniversalIntegration.ps1 -Context 'developer' -DryRun" -ForegroundColor Green
} else {
    Write-Host "  1️⃣ Install missing tools (see recommendations above)" -ForegroundColor Yellow
    Write-Host "  2️⃣ Run: refreshenv (or restart PowerShell)" -ForegroundColor Yellow
    Write-Host "  3️⃣ Re-run this verification: .\Test-PostInstall.ps1" -ForegroundColor Yellow
}

# === Export Report ===
if ($ExportReport) {
    Write-Host "`n📄 Exporting Verification Report..." -ForegroundColor Cyan

    $reportPath = ".\Sponsors\PostInstall_Verification_Report.json"

    # Ensure Sponsors directory exists
    if (-not (Test-Path ".\Sponsors")) {
        New-Item -ItemType Directory -Path ".\Sponsors" -Force | Out-Null
    }

    $script:VerificationResults | ConvertTo-Json -Depth 10 | Set-Content $reportPath

    Write-Host "  ✅ Report exported: $reportPath" -ForegroundColor Green
}

# === Exit Code ===
if ($readinessScore -ge 80 -and $script:VerificationResults.IntelIntent.Repository) {
    Write-Host "`n✅ Post-install verification passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n⚠️ Post-install verification completed with warnings. Review recommendations above." -ForegroundColor Yellow
    exit 1
}
