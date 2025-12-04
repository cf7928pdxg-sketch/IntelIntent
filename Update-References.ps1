# Update References After Reorganization
# Author: GitHub Copilot
# Purpose: Update all script paths and imports after workspace reorganization

param(
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$rootPath = $PSScriptRoot

Write-Host '🔧 Updating Script References' -ForegroundColor Cyan
Write-Host '===============================' -ForegroundColor Cyan
Write-Host ''

if ($DryRun) {
    Write-Host '🔍 DRY RUN MODE - No changes will be made' -ForegroundColor Yellow
    Write-Host ''
}

# Function to update file content
function Update-FileContent {
    param(
        [string]$FilePath,
        [hashtable]$Replacements,
        [string]$Description
    )

    if (-not (Test-Path $FilePath)) {
        Write-Host "   ⚠️  File not found: $FilePath" -ForegroundColor DarkYellow
        return
    }

    $content = Get-Content -Path $FilePath -Raw
    $modified = $false

    foreach ($replacement in $Replacements.GetEnumerator()) {
        if ($content -match [regex]::Escape($replacement.Key)) {
            $content = $content -replace [regex]::Escape($replacement.Key), $replacement.Value
            $modified = $true
        }
    }

    if ($modified) {
        if ($DryRun) {
            Write-Host "   [DRY RUN] Would update: $Description" -ForegroundColor Yellow
        } else {
            Set-Content -Path $FilePath -Value $content -Force
            Write-Host "   ✅ Updated: $Description" -ForegroundColor Green
        }
    }
}

# ============================================
# STEP 1: Update .vscode/tasks.json
# ============================================
Write-Host '📝 Step 1: Updating VS Code tasks...' -ForegroundColor Cyan

$tasksPath = Join-Path $rootPath '.vscode\tasks.json'
$taskReplacements = @{
    '${workspaceFolder}/Week1_Automation.ps1'                     = '${workspaceFolder}/scripts/automation/Week1_Automation.ps1'
    '${workspaceFolder}/IntelIntent_Seeding/Orchestrator.ps1'     = '${workspaceFolder}/modules/IntelIntent_Seeding/Orchestrator.ps1'
    '${workspaceFolder}/.vscode/scripts/Check-MissingModules.ps1' = '${workspaceFolder}/.vscode/scripts/Check-MissingModules.ps1'
}

Update-FileContent -FilePath $tasksPath -Replacements $taskReplacements -Description '.vscode/tasks.json'

Write-Host ''

# ============================================
# STEP 2: Update IntelIntent_Launcher.ps1
# ============================================
Write-Host '🚀 Step 2: Updating launcher script...' -ForegroundColor Cyan

$launcherPath = Join-Path $rootPath 'scripts\automation\IntelIntent_Launcher.ps1'
$launcherReplacements = @{
    '.\Identity_Modules\'       = '..\modules\Identity_Modules\'
    '.\Environment_Setup\'      = '..\modules\Environment_Setup\'
    '.\Tooling\'                = '..\modules\Tooling\'
    '.\Services\'               = '..\modules\Services\'
    '.\Enhancements\'           = '..\modules\Enhancements\'
    '.\Security_Validation\'    = '..\modules\Security_Validation\'
    '.\Remote_Updates\'         = '..\modules\Remote_Updates\'
    '.\Autopilot_Provisioning\' = '..\modules\Autopilot_Provisioning\'
    '.\CI_CD_Workflows\'        = '..\modules\CI_CD_Workflows\'
}

Update-FileContent -FilePath $launcherPath -Replacements $launcherReplacements -Description 'IntelIntent_Launcher.ps1'

Write-Host ''

# ============================================
# STEP 3: Update Week1_Automation.ps1
# ============================================
Write-Host '⚙️ Step 3: Updating Week1 automation...' -ForegroundColor Cyan

$week1Path = Join-Path $rootPath 'scripts\automation\Week1_Automation.ps1'
$week1Replacements = @{
    '.\IntelIntent_Seeding\'   = '..\..\modules\IntelIntent_Seeding\'
    '.\Week1_Checkpoints.json' = '..\..\data\checkpoints\Week1_Checkpoints.json'
    '.\Sponsors\'              = '..\..\data\sponsors\'
}

Update-FileContent -FilePath $week1Path -Replacements $week1Replacements -Description 'Week1_Automation.ps1'

Write-Host ''

# ============================================
# STEP 4: Update Orchestrator.ps1
# ============================================
Write-Host '🎯 Step 4: Updating orchestrator...' -ForegroundColor Cyan

$orchestratorPath = Join-Path $rootPath 'modules\IntelIntent_Seeding\Orchestrator.ps1'
$orchestratorReplacements = @{
    '.\IntelIntent_Seeding\ManifestReader.ps1' = '.\ManifestReader.ps1'
    '.\IntelIntent_Seeding\AgentBridge.psm1'   = '.\AgentBridge.psm1'
    '..\IntelIntent-Seed\'                     = '..\..\config\manifests\'
}

Update-FileContent -FilePath $orchestratorPath -Replacements $orchestratorReplacements -Description 'Orchestrator.ps1'

Write-Host ''

# ============================================
# STEP 5: Update ManifestReader.ps1
# ============================================
Write-Host '📋 Step 5: Updating manifest reader...' -ForegroundColor Cyan

$manifestReaderPath = Join-Path $rootPath 'modules\IntelIntent_Seeding\ManifestReader.ps1'
$manifestReplacements = @{
    'IntelIntent-Seed'    = '..\..\..\config\manifests'
    '.\IntelIntent-Seed\' = '..\..\config\manifests\'
}

Update-FileContent -FilePath $manifestReaderPath -Replacements $manifestReplacements -Description 'ManifestReader.ps1'

Write-Host ''

# ============================================
# STEP 6: Update Test Files
# ============================================
Write-Host '🧪 Step 6: Updating test files...' -ForegroundColor Cyan

$testFiles = Get-ChildItem "$rootPath\tests" -Filter 'Test-*.ps1' -File
foreach ($testFile in $testFiles) {
    $testReplacements = @{
        '.\IntelIntent_Seeding\'  = '..\modules\IntelIntent_Seeding\'
        '..\IntelIntent_Seeding\' = '..\modules\IntelIntent_Seeding\'
    }
    Update-FileContent -FilePath $testFile.FullName -Replacements $testReplacements -Description $testFile.Name
}

Write-Host ''

# ============================================
# STEP 7: Update GitHub Copilot Instructions
# ============================================
Write-Host '📝 Step 7: Updating copilot instructions...' -ForegroundColor Cyan

$copilotInstructionsPath = Join-Path $rootPath '.github\copilot-instructions.md'
$copilotReplacements = @{
    '`.\Week1_Automation.ps1`'                 = '`.\scripts\automation\Week1_Automation.ps1`'
    '`.\IntelIntent_Launcher.ps1`'             = '`.\scripts\automation\IntelIntent_Launcher.ps1`'
    '`.\IntelIntent_Seeding\Orchestrator.ps1`' = '`.\modules\IntelIntent_Seeding\Orchestrator.ps1`'
    'IntelIntent-Seed/*.json'                  = 'config/manifests/*.json'
    'IntelIntent_Seeding/*.psm1'               = 'modules/IntelIntent_Seeding/*.psm1'
    'Sponsors/Week1_Codex_Scroll'              = 'data/sponsors/Week1_Codex_Scroll'
    'Week1_Checkpoints.json'                   = 'data/checkpoints/Week1_Checkpoints.json'
}

Update-FileContent -FilePath $copilotInstructionsPath -Replacements $copilotReplacements -Description '.github/copilot-instructions.md'

Write-Host ''

# ============================================
# STEP 8: Update azure-pipelines.yml
# ============================================
Write-Host '🔄 Step 8: Updating Azure pipelines...' -ForegroundColor Cyan

$pipelinePath = Join-Path $rootPath 'config\pipelines\azure-pipelines.yml'
$pipelineReplacements = @{
    'Week1_Automation.ps1'        = '$(Build.SourcesDirectory)/scripts/automation/Week1_Automation.ps1'
    'Week1_Checkpoints.json'      = '$(Build.SourcesDirectory)/data/checkpoints/Week1_Checkpoints.json'
    'Sponsors/Week1_Codex_Scroll' = '$(Build.SourcesDirectory)/data/sponsors/Week1_Codex_Scroll'
}

Update-FileContent -FilePath $pipelinePath -Replacements $pipelineReplacements -Description 'azure-pipelines.yml'

Write-Host ''

# ============================================
# STEP 9: Update Module Imports in Components
# ============================================
Write-Host '🧩 Step 9: Updating module component imports...' -ForegroundColor Cyan

$componentDirs = @(
    'modules\Identity_Modules',
    'modules\Environment_Setup',
    'modules\Tooling',
    'modules\Services',
    'modules\Enhancements',
    'modules\Security_Validation',
    'modules\Remote_Updates',
    'modules\Autopilot_Provisioning',
    'modules\CI_CD_Workflows'
)

foreach ($componentDir in $componentDirs) {
    $componentPath = Join-Path $rootPath "$componentDir"
    if (Test-Path $componentPath) {
        $componentFiles = Get-ChildItem $componentPath -Filter '*_component.ps1' -File
        foreach ($file in $componentFiles) {
            $componentReplacements = @{
                '..\IntelIntent_Seeding\' = '..\IntelIntent_Seeding\'
            }
            Update-FileContent -FilePath $file.FullName -Replacements $componentReplacements -Description $file.Name
        }
    }
}

Write-Host ''

# ============================================
# STEP 10: Create Path Helper Module
# ============================================
Write-Host '🔧 Step 10: Creating path helper module...' -ForegroundColor Cyan

$pathHelperContent = @'
# IntelIntent Path Helper Module
# Provides standardized path resolution after reorganization

<#
.SYNOPSIS
    Get standardized paths for IntelIntent workspace.

.DESCRIPTION
    Provides central path resolution for all IntelIntent components
    after workspace reorganization.
#>

$script:RootPath = Split-Path -Parent $PSScriptRoot

function Get-IntelIntentPath {
    <#
    .SYNOPSIS
        Get path to IntelIntent component.

    .PARAMETER Type
        Type of path: Docs, Scripts, Modules, Config, Tests, Data, Legacy

    .PARAMETER Subpath
        Optional subpath within category.

    .EXAMPLE
        Get-IntelIntentPath -Type Scripts -Subpath "automation\Week1_Automation.ps1"
    #>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("Docs", "Scripts", "Modules", "Config", "Tests", "Data", "Governance", "Tools", "Legacy", "Sandbox", "Root")]
        [string]$Type,

        [string]$Subpath
    )

    $basePaths = @{
        Root = $script:RootPath
        Docs = Join-Path $script:RootPath "docs"
        Scripts = Join-Path $script:RootPath "scripts"
        Modules = Join-Path $script:RootPath "modules"
        Config = Join-Path $script:RootPath "config"
        Tests = Join-Path $script:RootPath "tests"
        Data = Join-Path $script:RootPath "data"
        Governance = Join-Path $script:RootPath "governance"
        Tools = Join-Path $script:RootPath "tools"
        Legacy = Join-Path $script:RootPath "legacy"
        Sandbox = Join-Path $script:RootPath "sandbox"
    }

    $basePath = $basePaths[$Type]

    if ($Subpath) {
        return Join-Path $basePath $Subpath
    }

    return $basePath
}

