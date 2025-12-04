# ManifestReader.ps1
# Phase 2.1: Manifest Reading and Parsing Engine
# Purpose: Load and parse semantic manifests from IntelIntent-Seed directory

<#
.SYNOPSIS
    Reads and parses manifest files from IntelIntent-Seed directory.

.DESCRIPTION
    This module provides functions to load JSON and YAML manifest files that define
    the recursive component generation pipeline. Manifests include:
    - creator_of_creators_checklist.json (project plan)
    - intelintent_precursive_table.txt (precursive modules -000.x)
    - intelintent_recursive_table.txt (recursive CoE components 001-599)
    - Fluent2_Interface_Deployment_Checklist.json (UI components)

.NOTES
    Author: IntelIntent Orchestration System
    Date: 2025-11-26
    Version: 2.1.0
#>

# === Configuration ===
$script:ManifestBasePath = ".\IntelIntent-Seed"
$script:ManifestCache = @{}

# === Core Functions ===

function Get-ManifestPath {
    <#
    .SYNOPSIS
        Returns the absolute path to the IntelIntent-Seed directory.
    #>
    param(
        [string]$RelativePath = ""
    )
    
    $basePath = Join-Path $PSScriptRoot "..\IntelIntent-Seed"
    if ($RelativePath) {
        return Join-Path $basePath $RelativePath
    }
    return $basePath
}

function Read-JsonManifest {
    <#
    .SYNOPSIS
        Reads and parses a JSON manifest file.
    
    .PARAMETER FilePath
        Path to the JSON manifest file.
    
    .EXAMPLE
        $checklist = Read-JsonManifest -FilePath "creator_of_creators_checklist.json"
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )
    
    $fullPath = Get-ManifestPath -RelativePath $FilePath
    
    if (-not (Test-Path $fullPath)) {
        Write-Warning "⚠️ Manifest not found: $fullPath"
        return $null
    }
    
    try {
        $content = Get-Content $fullPath -Raw -ErrorAction Stop
        $manifest = $content | ConvertFrom-Json -ErrorAction Stop
        Write-Verbose "✅ Loaded JSON manifest: $FilePath"
        return $manifest
    }
    catch {
        Write-Error "❌ Failed to parse JSON manifest: $FilePath - $_"
        return $null
    }
}

function Read-TextManifest {
    <#
    .SYNOPSIS
        Reads a text-based manifest file (tables, lists).
    
    .PARAMETER FilePath
        Path to the text manifest file.
    
    .PARAMETER ParseMode
        Parsing mode: 'Lines', 'Table', 'Raw'
    
    .EXAMPLE
        $precursive = Read-TextManifest -FilePath "intelintent_precursive_table.txt" -ParseMode "Table"
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$FilePath,
        
        [ValidateSet('Lines', 'Table', 'Raw')]
        [string]$ParseMode = 'Lines'
    )
    
    $fullPath = Get-ManifestPath -RelativePath $FilePath
    
    if (-not (Test-Path $fullPath)) {
        Write-Warning "⚠️ Manifest not found: $fullPath"
        return $null
    }
    
    try {
        $content = Get-Content $fullPath -ErrorAction Stop
        
        switch ($ParseMode) {
            'Raw' {
                return $content -join "`n"
            }
            'Lines' {
                return $content | Where-Object { $_ -and $_.Trim() -ne '' }
            }
            'Table' {
                # Parse table format: ID | Title | Description
                $parsed = @()
                foreach ($line in $content) {
                    if ($line -match '^\s*(\S+)\s*\|\s*(.+?)\s*\|\s*(.+?)\s*$') {
                        $parsed += @{
                            ID = $Matches[1]
                            Title = $Matches[2]
                            Description = $Matches[3]
                        }
                    }
                }
                return $parsed
            }
        }
    }
    catch {
        Write-Error "❌ Failed to read text manifest: $FilePath - $_"
        return $null
    }
}

