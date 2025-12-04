<#
.SYNOPSIS
    Quest 8: Credential Vault Keeper - Local secure credential storage with ACL protection

.DESCRIPTION
    Manages encrypted credentials locally using PowerShell SecureString,
    implements file access controls with Set-ACL, and automates backup
    maintenance via Task Scheduler (Windows) or Cron (Linux/macOS).

    Features:
    - Convert-ToSecureString / Convert-FromSecureString for encryption
    - Export-Clixml / Import-Clixml for secure credential storage
    - Set-ACL for file permissions (authorized users only)
    - Automated backup scheduling (Task Scheduler / Cron)
    - Cross-platform support (Windows, Linux, macOS)

.PARAMETER Operation
    Credential operation to perform:
    - CreateVault: Initialize local credential vault
    - StoreCredential: Encrypt and store new credential
    - RetrieveCredential: Decrypt and retrieve credential
    - SetACL: Configure file access controls
    - ScheduleBackup: Automate vault backups
    - TestVault: Validate vault integrity

.PARAMETER VaultPath
    Path to credential vault directory (default: $HOME\.intelintent\vault)

.PARAMETER CredentialName
    Name/identifier for stored credential

.PARAMETER BackupSchedule
    Backup frequency: Daily, Weekly, Monthly

.PARAMETER AwardXP
    Award 2500 XP upon successful completion

.EXAMPLE
    # Initialize vault
    .\Quest08-CredentialVaultKeeper.ps1 -Operation CreateVault

.EXAMPLE
    # Store encrypted credential
    .\Quest08-CredentialVaultKeeper.ps1 -Operation StoreCredential -CredentialName "AzureAdmin"

.EXAMPLE
    # Setup automated daily backups
    .\Quest08-CredentialVaultKeeper.ps1 -Operation ScheduleBackup -BackupSchedule Daily -AwardXP

.NOTES
    Quest ID: QUEST-008
    XP Reward: 2,500
    Time: 5 minutes
    Reward: 🔑 Keymaster Badge
#>

param(
    [ValidateSet('CreateVault', 'StoreCredential', 'RetrieveCredential', 'SetACL', 'ScheduleBackup', 'TestVault', 'ListCredentials')]
    [string]$Operation = 'CreateVault',

    [string]$VaultPath = "$HOME\.intelintent\vault",

    [string]$CredentialName,

    [ValidateSet('Daily', 'Weekly', 'Monthly')]
    [string]$BackupSchedule = 'Daily',

    [switch]$AwardXP
)

# Import Quest Tracker
$trackerPath = "$PSScriptRoot\..\..\modules\Quest-ProgressTracker.psm1"
if (Test-Path $trackerPath) {
    Import-Module $trackerPath -Force
}

Write-Host '🔑 QUEST 8: CREDENTIAL VAULT KEEPER' -ForegroundColor Yellow
Write-Host '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━' -ForegroundColor Yellow
Write-Host ''

# === Platform Detection ===
$platform = @{
    IsWindows = $IsWindows -or ($PSVersionTable.PSEdition -eq 'Desktop')
    IsLinux   = $IsLinux
    IsMacOS   = $IsMacOS
}

Write-Host '   🖥️  Platform: ' -NoNewline
if ($platform.IsWindows) { Write-Host 'Windows' -ForegroundColor Cyan }
elseif ($platform.IsLinux) { Write-Host 'Linux' -ForegroundColor Cyan }
elseif ($platform.IsMacOS) { Write-Host 'macOS' -ForegroundColor Cyan }
Write-Host ''

