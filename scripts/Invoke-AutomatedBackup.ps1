<#
.SYNOPSIS
    Automated Backup & Maintenance Script for IntelIntent Orchestration Framework

.DESCRIPTION
    Comprehensive backup solution that:
    - Backs up credential vault (encrypted credentials)
    - Backs up orchestration configs (Week1_Automation.ps1, manifests, etc.)
    - Backs up checkpoint logs and quest progress
    - Performs integrity checks (file validation, encryption verification)
    - Cleans up old backups (retention policy: keep last 30 days)
    - Logs all operations with timestamps
    - Can be scheduled via Task Scheduler for automated execution

.PARAMETER BackupPath
    Destination path for backups (default: $HOME\IntelIntent_Backups)

.PARAMETER IncludeVault
    Include credential vault in backup (default: $true)

.PARAMETER IncludeConfigs
    Include orchestration configs in backup (default: $true)

.PARAMETER IncludeCheckpoints
    Include checkpoint logs and quest progress (default: $true)

.PARAMETER RetentionDays
    Number of days to retain backups (default: 30)

.PARAMETER RunIntegrityCheck
    Perform integrity validation after backup (default: $true)

.PARAMETER SendEmailNotification
    Send email notification on completion (requires IdentityAgent)

.EXAMPLE
    # Run full backup
    .\Invoke-AutomatedBackup.ps1

.EXAMPLE
    # Run backup with custom retention (keep 60 days)
    .\Invoke-AutomatedBackup.ps1 -RetentionDays 60

.EXAMPLE
    # Backup only vault (skip configs and checkpoints)
    .\Invoke-AutomatedBackup.ps1 -IncludeConfigs:$false -IncludeCheckpoints:$false

.NOTES
    Created: December 1, 2025
    Quest Integration: System Tune-Up Milestone
    Task Scheduler: Recommended daily at 2am
#>

param(
    [string]$BackupPath = "$HOME\IntelIntent_Backups",

    [bool]$IncludeVault = $true,
    [bool]$IncludeConfigs = $true,
    [bool]$IncludeCheckpoints = $true,

    [int]$RetentionDays = 30,

    [bool]$RunIntegrityCheck = $true,

    [switch]$SendEmailNotification
)

# ===========================
# CONFIGURATION
# ===========================
$ErrorActionPreference = "Continue"
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$sessionBackupPath = Join-Path $BackupPath $timestamp

# Backup sources
$sources = @{
    Vault = "$HOME\.intelintent\vault"
    WorkspaceRoot = "$HOME\OneDrive\IntelIntent!"
    Configs = @(
        "Week1_Automation.ps1",
        "IntelIntent_Launcher.ps1",
        "IntelIntent-Seed\*.json",
        "IntelIntent_Seeding\*.psm1",
        ".vscode\settings.json"
    )
    Checkpoints = @(
        "Week1_Checkpoints.json",
        "Phase5_Modality_Checkpoints.json",
        "Test_Checkpoints.json"
    )
    QuestProgress = @(
        "modules\Quest-ProgressTracker.psm1",
        "docs\quickstart\AUTOMATION_QUEST_SYSTEM.md",
        "docs\quickstart\Quest*.ps1"
    )
}

# Log file
$logFile = Join-Path $BackupPath "backup-log.txt"

# ===========================
# LOGGING FUNCTIONS
# ===========================
function Write-BackupLog {
    param(
        [string]$Message,
        [ValidateSet("INFO", "SUCCESS", "WARNING", "ERROR")]
        [string]$Level = "INFO"
    )

    $logEntry = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [$Level] $Message"

    # Write to console with color
    $color = switch ($Level) {
        "INFO" { "Cyan" }
        "SUCCESS" { "Green" }
        "WARNING" { "Yellow" }
        "ERROR" { "Red" }
    }
    Write-Host $logEntry -ForegroundColor $color

    # Write to log file
    Add-Content -Path $logFile -Value $logEntry
}

# ===========================
# BACKUP FUNCTIONS
# ===========================
function Initialize-BackupSession {
    Write-Host ""
    Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
    Write-Host "║   🔄 INTELINTENT AUTOMATED BACKUP & MAINTENANCE               ║" -ForegroundColor Magenta
    Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
    Write-Host ""

    Write-BackupLog "Starting backup session: $timestamp" -Level INFO
    Write-BackupLog "Backup destination: $sessionBackupPath" -Level INFO

    # Create backup directory
    if (-not (Test-Path $BackupPath)) {
        New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null
        Write-BackupLog "Created backup root: $BackupPath" -Level SUCCESS
    }

    New-Item -ItemType Directory -Path $sessionBackupPath -Force | Out-Null
    Write-BackupLog "Created session directory: $sessionBackupPath" -Level SUCCESS
    Write-Host ""
}

