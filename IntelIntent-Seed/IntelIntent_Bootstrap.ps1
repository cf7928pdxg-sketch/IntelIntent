
# IntelIntent Bootstrap Script
# Author: Copilot
# Description: Automates setup of a fully configured environment for IntelIntent using Winget, GitHub, OneDrive, and environment variables.

# -------------------------------
# Function: Install Applications
# -------------------------------
function Install-Applications {
    Write-Host "Installing applications via Winget..."
    $apps = @(
        "Microsoft.VisualStudioCode.Insiders",
        "Git.Git",
        "OpenJS.NodeJS",
        "Python.Python.3",
        "Microsoft.AzureCLI",
        "GitHub.cli"
    )
    foreach ($app in $apps) {
        winget install --id=$app --silent --accept-package-agreements --accept-source-agreements
    }
}

# -------------------------------
# Function: Clone GitHub Repos
# -------------------------------
function Clone-Repositories {
    Write-Host "Cloning GitHub repositories..."
    $repos = @(
        "https://github.com/NicIntel/IntelIntent-Core",
        "https://github.com/NicIntel/IntelIntent-Agents",
        "https://github.com/NicIntel/IntelIntent-UI"
    )
    $targetDir = "$env:USERPROFILE\IntelIntent"
    if (!(Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir
    }
    Set-Location $targetDir
    foreach ($repo in $repos) {
        git clone $repo
    }
}

# -------------------------------
# Function: Setup OneDrive Folders
# -------------------------------
function Setup-OneDriveFolders {
    Write-Host "Setting up OneDrive folders..."
    $oneDrivePath = "$env:OneDrive\IntelIntent"
    $folders = @("Data", "Logs", "Configs", "Snapshots")
    foreach ($folder in $folders) {
        $fullPath = Join-Path $oneDrivePath $folder
        if (!(Test-Path $fullPath)) {
            New-Item -ItemType Directory -Path $fullPath
        }
    }
}

# -------------------------------
# Function: Configure Environment Variables
# -------------------------------
function Configure-Environment {
    Write-Host "Configuring environment variables..."
    [Environment]::SetEnvironmentVariable("INTELINTENT_HOME", "$env:USERPROFILE\IntelIntent", "User")
    [Environment]::SetEnvironmentVariable("INTELINTENT_CONFIG", "$env:OneDrive\IntelIntent\Configs\config.json", "User")
}

# -------------------------------
# Function: Run All Setup Steps
# -------------------------------
function Run-Bootstrap {
    Install-Applications
    Clone-Repositories
    Setup-OneDriveFolders
    Configure-Environment
    Write-Host "IntelIntent environment setup complete."
}

# Execute the bootstrap
Run-Bootstrap
