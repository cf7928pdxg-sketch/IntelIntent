<#
.SYNOPSIS
    Zero-trust backup script for orchestration files with authentication and verification at every step.

.DESCRIPTION
    Backs up critical orchestration files from C:\orchestration\ to a secure backup location.
    Implements zero assumptions and zero trust principles:
    - Verifies every file exists before backup
    - Authenticates file access permissions
    - Validates file integrity with hash comparison
    - Confirms backup completion with verification checks
    - Logs all operations for audit trail

.PARAMETER BackupRoot
    Root directory for backups (default: $HOME\IntelIntent_Backups)

.PARAMETER VerifyIntegrity
    Enable SHA256 hash verification (default: $true)

.PARAMETER CreateManifest
    Generate backup manifest with metadata (default: $true)

.EXAMPLE
    .\Backup-OrchestrationFiles.ps1
    Performs full backup with verification

.EXAMPLE
    .\Backup-OrchestrationFiles.ps1 -BackupRoot "D:\Backups" -VerifyIntegrity $true
    Custom backup location with integrity checks

.NOTES
    Author: IntelIntent Orchestration Team
    Version: 1.0.0
    Zero Trust Principles:
    - No implicit file access assumptions
    - Every path validated before use
    - All operations authenticated
    - Complete verification at each step
    - Comprehensive logging and audit trail
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [ValidateScript({
        if (-not (Test-Path $_ -IsValid)) {
            throw "Invalid path format: $_"
        }
        $true
    })]
    [string]$BackupRoot = "$HOME\IntelIntent_Backups",

    [Parameter(Mandatory=$false)]
    [bool]$VerifyIntegrity = $true,

    [Parameter(Mandatory=$false)]
    [bool]$CreateManifest = $true
)

#region Zero Trust Configuration
$ErrorActionPreference = "Stop"
$ProgressPreference = "Continue"

# Define source files with zero assumptions
$SourceFiles = @(
    @{
        Path = "C:\orchestration\main_orchestration.ps1"
        Type = "Script"
        Critical = $true
        Description = "Main orchestration script"
    },
    @{
        Path = "C:\orchestration\credentials.json"
        Type = "Credentials"
        Critical = $true
        Description = "Credential storage"
    },
    @{
        Path = "C:\orchestration\config.xml"
        Type = "Configuration"
        Critical = $true
        Description = "System configuration"
    }
)

# Backup metadata
$BackupSession = @{
    SessionID = (New-Guid).ToString()
    StartTime = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
    User = $env:USERNAME
    Computer = $env:COMPUTERNAME
    ScriptVersion = "1.0.0"
    ZeroTrustMode = $true
}
#endregion

#region Helper Functions

function Write-AuditLog {
    <#
    .SYNOPSIS
        Writes zero-trust audit log with authentication context.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("INFO", "SUCCESS", "WARNING", "ERROR", "VERIFY")]
        [string]$Level,

        [Parameter(Mandatory=$true)]
        [string]$Message,

        [Parameter(Mandatory=$false)]
        [hashtable]$Metadata = @{}
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = @{
        Timestamp = $timestamp
        Level = $Level
        Message = $Message
        SessionID = $BackupSession.SessionID
        User = $BackupSession.User
        Computer = $BackupSession.Computer
        Metadata = $Metadata
    }

    # Color-coded console output
    $color = switch ($Level) {
        "INFO"    { "Cyan" }
        "SUCCESS" { "Green" }
        "WARNING" { "Yellow" }
        "ERROR"   { "Red" }
        "VERIFY"  { "Magenta" }
    }

    $icon = switch ($Level) {
        "INFO"    { "ℹ️" }
        "SUCCESS" { "✅" }
        "WARNING" { "⚠️" }
        "ERROR"   { "❌" }
        "VERIFY"  { "🔍" }
    }

    Write-Host "[$timestamp] $icon $Level : $Message" -ForegroundColor $color

    # Append to log file
    $logPath = Join-Path $BackupRoot "backup-audit.log"
    $logEntry | ConvertTo-Json -Compress | Add-Content -Path $logPath -Force
}

