<#
.SYNOPSIS
    Logs GitHub Copilot lifecycle events (Enable/Disable/Toggle/Install/Uninstall/Update).

.DESCRIPTION
    Appends structured lifecycle events to JSON log for Power BI dashboard integration.
    Includes cryptographic hash validation and structured telemetry fields.

.PARAMETER Action
    Lifecycle action: Enable, Disable, Toggle, Install, Uninstall, Update

.PARAMETER ExtensionID
    Extension identifier (default: github.copilot)

.PARAMETER Version
    Extension version number

.PARAMETER Workspace
    Workspace name (IntelIntent, Global, etc.)

.PARAMETER Reason
    Human-readable reason for the action

.PARAMETER Stage
    Pipeline stage (Configuration, Deployment, Testing, Production)

.PARAMETER Result
    Execution result (Success, Failed, Pending)

.PARAMETER LogPath
    Path to log file (default: ../logs/CopilotLifecycleLog.json)

.EXAMPLE
    .\Log-CopilotLifecycle.ps1 -Action Enable -Version "1.388.0" -Workspace "IntelIntent" -Reason "Starting Week 1 automation"

.EXAMPLE
    .\Log-CopilotLifecycle.ps1 -Action Disable -Version "1.388.0" -Workspace "Global" -Reason "Testing disable flow" -Stage "Testing"
#>

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Enable", "Disable", "Toggle", "Install", "Uninstall", "Update")]
    [string]$Action,
    
    [string]$ExtensionID = "github.copilot",
    
    [Parameter(Mandatory=$true)]
    [string]$Version,
    
    [Parameter(Mandatory=$true)]
    [string]$Workspace,
    
    [Parameter(Mandatory=$true)]
    [string]$Reason,
    
    [ValidateSet("Configuration", "Deployment", "Testing", "Production", "Recovery")]
    [string]$Stage = "Configuration",
    
    [ValidateSet("Success", "Failed", "Pending")]
    [string]$Result = "Success",
    
    [string]$LogPath = "$PSScriptRoot\..\logs\CopilotLifecycleLog.json"
)

# === Helper Functions ===

function Get-VsixHash {
    <#
    .SYNOPSIS
        Calculates SHA256 hash of VSIX extension file if available.
    #>
    param(
        [string]$ExtensionID,
        [string]$Version
    )
    
    # Check common VSIX locations
    $vsixLocations = @(
        "$env:USERPROFILE\.vscode\extensions\$ExtensionID-$Version.vsix",
        "$env:USERPROFILE\.vscode-insiders\extensions\$ExtensionID-$Version.vsix",
        "$PSScriptRoot\$ExtensionID-$Version.vsix"
    )
    
    foreach ($candidate in $vsixLocations) {
        if (Test-Path $candidate) {
            try {
                $hash = (Get-FileHash $candidate -Algorithm SHA256).Hash
                Write-Verbose "✅ Calculated hash for $candidate"
                return $hash
            } catch {
                Write-Warning "⚠️ Failed to calculate hash for $candidate"
            }
        }
    }
    
    # Return placeholder if VSIX not found
    return "[Pending SHA256]"
}

function Initialize-LogFile {
    <#
    .SYNOPSIS
        Ensures log file exists and is valid JSON.
    #>
    param([string]$Path)
    
    $directory = Split-Path -Parent $Path
    if (-not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
        Write-Verbose "📁 Created log directory: $directory"
    }
    
    if (-not (Test-Path $Path)) {
        @() | ConvertTo-Json | Set-Content -Path $Path -Encoding UTF8
        Write-Verbose "📄 Initialized log file: $Path"
    }
}

# === Main Logic ===

try {
    # Initialize log file
    Initialize-LogFile -Path $LogPath
    
    # Create lifecycle entry
    $entry = [ordered]@{
        Timestamp            = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
        RunId                = "RUN-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        LifecycleAction      = $Action
        ExtensionID          = $ExtensionID
        Version              = $Version
        WorkspaceName        = $Workspace
        WorkspaceScope       = if ($Workspace -eq "Global") { "Global" } else { "Workspace" }
        Reason               = $Reason
        Stage                = $Stage
        Result               = $Result
        Hash                 = Get-VsixHash -ExtensionID $ExtensionID -Version $Version
        ExtensionUnification = $true
        SessionID            = if ($env:VSCODE_PID) { $env:VSCODE_PID } else { (New-Guid).ToString() }
    }
    
    # Load existing logs
    $existing = Get-Content $LogPath | ConvertFrom-Json
    
    # Append new entry
    $updated = @($existing) + $entry
    
    # Write back to file
    $updated | ConvertTo-Json -Depth 10 | Set-Content -Path $LogPath -Encoding UTF8
    
    Write-Host "✅ Logged lifecycle: $Action ($ExtensionID $Version)" -ForegroundColor Green
    Write-Host "   Workspace: $Workspace" -ForegroundColor Gray
    Write-Host "   Reason: $Reason" -ForegroundColor Gray
    Write-Host "   RunId: $($entry.RunId)" -ForegroundColor Gray
    Write-Host "   Hash: $($entry.Hash)" -ForegroundColor Gray
    
} catch {
    Write-Error "❌ Failed to log lifecycle event: $_"
    exit 1
}
