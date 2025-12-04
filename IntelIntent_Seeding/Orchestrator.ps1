# Orchestrator.ps1
# Phase 2.3: Central Nervous System - Semantic Orchestration Engine
# Purpose: Coordinate manifest reading, component generation, and agent invocation

<#
.SYNOPSIS
    IntelIntent central orchestrator - coordinates all recursive operations.

.DESCRIPTION
    The Orchestrator is the central nervous system that:
    1. Loads manifests from IntelIntent-Seed directory
    2. Builds execution queue with priority ordering
    3. Generates components from manifest metadata
    4. Invokes specialized agents via AgentBridge
    5. Tracks progress with checkpoint-based recovery
    6. Implements feedback loops for recursive execution

.PARAMETER Mode
    Orchestration mode:
    - "Full": Execute complete pipeline (manifest → generation → validation)
    - "ManifestOnly": Load and validate manifests without generation
    - "GenerateOnly": Generate components from existing queue
    - "ValidateOnly": Validate existing components and checkpoints

.PARAMETER Category
    Optional category filter to process specific module only.

.EXAMPLE
    .\Orchestrator.ps1 -Mode "Full" -Verbose

.EXAMPLE
    .\Orchestrator.ps1 -Mode "GenerateOnly" -Category "Identity_Modules"

.NOTES
    Author: IntelIntent Orchestration System
    Date: 2025-11-26
    Version: 2.3.0
#>

param(
    [ValidateSet("Full", "ManifestOnly", "GenerateOnly", "ValidateOnly")]
    [string]$Mode = "Full",
    
    [string]$Category = "",
    
    [switch]$DryRun
)

# === Import Required Modules ===
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module "$scriptPath\ManifestReader.ps1" -Force -Verbose:$false
Import-Module "$scriptPath\AgentBridge.psm1" -Force -Verbose:$false

# === Orchestrator State ===
$script:OrchestratorState = @{
    SessionID = (New-Guid).ToString()
    StartTime = Get-Date
    Mode = $Mode
    Category = $Category
    DryRun = $DryRun
    Manifests = $null
    ExecutionQueue = @()
    GeneratedComponents = @()
    FailedComponents = @()
    Progress = @{
        Total = 0
        Completed = 0
        Failed = 0
        Skipped = 0
    }
}

# === Core Orchestration Functions ===

function Initialize-Orchestrator {
    <#
    .SYNOPSIS
        Initializes orchestrator session and validates environment.
    #>
    
    Write-Output "═══════════════════════════════════════════════════════════════"
    Write-Output "  IntelIntent Orchestrator - Phase 2.3"
    Write-Output "  Session ID: $($script:OrchestratorState.SessionID)"
    Write-Output "  Mode: $Mode"
    if ($Category) { Write-Output "  Category Filter: $Category" }
    if ($DryRun) { Write-Output "  ⚠️ DRY RUN MODE - No files will be modified" }
    Write-Output "═══════════════════════════════════════════════════════════════"
    Write-Output ""
    
    # Validate environment
    Write-Output "🔍 Validating environment..."
    
    # Check for IntelIntent-Seed directory
    $seedPath = Join-Path $scriptPath "..\IntelIntent-Seed"
    if (-not (Test-Path $seedPath)) {
        Write-Error "❌ IntelIntent-Seed directory not found: $seedPath"
        return $false
    }
    Write-Output "  ✅ IntelIntent-Seed directory found"
    
    # Check for Recursive_Operations directory
    $recOpsPath = Join-Path $scriptPath "Recursive_Operations"
    if (-not (Test-Path $recOpsPath)) {
        Write-Output "  📁 Creating Recursive_Operations directory..."
        New-Item -ItemType Directory -Path $recOpsPath -Force | Out-Null
    }
    Write-Output "  ✅ Recursive_Operations directory ready"
    
    Write-Output ""
    return $true
}

function Invoke-ManifestLoading {
    <#
    .SYNOPSIS
        Loads and validates all manifest files.
    #>
    
    Write-Output "📖 Phase 1: Manifest Loading"
    Write-Output "───────────────────────────────────────────────────────────────"
    
    # Load all manifests
    $manifests = Get-AllManifests
    $script:OrchestratorState.Manifests = $manifests
    
    # Validate integrity
    $valid = Test-ManifestIntegrity -Manifests $manifests
    
    if ($valid) {
        Write-Output "  ✅ All manifests loaded and validated"
    }
    else {
        Write-Warning "  ⚠️ Manifest validation issues detected"
    }
    
    Write-Output ""
    return $valid
}