function Get-Week1AutomationPath {
    <#
    .SYNOPSIS
        Get path to Week1_Automation.ps1
    #>
    return Get-IntelIntentPath -Type Scripts -Subpath "automation\Week1_Automation.ps1"
}

function Get-OrchestratorPath {
    <#
    .SYNOPSIS
        Get path to Orchestrator.ps1
    #>
    return Get-IntelIntentPath -Type Modules -Subpath "IntelIntent_Seeding\Orchestrator.ps1"
}

function Get-ManifestPath {
    <#
    .SYNOPSIS
        Get path to manifests directory
    #>
    return Get-IntelIntentPath -Type Config -Subpath "manifests"
}

function Get-CheckpointPath {
    <#
    .SYNOPSIS
        Get path to checkpoints directory
    #>
    return Get-IntelIntentPath -Type Data -Subpath "checkpoints"
}

Export-ModuleMember -Function @(
    'Get-IntelIntentPath',
    'Get-Week1AutomationPath',
    'Get-OrchestratorPath',
    'Get-ManifestPath',
    'Get-CheckpointPath'
)
'@

$pathHelperPath = Join-Path $rootPath 'modules\IntelIntent_Seeding\PathHelper.psm1'
if ($DryRun) {
    Write-Host '   [DRY RUN] Would create: PathHelper.psm1' -ForegroundColor Yellow
} else {
    Set-Content -Path $pathHelperPath -Value $pathHelperContent -Force
    Write-Host '   ✅ Created: PathHelper.psm1' -ForegroundColor Green
}