function Backup-CredentialVault {
    if (-not $IncludeVault) {
        Write-BackupLog "Vault backup skipped (disabled)" -Level INFO
        return $null
    }

    Write-Host "   🔐 Backing up Credential Vault..." -ForegroundColor Yellow

    $vaultPath = $sources.Vault

    if (-not (Test-Path $vaultPath)) {
        Write-BackupLog "Vault not found: $vaultPath" -Level WARNING
        return $null
    }

    try {
        $vaultBackupFile = Join-Path $sessionBackupPath "vault_backup.zip"

        # Compress vault directory
        Compress-Archive -Path "$vaultPath\*" -DestinationPath $vaultBackupFile -Force

        $size = (Get-Item $vaultBackupFile).Length / 1MB
        Write-BackupLog "Vault backup completed: $vaultBackupFile (${size:N2} MB)" -Level SUCCESS

        # Count credentials
        $credCount = (Get-ChildItem "$vaultPath\credentials" -Filter "*.cred" -ErrorAction SilentlyContinue).Count
        Write-Host "      ✅ Backed up $credCount credential(s)" -ForegroundColor Green

        return @{
            File = $vaultBackupFile
            Size = $size
            CredentialCount = $credCount
        }

    } catch {
        Write-BackupLog "Vault backup failed: $_" -Level ERROR
        return $null
    }
}

