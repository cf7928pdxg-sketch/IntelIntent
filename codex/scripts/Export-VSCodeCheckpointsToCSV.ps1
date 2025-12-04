<#
.SYNOPSIS
    Export VS Code download checkpoints to CSV for Power BI ingestion.

.DESCRIPTION
    Aggregates individual checkpoint JSON files from Week 1 downloads into a single
    CSV file optimized for Power BI Desktop import. No Azure SQL dependency.

.PARAMETER CheckpointDirectory
    Directory containing checkpoint JSON files (default: ..\downloads\vscode)

.PARAMETER OutputPath
    CSV output file path (default: ..\downloads\vscode_checkpoints.csv)

.EXAMPLE
    .\Export-VSCodeCheckpointsToCSV.ps1

    Export all checkpoints from default directory to CSV

.EXAMPLE
    .\Export-VSCodeCheckpointsToCSV.ps1 -CheckpointDirectory "C:\Custom\Path" -OutputPath "C:\Output\checkpoints.csv"

    Export from custom directory to custom output path

.NOTES
    Author: IntelIntent Governance System
    Date: 2025-11-28
    Version: 1.0.0
    Dependencies: None (PowerShell 7.0+)
#>

[CmdletBinding()]
param(
    [string]$CheckpointDirectory = "..\downloads\vscode",
    [string]$OutputPath = "..\downloads\vscode_checkpoints.csv"
)

$ErrorActionPreference = "Stop"

Write-Host "`n📊 VS Code Checkpoint CSV Export" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Validate checkpoint directory exists
if (-not (Test-Path $CheckpointDirectory)) {
    Write-Error "❌ Checkpoint directory not found: $CheckpointDirectory"
    exit 1
}

Write-Host "📁 Checkpoint Directory: $CheckpointDirectory"
Write-Host "💾 Output CSV Path: $OutputPath"

# Load all checkpoint JSON files
$checkpointFiles = Get-ChildItem -Path $CheckpointDirectory -Filter "*checkpoint*.json" -ErrorAction SilentlyContinue

if ($checkpointFiles.Count -eq 0) {
    Write-Warning "⚠️ No checkpoint files found in $CheckpointDirectory"
    Write-Host "   Run Get-VSCodeDownload.ps1 with -CreateCheckpoint flag first"
    exit 1
}

Write-Host "`n🔍 Found $($checkpointFiles.Count) checkpoint file(s)"

# Parse checkpoints and map to CSV structure
$csvData = @()

foreach ($file in $checkpointFiles) {
    Write-Host "  📄 Processing: $($file.Name)" -ForegroundColor Gray
    
    try {
        $checkpoint = Get-Content $file.FullName | ConvertFrom-Json
        
        # Validate required fields (9 total)
        $requiredFields = @("TaskID", "Timestamp", "Status", "Inputs", "Outputs", "Artifacts", "Signature", "Duration", "SessionID")
        $missingFields = $requiredFields | Where-Object { -not $checkpoint.$_ }
        
        if ($missingFields.Count -gt 0) {
            Write-Warning "     ⚠️ Missing fields: $($missingFields -join ', ') - Skipping file"
            continue
        }
        
        # Map checkpoint fields to CSV columns
        $csvRow = [PSCustomObject]@{
            DistributionID    = $checkpoint.TaskID
            Platform          = $checkpoint.Inputs.Platform
            Architecture      = $checkpoint.Inputs.Architecture
            DownloadType      = $checkpoint.Inputs.DownloadType
            Version           = $checkpoint.Inputs.Version
            DownloadURL       = $checkpoint.Outputs.DownloadURL
            SHA256Hash        = $checkpoint.Outputs.SHA256Hash
            FileSize          = $checkpoint.Outputs.FileSize
            DownloadTimestamp = $checkpoint.Timestamp
            Status            = $checkpoint.Status
            DurationSeconds   = $checkpoint.Duration
            SessionID         = $checkpoint.SessionID
            CheckpointPath    = $file.FullName
        }
        
        $csvData += $csvRow
        Write-Host "     ✅ Mapped: $($checkpoint.Inputs.Platform) $($checkpoint.Inputs.Architecture) $($checkpoint.Inputs.DownloadType)" -ForegroundColor Green
        
    } catch {
        Write-Warning "     ❌ Failed to parse $($file.Name): $($_.Exception.Message)"
        continue
    }
}

if ($csvData.Count -eq 0) {
    Write-Error "❌ No valid checkpoints found - cannot generate CSV"
    exit 1
}

Write-Host "`n💾 Exporting $($csvData.Count) checkpoint(s) to CSV..."

# Export to CSV
try {
    $csvData | Export-Csv -Path $OutputPath -NoTypeInformation -Force
    Write-Host "✅ CSV export complete!" -ForegroundColor Green
    Write-Host "   File: $OutputPath"
    Write-Host "   Rows: $($csvData.Count)"
    Write-Host "   Columns: 13"
    
    # Display summary statistics
    Write-Host "`n📊 Summary Statistics:" -ForegroundColor Cyan
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Platform breakdown
    $platformCounts = $csvData | Group-Object -Property Platform | Select-Object Name, Count
    Write-Host "`nPlatform Distribution:"
    foreach ($platform in $platformCounts) {
        Write-Host "  $($platform.Name): $($platform.Count) distribution(s)"
    }
    
    # Status breakdown
    $statusCounts = $csvData | Group-Object -Property Status | Select-Object Name, Count
    Write-Host "`nStatus Breakdown:"
    foreach ($status in $statusCounts) {
        $color = if ($status.Name -eq "Success") { "Green" } elseif ($status.Name -eq "Failed") { "Red" } else { "Yellow" }
        Write-Host "  $($status.Name): $($status.Count) distribution(s)" -ForegroundColor $color
    }
    
    # Hash compliance
    $hashCompliant = ($csvData | Where-Object { $_.SHA256Hash -ne "[Pending SHA256]" }).Count
    $hashComplianceRate = [math]::Round(($hashCompliant / $csvData.Count) * 100, 2)
    Write-Host "`nHash Compliance:"
    Write-Host "  Verified: $hashCompliant / $($csvData.Count) ($hashComplianceRate%)"
    
    # Version distribution
    $versions = $csvData | Group-Object -Property Version | Select-Object Name, Count
    Write-Host "`nVersion Distribution:"
    foreach ($version in $versions) {
        Write-Host "  v$($version.Name): $($version.Count) distribution(s)"
    }
    
    # Total download size
    $totalSize = ($csvData | Measure-Object -Property FileSize -Sum).Sum
    Write-Host "`nTotal Downloaded: $([math]::Round($totalSize, 2)) MB"
    
    Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    Write-Host "✅ Ready for Power BI Desktop import!" -ForegroundColor Green
    Write-Host "`nNext Steps:"
    Write-Host "  1. Open Power BI Desktop"
    Write-Host "  2. Get Data → Text/CSV → Select: $OutputPath"
    Write-Host "  3. Build 3-page dashboard (Coverage Map, Drift Analysis, Hash Compliance)"
    Write-Host "  4. Add KPI cards (Platform Coverage, Hash Compliance Rate, Version Drift Count)"
    
} catch {
    Write-Error "❌ Failed to export CSV: $($_.Exception.Message)"
    exit 1
}

# Return CSV data for pipeline use
return $csvData
