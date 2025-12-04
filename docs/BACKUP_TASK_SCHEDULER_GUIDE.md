# 🔄 Automated Backup & Task Scheduler - Quick Reference

**Created:** December 1, 2025  
**Quest Integration:** System Tune-Up Milestone  
**Platform:** Windows (Task Scheduler)

---

## 📦 What You Got

Two powerful automation scripts:

1. **`Invoke-AutomatedBackup.ps1`** - Comprehensive backup solution
   - Backs up credential vault (encrypted credentials)
   - Backs up orchestration configs (scripts, manifests, modules)
   - Backs up checkpoint logs and quest progress
   - Runs integrity validation (6 checks)
   - Cleans up old backups (30-day retention)
   - Logs all operations with timestamps

2. **`Setup-TaskScheduler.ps1`** - Task Scheduler automation
   - Creates scheduled task for automated execution
   - Supports multiple schedules (Daily, Weekly, Monthly, Startup)
   - Runs with SYSTEM privileges
   - Includes test run capability

---

## 🚀 Quick Start (3 Steps)

### Step 1: Test Backup Manually

```powershell
# Navigate to scripts folder
cd "$HOME\OneDrive\IntelIntent!\scripts"

# Run backup once to test
.\Invoke-AutomatedBackup.ps1
```

**Expected Output:**
```
╔═══════════════════════════════════════════════════════════════╗
║   🔄 INTELINTENT AUTOMATED BACKUP & MAINTENANCE               ║
╚═══════════════════════════════════════════════════════════════╝

   🔐 Backing up Credential Vault...
      ✅ Backed up 3 credential(s)

   ⚙️  Backing up Orchestration Configs...
      ✅ Week1_Automation.ps1
      ✅ IntelIntent_Launcher.ps1
      ✅ creator_of_creators_checklist.json
      ... (more files)

   📊 Backing up Checkpoints & Quest Progress...
      ✅ Week1_Checkpoints.json
      ✅ Quest-ProgressTracker.psm1
      ... (more files)

   🔍 Running Integrity Validation...
      ✅ SessionDirectoryExists
      ✅ VaultBackupValid
      ✅ ConfigBackupValid
      ✅ CheckpointBackupValid
      ✅ TotalSizeReasonable
      
      📊 Integrity Score: 5/5 checks passed

   🗑️  Cleaning up old backups (retention: 30 days)...
      ✅ No old backups to remove

╔═══════════════════════════════════════════════════════════════╗
║   ✅ BACKUP COMPLETED SUCCESSFULLY                            ║
╚═══════════════════════════════════════════════════════════════╝

   📁 Backup Location: C:\Users\YourName\IntelIntent_Backups\20251201_140530
   📊 Total Size: 15.47 MB
   📝 Log File: C:\Users\YourName\IntelIntent_Backups\backup-log.txt
```

---

### Step 2: Setup Automated Task Scheduler

```powershell
# Open PowerShell as Administrator (right-click → Run as Administrator)

# Navigate to scripts folder
cd "$HOME\OneDrive\IntelIntent!\scripts"

# Setup daily backup at 2am
.\Setup-TaskScheduler.ps1 -Schedule Daily

# OR setup weekly backup with email notifications
.\Setup-TaskScheduler.ps1 -Schedule Weekly -SendEmail

# OR test immediately after setup
.\Setup-TaskScheduler.ps1 -Schedule Daily -TestRun
```

**Expected Output:**
```
╔═══════════════════════════════════════════════════════════════╗
║   📅 TASK SCHEDULER SETUP - AUTOMATED BACKUP                  ║
╚═══════════════════════════════════════════════════════════════╝

   ✅ Backup Script: C:\Users\...\Invoke-AutomatedBackup.ps1
   📅 Schedule: Daily
   ⏰ Time: 02:00 AM
   🗑️  Retention: 30 days

   🔧 Creating Scheduled Task...

      ✅ Action: Run PowerShell backup script
      ✅ Trigger: Daily at 02:00 AM
      ✅ Settings: Start when available, run on battery
      ✅ Principal: SYSTEM account (highest privileges)

      🔄 Registering scheduled task...
      ✅ Task registered: IntelIntent-AutomatedBackup

   🔍 Verifying Task Registration...

      ✅ Task Name: IntelIntent-AutomatedBackup
      ✅ State: Ready
      📅 Next Run: 12/2/2025 2:00:00 AM
      🔄 Last Run: Never
      📊 Last Result: 0

╔═══════════════════════════════════════════════════════════════╗
║   ✅ TASK SCHEDULER SETUP COMPLETE                            ║
╚═══════════════════════════════════════════════════════════════╝

🎉 Your IntelIntent backups are now automated!
```

