# 🍫 Chocolatey Quick Reference for IntelIntent

## Overview

Chocolatey is your Windows package manager - like `apt` for Ubuntu or `brew` for macOS. It automates software installation, updates, and configuration.

**Your Current Setup:**
- ✅ Chocolatey v2.5.1 installed
- ✅ Python 3.14 installed
- ✅ Visual Studio Build Tools 2022 installed
- ✅ VC++ workload configured

---

## 📦 Essential Chocolatey Commands

### Package Management

```powershell
# Search for packages
choco search python

# Install package
choco install python -y

# Install specific version
choco install python --version=3.14 -y

# Upgrade package
choco upgrade python -y

# Upgrade all packages
choco upgrade all -y

# Uninstall package
choco uninstall python -y

# List installed packages
choco list --local-only

# Get package info
choco info python
```

### System Operations

```powershell
# Check Chocolatey version
choco --version

# Update Chocolatey itself
choco upgrade chocolatey -y

# Refresh environment variables (after installs)
refreshenv

# Clear cache
choco cleancache

# View logs
Get-Content $env:ChocolateyInstall\logs\chocolatey.log -Tail 50
```

---

## 🔧 IntelIntent Development Stack

### Core Tools (Already Installed ✅)

```powershell
# Python 3.14 with pip
choco install python --version=3.14 -y

# Visual Studio Build Tools 2022 with VC++
choco install visualstudio2022buildtools `
    --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools" -y

# Azure CLI
choco install azure-cli -y
```

### Recommended Additional Tools

```powershell
# PowerShell 7+ (if not already installed)
choco install powershell-core -y

# Git (if not already installed)
choco install git -y

# Node.js (for JavaScript workflows)
choco install nodejs -y

# Docker Desktop (for containerization)
choco install docker-desktop -y

# VS Code (if not already installed)
choco install vscode -y

# GitHub CLI
choco install gh -y

# Azure Storage Explorer
choco install microsoftazurestorageexplorer -y

# Terraform (for IaC)
choco install terraform -y
```

### Python Packages (via pip)

```powershell
# Azure SDK for Python
pip install azure-identity azure-mgmt-keyvault azure-storage-blob

# Microsoft Graph SDK
pip install msgraph-sdk

# OpenAI SDK
pip install openai

# Data science stack
pip install pandas numpy matplotlib jupyter

# Web frameworks
pip install flask fastapi uvicorn
```

---

## 🎯 IntelIntent Integration Patterns

### Pattern 1: Install Tool with Chocolatey, Configure with Script

```powershell
# Install Azure CLI
choco install azure-cli -y

# Refresh environment
refreshenv

# Authenticate
az login

# Use in Week1_Automation.ps1
Import-Module .\IntelIntent_Seeding\SecureSecretsManager.psm1
New-SecretVault -VaultName "IntelIntentSecrets" -ResourceGroup "Phase4RG"
```

### Pattern 2: Batch Install for New Workstation

Create `Install-IntelIntentDevTools.ps1`:

```powershell
<#
.SYNOPSIS
    One-click development environment setup for IntelIntent.
#>

param([switch]$MinimalInstall)