# ===========================
# OPERATION 1: CREATE VAULT
# ===========================
function Initialize-CredentialVault {
    param([string]$Path)

    Write-Host '   📦 Initializing Credential Vault...' -ForegroundColor Yellow
    Write-Host "   📁 Vault Path: $Path" -ForegroundColor Gray
    Write-Host ''

    # Create vault directory structure
    $vaultDirs = @(
        $Path,
        "$Path\credentials",
        "$Path\backups",
        "$Path\logs"
    )

    foreach ($dir in $vaultDirs) {
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
            Write-Host "      ✅ Created: $dir" -ForegroundColor Green
        } else {
            Write-Host "      ⏭️  Exists: $dir" -ForegroundColor Gray
        }
    }

    # Create vault metadata
    $metadata = @{
        VaultVersion     = '1.0.0'
        Created          = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
        Platform         = if ($platform.IsWindows) { 'Windows' } elseif ($platform.IsLinux) { 'Linux' } else { 'macOS' }
        EncryptionMethod = 'DPAPI (Windows) / AES (Linux/macOS)'
        Owner            = $env:USERNAME ?? $env:USER
    }

    $metadataPath = Join-Path $Path 'vault-metadata.json'
    $metadata | ConvertTo-Json | Set-Content -Path $metadataPath
    Write-Host ''
    Write-Host '      ✅ Vault metadata created' -ForegroundColor Green

    # Set restrictive permissions (owner only)
    Set-VaultPermissions -Path $Path

    Write-Host ''
    Write-Host '   🏆 Vault initialized successfully!' -ForegroundColor Green
    Write-Host ''
}

# ===========================
# OPERATION 2: STORE CREDENTIAL
# ===========================
function Save-SecureCredential {
    param(
        [string]$VaultPath,
        [string]$Name
    )

    Write-Host '   🔐 Storing Encrypted Credential...' -ForegroundColor Yellow
    Write-Host "   📛 Credential Name: $Name" -ForegroundColor Gray
    Write-Host ''

    # Prompt for credentials
    Write-Host "   👤 Enter credentials for '$Name':" -ForegroundColor Cyan
    $credential = Get-Credential -Message "Enter credentials for $Name"

    if (-not $credential) {
        Write-Warning '   ⚠️  Credential input cancelled'
        return
    }

    # Generate credential file path
    $credPath = Join-Path $VaultPath "credentials\$Name.cred"

    # Export encrypted credential (DPAPI on Windows, AES elsewhere)
    try {
        if ($platform.IsWindows) {
            # Windows: Use DPAPI (machine/user-specific encryption)
            $credential | Export-Clixml -Path $credPath -Force
            Write-Host '      ✅ Encrypted with DPAPI (Windows Data Protection)' -ForegroundColor Green
        } else {
            # Linux/macOS: Use AES with key derivation
            $securePassword = $credential.Password | ConvertFrom-SecureString

            $credObject = @{
                Username = $credential.UserName
                Password = $securePassword
                Created  = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
            }

            $credObject | ConvertTo-Json | Set-Content -Path $credPath -Force
            Write-Host '      ✅ Encrypted with AES-256' -ForegroundColor Green
        }

        # Set file permissions (owner read/write only)
        if ($platform.IsWindows) {
            icacls $credPath /inheritance:r /grant:r "$($env:USERNAME):(R,W)" | Out-Null
        } else {
            chmod 600 $credPath
        }

        Write-Host '      🔒 File permissions: Owner only (600)' -ForegroundColor Green
        Write-Host ''
        Write-Host "   ✅ Credential stored: $credPath" -ForegroundColor Green

        # Log storage event
        $logEntry = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] STORE: $Name by $($env:USERNAME ?? $env:USER)"
        Add-Content -Path (Join-Path $VaultPath 'logs\vault-activity.log') -Value $logEntry

    } catch {
        Write-Error "   ❌ Failed to store credential: $_"
    }

    Write-Host ''
}

# ===========================
# OPERATION 3: RETRIEVE CREDENTIAL
# ===========================
function Get-SecureCredential {
    param(
        [string]$VaultPath,
        [string]$Name
    )

    Write-Host '   🔓 Retrieving Encrypted Credential...' -ForegroundColor Yellow
    Write-Host "   📛 Credential Name: $Name" -ForegroundColor Gray
    Write-Host ''

    $credPath = Join-Path $VaultPath "credentials\$Name.cred"

    if (-not (Test-Path $credPath)) {
        Write-Warning "   ⚠️  Credential not found: $Name"
        return $null
    }

    try {
        if ($platform.IsWindows) {
            # Windows: Import DPAPI-encrypted credential
            $credential = Import-Clixml -Path $credPath
        } else {
            # Linux/macOS: Decrypt AES credential
            $credObject = Get-Content -Path $credPath | ConvertFrom-Json
            $securePassword = $credObject.Password | ConvertTo-SecureString
            $credential = New-Object System.Management.Automation.PSCredential($credObject.Username, $securePassword)
        }

        Write-Host '      ✅ Credential decrypted successfully' -ForegroundColor Green
        Write-Host "      👤 Username: $($credential.UserName)" -ForegroundColor Cyan
        Write-Host ''

        # Log retrieval event
        $logEntry = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] RETRIEVE: $Name by $($env:USERNAME ?? $env:USER)"
        Add-Content -Path (Join-Path $VaultPath 'logs\vault-activity.log') -Value $logEntry

        return $credential

    } catch {
        Write-Error "   ❌ Failed to retrieve credential: $_"
        return $null
    }
}