function Get-AllManifests {
    <#
    .SYNOPSIS
        Loads all critical manifests into a structured object.
    
    .DESCRIPTION
        Returns a hashtable containing all parsed manifests:
        - CreatorChecklist: Main project plan
        - PrecursiveTable: Precursive modules (-000.x)
        - RecursiveTable: Recursive CoE components (001-599)
        - FluentDeployment: UI component checklist
    
    .EXAMPLE
        $manifests = Get-AllManifests
        $manifests.CreatorChecklist.checklist
    #>
    
    Write-Output "📖 Loading IntelIntent manifests..."
    
    $manifests = @{
        CreatorChecklist = $null
        PrecursiveTable = $null
        RecursiveTable = $null
        FluentDeployment = $null
        GapAnalysis = $null
        RecursivePlan = $null
    }
    
    # Load JSON manifests
    $manifests.CreatorChecklist = Read-JsonManifest -FilePath "creator_of_creators_checklist.json"
    $manifests.FluentDeployment = Read-JsonManifest -FilePath "Fluent2_Interface_Deployment_Checklist.json"
    $manifests.GapAnalysis = Read-JsonManifest -FilePath "creator_of_creators_gap_analysis.json"
    $manifests.RecursivePlan = Read-JsonManifest -FilePath "creator_of_creators_recursive_plan.json"
    
    # Load text-based tables
    $manifests.PrecursiveTable = Read-TextManifest -FilePath "intelintent_precursive_table.txt" -ParseMode "Table"
    $manifests.RecursiveTable = Read-TextManifest -FilePath "intelintent_recursive_table.txt" -ParseMode "Table"
    
    # Report status
    $loadedCount = ($manifests.Values | Where-Object { $_ -ne $null }).Count
    Write-Output "  ✅ Loaded $loadedCount of 6 manifests"
    
    # Cache results
    $script:ManifestCache = $manifests
    
    return $manifests
}

function Get-ComponentQueue {
    <#
    .SYNOPSIS
        Builds an execution queue from manifest data with priority ordering.
    
    .PARAMETER Manifests
        Manifest data from Get-AllManifests.
    
    .PARAMETER FilterCategory
        Optional category filter (e.g., "Environment_Setup", "Identity_Modules").
    
    .EXAMPLE
        $queue = Get-ComponentQueue -Manifests $manifests
        $queue | Format-Table ID, Title, Priority, Category
    #>
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$Manifests,
        
        [string]$FilterCategory = ""
    )
    
    Write-Output "🎯 Building component execution queue..."
    
    $queue = @()
    
    # Parse creator checklist if available
    if ($Manifests.CreatorChecklist -and $Manifests.CreatorChecklist.checklist) {
        foreach ($item in $Manifests.CreatorChecklist.checklist) {
            # Skip if category filter specified and doesn't match
            if ($FilterCategory -and $item.category -ne $FilterCategory) {
                continue
            }
            
            $component = @{
                ID = $item.id
                Title = $item.title
                Category = $item.category
                Priority = if ($item.priority) { $item.priority } else { 99 }
                Status = $item.status
                Dependencies = if ($item.dependencies) { $item.dependencies } else { @() }
                ComponentPath = ".\$($item.category)\$($item.id)_component.ps1"
                CheckpointPath = ".\$($item.category)\Recursive_Operations\$($item.id)_checkpoint.txt"
            }
            
            $queue += $component
        }
    }
    
    # Sort by priority (lower number = higher priority)
    $queue = $queue | Sort-Object Priority
    
    Write-Output "  ✅ Queue built: $($queue.Count) components"
    
    return $queue
}

function Test-ManifestIntegrity {
    <#
    .SYNOPSIS
        Validates manifest files for structural integrity and required fields.
    
    .EXAMPLE
        Test-ManifestIntegrity -Manifests $manifests
    #>
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$Manifests
    )
    
    Write-Output "🔍 Validating manifest integrity..."
    
    $issues = @()
    
    # Check creator checklist structure
    if ($Manifests.CreatorChecklist) {
        if (-not $Manifests.CreatorChecklist.checklist) {
            $issues += "CreatorChecklist missing 'checklist' array"
        }
        else {
            foreach ($item in $Manifests.CreatorChecklist.checklist) {
                if (-not $item.id) { $issues += "Checklist item missing 'id' field" }
                if (-not $item.title) { $issues += "Checklist item missing 'title' field" }
                if (-not $item.category) { $issues += "Checklist item missing 'category' field" }
            }
        }
    }
    else {
        $issues += "CreatorChecklist not loaded"
    }
    
    # Report results
    if ($issues.Count -eq 0) {
        Write-Output "  ✅ All manifests valid"
        return $true
    }
    else {
        Write-Warning "  ⚠️ Found $($issues.Count) integrity issues:"
        foreach ($issue in $issues) {
            Write-Warning "    - $issue"
        }
        return $false
    }
}

# === Export Functions ===
Export-ModuleMember -Function @(
    'Get-ManifestPath',
    'Read-JsonManifest',
    'Read-TextManifest',
    'Get-AllManifests',
    'Get-ComponentQueue',
    'Test-ManifestIntegrity'
)

# === Module Initialization ===
Write-Verbose "ManifestReader.ps1 loaded - Phase 2.1 active"
