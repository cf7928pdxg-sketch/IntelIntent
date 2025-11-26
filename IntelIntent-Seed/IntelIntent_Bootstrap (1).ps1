
# IntelIntent Bootstrap Script
# Author: Copilot
# Description: Modular PowerShell script for backup, restart, seeding, and recursive preparedness

# -------------------------------
# 1. Backup Module
# -------------------------------
Write-Host "Starting Backup Module..."

$backupFolders = @("C:\Users\Public\Documents", "$env:USERPROFILE\OneDrive", "$env:USERPROFILE\Projects")
$backupDestination = "C:\IntelIntent_Backup"

foreach ($folder in $backupFolders) {
    $dest = Join-Path $backupDestination (Split-Path $folder -Leaf)
    Write-Host "Backing up $folder to $dest"
    robocopy $folder $dest /E /Z /R:3 /W:5
}

# Export environment variables
Get-ChildItem Env: | Export-Csv "$backupDestination\env_variables.csv" -NoTypeInformation

# Export registry keys (example)
reg export HKCU "$backupDestination\HKCU_Backup.reg" /y

# -------------------------------
# 2. Restart Module
# -------------------------------
Write-Host "Initiating System Restart..."
# Uncomment below for actual restart
# Restart-Computer -Force

# -------------------------------
# 3. Seed & Propagation Module
# -------------------------------
Write-Host "Seeding IntelIntent Environment..."

# Clone GitHub repositories
$repos = @(
    "https://github.com/IntelIntent/Core",
    "https://github.com/IntelIntent/Agents",
    "https://github.com/IntelIntent/Dashboard"
)
$clonePath = "$env:USERPROFILE\IntelIntent"

foreach ($repo in $repos) {
    git clone $repo $clonePath\$(Split-Path $repo -Leaf)
}

# Sync OneDrive
Write-Host "Syncing OneDrive..."
Start-Process "OneDrive.exe"

# Install apps via Winget
$apps = @("Microsoft.VisualStudioCode", "Git.Git", "Nodejs.Nodejs", "Python.Python.3")
foreach ($app in $apps) {
    winget install --id=$app --silent --accept-package-agreements --accept-source-agreements
}

# Set environment variables
[System.Environment]::SetEnvironmentVariable("INTELINTENT_HOME", "$clonePath", "User")
[System.Environment]::SetEnvironmentVariable("INTELINTENT_MODE", "Recursive", "User")

# -------------------------------
# 4. Recursive Preparedness Checkpoint
# -------------------------------
Write-Host "Running Recursive Preparedness Checkpoint..."

$checkpointLog = "$clonePath\preparedness_log.txt"
$currentState = @{
    Timestamp = (Get-Date)
    InstalledApps = $apps
    ClonedRepos = $repos
    EnvironmentVariables = @{
        INTELINTENT_HOME = "$clonePath"
        INTELINTENT_MODE = "Recursive"
    }
}

$currentState | Out-File $checkpointLog

# Compare with future-current state (mock logic)
$futureGoals = @{
    INTELINTENT_MODE = "Recursive"
    RequiredApps = @("Microsoft.VisualStudioCode", "Git.Git", "Nodejs.Nodejs", "Python.Python.3")
}

if ($currentState.EnvironmentVariables.INTELINTENT_MODE -ne $futureGoals.INTELINTENT_MODE) {
    Write-Warning "Mode mismatch with future-current state!"
}

Write-Host "Bootstrap completed. IntelIntent system is seeded and ready."