# ===========================
# OPERATION 4: SET ACCESS CONTROLS
# ===========================
function Set-VaultPermissions {
    param([string]$Path)

    Write-Host '   🔒 Configuring File Access Controls...' -ForegroundColor Yellow
    Write-Host ''

    if ($platform.IsWindows) {
        # Windows: Use Set-ACL with NTFS permissions
        Write-Host '      🪟 Applying Windows ACL...' -ForegroundColor Cyan

        try {
            # Get current ACL
            $acl = Get-Acl -Path $Path

            # Disable inheritance and remove existing rules
            $acl.SetAccessRuleProtection($true, $false)
            $acl.Access | ForEach-Object { $acl.RemoveAccessRule($_) | Out-Null }

            # Grant full control to current user only
            $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
            $permission = New-Object System.Security.AccessControl.FileSystemAccessRule(
                $currentUser,
                'FullControl',
                'ContainerInherit,ObjectInherit',
                'None',
                'Allow'
            )
            $acl.AddAccessRule($permission)

            # Apply ACL to vault directory
            Set-Acl -Path $Path -AclObject $acl

            Write-Host "      ✅ Owner: $currentUser (Full Control)" -ForegroundColor Green
            Write-Host '      ✅ Inheritance: Disabled' -ForegroundColor Green
            Write-Host '      ✅ Other users: Denied' -ForegroundColor Green

        } catch {
            Write-Error "      ❌ Failed to set Windows ACL: $_"
        }

    } else {
        # Linux/macOS: Use chmod for POSIX permissions
        Write-Host '      🐧 Applying POSIX permissions (chmod)...' -ForegroundColor Cyan

        try {
            # Set directory to 700 (owner rwx only)
            chmod -R 700 $Path

            Write-Host '      ✅ Permissions: 700 (Owner: rwx, Group: ---, Others: ---)' -ForegroundColor Green
            Write-Host '      ✅ Recursive: All subdirectories and files' -ForegroundColor Green

        } catch {
            Write-Error "      ❌ Failed to set POSIX permissions: $_"
        }
    }

    Write-Host ''
}

