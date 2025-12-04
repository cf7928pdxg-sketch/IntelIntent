<#
.SYNOPSIS
    Comprehensive development environment verification for IntelIntent.

.DESCRIPTION
    Validates all critical tools and their integration readiness:
    - Chocolatey package manager
    - Python 3.14 with pip
    - Visual Studio Build Tools (VC++)
    - Azure CLI
    - Git
    - PowerShell 7+
    - Node.js (optional)

.PARAMETER Fix
    Attempt to fix common issues automatically.

.PARAMETER ExportReport
    Export verification results to JSON file.

.EXAMPLE
    .\Verify-DevelopmentEnvironment.ps1

.EXAMPLE
    .\Verify-DevelopmentEnvironment.ps1 -Fix -ExportReport
#>

param(
    [switch]$Fix,
    [switch]$ExportReport
)

$ErrorActionPreference = 'Continue'

Write-Host @'

╔══════════════════════════════════════════════════════════╗
║   IntelIntent Development Environment Verification      ║
╚══════════════════════════════════════════════════════════╝

'@ -ForegroundColor Cyan

# === Verification Results ===
$script:VerificationResults = @{
    Timestamp       = Get-Date -Format 'o'
    Environment     = @{
        OS                = [System.Environment]::OSVersion.VersionString
        PowerShellVersion = $PSVersionTable.PSVersion.ToString()
        User              = $env:USERNAME
        ComputerName      = $env:COMPUTERNAME
    }
    Tools           = @()
    Issues          = @()
    Recommendations = @()
}

# === Helper Functions ===
function Test-Tool {
    param(
        [string]$Name,
        [string]$Command,
        [string]$VersionArg = '--version',
        [scriptblock]$CustomCheck,
        [string]$ExpectedPath,
        [string]$InstallCommand
    )

    Write-Host "`n🔍 Checking: $Name" -ForegroundColor Yellow

    $result = @{
        Name      = $Name
        Installed = $false
        Version   = $null
        Path      = $null
        Issues    = @()
    }

    try {
        if ($CustomCheck) {
            $checkResult = & $CustomCheck
            $result.Installed = $checkResult.Installed
            $result.Version = $checkResult.Version
            $result.Path = $checkResult.Path
        } else {
            # Standard command check
            $cmdInfo = Get-Command $Command -ErrorAction SilentlyContinue

            if ($cmdInfo) {
                $result.Installed = $true
                $result.Path = $cmdInfo.Source

                # Get version
                try {
                    $versionOutput = & $Command $VersionArg 2>&1 | Out-String
                    $result.Version = ($versionOutput -split "`n")[0].Trim()
                } catch {
                    $result.Version = 'Unknown'
                }
            }
        }

        if ($result.Installed) {
            Write-Host '  ✅ INSTALLED' -ForegroundColor Green
            Write-Host "     Version: $($result.Version)" -ForegroundColor Gray
            Write-Host "     Path: $($result.Path)" -ForegroundColor Gray
        } else {
            Write-Host '  ❌ NOT FOUND' -ForegroundColor Red
            $result.Issues += 'Tool not installed or not in PATH'

            if ($InstallCommand) {
                Write-Host "     Install with: $InstallCommand" -ForegroundColor Yellow
                $script:VerificationResults.Recommendations += "Install $Name : $InstallCommand"
            }
        }
    } catch {
        Write-Host "  ❌ ERROR: $_" -ForegroundColor Red
        $result.Issues += $_.Exception.Message
    }

    $script:VerificationResults.Tools += $result
    return $result
}

function Test-PathVariable {
    param([string[]]$RequiredPaths)

    Write-Host "`n🔍 Checking PATH variable" -ForegroundColor Yellow

    $currentPath = $env:Path -split ';'
    $missing = @()

    foreach ($path in $RequiredPaths) {
        if ($currentPath -contains $path) {
            Write-Host "  ✅ $path" -ForegroundColor Green
        } else {
            Write-Host "  ❌ Missing: $path" -ForegroundColor Red
            $missing += $path
        }
    }

    if ($missing.Count -gt 0) {
        $script:VerificationResults.Issues += "Missing PATH entries: $($missing -join ', ')"

        if ($Fix) {
            Write-Host "`n  🔧 Adding missing paths..." -ForegroundColor Cyan
            foreach ($path in $missing) {
                [Environment]::SetEnvironmentVariable(
                    'Path',
                    $env:Path + ";$path",
                    [EnvironmentVariableTarget]::User
                )
            }
            Write-Host '  ✅ PATH updated (restart shell to apply)' -ForegroundColor Green
        }
    }

    return $missing.Count -eq 0
}