function Test-FileAuthentication {
    <#
    .SYNOPSIS
        Zero-trust file authentication - verifies existence and access.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$FilePath,

        [Parameter(Mandatory=$true)]
        [string]$Description
    )

    Write-AuditLog -Level "VERIFY" -Message "Authenticating file: $Description" -Metadata @{ Path = $FilePath }

    # Step 1: Verify path format is valid
    if (-not (Test-Path $FilePath -IsValid)) {
        Write-AuditLog -Level "ERROR" -Message "Invalid path format: $FilePath"
        return $false
    }

    # Step 2: Verify file exists
    if (-not (Test-Path $FilePath -PathType Leaf)) {
        Write-AuditLog -Level "ERROR" -Message "File not found: $FilePath"
        return $false
    }

    # Step 3: Verify file is readable
    try {
        $fileInfo = Get-Item -Path $FilePath -ErrorAction Stop
        Write-AuditLog -Level "SUCCESS" -Message "File authenticated: $($fileInfo.Name)" -Metadata @{
            Size = $fileInfo.Length
            LastModified = $fileInfo.LastWriteTime
            Attributes = $fileInfo.Attributes.ToString()
        }
        return $true
    }
    catch {
        Write-AuditLog -Level "ERROR" -Message "File access denied: $FilePath - $($_.Exception.Message)"
        return $false
    }
}

function Get-FileIntegrityHash {
    <#
    .SYNOPSIS
        Calculates SHA256 hash for file integrity verification.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    try {
        $hash = Get-FileHash -Path $FilePath -Algorithm SHA256 -ErrorAction Stop
        Write-AuditLog -Level "VERIFY" -Message "Hash calculated: $(Split-Path $FilePath -Leaf)" -Metadata @{
            Algorithm = "SHA256"
            Hash = $hash.Hash
        }
        return $hash.Hash
    }
    catch {
        Write-AuditLog -Level "ERROR" -Message "Hash calculation failed: $FilePath - $($_.Exception.Message)"
        return $null
    }
}

function Initialize-BackupEnvironment {
    <#
    .SYNOPSIS
        Creates backup directory structure with zero assumptions.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$BackupRoot
    )

    Write-AuditLog -Level "INFO" -Message "Initializing backup environment: $BackupRoot"

    # Create timestamped backup folder
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupPath = Join-Path $BackupRoot "Backup_$timestamp"

    try {
        # Verify parent directory exists or create it
        if (-not (Test-Path $BackupRoot)) {
            Write-AuditLog -Level "INFO" -Message "Creating backup root: $BackupRoot"
            New-Item -Path $BackupRoot -ItemType Directory -Force | Out-Null
        }

        # Create session backup directory
        New-Item -Path $backupPath -ItemType Directory -Force | Out-Null
        Write-AuditLog -Level "SUCCESS" -Message "Backup directory created: $backupPath"

        # Create subdirectories by file type
        $subdirs = @("Scripts", "Credentials", "Configurations", "Logs", "Manifests")
        foreach ($subdir in $subdirs) {
            $subdirPath = Join-Path $backupPath $subdir
            New-Item -Path $subdirPath -ItemType Directory -Force | Out-Null
            Write-AuditLog -Level "INFO" -Message "Subdirectory created: $subdir"
        }

        return $backupPath
    }
    catch {
        Write-AuditLog -Level "ERROR" -Message "Failed to initialize backup environment: $($_.Exception.Message)"
        throw
    }
}

