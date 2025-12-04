<#
.SYNOPSIS
    Download VS Code distributions across all platforms and architectures.

.DESCRIPTION
    Universal VS Code distribution downloader supporting 26 platform/architecture combinations.
    Integrates with IntelIntent checkpoint system for audit trail and lineage tracking.

.PARAMETER Platform
    Target platform: Windows, macOS, Linux

.PARAMETER Architecture
    Target architecture: x64, x86, arm64, armhf, universal

.PARAMETER DownloadType
    Distribution type: installer, user-installer, zip, archive, deb, rpm, snap, cli

.PARAMETER Version
    VS Code version (e.g., "1.95.0"). Use "latest" for current stable release.

.PARAMETER OutputPath
    Download destination directory. Defaults to .\codex\downloads\vscode\

.PARAMETER DryRun
    Preview download without executing. Shows URL and metadata.

.PARAMETER VerifyHash
    Compute SHA256 hash after download for integrity validation.

.PARAMETER CreateCheckpoint
    Log download event to IntelIntent checkpoint system.

.EXAMPLE
    .\Get-VSCodeDownload.ps1 -Platform Windows -Architecture x64 -DownloadType installer

    Download Windows x64 System installer (latest version)

.EXAMPLE
    .\Get-VSCodeDownload.ps1 -Platform Linux -Architecture arm64 -DownloadType deb -Version "1.95.0"

    Download specific version of Linux Arm64 debian package

.EXAMPLE
    .\Get-VSCodeDownload.ps1 -Platform macOS -Architecture universal -VerifyHash -CreateCheckpoint

    Download macOS Universal build with SHA256 verification and checkpoint logging

.EXAMPLE
    # Download all Windows distributions
    @('installer', 'user-installer', 'zip', 'cli') | ForEach-Object {
        .\Get-VSCodeDownload.ps1 -Platform Windows -Architecture x64 -DownloadType $_
    }

.NOTES
    Author: IntelIntent Operations Team
    Version: 1.0.0
    Last Updated: 2025-11-28
    
    Distribution Matrix: 26 combinations
    - Windows: x64, arm64 (4 types each = 8 total)
    - macOS: universal, x64, arm64 (1-2 types each = 5 total)
    - Linux: x64, armhf, arm64 (4-5 types each = 13 total)
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('Windows', 'macOS', 'Linux')]
    [string]$Platform,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet('x64', 'arm64', 'armhf', 'universal')]
    [string]$Architecture,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet('installer', 'user-installer', 'zip', 'archive', 'deb', 'rpm', 'snap', 'cli', 'darwin')]
    [string]$DownloadType,
    
    [Parameter(Mandatory=$false)]
    [string]$Version = 'latest',
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = ".\codex\downloads\vscode",
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun,
    
    [Parameter(Mandatory=$false)]
    [switch]$VerifyHash,
    
    [Parameter(Mandatory=$false)]
    [switch]$CreateCheckpoint
)