# === Tool Checks ===

# 1. Chocolatey
Test-Tool -Name 'Chocolatey' -Command 'choco' -InstallCommand "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

# 2. Python 3.14
$pythonResult = Test-Tool -Name 'Python 3.14' -Command 'python' -CustomCheck {
    $pythonCmd = Get-Command python -ErrorAction SilentlyContinue

    if ($pythonCmd) {
        $version = python --version 2>&1
        $versionNumber = ($version -replace 'Python ', '').Trim()

        return @{
            Installed = $true
            Version   = $versionNumber
            Path      = $pythonCmd.Source
        }
    }

    return @{ Installed = $false }
} -InstallCommand 'choco install python --version=3.14 -y'

# Check pip
if ($pythonResult.Installed) {
    Test-Tool -Name 'pip (Python Package Manager)' -Command 'pip' -VersionArg '--version'
}

# 3. Visual Studio Build Tools
Test-Tool -Name 'Visual Studio Build Tools 2022' -Command 'cl' -CustomCheck {
    $vsPath = 'C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools'
    $clPath = "$vsPath\VC\Tools\MSVC"

    if (Test-Path $vsPath) {
        # Find cl.exe
        $clExe = Get-ChildItem -Path $clPath -Recurse -Filter 'cl.exe' -ErrorAction SilentlyContinue | Select-Object -First 1

        if ($clExe) {
            # Get version
            $versionOutput = & $clExe.FullName 2>&1 | Out-String
            $version = ($versionOutput -split "`n")[0] -replace '.*Version ([0-9.]+).*', '$1'

            return @{
                Installed = $true
                Version   = "MSVC $version"
                Path      = $clExe.FullName
            }
        }
    }

    return @{ Installed = $false }
} -InstallCommand "choco install visualstudio2022buildtools --package-parameters `"--add Microsoft.VisualStudio.Workload.VCTools`" -y"

# 4. Azure CLI
Test-Tool -Name 'Azure CLI' -Command 'az' -InstallCommand 'choco install azure-cli -y'

# 5. Git
Test-Tool -Name 'Git' -Command 'git' -InstallCommand 'choco install git -y'

# 6. PowerShell 7+
Test-Tool -Name 'PowerShell 7+' -Command 'pwsh' -InstallCommand 'choco install powershell-core -y'

# 7. Node.js (Optional)
Test-Tool -Name 'Node.js (Optional)' -Command 'node' -VersionArg '--version' -InstallCommand 'choco install nodejs -y'

# 8. Docker (Optional)
Test-Tool -Name 'Docker (Optional)' -Command 'docker' -InstallCommand 'choco install docker-desktop -y'

# === PATH Verification ===
$requiredPaths = @(
    'C:\ProgramData\chocolatey\bin',
    'C:\Python314',
    'C:\Python314\Scripts'
)

Test-PathVariable -RequiredPaths $requiredPaths

# === IntelIntent-Specific Checks ===
Write-Host "`n🔍 Checking IntelIntent Prerequisites" -ForegroundColor Yellow

# Check if in IntelIntent directory
$currentDir = Get-Location
$isIntelIntentRepo = (Test-Path '.\Week1_Automation.ps1') -and (Test-Path '.\IntelIntent_Seeding')

if ($isIntelIntentRepo) {
    Write-Host '  ✅ Running in IntelIntent repository' -ForegroundColor Green
} else {
    Write-Host '  ⚠️ Not in IntelIntent repository directory' -ForegroundColor Yellow
    $script:VerificationResults.Issues += 'Current directory is not IntelIntent repository'
}