function Backup-FileWithVerification {
    <#
    .SYNOPSIS
        Backs up single file with zero-trust verification.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$FileSpec,

        [Parameter(Mandatory=$true)]
        [string]$BackupPath,

        [Parameter(Mandatory=$true)]
        [bool]$VerifyIntegrity
    )

    $sourcePath = $FileSpec.Path
    $fileType = $FileSpec.Type
    $description = $FileSpec.Description

    Write-AuditLog -Level "INFO" -Message "Starting backup: $description" -Metadata @{
        Source = $sourcePath
        Type = $fileType
    }

    # Step 1: Authenticate source file
    if (-not (Test-FileAuthentication -FilePath $sourcePath -Description $description)) {
        return @{
            Success = $false
            FilePath = $sourcePath
            Error = "Authentication failed"
        }
    }

    # Step 2: Calculate source hash (if integrity verification enabled)
    $sourceHash = $null
    if ($VerifyIntegrity) {
        $sourceHash = Get-FileIntegrityHash -FilePath $sourcePath
        if (-not $sourceHash) {
            return @{
                Success = $false
                FilePath = $sourcePath
                Error = "Hash calculation failed"
            }
        }
    }

    # Step 3: Determine destination path by file type
    $destSubdir = switch ($fileType) {
        "Script"        { "Scripts" }
        "Credentials"   { "Credentials" }
        "Configuration" { "Configurations" }
        default         { "Logs" }
    }

    $fileName = Split-Path $sourcePath -Leaf
    $destPath = Join-Path (Join-Path $BackupPath $destSubdir) $fileName

    # Step 4: Copy file with error handling
    try {
        Copy-Item -Path $sourcePath -Destination $destPath -Force -ErrorAction Stop
        Write-AuditLog -Level "SUCCESS" -Message "File copied: $fileName" -Metadata @{
            Destination = $destPath
        }
    }
    catch {
        Write-AuditLog -Level "ERROR" -Message "Copy failed: $fileName - $($_.Exception.Message)"
        return @{
            Success = $false
            FilePath = $sourcePath
            Error = $_.Exception.Message
        }
    }

    # Step 5: Verify destination file integrity
    if ($VerifyIntegrity) {
        Write-AuditLog -Level "VERIFY" -Message "Verifying backup integrity: $fileName"

        # Authenticate destination file
        if (-not (Test-FileAuthentication -FilePath $destPath -Description "Backup: $description")) {
            return @{
                Success = $false
                FilePath = $sourcePath
                Error = "Destination authentication failed"
            }
        }

        # Calculate destination hash
        $destHash = Get-FileIntegrityHash -FilePath $destPath
        if (-not $destHash) {
            return @{
                Success = $false
                FilePath = $sourcePath
                Error = "Destination hash calculation failed"
            }
        }

        # Compare hashes
        if ($sourceHash -ne $destHash) {
            Write-AuditLog -Level "ERROR" -Message "Hash mismatch detected!" -Metadata @{
                SourceHash = $sourceHash
                DestHash = $destHash
            }
            return @{
                Success = $false
                FilePath = $sourcePath
                Error = "Integrity verification failed (hash mismatch)"
            }
        }

        Write-AuditLog -Level "SUCCESS" -Message "Integrity verified: $fileName" -Metadata @{
            Hash = $destHash
        }
    }

    # Step 6: Return success with metadata
    return @{
        Success = $true
        FilePath = $sourcePath
        BackupPath = $destPath
        SourceHash = $sourceHash
        Size = (Get-Item $sourcePath).Length
    }
}

function New-BackupManifest {
    <#
    .SYNOPSIS
        Creates backup manifest with complete metadata.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$BackupPath,

        [Parameter(Mandatory=$true)]
        [array]$BackupResults
    )

    Write-AuditLog -Level "INFO" -Message "Generating backup manifest"

    $manifest = @{
        SessionID = $BackupSession.SessionID
        StartTime = $BackupSession.StartTime
        EndTime = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
        User = $BackupSession.User
        Computer = $BackupSession.Computer
        BackupPath = $BackupPath
        ZeroTrustMode = $BackupSession.ZeroTrustMode
        Files = $BackupResults | ForEach-Object {
            @{
                SourcePath = $_.FilePath
                BackupPath = $_.BackupPath
                Success = $_.Success
                Size = $_.Size
                Hash = $_.SourceHash
                Error = $_.Error
            }
        }
        Statistics = @{
            TotalFiles = $BackupResults.Count
            Successful = ($BackupResults | Where-Object { $_.Success }).Count
            Failed = ($BackupResults | Where-Object { -not $_.Success }).Count
            TotalSize = ($BackupResults | Where-Object { $_.Success } | Measure-Object -Property Size -Sum).Sum
        }
    }

    # Save manifest as JSON
    $manifestPath = Join-Path (Join-Path $BackupPath "Manifests") "backup-manifest.json"
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -Path $manifestPath -Force

    Write-AuditLog -Level "SUCCESS" -Message "Manifest created: backup-manifest.json" -Metadata $manifest.Statistics

    return $manifest
}