# VS Code Distribution URL Matrix
$urlMatrix = @{
    'Windows-x64-installer' = 'https://update.code.visualstudio.com/{version}/win32-x64/stable'
    'Windows-x64-user-installer' = 'https://update.code.visualstudio.com/{version}/win32-x64-user/stable'
    'Windows-x64-zip' = 'https://update.code.visualstudio.com/{version}/win32-x64-archive/stable'
    'Windows-x64-cli' = 'https://update.code.visualstudio.com/{version}/cli-win32-x64/stable'
    'Windows-arm64-installer' = 'https://update.code.visualstudio.com/{version}/win32-arm64/stable'
    'Windows-arm64-user-installer' = 'https://update.code.visualstudio.com/{version}/win32-arm64-user/stable'
    'Windows-arm64-zip' = 'https://update.code.visualstudio.com/{version}/win32-arm64-archive/stable'
    'Windows-arm64-cli' = 'https://update.code.visualstudio.com/{version}/cli-win32-arm64/stable'
    'macOS-universal-darwin' = 'https://update.code.visualstudio.com/{version}/darwin-universal/stable'
    'macOS-x64-darwin' = 'https://update.code.visualstudio.com/{version}/darwin/stable'
    'macOS-x64-cli' = 'https://update.code.visualstudio.com/{version}/cli-darwin-x64/stable'
    'macOS-arm64-darwin' = 'https://update.code.visualstudio.com/{version}/darwin-arm64/stable'
    'macOS-arm64-cli' = 'https://update.code.visualstudio.com/{version}/cli-darwin-arm64/stable'
    'Linux-x64-archive' = 'https://update.code.visualstudio.com/{version}/linux-x64/stable'
    'Linux-x64-deb' = 'https://update.code.visualstudio.com/{version}/linux-deb-x64/stable'
    'Linux-x64-rpm' = 'https://update.code.visualstudio.com/{version}/linux-rpm-x64/stable'
    'Linux-x64-snap' = 'https://update.code.visualstudio.com/{version}/linux-snap-x64/stable'
    'Linux-x64-cli' = 'https://update.code.visualstudio.com/{version}/cli-linux-x64/stable'
    'Linux-armhf-archive' = 'https://update.code.visualstudio.com/{version}/linux-armhf/stable'
    'Linux-armhf-deb' = 'https://update.code.visualstudio.com/{version}/linux-deb-armhf/stable'
    'Linux-armhf-rpm' = 'https://update.code.visualstudio.com/{version}/linux-rpm-armhf/stable'
    'Linux-armhf-cli' = 'https://update.code.visualstudio.com/{version}/cli-linux-armhf/stable'
    'Linux-arm64-archive' = 'https://update.code.visualstudio.com/{version}/linux-arm64/stable'
    'Linux-arm64-deb' = 'https://update.code.visualstudio.com/{version}/linux-deb-arm64/stable'
    'Linux-arm64-rpm' = 'https://update.code.visualstudio.com/{version}/linux-rpm-arm64/stable'
    'Linux-arm64-cli' = 'https://update.code.visualstudio.com/{version}/cli-linux-arm64/stable'
}

# Build lookup key
$key = "$Platform-$Architecture-$DownloadType"

# Validate combination
if (-not $urlMatrix.ContainsKey($key)) {
    Write-Error "❌ Invalid combination: Platform=$Platform, Architecture=$Architecture, DownloadType=$DownloadType"
    Write-Host "`nValid combinations for $Platform-$Architecture`:"
    $urlMatrix.Keys | Where-Object { $_ -like "$Platform-$Architecture-*" } | ForEach-Object {
        $parts = $_ -split '-'
        Write-Host "  - DownloadType: $($parts[2])"
    }
    exit 1
}

# Get URL template
$urlTemplate = $urlMatrix[$key]

# Resolve version
if ($Version -eq 'latest') {
    Write-Host "🔍 Resolving latest VS Code version..."
    try {
        $latestUrl = "https://update.code.visualstudio.com/api/releases/stable"
        $versionInfo = Invoke-RestMethod -Uri $latestUrl -Method Get
        $Version = $versionInfo[0].version
        Write-Host "✅ Latest version: $Version"
    } catch {
        Write-Warning "Failed to resolve latest version, using 'latest' placeholder"
        $Version = 'latest'
    }
}

# Build download URL
$downloadUrl = $urlTemplate -replace '\{version\}', $Version

# Determine file extension
$extension = switch -Regex ($key) {
    'installer' { '.exe' }
    'zip' { '.zip' }
    'archive' { '.tar.gz' }
    'deb' { '.deb' }
    'rpm' { '.rpm' }
    'snap' { '.snap' }
    'cli' { if ($Platform -eq 'Windows') { '.zip' } else { '.tar.gz' } }
    'darwin' { '.zip' }
    default { '.bin' }
}

# Build output filename
$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$filename = "vscode-$Version-$Platform-$Architecture-$DownloadType$extension"
$outputFile = Join-Path $OutputPath $filename