Write-Host ''

# ============================================
# COMPLETION SUMMARY
# ============================================
Write-Host '🎉 Reference Updates Complete!' -ForegroundColor Green
Write-Host '================================' -ForegroundColor Green
Write-Host ''

if ($DryRun) {
    Write-Host 'This was a DRY RUN. No changes were made.' -ForegroundColor Yellow
    Write-Host 'To execute updates, run without -DryRun flag:' -ForegroundColor Yellow
    Write-Host '   .\Update-References.ps1' -ForegroundColor Cyan
} else {
    Write-Host '✅ VS Code tasks updated' -ForegroundColor Green
    Write-Host '✅ Script paths updated' -ForegroundColor Green
    Write-Host '✅ Module imports updated' -ForegroundColor Green
    Write-Host '✅ Pipeline configuration updated' -ForegroundColor Green
    Write-Host '✅ Path helper module created' -ForegroundColor Green
    Write-Host ''
    Write-Host '⚠️ IMPORTANT NEXT STEPS:' -ForegroundColor Yellow
    Write-Host '1. Test all scripts with -DryRun flag' -ForegroundColor Yellow
    Write-Host '2. Run: .\scripts\automation\Week1_Automation.ps1 -DryRun -SkipEmail' -ForegroundColor Yellow
    Write-Host '3. Run: .\modules\IntelIntent_Seeding\Orchestrator.ps1 -Mode ValidateOnly' -ForegroundColor Yellow
    Write-Host '4. Run: Invoke-Pester (test all tests)' -ForegroundColor Yellow
    Write-Host '5. Review and commit all changes' -ForegroundColor Yellow
}

Write-Host ''