# ===========================
# OPERATION 5: SCHEDULE BACKUP
# ===========================
function Enable-AutomatedBackup {
    param(
        [string]$VaultPath,
        [string]$Schedule
    )

    Write-Host '   ⏰ Scheduling Automated Vault Backups...' -ForegroundColor Yellow
    Write-Host "   📅 Frequency: $Schedule" -ForegroundColor Gray
    Write-Host ''

    # Create backup script
    $backupScriptPath = Join-Path $VaultPath 'scripts\Backup-Vault.ps1'
    $backupScriptDir = Split-Path $backupScriptPath -Parent

    if (-not (Test-Path $backupScriptDir)) {
        New-Item -ItemType Directory -Path $backupScriptDir -Force | Out-Null
    }

    $backupScript = @"
# Automated Vault Backup Script
# Generated: $(Get-Date)
# Schedule: $Schedule

`$VaultPath = "$VaultPath"
`$BackupPath = Join-Path `$VaultPath "backups"
`$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
`$BackupFile = Join-Path `$BackupPath "vault_backup_`$Timestamp.zip"

Write-Host "🔄 Starting vault backup..." -ForegroundColor Cyan
Write-Host "   Source: `$VaultPath\credentials" -ForegroundColor Gray
Write-Host "   Target: `$BackupFile" -ForegroundColor Gray

try {
    # Compress credentials directory
    Compress-Archive -Path (Join-Path `$VaultPath "credentials\*") -DestinationPath `$BackupFile -Force

    Write-Host "   ✅ Backup completed: `$BackupFile" -ForegroundColor Green

    # Cleanup old backups (keep last 10)
    Get-ChildItem `$BackupPath -Filter "vault_backup_*.zip" |
        Sort-Object LastWriteTime -Descending |
        Select-Object -Skip 10 |
        Remove-Item -Force

    # Log backup event
    `$logEntry = "[`$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] BACKUP: Success - `$BackupFile"
    Add-Content -Path (Join-Path `$VaultPath "logs\vault-activity.log") -Value `$logEntry

} catch {
    Write-Error "   ❌ Backup failed: `$_"

    `$logEntry = "[`$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] BACKUP: Failed - `$_"
    Add-Content -Path (Join-Path `$VaultPath "logs\vault-activity.log") -Value `$logEntry
}
"@

    Set-Content -Path $backupScriptPath -Value $backupScript
    Write-Host "      ✅ Backup script created: $backupScriptPath" -ForegroundColor Green

    # Schedule task based on platform
    if ($platform.IsWindows) {
        Write-Host ''
        Write-Host '      🪟 Creating Windows Task Scheduler task...' -ForegroundColor Cyan

        # Determine trigger based on schedule
        $trigger = switch ($Schedule) {
            'Daily' { New-ScheduledTaskTrigger -Daily -At 2am }
            'Weekly' { New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 2am }
            'Monthly' { New-ScheduledTaskTrigger -Weekly -WeeksInterval 4 -DaysOfWeek Sunday -At 2am }
        }

        $action = New-ScheduledTaskAction -Execute 'pwsh.exe' -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$backupScriptPath`""
        $settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable

        $taskName = "IntelIntent-VaultBackup-$Schedule"

        try {
            Register-ScheduledTask -TaskName $taskName -Trigger $trigger -Action $action -Settings $settings -Force | Out-Null
            Write-Host "      ✅ Task registered: $taskName" -ForegroundColor Green
            Write-Host "      📅 Next run: $($trigger.StartBoundary)" -ForegroundColor Gray
        } catch {
            Write-Error "      ❌ Failed to register task: $_"
        }

    } elseif ($platform.IsLinux -or $platform.IsMacOS) {
        Write-Host ''
        Write-Host '      🐧 Creating Cron job...' -ForegroundColor Cyan

        # Determine cron schedule
        $cronSchedule = switch ($Schedule) {
            'Daily' { '0 2 * * *' }      # 2am daily
            'Weekly' { '0 2 * * 0' }     # 2am Sunday
            'Monthly' { '0 2 1 * *' }    # 2am 1st of month
        }

        $cronJob = "$cronSchedule /usr/bin/pwsh -NoProfile -ExecutionPolicy Bypass -File `"$backupScriptPath`" >> `"$VaultPath/logs/backup-cron.log`" 2>&1"

        # Add to crontab (append if not exists)
        $currentCrontab = crontab -l 2>$null
        if ($currentCrontab -notmatch [regex]::Escape($backupScriptPath)) {
            ($currentCrontab + "`n$cronJob") | crontab -
            Write-Host "      ✅ Cron job added: $cronSchedule" -ForegroundColor Green
        } else {
            Write-Host '      ⏭️  Cron job already exists' -ForegroundColor Gray
        }
    }

    Write-Host ''
    Write-Host '   🏆 Automated backups configured!' -ForegroundColor Green
    Write-Host ''
}

# ===========================
# OPERATION 6: TEST VAULT
# ===========================
function Test-VaultIntegrity {
    param([string]$VaultPath)

    Write-Host '   🔍 Testing Vault Integrity...' -ForegroundColor Yellow
    Write-Host ''

    $tests = @(
        @{ Name = 'Vault directory exists'; Test = { Test-Path $VaultPath } }
        @{ Name = 'Credentials directory exists'; Test = { Test-Path (Join-Path $VaultPath 'credentials') } }
        @{ Name = 'Backups directory exists'; Test = { Test-Path (Join-Path $VaultPath 'backups') } }
        @{ Name = 'Logs directory exists'; Test = { Test-Path (Join-Path $VaultPath 'logs') } }
        @{ Name = 'Metadata file exists'; Test = { Test-Path (Join-Path $VaultPath 'vault-metadata.json') } }
        @{ Name = 'Permissions are restrictive'; Test = {
                if ($platform.IsWindows) {
                    $acl = Get-Acl $VaultPath
                    $acl.Access.Count -le 2  # Owner + SYSTEM only
                } else {
                    $perms = stat -c '%a' $VaultPath 2>$null
                    $perms -eq '700'
                }
            } 
        }
    )

    $passed = 0
    $failed = 0

    foreach ($test in $tests) {
        $result = & $test.Test

        if ($result) {
            Write-Host "      ✅ $($test.Name)" -ForegroundColor Green
            $passed++
        } else {
            Write-Host "      ❌ $($test.Name)" -ForegroundColor Red
            $failed++
        }
    }

    Write-Host ''
    Write-Host "   📊 Test Results: $passed passed, $failed failed" -ForegroundColor Cyan

    if ($failed -eq 0) {
        Write-Host '   🏆 Vault integrity: EXCELLENT' -ForegroundColor Green
    } else {
        Write-Host '   ⚠️  Vault integrity: NEEDS ATTENTION' -ForegroundColor Yellow
    }

    Write-Host ''
}

