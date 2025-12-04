<#
.SYNOPSIS
    Logs GitHub Copilot command invocations (Inline/Chat/Agent/Panel).

.DESCRIPTION
    Appends structured invocation events to JSON log for usage analytics and dashboard visualization.

.PARAMETER CommandID
    Copilot command identifier (e.g., "editor.action.inlineSuggest.trigger")

.PARAMETER InvocationType
    Invocation mode: Inline, Chat, Agent, Panel, Edit

.PARAMETER CompletionModel
    Model ID used for completion (default: gpt-4-copilot)

.PARAMETER ShortcutUsed
    Keyboard shortcut used (if applicable)

.PARAMETER Workspace
    Workspace name

.PARAMETER Context
    Optional context description

.PARAMETER Stage
    Pipeline stage (Editing, CodeReview, Testing, etc.)

.PARAMETER Result
    Execution result (Success, Failed, Cancelled)

.PARAMETER LogPath
    Path to log file (default: ../logs/CopilotInvocationLog.json)

.EXAMPLE
    .\Log-CopilotInvocation.ps1 -CommandID "editor.action.inlineSuggest.trigger" -InvocationType "Inline" -ShortcutUsed "Alt+\" -Workspace "IntelIntent"

.EXAMPLE
    .\Log-CopilotInvocation.ps1 -CommandID "github.copilot.generate" -InvocationType "Panel" -Workspace "IntelIntent" -Context "Generating PowerShell function"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$CommandID,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet("Inline", "Chat", "Agent", "Panel", "Edit")]
    [string]$InvocationType,
    
    [string]$CompletionModel = "gpt-4-copilot",
    
    [string]$ShortcutUsed = $null,
    
    [Parameter(Mandatory=$true)]
    [string]$Workspace,
    
    [string]$Context = "",
    
    [ValidateSet("Editing", "CodeReview", "Testing", "Debugging", "Documentation")]
    [string]$Stage = "Editing",
    
    [ValidateSet("Success", "Failed", "Cancelled")]
    [string]$Result = "Success",
    
    [string]$LogPath = "$PSScriptRoot\..\logs\CopilotInvocationLog.json"
)

# === Helper Functions ===

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
    
    # Create invocation entry
    $entry = [ordered]@{
        Timestamp       = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
        RunId           = "RUN-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        InvocationType  = $InvocationType
        CommandID       = $CommandID
        ShortcutUsed    = $ShortcutUsed
        CompletionModel = $CompletionModel
        ExtensionID     = "github.copilot"
        WorkspaceName   = $Workspace
        WorkspaceScope  = "Workspace:$Workspace"
        Context         = $Context
        Stage           = $Stage
        Result          = $Result
        SessionID       = if ($env:VSCODE_PID) { $env:VSCODE_PID } else { (New-Guid).ToString() }
    }
    
    # Load existing logs
    $existing = Get-Content $LogPath | ConvertFrom-Json
    
    # Append new entry
    $updated = @($existing) + $entry
    
    # Write back to file
    $updated | ConvertTo-Json -Depth 10 | Set-Content -Path $LogPath -Encoding UTF8
    
    Write-Host "✅ Logged invocation: $CommandID ($InvocationType)" -ForegroundColor Green
    Write-Host "   Workspace: $Workspace" -ForegroundColor Gray
    Write-Host "   Model: $CompletionModel" -ForegroundColor Gray
    Write-Host "   RunId: $($entry.RunId)" -ForegroundColor Gray
    if ($ShortcutUsed) {
        Write-Host "   Shortcut: $ShortcutUsed" -ForegroundColor Gray
    }
    
} catch {
    Write-Error "❌ Failed to log invocation event: $_"
    exit 1
}