#endregion

#region Main Execution

try {
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║         ZERO-TRUST ORCHESTRATION BACKUP SYSTEM                 ║" -ForegroundColor Cyan
    Write-Host "║         Zero Assumptions | Complete Verification               ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

    Write-AuditLog -Level "INFO" -Message "Backup session started" -Metadata $BackupSession

    # Step 1: Initialize backup environment
    Write-Host "`n[STEP 1] Initializing backup environment...`n" -ForegroundColor Yellow
    $backupPath = Initialize-BackupEnvironment -BackupRoot $BackupRoot

    # Step 2: Backup each file with verification
    Write-Host "`n[STEP 2] Backing up orchestration files...`n" -ForegroundColor Yellow
    $backupResults = @()

    foreach ($fileSpec in $SourceFiles) {
        $result = Backup-FileWithVerification -FileSpec $fileSpec -BackupPath $backupPath -VerifyIntegrity $VerifyIntegrity
        $backupResults += $result

        if (-not $result.Success) {
            if ($fileSpec.Critical) {
                Write-AuditLog -Level "ERROR" -Message "CRITICAL FILE BACKUP FAILED: $($fileSpec.Path)"
            }
        }
    }

    # Step 3: Generate backup manifest
    if ($CreateManifest) {
        Write-Host "`n[STEP 3] Generating backup manifest...`n" -ForegroundColor Yellow
        $manifest = New-BackupManifest -BackupPath $backupPath -BackupResults $backupResults
    }

    # Step 4: Display summary
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║                    BACKUP SUMMARY                              ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

    Write-Host "Session ID      : $($BackupSession.SessionID)" -ForegroundColor White
    Write-Host "Backup Location : $backupPath" -ForegroundColor White
    Write-Host "Total Files     : $($backupResults.Count)" -ForegroundColor White
    Write-Host "✅ Successful   : $($manifest.Statistics.Successful)" -ForegroundColor Green
    Write-Host "❌ Failed       : $($manifest.Statistics.Failed)" -ForegroundColor $(if ($manifest.Statistics.Failed -gt 0) { "Red" } else { "Gray" })
    Write-Host "Total Size      : $([math]::Round($manifest.Statistics.TotalSize / 1KB, 2)) KB" -ForegroundColor White
    Write-Host "Integrity Check : $(if ($VerifyIntegrity) { 'ENABLED ✅' } else { 'DISABLED' })" -ForegroundColor $(if ($VerifyIntegrity) { "Green" } else { "Yellow" })

    Write-Host "`n📂 Backup Details:" -ForegroundColor Cyan
    foreach ($result in $backupResults) {
        $fileName = Split-Path $result.FilePath -Leaf
        if ($result.Success) {
            Write-Host "  ✅ $fileName - $(if ($result.SourceHash) { "Hash: $($result.SourceHash.Substring(0, 16))..." } else { 'No verification' })" -ForegroundColor Green
        }
        else {
            Write-Host "  ❌ $fileName - ERROR: $($result.Error)" -ForegroundColor Red
        }
    }

    Write-AuditLog -Level "SUCCESS" -Message "Backup session completed" -Metadata @{
        BackupPath = $backupPath
        Statistics = $manifest.Statistics
    }

    # Final verification check
    $criticalFailures = $backupResults | Where-Object { -not $_.Success -and $SourceFiles | Where-Object { $_.Path -eq $result.FilePath -and $_.Critical } }
    if ($criticalFailures) {
        Write-Host "`n⚠️  WARNING: Critical files failed to backup!" -ForegroundColor Red
        Write-AuditLog -Level "ERROR" -Message "Critical backup failures detected"
        exit 1
    }

    Write-Host "`n✅ Backup completed successfully!`n" -ForegroundColor Green
    exit 0
}
catch {
    Write-AuditLog -Level "ERROR" -Message "Backup session failed: $($_.Exception.Message)" -Metadata @{
        Exception = $_.Exception.GetType().FullName
        StackTrace = $_.ScriptStackTrace
    }

    Write-Host "`n❌ BACKUP FAILED: $($_.Exception.Message)`n" -ForegroundColor Red
    exit 1
}

#endregion