function Build-ExecutionQueue {
    <#
    .SYNOPSIS
        Builds prioritized execution queue from manifests.
    #>
    
    Write-Output "🎯 Phase 2: Execution Queue Building"
    Write-Output "───────────────────────────────────────────────────────────────"
    
    $queue = Get-ComponentQueue -Manifests $script:OrchestratorState.Manifests -FilterCategory $Category
    $script:OrchestratorState.ExecutionQueue = $queue
    $script:OrchestratorState.Progress.Total = $queue.Count
    
    if ($queue.Count -eq 0) {
        Write-Warning "  ⚠️ No components found in execution queue"
        return $false
    }
    
    Write-Output "  📊 Queue Summary:"
    Write-Output "    Total Components: $($queue.Count)"
    
    # Group by category
    $categories = $queue | Group-Object Category | Sort-Object Count -Descending
    foreach ($cat in $categories) {
        Write-Output "    - $($cat.Name): $($cat.Count) components"
    }
    
    Write-Output ""
    return $true
}

function Invoke-ComponentGeneration {
    <#
    .SYNOPSIS
        Generates PowerShell component files from execution queue.
    #>
    
    Write-Output "🏗️ Phase 3: Component Generation"
    Write-Output "───────────────────────────────────────────────────────────────"
    
    if ($DryRun) {
        Write-Output "  ⚠️ DRY RUN - Components will not be created"
        Write-Output ""
    }
    
    $queue = $script:OrchestratorState.ExecutionQueue
    $current = 0
    
    foreach ($component in $queue) {
        $current++
        $progressPercent = [math]::Round(($current / $queue.Count) * 100, 1)
        
        Write-Output "[$current/$($queue.Count)] ($progressPercent%) Generating: $($component.Title)"
        Write-Verbose "  ID: $($component.ID)"
        Write-Verbose "  Category: $($component.Category)"
        Write-Verbose "  Priority: $($component.Priority)"
        
        if (-not $DryRun) {
            try {
                # Ensure directory exists
                $componentDir = Split-Path $component.ComponentPath -Parent
                if (-not (Test-Path $componentDir)) {
                    New-Item -ItemType Directory -Path $componentDir -Force | Out-Null
                }
                
                # Check if component already exists
                if (Test-Path $component.ComponentPath) {
                    Write-Output "  ⏭️ Skipping - Component already exists"
                    $script:OrchestratorState.Progress.Skipped++
                    continue
                }
                
                # Generate component template
                $template = @"
# PowerShell Component: $($component.Title)
# Category: $($component.Category)
# ID: $($component.ID)
# Priority: $($component.Priority)
# Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
# Session: $($script:OrchestratorState.SessionID)

<#
.SYNOPSIS
    $($component.Title)

.DESCRIPTION
    Generated component for $($component.Category) module.
    This is a placeholder awaiting recursive implementation.
#>

Write-Output "Executing component: $($component.Title)"
Write-Output "  Category: $($component.Category)"
Write-Output "  ID: $($component.ID)"

# === Component Logic ===
Write-Output "  ⚠️ Status: Placeholder - Awaiting implementation"

# === Agent Integration (Optional) ===
# Import-Module "$PSScriptRoot\..\IntelIntent_Seeding\AgentBridge.psm1" -Force
# `$result = Invoke-OrchestratorAgent -Intent "$($component.Title)" -Context @{ComponentID = "$($component.ID)"}

# === Checkpoint Creation ===
`$checkpointDir = "$componentDir\Recursive_Operations"
if (-not (Test-Path `$checkpointDir)) {
    New-Item -ItemType Directory -Path `$checkpointDir -Force | Out-Null
}

`$checkpointPath = "`$checkpointDir\$($component.ID)_checkpoint.txt"
`$checkpointData = @{
    ComponentID = "$($component.ID)"
    Title = "$($component.Title)"
    Category = "$($component.Category)"
    CompletedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Status = "Generated"
}

Set-Content -Path `$checkpointPath -Value (`$checkpointData | ConvertTo-Json)

Write-Output "  ✅ Component completed"
Write-Output "  📄 Checkpoint: `$checkpointPath"
"@
                
                Set-Content -Path $component.ComponentPath -Value $template
                
                $script:OrchestratorState.GeneratedComponents += $component
                $script:OrchestratorState.Progress.Completed++
                
                Write-Output "  ✅ Generated: $($component.ComponentPath)"
            }
            catch {
                Write-Error "  ❌ Failed to generate component: $_"
                $script:OrchestratorState.FailedComponents += $component
                $script:OrchestratorState.Progress.Failed++
            }
        }
        else {
            Write-Output "  [DRY RUN] Would generate: $($component.ComponentPath)"
        }
        
        Write-Output ""
    }
    
    Write-Output "═══════════════════════════════════════════════════════════════"
    Write-Output "  Generation Complete"
    Write-Output "  ✅ Generated: $($script:OrchestratorState.Progress.Completed)"
    Write-Output "  ⏭️ Skipped: $($script:OrchestratorState.Progress.Skipped)"
    Write-Output "  ❌ Failed: $($script:OrchestratorState.Progress.Failed)"
    Write-Output "═══════════════════════════════════════════════════════════════"
    Write-Output ""
}