# Create output directory
if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
}

# Display download info
Write-Host "`n📦 VS Code Download Configuration"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host "Platform:      $Platform"
Write-Host "Architecture:  $Architecture"
Write-Host "Download Type: $DownloadType"
Write-Host "Version:       $Version"
Write-Host "URL:           $downloadUrl"
Write-Host "Output File:   $outputFile"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n"

# Dry run mode
if ($DryRun) {
    Write-Host "🔍 [DRY RUN] Would download from: $downloadUrl" -ForegroundColor Yellow
    Write-Host "   Output: $outputFile" -ForegroundColor Yellow
    exit 0
}

# Download file
Write-Host "⬇️  Downloading VS Code distribution..."
$startTime = Get-Date

try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $outputFile -UseBasicParsing
    
    $endTime = Get-Date
    $duration = ($endTime - $startTime).TotalSeconds
    $fileSize = (Get-Item $outputFile).Length / 1MB
    
    Write-Host "✅ Download complete!" -ForegroundColor Green
    Write-Host "   File Size: $($fileSize.ToString('F2')) MB"
    Write-Host "   Duration:  $($duration.ToString('F2')) seconds"
    Write-Host "   Path:      $outputFile"
    
} catch {
    Write-Error "❌ Download failed: $_"
    exit 1
}

# Verify hash
$hash = $null
if ($VerifyHash) {
    Write-Host "`n🔐 Computing SHA256 hash..."
    $hash = (Get-FileHash -Path $outputFile -Algorithm SHA256).Hash
    Write-Host "✅ SHA256: $hash" -ForegroundColor Green
}

# Create checkpoint
if ($CreateCheckpoint) {
    Write-Host "`n📝 Creating IntelIntent checkpoint..."
    
    $checkpoint = @{
        TaskID = "VSCODE-DOWNLOAD-$(Get-Date -Format 'yyyyMMddHHmmss')"
        Timestamp = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
        Status = "Success"
        Inputs = @{
            Platform = $Platform
            Architecture = $Architecture
            DownloadType = $DownloadType
            Version = $Version
            URL = $downloadUrl
        }
        Outputs = @{
            FilePath = $outputFile
            FileSize = $fileSize
            Hash = if ($hash) { $hash } else { "[Pending SHA256]" }
            Duration = $duration
        }
        Artifacts = @($filename)
        Signature = if ($hash) { $hash } else { "[Pending SHA256]" }
        DurationSeconds = [int]$duration
        SessionID = "VSCodeDownload-$(Get-Date -Format 'yyyyMMdd')"
    }
    
    # Save checkpoint
    $checkpointPath = Join-Path $OutputPath "vscode_download_checkpoint.json"
    
    if (Test-Path $checkpointPath) {
        $existingCheckpoints = Get-Content $checkpointPath | ConvertFrom-Json
        $existingCheckpoints.Checkpoints += $checkpoint
        $existingCheckpoints | ConvertTo-Json -Depth 10 | Set-Content $checkpointPath
    } else {
        @{
            SessionMetadata = @{
                SchemaVersion = "1.0.0"
                GeneratedBy = "Get-VSCodeDownload.ps1"
                CreatedAt = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
            }
            Checkpoints = @($checkpoint)
        } | ConvertTo-Json -Depth 10 | Set-Content $checkpointPath
    }
    
    Write-Host "✅ Checkpoint saved: $checkpointPath" -ForegroundColor Green
}

# Summary
Write-Host "`n🎉 VS Code distribution ready for deployment!"
Write-Host "   Use: code --install-extension <extension.vsix>"
Write-Host "   Or:  Extract and deploy via CI/CD pipeline"

# Return download metadata
return @{
    Success = $true
    FilePath = $outputFile
    FileSize = $fileSize
    Hash = $hash
    Duration = $duration
    Version = $Version
    Platform = $Platform
    Architecture = $Architecture
    DownloadType = $DownloadType
}