---

### Step 3: Verify in Task Scheduler (GUI)

1. Press **Win+R**, type `taskschd.msc`, press **Enter**
2. Navigate to **Task Scheduler Library**
3. Find **IntelIntent-AutomatedBackup**
4. Right-click → **Properties** to view settings
5. Right-click → **Run** to test immediately

![Task Scheduler Screenshot](https://via.placeholder.com/800x400?text=Task+Scheduler+GUI)

---

## 🎛️ Advanced Usage

### Custom Backup Configuration

```powershell
# Backup only vault (skip configs and checkpoints)
.\Invoke-AutomatedBackup.ps1 `
    -IncludeConfigs:$false `
    -IncludeCheckpoints:$false

# Custom backup path with 60-day retention
.\Invoke-AutomatedBackup.ps1 `
    -BackupPath "D:\Backups\IntelIntent" `
    -RetentionDays 60

# Backup with email notification
.\Invoke-AutomatedBackup.ps1 `
    -SendEmailNotification

# Skip integrity check (faster execution)
.\Invoke-AutomatedBackup.ps1 `
    -RunIntegrityCheck:$false
```

### Task Scheduler Options

```powershell
# Daily backup at 3am
.\Setup-TaskScheduler.ps1 -Schedule Daily -TaskTime "3:00AM"

# Weekly backup on Sunday at 2am
.\Setup-TaskScheduler.ps1 -Schedule Weekly -TaskTime "2:00AM"

# Monthly backup (1st of month) at midnight
.\Setup-TaskScheduler.ps1 -Schedule Monthly -TaskTime "12:00AM"

# Backup at system startup
.\Setup-TaskScheduler.ps1 -Schedule Startup

# Custom retention policy (keep 90 days)
.\Setup-TaskScheduler.ps1 -Schedule Daily -RetentionDays 90
```

---

## 📊 Monitoring & Maintenance

### Check Backup Status

```powershell
# View recent backups
Get-ChildItem "$HOME\IntelIntent_Backups" -Directory | 
    Sort-Object CreationTime -Descending | 
    Select-Object Name, CreationTime, @{N='Size(MB)';E={(Get-ChildItem $_.FullName -Recurse | Measure-Object Length -Sum).Sum / 1MB}}

# View backup log
Get-Content "$HOME\IntelIntent_Backups\backup-log.txt" -Tail 50

# Check disk space usage
$backupPath = "$HOME\IntelIntent_Backups"
$totalSize = (Get-ChildItem $backupPath -Recurse -File | Measure-Object -Property Length -Sum).Sum / 1GB
Write-Host "Total Backup Size: $($totalSize:N2) GB"
```

### Monitor Scheduled Task

```powershell
# Get task status
Get-ScheduledTask -TaskName "IntelIntent-AutomatedBackup"

# Get task execution info
Get-ScheduledTaskInfo -TaskName "IntelIntent-AutomatedBackup"

# View task history (last 10 runs)
Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-TaskScheduler/Operational'
    ID = 102  # Task completed
} -MaxEvents 10 | Where-Object { $_.Message -match "IntelIntent-AutomatedBackup" }
```

### Manual Task Control

```powershell
# Run task immediately
Start-ScheduledTask -TaskName "IntelIntent-AutomatedBackup"

# Disable task (pause automation)
Disable-ScheduledTask -TaskName "IntelIntent-AutomatedBackup"

# Enable task (resume automation)
Enable-ScheduledTask -TaskName "IntelIntent-AutomatedBackup"

# Remove task completely
Unregister-ScheduledTask -TaskName "IntelIntent-AutomatedBackup" -Confirm:$false
```

---

## 🔧 Troubleshooting

### Issue: Backup Fails with "Access Denied"

**Solution:** Run Task Scheduler setup as Administrator
```powershell
# Right-click PowerShell → Run as Administrator
.\Setup-TaskScheduler.ps1 -Schedule Daily
```

---

### Issue: Task Shows "Running" but Never Completes

**Causes:**
- Script path contains spaces (not properly quoted)
- PowerShell execution policy blocking script
- Network drive not available (if backup path on network)

**Solutions:**
```powershell
# Fix 1: Verify script path in task action
Get-ScheduledTask -TaskName "IntelIntent-AutomatedBackup" | 
    Select-Object -ExpandProperty Actions

# Fix 2: Set execution policy
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

# Fix 3: Use local backup path
.\Setup-TaskScheduler.ps1 -Schedule Daily
# (default: $HOME\IntelIntent_Backups)
```

---

### Issue: "Vault not found" Warning

**Cause:** Credential vault not initialized

**Solution:**
```powershell
# Initialize vault first (Quest 8)
.\Quest08-CredentialVaultKeeper.ps1 -Operation CreateVault

# Then run backup
.\Invoke-AutomatedBackup.ps1
```

---

### Issue: Old Backups Not Being Deleted

**Cause:** Retention policy not working

**Check:**
```powershell
# Verify retention setting
Get-ScheduledTask -TaskName "IntelIntent-AutomatedBackup" | 
    Select-Object -ExpandProperty Actions | 
    Select-Object -ExpandProperty Arguments
# Should contain: -RetentionDays 30

# Manual cleanup
Get-ChildItem "$HOME\IntelIntent_Backups" -Directory | 
    Where-Object { $_.CreationTime -lt (Get-Date).AddDays(-30) } | 
    Remove-Item -Recurse -Force
```

---

## 📋 Backup Directory Structure

```
$HOME\IntelIntent_Backups\
├── 20251201_140530\              # Backup session (timestamp)
│   ├── vault_backup.zip          # Encrypted credentials
│   ├── configs\
│   │   ├── Week1_Automation.ps1
│   │   ├── IntelIntent_Launcher.ps1
│   │   ├── IntelIntent-Seed\
│   │   │   └── *.json
│   │   ├── IntelIntent_Seeding\
│   │   │   └── *.psm1
│   │   └── .vscode\
│   │       └── settings.json
│   └── checkpoints\
│       ├── Week1_Checkpoints.json
│       ├── Phase5_Modality_Checkpoints.json
│       ├── Quest-ProgressTracker.psm1
│       └── Quest*.ps1
├── 20251202_020015\              # Next backup session
│   └── ... (same structure)
└── backup-log.txt                # Consolidated log file
```

---

## 🎯 Best Practices

### Backup Strategy

✅ **DO:**
- Run daily backups during off-hours (2am-4am)
- Keep 30-day retention for most environments
- Test backup restoration quarterly
- Monitor backup size trends
- Store critical backups offsite (OneDrive, Azure Blob)

❌ **DON'T:**
- Backup to same drive as original data
- Set retention too short (<7 days)
- Ignore backup failure notifications
- Store backups in public/shared folders

### Security

✅ **DO:**
- Use SYSTEM account for task execution
- Encrypt backup archives (vault already encrypted)
- Set restrictive NTFS permissions on backup folder
- Enable email notifications for failures

❌ **DON'T:**
- Store backup logs in public locations
- Share backup folders over network without encryption
- Disable integrity validation

---

## 🏆 Quest Integration

This backup system is part of the **System Tune-Up Milestone**:

**Quest Rewards:**
- ⚡ Performance Boost Icon
- 🛡️ Data Protection Badge
- 📊 2,000 XP

**Related Quests:**
- Quest 8: Credential Vault Keeper (credential storage)
- Quest 13: Cleanup Crusader (temp file cleanup)
- Quest 14: Backup Defender (disaster recovery)

---

## 📚 Additional Resources

**PowerShell Task Scheduler Commands:**
- `Get-ScheduledTask` - List all tasks
- `New-ScheduledTaskTrigger` - Create triggers
- `New-ScheduledTaskAction` - Define actions
- `Register-ScheduledTask` - Create task
- `Start-ScheduledTask` - Run task manually
- `Disable-ScheduledTask` - Pause automation
- `Unregister-ScheduledTask` - Remove task

**Backup Commands:**
- `Compress-Archive` - Create ZIP archives
- `Export-Clixml` - Serialize objects
- `Get-ChildItem -Recurse` - Directory traversal
- `Measure-Object -Sum` - Calculate sizes
- `Test-Path` - Validate paths

---

**Last Updated:** December 1, 2025  
**Version:** 1.0.0  
**Status:** ✅ Production Ready