function Invoke-ComponentValidation {
    <#
    .SYNOPSIS
        Validates generated components and checkpoints.
    #>
    
    Write-Output "🔍 Phase 4: Component Validation"
    Write-Output "───────────────────────────────────────────────────────────────"
    
    $queue = $script:OrchestratorState.ExecutionQueue
    $validationResults = @()
    
    foreach ($component in $queue) {
        $result = @{
            Component = $component.ID
            ComponentExists = (Test-Path $component.ComponentPath)
            CheckpointExists = (Test-Path $component.CheckpointPath)
            Valid = $false
        }
        
        $result.Valid = $result.ComponentExists -and $result.CheckpointExists
        $validationResults += $result
        
        if ($result.Valid) {
            Write-Output "  ✅ $($component.ID): Valid"
        }
        else {
            Write-Warning "  ⚠️ $($component.ID): Missing files"
            if (-not $result.ComponentExists) { Write-Warning "    - Component file not found" }
            if (-not $result.CheckpointExists) { Write-Warning "    - Checkpoint not found" }
        }
    }
    
    $validCount = ($validationResults | Where-Object { $_.Valid }).Count
    Write-Output ""
    Write-Output "  Validation Summary: $validCount / $($queue.Count) components valid"
    Write-Output ""
}

function Save-OrchestratorCheckpoint {
    <#
    .SYNOPSIS
        Saves orchestrator session state as checkpoint.
    #>
    
    Write-Output "💾 Saving orchestrator checkpoint..."
    
    $checkpointPath = Join-Path $scriptPath "Recursive_Operations\orchestrator_checkpoint.json"
    
    $checkpoint = @{
        SessionID = $script:OrchestratorState.SessionID
        StartTime = $script:OrchestratorState.StartTime
        EndTime = Get-Date
        Mode = $script:OrchestratorState.Mode
        Category = $script:OrchestratorState.Category
        Progress = $script:OrchestratorState.Progress
        GeneratedComponents = $script:OrchestratorState.GeneratedComponents | Select-Object ID, Title, Category
        FailedComponents = $script:OrchestratorState.FailedComponents | Select-Object ID, Title, Category
    }
    
    try {
        $checkpoint | ConvertTo-Json -Depth 10 | Set-Content -Path $checkpointPath
        Write-Output "  ✅ Checkpoint saved: $checkpointPath"
    }
    catch {
        Write-Error "  ❌ Failed to save checkpoint: $_"
    }
    
    Write-Output ""
}

# === Main Orchestration Flow ===

Write-Output ""

# Initialize
$initSuccess = Initialize-Orchestrator
if (-not $initSuccess) {
    Write-Error "❌ Orchestrator initialization failed"
    exit 1
}

# Phase 1: Load Manifests
if ($Mode -in @("Full", "ManifestOnly")) {
    $manifestSuccess = Invoke-ManifestLoading
    if (-not $manifestSuccess -and $Mode -eq "ManifestOnly") {
        Write-Error "❌ Manifest loading failed"
        exit 1
    }
}

# Phase 2: Build Queue
if ($Mode -in @("Full", "GenerateOnly")) {
    if ($Mode -eq "Full" -or $script:OrchestratorState.Manifests) {
        $queueSuccess = Build-ExecutionQueue
        if (-not $queueSuccess) {
            Write-Error "❌ Execution queue building failed"
            exit 1
        }
    }
    else {
        Write-Error "❌ Cannot build queue - manifests not loaded"
        exit 1
    }
}

# Phase 3: Generate Components
if ($Mode -in @("Full", "GenerateOnly")) {
    Invoke-ComponentGeneration
}

# Phase 4: Validate Components
if ($Mode -in @("Full", "ValidateOnly")) {
    if ($script:OrchestratorState.ExecutionQueue.Count -gt 0) {
        Invoke-ComponentValidation
    }
    else {
        Write-Warning "⚠️ No execution queue available for validation"
    }
}

# Save Checkpoint
Save-OrchestratorCheckpoint

# Final Summary
Write-Output "═══════════════════════════════════════════════════════════════"
Write-Output "  Orchestrator Session Complete"
Write-Output "  Session ID: $($script:OrchestratorState.SessionID)"
Write-Output "  Duration: $((Get-Date) - $script:OrchestratorState.StartTime)"
Write-Output "═══════════════════════════════════════════════════════════════"
Write-Output ""
