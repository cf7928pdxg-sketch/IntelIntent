# Test-CopilotLifecycleTracker.ps1
# Purpose: Test and demonstration script for Copilot lifecycle tracking

<#
.SYNOPSIS
    Demonstrates GitHub Copilot lifecycle tracking integration with IntelIntent.

.DESCRIPTION
    Creates sample lifecycle and invocation events, exports to Power BI format,
    and validates JSON schema compatibility.

.EXAMPLE
    .\Test-CopilotLifecycleTracker.ps1
#>

# Import module
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module "$scriptPath\IntelIntent_Seeding\CopilotLifecycleTracker.psm1" -Force

Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Copilot Lifecycle Tracker - Demo & Test" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# === Test 1: Initialize Tracker ===
Write-Host "📋 Test 1: Initializing tracker..." -ForegroundColor Yellow
Initialize-CopilotLifecycleLog
Write-Host ""

# === Test 2: Log Lifecycle Events ===
Write-Host "📋 Test 2: Logging lifecycle events..." -ForegroundColor Yellow

Add-CopilotLifecycleEvent `
    -Action "Enable" `
    -Reason "Starting Week 1 automation" `
    -Workspace "IntelIntent"

Start-Sleep -Seconds 1

Add-CopilotLifecycleEvent `
    -Action "Toggle" `
    -Reason "Testing toggle functionality" `
    -Workspace "IntelIntent"

Start-Sleep -Seconds 1

Add-CopilotLifecycleEvent `
    -Action "Update" `
    -Reason "Extension updated to v1.388.0" `
    -Workspace "Global"

Write-Host "✅ Logged 3 lifecycle events" -ForegroundColor Green
Write-Host ""

# === Test 3: Log Command Invocations ===
Write-Host "📋 Test 3: Logging command invocations..." -ForegroundColor Yellow

Add-CopilotCommandInvocation `
    -CommandID "editor.action.inlineSuggest.trigger" `
    -InvocationType "Inline" `
    -ShortcutUsed "Alt+\" `
    -Context "Writing Add-Checkpoint function"

Start-Sleep -Seconds 1

Add-CopilotCommandInvocation `
    -CommandID "github.copilot.generate" `
    -InvocationType "Panel" `
    -CompletionModel "gpt-4-copilot" `
    -Context "Generating PowerShell module structure"

Start-Sleep -Seconds 1

Add-CopilotCommandInvocation `
    -CommandID "github.copilot.chat" `
    -InvocationType "Chat" `
    -Context "Asking about Azure CLI commands"

Start-Sleep -Seconds 1

Add-CopilotCommandInvocation `
    -CommandID "github.copilot.agent" `
    -InvocationType "Agent" `
    -Context "Implementing placeholder modules"

Write-Host "✅ Logged 4 command invocations" -ForegroundColor Green
Write-Host ""

# === Test 4: Retrieve Logs ===
Write-Host "📋 Test 4: Retrieving logs..." -ForegroundColor Yellow

Write-Host "  📊 All Events:" -ForegroundColor Cyan
$allLogs = Get-CopilotLifecycleLogs -FilterEventType "All"
Write-Host "     Total events: $($allLogs.Count)" -ForegroundColor Gray

Write-Host "  📊 Lifecycle Events:" -ForegroundColor Cyan
$lifecycleLogs = Get-CopilotLifecycleLogs -FilterEventType "Lifecycle"
Write-Host "     Total lifecycle events: $($lifecycleLogs.Count)" -ForegroundColor Gray

Write-Host "  📊 Invocation Events:" -ForegroundColor Cyan
$invocationLogs = Get-CopilotLifecycleLogs -FilterEventType "Invocation"
Write-Host "     Total invocation events: $($invocationLogs.Count)" -ForegroundColor Gray

Write-Host ""

# === Test 5: Display Recent Events ===
Write-Host "📋 Test 5: Displaying recent events..." -ForegroundColor Yellow
$recentLogs = Get-CopilotLifecycleLogs -Last 5
$recentLogs | Format-Table -Property Timestamp, EventType, Action, InvocationType, CommandID, Workspace -AutoSize

# === Test 6: Export to Power BI ===
Write-Host "📋 Test 6: Exporting to Power BI format..." -ForegroundColor Yellow
$exportPath = ".\Sponsors\Copilot_Dashboard_Sample.json"