$coreTools = @(
    "python --version=3.14",
    "visualstudio2022buildtools --package-parameters `"--add Microsoft.VisualStudio.Workload.VCTools`"",
    "azure-cli",
    "git",
    "powershell-core"
)

$optionalTools = @(
    "nodejs",
    "docker-desktop",
    "vscode",
    "gh",
    "terraform"
)

Write-Host "🚀 Installing IntelIntent Development Stack..." -ForegroundColor Cyan

# Install core tools
foreach ($tool in $coreTools) {
    Write-Host "  Installing: $tool" -ForegroundColor Yellow
    choco install $tool -y
}

# Install optional tools
if (-not $MinimalInstall) {
    foreach ($tool in $optionalTools) {
        Write-Host "  Installing: $tool" -ForegroundColor Yellow
        choco install $tool -y
    }
}

# Refresh environment
refreshenv

Write-Host "`n✅ Installation complete!" -ForegroundColor Green
Write-Host "💡 Run: .\Verify-DevelopmentEnvironment.ps1" -ForegroundColor Cyan
```

Usage:
```powershell
# Full install
.\Install-IntelIntentDevTools.ps1

# Minimal install (core tools only)
.\Install-IntelIntentDevTools.ps1 -MinimalInstall
```

### Pattern 3: Verify Before Week 1 Automation

```powershell
# 1. Verify environment
.\Verify-DevelopmentEnvironment.ps1 -ExportReport

# 2. If issues found, fix automatically
.\Verify-DevelopmentEnvironment.ps1 -Fix

# 3. Refresh environment
refreshenv

# 4. Run Week 1 automation with DryRun
.\Week1_Automation.ps1 -DryRun -SkipEmail

# 5. If successful, run for real
.\Week1_Automation.ps1
```

---

## 🔍 Troubleshooting Common Issues

### Issue 1: "Command not found after install"

**Cause:** Environment variables not refreshed.

**Solution:**
```powershell
refreshenv
# Or restart PowerShell
```

### Issue 2: Visual Studio Build Tools installation warnings

**Cause:** Windows updates or feed connectivity issues.

**Solution:**
```powershell
# Verify installation
"C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat"
cl.exe

# If missing, reinstall
choco install visualstudio2022buildtools --force -y
```

### Issue 3: Python not in PATH

**Cause:** Chocolatey shim conflicts or PATH order.

**Solution:**
```powershell
# Check Python location
Get-Command python

# Add to PATH if needed
$env:Path = "C:\Python314;C:\Python314\Scripts;" + $env:Path

# Make permanent
[Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::User)
```

### Issue 4: Chocolatey outdated packages

**Solution:**
```powershell
# Check for updates
choco outdated

# Upgrade all
choco upgrade all -y

# Upgrade Chocolatey itself
choco upgrade chocolatey -y
```

### Issue 5: Permission denied errors

**Solution:**
```powershell
# Run PowerShell as Administrator
Start-Process pwsh -Verb RunAs

# Or use elevated Chocolatey command
choco install package --force -y
```

---

## 📊 Chocolatey Integration with IntelIntent Modules

### SecureSecretsManager.psm1

Install required tools:
```powershell
choco install azure-cli -y
refreshenv
az login
```

Usage in module:
```powershell
Import-Module .\IntelIntent_Seeding\SecureSecretsManager.psm1
New-SecretVault -VaultName "IntelIntentSecrets" -ResourceGroup "Phase4RG"
```

### CircuitBreaker.psm1

No additional Chocolatey packages required (pure PowerShell).

### CodexRenderer.psm1

Optional: Install pandoc for advanced Markdown rendering:
```powershell
choco install pandoc -y
```

### Week1_Automation.ps1

Prerequisites:
```powershell
# Ensure Azure CLI installed and authenticated
choco install azure-cli -y
az login

# Ensure PowerShell 7+
choco install powershell-core -y
```

---

## 🎓 Best Practices

### 1. Always Use `-y` Flag for Non-Interactive Installs
```powershell
choco install python -y
```

### 2. Pin Critical Versions
```powershell
# Pin Python to prevent unexpected upgrades
choco pin add --name python
```

### 3. Create Package Lists for Team Sync
```powershell
# Export installed packages
choco list --local-only > IntelIntent_ChocolateyPackages.txt

# Share with team
git add IntelIntent_ChocolateyPackages.txt
git commit -m "docs: Add Chocolatey package list"
```

### 4. Use Configuration Files
Create `chocolatey.config`:
```xml
<?xml version="1.0" encoding="utf-8"?>
<packages>
  <package id="python" version="3.14" />
  <package id="visualstudio2022buildtools" />
  <package id="azure-cli" />
  <package id="git" />
  <package id="powershell-core" />
</packages>
```

Install from config:
```powershell
choco install chocolatey.config -y
```

### 5. Schedule Automatic Updates
```powershell
# Create scheduled task for daily updates
$action = New-ScheduledTaskAction -Execute "choco" -Argument "upgrade all -y"
$trigger = New-ScheduledTaskTrigger -Daily -At 3am
Register-ScheduledTask -TaskName "ChocolateyDailyUpdate" -Action $action -Trigger $trigger
```

---

## 🚀 Quick Start for New IntelIntent Contributor

```powershell
# 1. Install Chocolatey (if not installed)
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# 2. Install IntelIntent dev stack
choco install python --version=3.14 -y
choco install visualstudio2022buildtools --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools" -y
choco install azure-cli git powershell-core -y

# 3. Refresh environment
refreshenv

# 4. Clone IntelIntent
git clone https://github.com/cf7928pdxg-sketch/IntelIntent.git
cd IntelIntent

# 5. Verify environment
.\Verify-DevelopmentEnvironment.ps1

# 6. Test production modules
.\Test-ProductionModules.ps1 -DryRun

# 7. Authenticate to Azure
az login

# 8. Run Week 1 automation
.\Week1_Automation.ps1 -DryRun -SkipEmail
```

---

## 📚 Additional Resources

- **Chocolatey Docs:** https://docs.chocolatey.org
- **Package Gallery:** https://community.chocolatey.org/packages
- **IntelIntent Repo:** https://github.com/cf7928pdxg-sketch/IntelIntent
- **Azure CLI Docs:** https://learn.microsoft.com/cli/azure/
- **Python Docs:** https://docs.python.org/3.14/

---

*Chocolatey Quick Reference for IntelIntent - Created November 30, 2025*