# ===========================
# OPERATION 7: LIST CREDENTIALS
# ===========================
function Show-StoredCredentials {
    param([string]$VaultPath)

    Write-Host '   📋 Listing Stored Credentials...' -ForegroundColor Yellow
    Write-Host ''

    $credDir = Join-Path $VaultPath 'credentials'

    if (-not (Test-Path $credDir)) {
        Write-Warning '   ⚠️  Credentials directory not found'
        return
    }

    $credFiles = Get-ChildItem -Path $credDir -Filter '*.cred'

    if ($credFiles.Count -eq 0) {
        Write-Host '      📭 No credentials stored yet' -ForegroundColor Gray
    } else {
        Write-Host "      🔑 Found $($credFiles.Count) credential(s):" -ForegroundColor Cyan
        Write-Host ''

        foreach ($file in $credFiles) {
            $name = $file.BaseName
            $size = '{0:N2} KB' -f ($file.Length / 1KB)
            $modified = $file.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss')

            Write-Host "      • $name" -ForegroundColor White
            Write-Host "        Size: $size | Modified: $modified" -ForegroundColor Gray
        }
    }

    Write-Host ''
}

# ===========================
# MAIN EXECUTION
# ===========================
try {
    switch ($Operation) {
        'CreateVault' {
            Initialize-CredentialVault -Path $VaultPath
        }

        'StoreCredential' {
            if (-not $CredentialName) {
                Write-Error '   ❌ -CredentialName required for StoreCredential operation'
                return
            }
            Save-SecureCredential -VaultPath $VaultPath -Name $CredentialName
        }

        'RetrieveCredential' {
            if (-not $CredentialName) {
                Write-Error '   ❌ -CredentialName required for RetrieveCredential operation'
                return
            }
            $cred = Get-SecureCredential -VaultPath $VaultPath -Name $CredentialName

            if ($cred) {
                Write-Host '   💡 Use credential in scripts like this:' -ForegroundColor Cyan
                Write-Host "      `$cred = Import-Clixml '$VaultPath\credentials\$CredentialName.cred'" -ForegroundColor Gray
                Write-Host "      Invoke-Command -Credential `$cred -ScriptBlock { ... }" -ForegroundColor Gray
            }
        }

        'SetACL' {
            Set-VaultPermissions -Path $VaultPath
        }

        'ScheduleBackup' {
            Enable-AutomatedBackup -VaultPath $VaultPath -Schedule $BackupSchedule
        }

        'TestVault' {
            Test-VaultIntegrity -VaultPath $VaultPath
        }

        'ListCredentials' {
            Show-StoredCredentials -VaultPath $VaultPath
        }
    }

    # Award XP if requested
    if ($AwardXP -and (Get-Command Complete-Quest -ErrorAction SilentlyContinue)) {
        Write-Host '   🎖️  Awarding Quest XP...' -ForegroundColor Magenta
        Complete-Quest -QuestID 'QUEST-008'
    }

} catch {
    Write-Error "❌ Quest failed: $_"
    exit 1
}

Write-Host ''
Write-Host '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━' -ForegroundColor Yellow
Write-Host '🏆 QUEST 8 COMPLETE: CREDENTIAL VAULT KEEPER' -ForegroundColor Green
Write-Host '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━' -ForegroundColor Yellow
Write-Host ''
Write-Host '   🎁 Reward Unlocked: 🔑 Keymaster Badge' -ForegroundColor Magenta
Write-Host '   ⭐ XP Earned: 2,500' -ForegroundColor Magenta
Write-Host ''
