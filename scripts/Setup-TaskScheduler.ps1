<#
.SYNOPSIS
    Setup automated backup via Windows Task Scheduler

.DESCRIPTION
    Creates and registers a scheduled task that runs the backup script
    automatically at configured intervals. Supports multiple schedules:
    - Daily (default: 2am)
    - Weekly (Sunday at 2am)
    - Monthly (1st of month at 2am)
    - At Startup
    - Custom (user-defined)

.PARAMETER Schedule
    Backup frequency: Daily, Weekly, Monthly, Startup, Custom

.PARAMETER TaskTime
    Time to run backup (default: 2am)

.PARAMETER TaskName
    Name of scheduled task (default: IntelIntent-AutomatedBackup)

.PARAMETER BackupScriptPath
    Path to Invoke-AutomatedBackup.ps1 script

.PARAMETER RetentionDays
    Number of days to retain backups (passed to backup script)

.PARAMETER SendEmail
    Enable email notifications on completion

.PARAMETER TestRun
    Test the task immediately after creation

.EXAMPLE
    # Setup daily backup at 2am
    .\Setup-TaskScheduler.ps1 -Schedule Daily

.EXAMPLE
    # Setup weekly backup on Sunday at 3am with email notifications
    .\Setup-TaskScheduler.ps1 -Schedule Weekly -TaskTime "3:00AM" -SendEmail

.EXAMPLE
    # Setup backup at system startup
    .\Setup-TaskScheduler.ps1 -Schedule Startup -TestRun

.NOTES
    Requires: Administrator privileges for Task Scheduler
    Created: December 1, 2025
#>

param(
    [ValidateSet("Daily", "Weekly", "Monthly", "Startup", "Custom")]
    [string]$Schedule = "Daily",

    [datetime]$TaskTime = "2:00AM",

    [string]$TaskName = "IntelIntent-AutomatedBackup",

    [string]$BackupScriptPath = "$PSScriptRoot\Invoke-AutomatedBackup.ps1",

    [int]$RetentionDays = 30,

    [switch]$SendEmail,

    [switch]$TestRun
)

# Check admin privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "❌ This script requires Administrator privileges" -ForegroundColor Red
    Write-Host "   Right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   📅 TASK SCHEDULER SETUP - AUTOMATED BACKUP                  ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Verify backup script exists
if (-not (Test-Path $BackupScriptPath)) {
    Write-Error "Backup script not found: $BackupScriptPath"
    exit 1
}

Write-Host "   ✅ Backup Script: $BackupScriptPath" -ForegroundColor Green
Write-Host "   📅 Schedule: $Schedule" -ForegroundColor Cyan
Write-Host "   ⏰ Time: $($TaskTime.ToString('hh:mm tt'))" -ForegroundColor Cyan
Write-Host "   🗑️  Retention: $RetentionDays days" -ForegroundColor Cyan
Write-Host ""

# ===========================
# CREATE SCHEDULED TASK
# ===========================

Write-Host "   🔧 Creating Scheduled Task..." -ForegroundColor Yellow
Write-Host ""

# Build task action (PowerShell command)
$emailParam = if ($SendEmail) { "-SendEmailNotification" } else { "" }
$arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$BackupScriptPath`" -RetentionDays $RetentionDays $emailParam"

$action = New-ScheduledTaskAction `
    -Execute "pwsh.exe" `
    -Argument $arguments

Write-Host "      ✅ Action: Run PowerShell backup script" -ForegroundColor Green

# Build task trigger based on schedule
$trigger = switch ($Schedule) {
    "Daily" {
        Write-Host "      ✅ Trigger: Daily at $($TaskTime.ToString('hh:mm tt'))" -ForegroundColor Green
        New-ScheduledTaskTrigger -Daily -At $TaskTime
    }

    "Weekly" {
        Write-Host "      ✅ Trigger: Weekly (Sunday) at $($TaskTime.ToString('hh:mm tt'))" -ForegroundColor Green
        New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At $TaskTime
    }

    "Monthly" {
        Write-Host "      ✅ Trigger: Monthly (1st) at $($TaskTime.ToString('hh:mm tt'))" -ForegroundColor Green
        New-ScheduledTaskTrigger -Weekly -WeeksInterval 4 -DaysOfWeek Sunday -At $TaskTime
    }

    "Startup" {
        Write-Host "      ✅ Trigger: At system startup" -ForegroundColor Green
        New-ScheduledTaskTrigger -AtStartup
    }

    "Custom" {
        Write-Host "      ⚠️  Custom trigger - using Daily as default" -ForegroundColor Yellow
        New-ScheduledTaskTrigger -Daily -At $TaskTime
    }
}

# Task settings
$settings = New-ScheduledTaskSettingsSet `
    -StartWhenAvailable `
    -RunOnlyIfNetworkAvailable `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -ExecutionTimeLimit (New-TimeSpan -Hours 2)

Write-Host "      ✅ Settings: Start when available, run on battery" -ForegroundColor Green