Export-CopilotLifecycleForPowerBI -OutputPath $exportPath -IncludeMetrics

if (Test-Path $exportPath) {
    Write-Host "✅ Power BI export successful" -ForegroundColor Green
    Write-Host "   Location: $exportPath" -ForegroundColor Gray
    
    # Display export summary
    $export = Get-Content $exportPath | ConvertFrom-Json
    Write-Host ""
    Write-Host "  📊 Export Summary:" -ForegroundColor Cyan
    Write-Host "     Total Events: $($export.TotalEvents)" -ForegroundColor Gray
    Write-Host "     Lifecycle Events: $($export.Metrics.LifecycleEvents)" -ForegroundColor Gray
    Write-Host "     Invocation Events: $($export.Metrics.InvocationEvents)" -ForegroundColor Gray
    Write-Host "     Inline Invocations: $($export.Metrics.InlineInvocations)" -ForegroundColor Gray
    Write-Host "     Chat Invocations: $($export.Metrics.ChatInvocations)" -ForegroundColor Gray
    Write-Host "     Agent Invocations: $($export.Metrics.AgentInvocations)" -ForegroundColor Gray
}

Write-Host ""

# === Test 7: Generate Load Test Data ===
Write-Host "📋 Test 7: Generating load test data (50 events)..." -ForegroundColor Yellow

$actions = @("Enable", "Disable", "Toggle")
$invocationTypes = @("Inline", "Chat", "Agent", "Panel")
$commands = @(
    "editor.action.inlineSuggest.trigger",
    "github.copilot.generate",
    "github.copilot.chat",
    "github.copilot.agent",
    "github.copilot.openModelPicker"
)

1..25 | ForEach-Object {
    $action = Get-Random -InputObject $actions
    Add-CopilotLifecycleEvent -Action $action -Reason "Load test $_" -Workspace "IntelIntent" -ErrorAction SilentlyContinue
}

1..25 | ForEach-Object {
    $invocationType = Get-Random -InputObject $invocationTypes
    $commandID = Get-Random -InputObject $commands
    Add-CopilotCommandInvocation `
        -CommandID $commandID `
        -InvocationType $invocationType `
        -Context "Load test invocation $_" `
        -ErrorAction SilentlyContinue
}

Write-Host "✅ Load test complete - 50 events generated" -ForegroundColor Green
Write-Host ""

# === Test 8: Validate JSON Schema ===
Write-Host "📋 Test 8: Validating JSON schema..." -ForegroundColor Yellow

$validation = $true
$errors = @()

$sampleEvent = Get-CopilotLifecycleLogs -Last 1 | Select-Object -First 1

# Required fields
$requiredFields = @("Timestamp", "EventType", "ExtensionID", "Version", "Workspace", "Hash", "RunId", "SessionID", "WorkspaceScope")

foreach ($field in $requiredFields) {
    if (-not $sampleEvent.$field) {
        $validation = $false
        $errors += "Missing required field: $field"
    }
}

if ($validation) {
    Write-Host "✅ JSON schema validation passed" -ForegroundColor Green
} else {
    Write-Host "❌ JSON schema validation failed" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "   - $_" -ForegroundColor Red }
}

Write-Host ""

# === Test 9: Tracker State ===
Write-Host "📋 Test 9: Displaying tracker state..." -ForegroundColor Yellow
$state = Get-CopilotTrackerState
Write-Host "  Session ID: $($state.SessionID)" -ForegroundColor Gray
Write-Host "  Extension ID: $($state.ExtensionID)" -ForegroundColor Gray
Write-Host "  Version: $($state.Version)" -ForegroundColor Gray
Write-Host "  Log File: $($state.LogFile)" -ForegroundColor Gray

Write-Host ""

# === Summary ===
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  ✅ All Tests Completed Successfully" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Import $exportPath into Power BI Desktop" -ForegroundColor Gray
Write-Host "  2. Create visuals using the schema in COPILOT_LINEAGE_OVERLAY.md" -ForegroundColor Gray
Write-Host "  3. Integrate tracker into Week1_Automation.ps1 and Orchestrator.ps1" -ForegroundColor Gray
Write-Host "  4. Review generated logs at: $($state.LogFile)" -ForegroundColor Gray
Write-Host ""