# Check PowerShell modules
$requiredModules = @(
    '.\IntelIntent_Seeding\SecureSecretsManager.psm1',
    '.\IntelIntent_Seeding\CircuitBreaker.psm1',
    '.\IntelIntent_Seeding\AgentBridge.psm1'
)

Write-Host "`n  📦 Production Modules:" -ForegroundColor Cyan
foreach ($module in $requiredModules) {
    if (Test-Path $module) {
        $lineCount = (Get-Content $module -ErrorAction SilentlyContinue).Count
        Write-Host "    ✅ $(Split-Path $module -Leaf) ($lineCount lines)" -ForegroundColor Green
    } else {
        Write-Host "    ❌ $(Split-Path $module -Leaf) NOT FOUND" -ForegroundColor Red
        $script:VerificationResults.Issues += "Missing module: $(Split-Path $module -Leaf)"
    }
}

# === Azure Connectivity ===
Write-Host "`n🔍 Checking Azure Connectivity" -ForegroundColor Yellow

$azResult = Test-Tool -Name 'Azure Authentication' -Command 'az' -CustomCheck {
    try {
        $account = az account show 2>$null | ConvertFrom-Json

        if ($account) {
            return @{
                Installed = $true
                Version   = "Authenticated as $($account.user.name)"
                Path      = "Subscription: $($account.name)"
            }
        }
    } catch {}

    return @{
        Installed = $false
        Version   = 'Not authenticated'
    }
}

if (-not $azResult.Installed) {
    Write-Host '    💡 Run: az login' -ForegroundColor Yellow
    $script:VerificationResults.Recommendations += 'Authenticate to Azure: az login'
}

# === Summary ===
Write-Host @'

╔══════════════════════════════════════════════════════════╗
║                   Verification Summary                   ║
╚══════════════════════════════════════════════════════════╝

'@ -ForegroundColor Cyan

$installedCount = ($script:VerificationResults.Tools | Where-Object { $_.Installed }).Count
$totalCount = $script:VerificationResults.Tools.Count
$percentage = [Math]::Round(($installedCount / $totalCount) * 100, 2)

Write-Host "Tools Installed: $installedCount / $totalCount ($percentage%)" -ForegroundColor White
Write-Host "Issues Found: $($script:VerificationResults.Issues.Count)" -ForegroundColor $(if ($script:VerificationResults.Issues.Count -eq 0) { 'Green' } else { 'Yellow' })

if ($script:VerificationResults.Issues.Count -gt 0) {
    Write-Host "`n⚠️ Issues Detected:" -ForegroundColor Yellow
    $script:VerificationResults.Issues | ForEach-Object {
        Write-Host "  • $_" -ForegroundColor Red
    }
}

if ($script:VerificationResults.Recommendations.Count -gt 0) {
    Write-Host "`n💡 Recommendations:" -ForegroundColor Cyan
    $script:VerificationResults.Recommendations | ForEach-Object {
        Write-Host "  • $_" -ForegroundColor Yellow
    }
}

# === Next Steps ===
Write-Host @'

📋 Next Steps for IntelIntent:

1️⃣ Refresh Environment
   refreshenv
   # Or restart PowerShell

2️⃣ Test Production Modules
   .\Test-ProductionModules.ps1 -DryRun

3️⃣ Authenticate to Azure
   az login

4️⃣ Run Week 1 Automation
   .\Week1_Automation.ps1 -DryRun -SkipEmail

5️⃣ Deploy Universal Integration
   .\IntelIntent-Seed\scripts\Deploy-UniversalIntegration.ps1 -Context "developer" -DryRun

'@ -ForegroundColor Cyan

# === Export Report ===
if ($ExportReport) {
    $reportPath = ".\Verification_Report_$(Get-Date -Format 'yyyyMMdd_HHmmss').json"
    $script:VerificationResults | ConvertTo-Json -Depth 10 | Set-Content -Path $reportPath
    Write-Host "✅ Report exported to: $reportPath" -ForegroundColor Green
}

# === Exit Code ===
if ($script:VerificationResults.Issues.Count -eq 0) {
    Write-Host "`n🎉 Environment fully configured!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n⚠️ Some issues require attention" -ForegroundColor Yellow
    exit 1
}