# Task principal (run with highest privileges)
$principal = New-ScheduledTaskPrincipal `
    -UserId "SYSTEM" `
    -LogonType ServiceAccount `
    -RunLevel Highest

Write-Host "      ✅ Principal: SYSTEM account (highest privileges)" -ForegroundColor Green

# Register task
try {
    # Remove existing task if present
    $existingTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
    if ($existingTask) {
        Write-Host ""
        Write-Host "      ⚠️  Existing task found - removing..." -ForegroundColor Yellow
        Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
    }

    Write-Host ""
    Write-Host "      🔄 Registering scheduled task..." -ForegroundColor Cyan

    Register-ScheduledTask `
        -TaskName $TaskName `
        -Action $action `
        -Trigger $trigger `
        -Settings $settings `
        -Principal $principal `
        -Description "Automated backup of IntelIntent vault, configs, and checkpoints" | Out-Null

    Write-Host "      ✅ Task registered: $TaskName" -ForegroundColor Green

} catch {
    Write-Error "Failed to register scheduled task: $_"
    exit 1
}

# ===========================
# VERIFY TASK
# ===========================

Write-Host ""
Write-Host "   🔍 Verifying Task Registration..." -ForegroundColor Yellow
Write-Host ""

$task = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue

if ($task) {
    Write-Host "      ✅ Task Name: $($task.TaskName)" -ForegroundColor Green
    Write-Host "      ✅ State: $($task.State)" -ForegroundColor Green

    # Get task info
    $taskInfo = Get-ScheduledTaskInfo -TaskName $TaskName

    if ($taskInfo.NextRunTime) {
        Write-Host "      📅 Next Run: $($taskInfo.NextRunTime)" -ForegroundColor Cyan
    } else {
        Write-Host "      ⏸️  Next Run: Not scheduled (Startup trigger)" -ForegroundColor Gray
    }

    Write-Host "      🔄 Last Run: $($taskInfo.LastRunTime)" -ForegroundColor Gray
    Write-Host "      📊 Last Result: $($taskInfo.LastTaskResult)" -ForegroundColor Gray

} else {
    Write-Error "Task verification failed - task not found"
    exit 1
}

# ===========================
# TEST RUN (OPTIONAL)
# ===========================

if ($TestRun) {
    Write-Host ""
    Write-Host "   🧪 Running Test Backup..." -ForegroundColor Yellow
    Write-Host ""

    try {
        Start-ScheduledTask -TaskName $TaskName
        Write-Host "      ✅ Test backup started" -ForegroundColor Green
        Write-Host "      ⏳ Monitor Task Scheduler for progress" -ForegroundColor Cyan

        # Wait for task to complete (max 2 minutes)
        $timeout = 120
        $elapsed = 0

        do {
            Start-Sleep -Seconds 5
            $elapsed += 5

            $taskState = (Get-ScheduledTask -TaskName $TaskName).State
            Write-Host "      ⏳ Status: $taskState... ($elapsed seconds)" -ForegroundColor Gray

        } while ($taskState -eq "Running" -and $elapsed -lt $timeout)

        if ($taskState -eq "Ready") {
            Write-Host ""
            Write-Host "      ✅ Test backup completed!" -ForegroundColor Green

            # Check last result
            $taskInfo = Get-ScheduledTaskInfo -TaskName $TaskName
            if ($taskInfo.LastTaskResult -eq 0) {
                Write-Host "      ✅ Exit Code: Success (0)" -ForegroundColor Green
            } else {
                Write-Host "      ⚠️  Exit Code: $($taskInfo.LastTaskResult)" -ForegroundColor Yellow
            }
        } else {
            Write-Host ""
            Write-Host "      ⏰ Task still running after $timeout seconds" -ForegroundColor Yellow
        }

    } catch {
        Write-Error "Test run failed: $_"
    }
}

# ===========================
# FINAL INSTRUCTIONS
# ===========================

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║   ✅ TASK SCHEDULER SETUP COMPLETE                            ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

Write-Host "📋 Next Steps:" -ForegroundColor Cyan
Write-Host ""
Write-Host "   1. Verify task in Task Scheduler:" -ForegroundColor White
Write-Host "      • Press Win+R, type 'taskschd.msc', press Enter" -ForegroundColor Gray
Write-Host "      • Navigate to 'Task Scheduler Library'" -ForegroundColor Gray
Write-Host "      • Find '$TaskName'" -ForegroundColor Gray
Write-Host ""

Write-Host "   2. Test backup manually:" -ForegroundColor White
Write-Host "      Start-ScheduledTask -TaskName '$TaskName'" -ForegroundColor Gray
Write-Host ""

Write-Host "   3. View task history:" -ForegroundColor White
Write-Host "      Get-ScheduledTaskInfo -TaskName '$TaskName'" -ForegroundColor Gray
Write-Host ""

Write-Host "   4. View backup logs:" -ForegroundColor White
Write-Host "      Get-Content '$HOME\IntelIntent_Backups\backup-log.txt' -Tail 50" -ForegroundColor Gray
Write-Host ""

Write-Host "   5. Disable task (if needed):" -ForegroundColor White
Write-Host "      Disable-ScheduledTask -TaskName '$TaskName'" -ForegroundColor Gray
Write-Host ""

Write-Host "   6. Remove task (if needed):" -ForegroundColor White
Write-Host "      Unregister-ScheduledTask -TaskName '$TaskName' -Confirm:`$false" -ForegroundColor Gray
Write-Host ""

Write-Host "🎉 Your IntelIntent backups are now automated!" -ForegroundColor Green
Write-Host ""