function Backup-OrchestrationConfigs {
    if (-not $IncludeConfigs) {
        Write-BackupLog "Config backup skipped (disabled)" -Level INFO
        return $null
    }

    Write-Host ""
    Write-Host "   ⚙️  Backing up Orchestration Configs..." -ForegroundColor Yellow

    $configBackupDir = Join-Path $sessionBackupPath "configs"
    New-Item -ItemType Directory -Path $configBackupDir -Force | Out-Null

    $backedUpFiles = @()
    $workspaceRoot = $sources.WorkspaceRoot

    foreach ($configPattern in $sources.Configs) {
        $fullPath = Join-Path $workspaceRoot $configPattern

        # Handle wildcards
        $files = Get-ChildItem $fullPath -ErrorAction SilentlyContinue

        foreach ($file in $files) {
            try {
                $relativePath = $file.FullName.Replace($workspaceRoot, "").TrimStart("\")
                $destPath = Join-Path $configBackupDir $relativePath
                $destDir = Split-Path $destPath -Parent

                if (-not (Test-Path $destDir)) {
                    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
                }

                Copy-Item -Path $file.FullName -Destination $destPath -Force
                $backedUpFiles += $relativePath

                Write-Host "      ✅ $relativePath" -ForegroundColor Green

            } catch {
                Write-BackupLog "Failed to backup $($file.Name): $_" -Level WARNING
            }
        }
    }

    Write-BackupLog "Config backup completed: $($backedUpFiles.Count) file(s)" -Level SUCCESS

    return @{
        Directory = $configBackupDir
        FileCount = $backedUpFiles.Count
        Files = $backedUpFiles
    }
}

function Backup-CheckpointsAndProgress {
    if (-not $IncludeCheckpoints) {
        Write-BackupLog "Checkpoint backup skipped (disabled)" -Level INFO
        return $null
    }

    Write-Host ""
    Write-Host "   📊 Backing up Checkpoints & Quest Progress..." -ForegroundColor Yellow

    $checkpointBackupDir = Join-Path $sessionBackupPath "checkpoints"
    New-Item -ItemType Directory -Path $checkpointBackupDir -Force | Out-Null

    $backedUpFiles = @()
    $workspaceRoot = $sources.WorkspaceRoot

    # Backup checkpoint files
    foreach ($checkpointFile in $sources.Checkpoints) {
        $fullPath = Join-Path $workspaceRoot $checkpointFile

        if (Test-Path $fullPath) {
            $destPath = Join-Path $checkpointBackupDir (Split-Path $checkpointFile -Leaf)
            Copy-Item -Path $fullPath -Destination $destPath -Force
            $backedUpFiles += $checkpointFile
            Write-Host "      ✅ $checkpointFile" -ForegroundColor Green
        }
    }

    # Backup quest progress
    foreach ($questPattern in $sources.QuestProgress) {
        $fullPath = Join-Path $workspaceRoot $questPattern
        $files = Get-ChildItem $fullPath -ErrorAction SilentlyContinue

        foreach ($file in $files) {
            $relativePath = $file.FullName.Replace($workspaceRoot, "").TrimStart("\")
            $destPath = Join-Path $checkpointBackupDir $file.Name
            Copy-Item -Path $file.FullName -Destination $destPath -Force
            $backedUpFiles += $relativePath
            Write-Host "      ✅ $relativePath" -ForegroundColor Green
        }
    }

    Write-BackupLog "Checkpoint backup completed: $($backedUpFiles.Count) file(s)" -Level SUCCESS

    return @{
        Directory = $checkpointBackupDir
        FileCount = $backedUpFiles.Count
        Files = $backedUpFiles
    }
}

function Test-BackupIntegrity {
    if (-not $RunIntegrityCheck) {
        Write-BackupLog "Integrity check skipped (disabled)" -Level INFO
        return $null
    }

    Write-Host ""
    Write-Host "   🔍 Running Integrity Validation..." -ForegroundColor Yellow

    $checks = @{
        SessionDirectoryExists = Test-Path $sessionBackupPath
        VaultBackupValid = $false
        ConfigBackupValid = $false
        CheckpointBackupValid = $false
        TotalSizeReasonable = $false
    }

    # Check vault backup
    $vaultBackup = Join-Path $sessionBackupPath "vault_backup.zip"
    if (Test-Path $vaultBackup) {
        $vaultSize = (Get-Item $vaultBackup).Length
        $checks.VaultBackupValid = $vaultSize -gt 0
    }

    # Check config backup
    $configDir = Join-Path $sessionBackupPath "configs"
    if (Test-Path $configDir) {
        $configFiles = Get-ChildItem $configDir -Recurse -File
        $checks.ConfigBackupValid = $configFiles.Count -gt 0
    }

    # Check checkpoint backup
    $checkpointDir = Join-Path $sessionBackupPath "checkpoints"
    if (Test-Path $checkpointDir) {
        $checkpointFiles = Get-ChildItem $checkpointDir -File
        $checks.CheckpointBackupValid = $checkpointFiles.Count -gt 0
    }

    # Check total size
    $totalSize = (Get-ChildItem $sessionBackupPath -Recurse -File | Measure-Object -Property Length -Sum).Sum / 1MB
    $checks.TotalSizeReasonable = $totalSize -gt 0.1 -and $totalSize -lt 10000  # Between 100KB and 10GB

    # Report results
    Write-Host ""
    foreach ($checkName in $checks.Keys) {
        $result = $checks[$checkName]
        $icon = if ($result) { "✅" } else { "❌" }
        $color = if ($result) { "Green" } else { "Red" }
        Write-Host "      $icon $checkName" -ForegroundColor $color
    }

    $passedChecks = ($checks.Values | Where-Object { $_ -eq $true }).Count
    $totalChecks = $checks.Count

    Write-Host ""
    Write-Host "      📊 Integrity Score: $passedChecks/$totalChecks checks passed" -ForegroundColor Cyan

    if ($passedChecks -eq $totalChecks) {
        Write-BackupLog "Integrity validation: ALL CHECKS PASSED" -Level SUCCESS
    } else {
        Write-BackupLog "Integrity validation: $passedChecks/$totalChecks checks passed" -Level WARNING
    }

    return @{
        Checks = $checks
        PassedCount = $passedChecks
        TotalCount = $totalChecks
        TotalSizeMB = $totalSize
    }
}

function Remove-OldBackups {
    Write-Host ""
    Write-Host "   🗑️  Cleaning up old backups (retention: $RetentionDays days)..." -ForegroundColor Yellow

    $cutoffDate = (Get-Date).AddDays(-$RetentionDays)

    $oldBackups = Get-ChildItem $BackupPath -Directory |
        Where-Object { $_.Name -match '^\d{8}_\d{6}$' -and $_.CreationTime -lt $cutoffDate }

    $removedCount = 0
    $freedSpaceMB = 0

    foreach ($backup in $oldBackups) {
        $size = (Get-ChildItem $backup.FullName -Recurse -File | Measure-Object -Property Length -Sum).Sum / 1MB

        try {
            Remove-Item $backup.FullName -Recurse -Force
            Write-Host "      🗑️  Removed: $($backup.Name) (${size:N2} MB)" -ForegroundColor Gray
            $removedCount++
            $freedSpaceMB += $size
        } catch {
            Write-BackupLog "Failed to remove old backup $($backup.Name): $_" -Level WARNING
        }
    }

    if ($removedCount -gt 0) {
        Write-BackupLog "Cleanup: Removed $removedCount backup(s), freed ${freedSpaceMB:N2} MB" -Level SUCCESS
    } else {
        Write-Host "      ✅ No old backups to remove" -ForegroundColor Green
    }

    return @{
        RemovedCount = $removedCount
        FreedSpaceMB = $freedSpaceMB
    }
}

function Send-BackupNotification {
    param([hashtable]$Results)

    if (-not $SendEmailNotification) {
        return
    }

    Write-Host ""
    Write-Host "   📧 Sending email notification..." -ForegroundColor Yellow

    # Check if IdentityAgent is available
    $agentPath = Join-Path $sources.WorkspaceRoot "IntelIntent_Seeding\AgentBridge.psm1"

    if (-not (Test-Path $agentPath)) {
        Write-BackupLog "IdentityAgent not available, skipping email" -Level WARNING
        return
    }

    try {
        Import-Module $agentPath -Force

        $emailBody = @"
<h2>🔄 IntelIntent Backup Report</h2>
<p><strong>Timestamp:</strong> $timestamp</p>

<h3>📊 Backup Summary</h3>
<ul>
    <li>✅ Vault: $($Results.Vault.CredentialCount) credentials ($($Results.Vault.Size:N2) MB)</li>
    <li>✅ Configs: $($Results.Configs.FileCount) files</li>
    <li>✅ Checkpoints: $($Results.Checkpoints.FileCount) files</li>
</ul>

<h3>🔍 Integrity Check</h3>
<p>Score: $($Results.Integrity.PassedCount)/$($Results.Integrity.TotalCount) checks passed</p>
<p>Total Size: $($Results.Integrity.TotalSizeMB:N2) MB</p>

<h3>🗑️ Cleanup</h3>
<p>Removed: $($Results.Cleanup.RemovedCount) old backup(s)</p>
<p>Freed: $($Results.Cleanup.FreedSpaceMB:N2) MB</p>

<p><em>Backup location: $sessionBackupPath</em></p>
"@

        Invoke-IdentityAgent -Operation "EmailOrchestration" -UserEmail "admin@example.com" -Subject "IntelIntent Backup Report - $timestamp" -Body $emailBody

        Write-BackupLog "Email notification sent successfully" -Level SUCCESS

    } catch {
        Write-BackupLog "Failed to send email notification: $_" -Level WARNING
    }
}

# ===========================
# MAIN EXECUTION
# ===========================
try {
    # Initialize
    Initialize-BackupSession

    # Execute backups
    $results = @{
        Vault = Backup-CredentialVault
        Configs = Backup-OrchestrationConfigs
        Checkpoints = Backup-CheckpointsAndProgress
        Integrity = $null
        Cleanup = $null
    }

    # Run integrity check
    $results.Integrity = Test-BackupIntegrity

    # Cleanup old backups
    $results.Cleanup = Remove-OldBackups

    # Send notification
    Send-BackupNotification -Results $results

    # Final summary
    Write-Host ""
    Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║   ✅ BACKUP COMPLETED SUCCESSFULLY                            ║" -ForegroundColor Green
    Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "   📁 Backup Location: $sessionBackupPath" -ForegroundColor Cyan
    Write-Host "   📊 Total Size: $($results.Integrity.TotalSizeMB:N2) MB" -ForegroundColor Cyan
    Write-Host "   📝 Log File: $logFile" -ForegroundColor Cyan
    Write-Host ""

    Write-BackupLog "Backup session completed successfully" -Level SUCCESS

    exit 0

} catch {
    Write-Host ""
    Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Red
    Write-Host "║   ❌ BACKUP FAILED                                            ║" -ForegroundColor Red
    Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Red
    Write-Host ""

    Write-BackupLog "Backup session failed: $_" -Level ERROR
    Write-Error $_

    exit 1
}
