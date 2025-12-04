# IntelIntent Workspace Reorganization Script
# Author: GitHub Copilot
# Purpose: Transform workspace into model of excellence
# WARNING: Review changes before executing!

param(
    [switch]$DryRun,
    [switch]$CreateBackup
)

$ErrorActionPreference = 'Stop'
$rootPath = $PSScriptRoot

Write-Host '🎯 IntelIntent Workspace Reorganization' -ForegroundColor Cyan
Write-Host '=========================================' -ForegroundColor Cyan
Write-Host ''

if ($DryRun) {
    Write-Host '🔍 DRY RUN MODE - No changes will be made' -ForegroundColor Yellow
    Write-Host ''
}

# Create backup if requested
if ($CreateBackup -and -not $DryRun) {
    Write-Host '📦 Creating backup...' -ForegroundColor Green
    $backupPath = "$rootPath\..\IntelIntent-Backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Copy-Item -Path $rootPath -Destination $backupPath -Recurse -Force
    Write-Host "   ✅ Backup created at: $backupPath" -ForegroundColor Green
    Write-Host ''
}

# Function to safely create directory
function New-SafeDirectory {
    param([string]$Path)
    if ($DryRun) {
        Write-Host "   [DRY RUN] Would create: $Path" -ForegroundColor Yellow
    } else {
        if (-not (Test-Path $Path)) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
            Write-Host "   ✅ Created: $Path" -ForegroundColor Green
        }
    }
}

# Function to safely move item
function Move-SafeItem {
    param(
        [string]$Source,
        [string]$Destination,
        [switch]$Force
    )
    if ($DryRun) {
        Write-Host "   [DRY RUN] Would move: $Source → $Destination" -ForegroundColor Yellow
    } else {
        if (Test-Path $Source) {
            $destDir = Split-Path -Parent $Destination
            if (-not (Test-Path $destDir)) {
                New-Item -ItemType Directory -Path $destDir -Force | Out-Null
            }
            Move-Item -Path $Source -Destination $Destination -Force:$Force
            Write-Host "   ✅ Moved: $(Split-Path -Leaf $Source) → $Destination" -ForegroundColor Green
        } else {
            Write-Host "   ⚠️  Source not found: $Source" -ForegroundColor DarkYellow
        }
    }
}

# ============================================
# STEP 1: Create New Directory Structure
# ============================================
Write-Host '📁 Step 1: Creating new directory structure...' -ForegroundColor Cyan

$newDirs = @(
    # Documentation
    'docs\architecture',
    'docs\deployment',
    'docs\phase5',
    'docs\phase6',
    'docs\agents',
    'docs\compliance',
    'docs\powerbi',
    'docs\quickstart',
    'docs\week1',
    'docs\analysis',
    'docs\integration',
    'docs\summary',
    'docs\legacy',

    # Scripts
    'scripts\automation',
    'scripts\phase5',
    'scripts\verification',
    'scripts\legacy',

    # Modules (existing will be preserved)
    'modules\IntelIntent_Seeding\Tests',

    # Configuration
    'config\manifests',
    'config\integration',
    'config\pipelines',
    'config\prompts',

    # Tests
    'tests\checkpoints',
    'tests\fixtures',

    # Data
    'data\checkpoints',
    'data\logs',
    'data\sponsors',
    'data\codex',

    # Legacy
    'legacy\boot-system',
    'legacy\post-install',
    'legacy\java-artifacts',

    # Tools & Governance remain as-is

    # Sandbox
    'sandbox'
)

foreach ($dir in $newDirs) {
    New-SafeDirectory -Path (Join-Path $rootPath $dir)
}

Write-Host ''

# ============================================
# STEP 2: Reorganize Documentation
# ============================================
Write-Host '📚 Step 2: Reorganizing documentation...' -ForegroundColor Cyan

$docMoves = @{
    # Architecture
    'PHASE3_IMPLEMENTATION_PLAN.md'                 = 'docs\architecture\PHASE3_IMPLEMENTATION_PLAN.md'
    'PHASE4_ARCHITECTURE_DIAGRAM.md'                = 'docs\architecture\PHASE4_ARCHITECTURE_DIAGRAM.md'
    'PHASE4_PREVIEW.md'                             = 'docs\architecture\PHASE4_PREVIEW.md'
    'UNIVERSAL_HYBRID_EXECUTION_FRAMEWORK.md'       = 'docs\architecture\UNIVERSAL_HYBRID_EXECUTION_FRAMEWORK.md'
    'WORKFLOW_MAP.md'                               = 'docs\architecture\WORKFLOW_MAP.md'

    # Deployment
    'PHASE4_DEPLOYMENT_COMPLETE.md'                 = 'docs\deployment\PHASE4_DEPLOYMENT_COMPLETE.md'
    'PHASE4_DEPLOYMENT_ROADMAP.md'                  = 'docs\deployment\PHASE4_DEPLOYMENT_ROADMAP.md'
    'CI_CD_SETUP_GUIDE.md'                          = 'docs\deployment\CI_CD_SETUP_GUIDE.md'
    'CHOCOLATEY_QUICKSTART.md'                      = 'docs\deployment\CHOCOLATEY_QUICKSTART.md'

    # Phase 5
    'Phase5_Ceremonial_Presentation_Deck.md'        = 'docs\phase5\Phase5_Ceremonial_Presentation_Deck.md'
    'Phase5_Completion_Scroll.md'                   = 'docs\phase5\Phase5_Completion_Scroll.md'
    'PHASE5_MODALITY_AGENT_ACTIVATION_SCROLL.md'    = 'docs\phase5\PHASE5_MODALITY_AGENT_ACTIVATION_SCROLL.md'
    'PHASE5_MODALITY_SPRINT_TRACKER.md'             = 'docs\phase5\PHASE5_MODALITY_SPRINT_TRACKER.md'

    # Phase 6
    'Phase6_Expansion_Blueprint.md'                 = 'docs\phase6\Phase6_Expansion_Blueprint.md'

    # Agents
    'Boopas_Agent_Guide.md'                         = 'docs\agents\Boopas_Agent_Guide.md'
    'Boopas_Agent_Implementation_Summary.md'        = 'docs\agents\Boopas_Agent_Implementation_Summary.md'
    'Finance_Agent_Guide.md'                        = 'docs\agents\Finance_Agent_Guide.md'
    'Modality_Agent_Guide.md'                       = 'docs\agents\Modality_Agent_Guide.md'
    'Modality_Agent_Implementation_Summary.md'      = 'docs\agents\Modality_Agent_Implementation_Summary.md'

    # Compliance
    'COMPLIANCE_AND_AUTHENTICATION_ARCHITECTURE.md' = 'docs\compliance\COMPLIANCE_AND_AUTHENTICATION_ARCHITECTURE.md'

    # Power BI
    'POWERBI_DASHBOARD_SCHEMA.md'                   = 'docs\powerbi\POWERBI_DASHBOARD_SCHEMA.md'
    'POWERBI_PHASE4_SCHEMA.md'                      = 'docs\powerbi\POWERBI_PHASE4_SCHEMA.md'

    # Quickstart
    'QUICK_REFERENCE.md'                            = 'docs\quickstart\QUICK_REFERENCE.md'
    'PRODUCTION_MODULES_QUICKSTART.md'              = 'docs\quickstart\PRODUCTION_MODULES_QUICKSTART.md'
    'CORE_MVP_VERIFICATION.md'                      = 'docs\quickstart\CORE_MVP_VERIFICATION.md'
    'Keybindings.md'                                = 'docs\quickstart\Keybindings.md'

    # Week 1
    'WEEK1_IMPLEMENTATION_CHECKLIST.md'             = 'docs\week1\WEEK1_IMPLEMENTATION_CHECKLIST.md'
    'WEEK1_CODEX_SCROLLS.md'                        = 'docs\week1\WEEK1_CODEX_SCROLLS.md'

    # Analysis
    'INTELINTENT_GAP_ANALYSIS.md'                   = 'docs\analysis\INTELINTENT_GAP_ANALYSIS.md'
    'REMAINING_MODULES_ROADMAP.md'                  = 'docs\analysis\REMAINING_MODULES_ROADMAP.md'
    'SERVICE_PATHWAYS.md'                           = 'docs\analysis\SERVICE_PATHWAYS.md'

    # Integration
    'POWERSHELL_INTEGRATION.md'                     = 'docs\integration\POWERSHELL_INTEGRATION.md'
    'README_PHASE2.md'                              = 'docs\integration\README_PHASE2.md'

    # Summary
    'EXECUTIVE_SUMMARY.md'                          = 'docs\summary\EXECUTIVE_SUMMARY.md'
    'UNIVERSAL_SYSTEM_COMPLETE.md'                  = 'docs\summary\UNIVERSAL_SYSTEM_COMPLETE.md'

    # Legacy
    'README.txt'                                    = 'docs\legacy\README.txt'
}

foreach ($move in $docMoves.GetEnumerator()) {
    Move-SafeItem -Source (Join-Path $rootPath $move.Key) -Destination (Join-Path $rootPath $move.Value)
}

Write-Host ''

# ============================================
# STEP 3: Reorganize Scripts
# ============================================
Write-Host '🚀 Step 3: Reorganizing scripts...' -ForegroundColor Cyan

$scriptMoves = @{
    # Automation
    'Week1_Automation.ps1'              = 'scripts\automation\Week1_Automation.ps1'
    'IntelIntent_Launcher.ps1'          = 'scripts\automation\IntelIntent_Launcher.ps1'
    'Deploy-Phase4-Complete.ps1'        = 'scripts\automation\Deploy-Phase4-Complete.ps1'
    'Install-MaximumCapabilities.ps1'   = 'scripts\automation\Install-MaximumCapabilities.ps1'
    'Install-MVP.ps1'                   = 'scripts\automation\Install-MVP.ps1'

    # Phase 5
    'Phase5_Demo_Environment_Setup.ps1' = 'scripts\phase5\Phase5_Demo_Environment_Setup.ps1'
    'Phase5_Live_Metrics_Dashboard.ps1' = 'scripts\phase5\Phase5_Live_Metrics_Dashboard.ps1'

    # Verification
    'Verify-DevelopmentEnvironment.ps1' = 'scripts\verification\Verify-DevelopmentEnvironment.ps1'
    'Verify-WindowsSetup.ps1'           = 'scripts\verification\Verify-WindowsSetup.ps1'
}

foreach ($move in $scriptMoves.GetEnumerator()) {
    Move-SafeItem -Source (Join-Path $rootPath $move.Key) -Destination (Join-Path $rootPath $move.Value)
}

Write-Host ''

# ============================================
# STEP 4: Reorganize Modules
# ============================================
Write-Host '🧩 Step 4: Reorganizing modules...' -ForegroundColor Cyan

# Move IntelIntent_Seeding to modules directory
if (Test-Path "$rootPath\IntelIntent_Seeding") {
    if ($DryRun) {
        Write-Host '   [DRY RUN] Would move: IntelIntent_Seeding → modules\IntelIntent_Seeding' -ForegroundColor Yellow
    } else {
        if (-not (Test-Path "$rootPath\modules")) {
            New-Item -ItemType Directory -Path "$rootPath\modules" -Force | Out-Null
        }
        if (-not (Test-Path "$rootPath\modules\IntelIntent_Seeding")) {
            Move-Item -Path "$rootPath\IntelIntent_Seeding" -Destination "$rootPath\modules\IntelIntent_Seeding" -Force
            Write-Host '   ✅ Moved: IntelIntent_Seeding → modules\IntelIntent_Seeding' -ForegroundColor Green
        }
    }
}

# Move component modules to modules directory
$componentModules = @(
    'Identity_Modules',
    'Environment_Setup',
    'Environment_Configuration',
    'Tooling',
    'Services',
    'Enhancements',
    'Security_Validation',
    'Remote_Updates',
    'Autopilot_Provisioning',
    'CI_CD_Workflows'
)

foreach ($module in $componentModules) {
    if (Test-Path "$rootPath\$module") {
        if ($DryRun) {
            Write-Host "   [DRY RUN] Would move: $module → modules\$module" -ForegroundColor Yellow
        } else {
            if (-not (Test-Path "$rootPath\modules\$module")) {
                Move-Item -Path "$rootPath\$module" -Destination "$rootPath\modules\$module" -Force
                Write-Host "   ✅ Moved: $module → modules\$module" -ForegroundColor Green
            }
        }
    }
}

Write-Host ''

# ============================================
# STEP 5: Reorganize Configuration
# ============================================
Write-Host '⚙️ Step 5: Reorganizing configuration...' -ForegroundColor Cyan

# Move azure-pipelines.yml
Move-SafeItem -Source "$rootPath\azure-pipelines.yml" -Destination "$rootPath\config\pipelines\azure-pipelines.yml"

# Move manifests from IntelIntent-Seed
if (Test-Path "$rootPath\IntelIntent-Seed") {
    $manifestFiles = Get-ChildItem "$rootPath\IntelIntent-Seed" -Filter '*.json' -File
    foreach ($file in $manifestFiles) {
        Move-SafeItem -Source $file.FullName -Destination (Join-Path "$rootPath\config\manifests" $file.Name)
    }

    # Move prompts
    $promptFiles = Get-ChildItem "$rootPath\IntelIntent-Seed" -Filter '*prompt*.txt' -File
    foreach ($file in $promptFiles) {
        Move-SafeItem -Source $file.FullName -Destination (Join-Path "$rootPath\config\prompts" $file.Name)
    }
}

Write-Host ''

# ============================================
# STEP 6: Reorganize Tests
# ============================================
Write-Host '🧪 Step 6: Reorganizing tests...' -ForegroundColor Cyan

$testMoves = @{
    'Test-BoopasAgent.ps1'             = 'tests\Test-BoopasAgent.ps1'
    'Test-CopilotAuth.ps1'             = 'tests\Test-CopilotAuth.ps1'
    'Test-CopilotLifecycleTracker.ps1' = 'tests\Test-CopilotLifecycleTracker.ps1'
    'Test-FinanceAgent.ps1'            = 'tests\Test-FinanceAgent.ps1'
    'Test-PostInstall.ps1'             = 'tests\Test-PostInstall.ps1'
    'Test-ProductionModules.ps1'       = 'tests\Test-ProductionModules.ps1'
    'Test-Failures-Detailed.json'      = 'tests\checkpoints\Test-Failures-Detailed.json'
    'Test-Results-Summary.json'        = 'tests\checkpoints\Test-Results-Summary.json'
    'TestCheckpoints.json'             = 'tests\checkpoints\TestCheckpoints.json'
    'Test_Checkpoints.json'            = 'tests\checkpoints\Test_Checkpoints.json'
}

foreach ($move in $testMoves.GetEnumerator()) {
    Move-SafeItem -Source (Join-Path $rootPath $move.Key) -Destination (Join-Path $rootPath $move.Value)
}

# Move Tests directory if exists
if (Test-Path "$rootPath\Tests") {
    if ($DryRun) {
        Write-Host '   [DRY RUN] Would merge: Tests → tests' -ForegroundColor Yellow
    } else {
        Get-ChildItem "$rootPath\Tests" -Recurse | ForEach-Object {
            $dest = $_.FullName.Replace("$rootPath\Tests", "$rootPath\tests")
            $destDir = Split-Path -Parent $dest
            if (-not (Test-Path $destDir)) {
                New-Item -ItemType Directory -Path $destDir -Force | Out-Null
            }
            Move-Item -Path $_.FullName -Destination $dest -Force
        }
        Remove-Item "$rootPath\Tests" -Recurse -Force
        Write-Host '   ✅ Merged: Tests → tests' -ForegroundColor Green
    }
}

Write-Host ''

# ============================================
# STEP 7: Reorganize Data
# ============================================
Write-Host '💾 Step 7: Reorganizing data...' -ForegroundColor Cyan

$dataMoves = @{
    'Week1_Checkpoints.json'           = 'data\checkpoints\Week1_Checkpoints.json'
    'Phase5_Modality_Checkpoints.json' = 'data\checkpoints\Phase5_Modality_Checkpoints.json'
}

foreach ($move in $dataMoves.GetEnumerator()) {
    Move-SafeItem -Source (Join-Path $rootPath $move.Key) -Destination (Join-Path $rootPath $move.Value)
}

# Move directories
if (Test-Path "$rootPath\Recovery_Logs") {
    Move-SafeItem -Source "$rootPath\Recovery_Logs" -Destination "$rootPath\data\logs\Recovery_Logs"
}
if (Test-Path "$rootPath\Sponsors") {
    Move-SafeItem -Source "$rootPath\Sponsors" -Destination "$rootPath\data\sponsors"
}
if (Test-Path "$rootPath\codex") {
    Move-SafeItem -Source "$rootPath\codex" -Destination "$rootPath\data\codex"
}
if (Test-Path "$rootPath\Data") {
    if ($DryRun) {
        Write-Host '   [DRY RUN] Would merge: Data → data' -ForegroundColor Yellow
    } else {
        Get-ChildItem "$rootPath\Data" -Recurse | ForEach-Object {
            $dest = $_.FullName.Replace("$rootPath\Data", "$rootPath\data")
            $destDir = Split-Path -Parent $dest
            if (-not (Test-Path $destDir)) {
                New-Item -ItemType Directory -Path $destDir -Force | Out-Null
            }
            Move-Item -Path $_.FullName -Destination $dest -Force
        }
        Remove-Item "$rootPath\Data" -Recurse -Force
        Write-Host '   ✅ Merged: Data → data' -ForegroundColor Green
    }
}

Write-Host ''

# ============================================
# STEP 8: Move Governance
# ============================================
Write-Host '📋 Step 8: Organizing governance...' -ForegroundColor Cyan

if (Test-Path "$rootPath\Governance") {
    if ($DryRun) {
        Write-Host '   [DRY RUN] Would move: Governance → governance' -ForegroundColor Yellow
    } else {
        Move-Item -Path "$rootPath\Governance" -Destination "$rootPath\governance" -Force
        Write-Host '   ✅ Moved: Governance → governance' -ForegroundColor Green
    }
}

Write-Host ''

# ============================================
# STEP 9: Move Tools
# ============================================
Write-Host '🔧 Step 9: Organizing tools...' -ForegroundColor Cyan

if (Test-Path "$rootPath\Visual_Dashboard_Setup") {
    Move-SafeItem -Source "$rootPath\Visual_Dashboard_Setup" -Destination "$rootPath\tools\Visual_Dashboard_Setup"
}
if (Test-Path "$rootPath\IntelIntent_Mutation_Launchpad") {
    Move-SafeItem -Source "$rootPath\IntelIntent_Mutation_Launchpad" -Destination "$rootPath\tools\IntelIntent_Mutation_Launchpad"
}

Write-Host ''

# ============================================
# STEP 10: Archive Legacy Files
# ============================================
Write-Host '🗄️ Step 10: Archiving legacy files...' -ForegroundColor Cyan

$legacyMoves = @{
    # Boot system files
    'boot'                  = 'legacy\boot-system\boot'
    'efi'                   = 'legacy\boot-system\efi'
    'sources'               = 'legacy\boot-system\sources'
    'support'               = 'legacy\boot-system\support'
    'bootmgr'               = 'legacy\boot-system\bootmgr'
    'bootmgr.efi'           = 'legacy\boot-system\bootmgr.efi'
    'autorun.inf'           = 'legacy\boot-system\autorun.inf'
    'setup.exe'             = 'legacy\boot-system\setup.exe'

    # Post-install
    'post-install'          = 'legacy\post-install'
    'Backup'                = 'legacy\Backup'
    'Reboot'                = 'legacy\Reboot'
    'System_Wipe'           = 'legacy\System_Wipe'
    'Mutation_Confirmation' = 'legacy\Mutation_Confirmation'
}

foreach ($move in $legacyMoves.GetEnumerator()) {
    Move-SafeItem -Source (Join-Path $rootPath $move.Key) -Destination (Join-Path $rootPath $move.Value)
}

# Archive Java artifacts from IntelIntent-Seed
if (Test-Path "$rootPath\IntelIntent-Seed") {
    $javaDir = Get-ChildItem "$rootPath\IntelIntent-Seed" -Directory | Where-Object { $_.Name -like 'java-*' }
    if ($javaDir) {
        Move-SafeItem -Source $javaDir.FullName -Destination "$rootPath\legacy\java-artifacts\$($javaDir.Name)"
    }
}

Write-Host ''

# ============================================
# STEP 11: Create README Files
# ============================================
Write-Host '📝 Step 11: Creating README files...' -ForegroundColor Cyan

$readmeContents = @{
    'docs\README.md'    = @'
# 📚 IntelIntent Documentation

Comprehensive documentation for the IntelIntent system.

## 📁 Directory Structure

- **architecture/** - System architecture diagrams and implementation plans
- **deployment/** - Deployment guides and CI/CD setup
- **phase5/** - Phase 5 modality agent documentation
- **phase6/** - Phase 6 expansion blueprints
- **agents/** - Agent implementation guides
- **compliance/** - Security and compliance documentation
- **powerbi/** - Power BI dashboard schemas
- **quickstart/** - Quick reference and getting started guides
- **week1/** - Week 1 implementation details
- **analysis/** - Gap analysis and roadmaps
- **integration/** - Integration guides
- **summary/** - Executive summaries
- **legacy/** - Archived documentation

## 🚀 Getting Started

1. Start with [QUICK_REFERENCE.md](quickstart/QUICK_REFERENCE.md)
2. Review [WORKFLOW_MAP.md](architecture/WORKFLOW_MAP.md)
3. Check [PRODUCTION_MODULES_QUICKSTART.md](quickstart/PRODUCTION_MODULES_QUICKSTART.md)

'@

    'scripts\README.md' = @"
# 🚀 IntelIntent Scripts

Executable PowerShell scripts for IntelIntent automation.

## 📁 Directory Structure

- **automation/** - Main automation scripts (Week1, Launcher, Deploy)
- **phase5/** - Phase 5 demo and metrics scripts
- **verification/** - Environment verification scripts
- **legacy/** - Archived/deprecated scripts

## 🎯 Primary Scripts

### Automation
- **Week1_Automation.ps1** - Main Week 1 hardening automation
- **IntelIntent_Launcher.ps1** - Interactive module launcher
- **Deploy-Phase4-Complete.ps1** - Complete Phase 4 deployment
- **Install-MaximumCapabilities.ps1** - Full capability installation
- **Install-MVP.ps1** - Minimum viable product installation

### Phase 5
- **Phase5_Demo_Environment_Setup.ps1** - Demo environment setup
- **Phase5_Live_Metrics_Dashboard.ps1** - Live metrics dashboard

### Verification
- **Verify-DevelopmentEnvironment.ps1** - Dev environment checks
- **Verify-WindowsSetup.ps1** - Windows environment validation

## ⚡ Quick Start

\`\`\`powershell
# Safe exploration (DRY RUN)
.\automation\Week1_Automation.ps1 -DryRun -SkipEmail

# Interactive launcher
.\automation\IntelIntent_Launcher.ps1

# Verify environment
.\verification\Verify-DevelopmentEnvironment.ps1
\`\`\`

"@

    'modules\README.md' = @"
# 🧩 IntelIntent Modules

PowerShell modules for IntelIntent system.

## 📁 Core Modules

### IntelIntent_Seeding
Production-ready orchestration modules:
- **AgentBridge.psm1** - Agent lifecycle management
- **CircuitBreaker.psm1** - Resilience patterns
- **CodexRenderer.psm1** - Checkpoint rendering
- **CopilotLifecycleTracker.psm1** - Copilot tracking
- **Get-CodexEmailBody.psm1** - Email templates
- **ManifestReader.ps1** - Manifest parsing
- **Orchestrator.ps1** - Central orchestration
- **SecureSecretsManager.psm1** - Azure Key Vault integration

### Component Modules
- **Identity_Modules** - Identity and authentication
- **Environment_Setup** - Environment configuration
- **Tooling** - Development tools
- **Services** - Service integrations
- **Enhancements** - System enhancements
- **Security_Validation** - Security checks
- **Remote_Updates** - Remote update capabilities
- **Autopilot_Provisioning** - Autopilot setup
- **CI_CD_Workflows** - CI/CD automation

## 🔧 Usage

\`\`\`powershell
# Import module
Import-Module .\IntelIntent_Seeding\AgentBridge.psm1 -Force

# Use agent
\$result = Invoke-OrchestratorAgent -Intent "Generate report"
\`\`\`

"@

    'config\README.md'  = @'
# ⚙️ IntelIntent Configuration

Configuration files, manifests, and prompts.

## 📁 Directory Structure

- **manifests/** - Component and workflow manifests (JSON)
- **integration/** - Integration configurations
- **pipelines/** - CI/CD pipeline definitions
- **prompts/** - Copilot and AI prompts

## 📋 Key Files

### Manifests
- **creator_of_creators_checklist.json** - Main project checklist
- **sample_manifest.json** - Manifest template
- **Fluent2_Interface_Deployment_Checklist.json** - UI deployment checklist

### Pipelines
- **azure-pipelines.yml** - Azure DevOps pipeline

### Prompts
- **copilot_prompt.txt** - GitHub Copilot instructions
- **copilot_recursive_prompt.txt** - Recursive orchestration prompts
- **intelintent_copilot_prompt.txt** - IntelIntent-specific prompts

'@

    'tests\README.md'   = @"
# 🧪 IntelIntent Tests

Test files and test data for IntelIntent system.

## 📁 Directory Structure

- **checkpoints/** - Test checkpoint data
- **fixtures/** - Test fixtures and mock data

## 🧪 Test Files

- **Test-BoopasAgent.ps1** - Boopas agent tests
- **Test-CopilotAuth.ps1** - Copilot authentication tests
- **Test-CopilotLifecycleTracker.ps1** - Lifecycle tracker tests
- **Test-FinanceAgent.ps1** - Finance agent tests
- **Test-PostInstall.ps1** - Post-install validation tests
- **Test-ProductionModules.ps1** - Production module tests

## 🚀 Running Tests

\`\`\`powershell
# Run all tests
Invoke-Pester

# Run specific test
Invoke-Pester -Path .\Test-BoopasAgent.ps1

# Run with coverage
Invoke-Pester -CodeCoverage ..\modules\**\*.psm1
\`\`\`

"@

    'data\README.md'    = @'
# 💾 IntelIntent Data

Data files, checkpoints, logs, and outputs.

## 📁 Directory Structure

- **checkpoints/** - Execution checkpoints (JSON)
- **logs/** - System logs
- **sponsors/** - Sponsor reports and scrolls
- **codex/** - Codex artifacts

## 📋 Key Files

### Checkpoints
- **Week1_Checkpoints.json** - Week 1 execution checkpoints
- **Phase5_Modality_Checkpoints.json** - Phase 5 modality checkpoints

### Logs
- **Recovery_Logs/** - System recovery logs

### Sponsors
- Generated Codex scrolls and reports

'@

    'legacy\README.md'  = @'
# 🗄️ Legacy and Archived Files

Archived files from previous implementations and deprecated features.

## ⚠️ WARNING

Files in this directory are **ARCHIVED** and may not be compatible with current system.

## 📁 Contents

### boot-system/
Legacy bootable system files (bootmgr, EFI, etc.) from bare-metal PC reset scenarios.
**Status:** Not actively used in Phase 4+

### post-install/
Legacy post-install mutation package.
**Status:** Superseded by IntelIntent_Seeding orchestration

### java-artifacts/
Java OpenJDK artifacts from IntelIntent-Seed.
**Status:** Archived pending cleanup

### Backup/, Reboot/, System_Wipe/, Mutation_Confirmation/
Legacy system mutation components.
**Status:** Deprecated

## 🔍 Restoration

If you need to restore any files, create an issue in the repository.

'@

    'tools\README.md'   = @'
# 🔧 IntelIntent Developer Tools

Development and debugging tools.

## 📁 Contents

### Visual_Dashboard_Setup/
Visual dashboard configuration and setup tools.

### IntelIntent_Mutation_Launchpad/
Legacy mutation launchpad interface.

## 🛠️ Usage

These tools support development workflows and are not part of production automation.

'@

    'sandbox\README.md' = @'
# 🧪 Sandbox - Experimental Workspace

Temporary workspace for experimental development and work-in-progress features.

## ⚠️ Usage Guidelines

1. **Temporary Only** - Do not commit long-term code here
2. **Clean Regularly** - Delete finished experiments
3. **Document** - Add comments explaining experiments
4. **Graduate** - Move successful experiments to proper modules

## 🗑️ Cleanup

This directory should be cleaned regularly. Files here are not part of the production system.

'@
}

foreach ($readme in $readmeContents.GetEnumerator()) {
    $readmePath = Join-Path $rootPath $readme.Key
    if ($DryRun) {
        Write-Host "   [DRY RUN] Would create: $($readme.Key)" -ForegroundColor Yellow
    } else {
        $readmeDir = Split-Path -Parent $readmePath
        if (-not (Test-Path $readmeDir)) {
            New-Item -ItemType Directory -Path $readmeDir -Force | Out-Null
        }
        Set-Content -Path $readmePath -Value $readme.Value -Force
        Write-Host "   ✅ Created: $($readme.Key)" -ForegroundColor Green
    }
}

Write-Host ''

# ============================================
# STEP 12: Create Master README
# ============================================
Write-Host '📄 Step 12: Creating master README...' -ForegroundColor Cyan

$masterReadme = @"
# 🎯 IntelIntent - Universal Creative System

> **Architecture**: Checkpoint-driven orchestration for code automation, sacred scripture composition, temple architecture, and artistic expression. Built on PowerShell 7+ with manifest-guided generation and cryptographic audit trails.

## ⚡ Quick Start

\`\`\`powershell
# Safe exploration (DRY RUN - always start here!)
.\scripts\automation\Week1_Automation.ps1 -DryRun -SkipEmail

# Interactive launcher
.\scripts\automation\IntelIntent_Launcher.ps1

# Generate components from manifests
.\modules\IntelIntent_Seeding\Orchestrator.ps1 -Mode Full -Verbose

# Verify environment
.\scripts\verification\Verify-DevelopmentEnvironment.ps1
\`\`\`

## 📁 Directory Structure

\`\`\`
IntelIntent/
├── 📚 docs/              # All documentation (architecture, guides, analysis)
├── 🚀 scripts/           # Executable automation scripts
├── 🧩 modules/           # PowerShell modules and components
├── ⚙️ config/            # Configuration, manifests, prompts
├── 🧪 tests/             # Test files and test data
├── 💾 data/              # Checkpoints, logs, outputs
├── 📋 governance/        # Governance and compliance
├── 🔧 tools/             # Developer tools
├── 🗄️ legacy/            # Archived/deprecated files
└── 🧪 sandbox/           # Experimental workspace
\`\`\`

## 🎓 Documentation Quick Links

| Category | Link | Description |
|----------|------|-------------|
| **Getting Started** | [QUICK_REFERENCE.md](docs/quickstart/QUICK_REFERENCE.md) | Quick reference guide |
| **Architecture** | [WORKFLOW_MAP.md](docs/architecture/WORKFLOW_MAP.md) | System workflow map |
| **Production** | [PRODUCTION_MODULES_QUICKSTART.md](docs/quickstart/PRODUCTION_MODULES_QUICKSTART.md) | Production module guide |
| **Phase 4** | [PHASE4_ARCHITECTURE_DIAGRAM.md](docs/architecture/PHASE4_ARCHITECTURE_DIAGRAM.md) | Phase 4 architecture |
| **Week 1** | [WEEK1_IMPLEMENTATION_CHECKLIST.md](docs/week1/WEEK1_IMPLEMENTATION_CHECKLIST.md) | Week 1 checklist |
| **Agents** | [docs/agents/](docs/agents/) | Agent implementation guides |
| **Compliance** | [COMPLIANCE_AND_AUTHENTICATION_ARCHITECTURE.md](docs/compliance/COMPLIANCE_AND_AUTHENTICATION_ARCHITECTURE.md) | Security & compliance |

## 🚀 Primary Entry Points

| Script | Purpose | Command |
|--------|---------|---------|
| **Week1 Automation** | Main hardening automation (26 checkpoints) | `.\scripts\automation\Week1_Automation.ps1 -DryRun -SkipEmail` |
| **Launcher** | Interactive module testing menu | `.\scripts\automation\IntelIntent_Launcher.ps1` |
| **Orchestrator** | Component generation from manifests | `.\modules\IntelIntent_Seeding\Orchestrator.ps1 -Mode Full` |

## 📦 Core Modules

Located in `modules/IntelIntent_Seeding/`:

- **AgentBridge.psm1** (447 lines) - Agent lifecycle management (6 agents)
- **CircuitBreaker.psm1** (530 lines) - Resilience patterns (retry, backoff, fallback)
- **CodexRenderer.psm1** (777 lines) - Checkpoint → Markdown/HTML conversion
- **CopilotLifecycleTracker.psm1** (380 lines) - GitHub Copilot tracking
- **Get-CodexEmailBody.psm1** (666 lines) - Email template generation
- **ManifestReader.ps1** (323 lines) - Manifest parsing
- **Orchestrator.ps1** (422 lines) - Central orchestration engine
- **SecureSecretsManager.psm1** (608 lines) - Azure Key Vault integration

## 🧪 Testing

\`\`\`powershell
# Run all tests
Invoke-Pester

# Run specific test
Invoke-Pester -Path .\tests\Test-BoopasAgent.ps1

# VS Code task
Ctrl+Shift+P → "Pester: Run All Tests"
\`\`\`

## 📋 VS Code Tasks

Press `Ctrl+Shift+P` → "Tasks: Run Task":

- **Week1: Run DryRun Mode** - Safe Week 1 automation test
- **Orchestrator: Generate Components** - Create components from manifests
- **Pester: Run All Tests** - Execute test suite
- **Module: Check Missing Modules** - Verify implementation status
- **Azure: Validate Connection** - Check Azure CLI authentication

## 🔑 Critical Patterns

### Always Test with DryRun First
\`\`\`powershell
# SAFE - simulates without Azure changes
.\scripts\automation\Week1_Automation.ps1 -DryRun -SkipEmail

# LIVE - executes actual Azure operations
.\scripts\automation\Week1_Automation.ps1
\`\`\`

### Checkpoint Pattern
\`\`\`powershell
# Every task creates a checkpoint
Invoke-TaskWithCheckpoint -TaskID "KV-001" -Description "Provision Key Vault" -ScriptBlock {
    az keyvault create --name \$VaultName --resource-group \$ResourceGroup
} -Inputs @{ VaultName = \$VaultName } -Artifacts @(\$VaultName)
\`\`\`

### Module Import Safety
\`\`\`powershell
# Graceful fallback for missing modules
Import-Module .\modules\IntelIntent_Seeding\SecureSecretsManager.psm1 -Force -ErrorAction SilentlyContinue

if (Get-Command New-SecretVault -ErrorAction SilentlyContinue) {
    New-SecretVault -VaultName "TestVault"
} else {
    Write-Warning "Module not implemented yet"
}
\`\`\`

## 🌍 Universal Workspace Philosophy

IntelIntent supports four creative domains:

1. **💻 Code & Automation** - Infrastructure orchestration, agent systems
2. **📜 Scriptures & Doctrine** - Sacred text composition, doctrinal frameworks
3. **🏛️ Temple Architecture** - Structural blueprints, sacred geometry
4. **🎨 Creative Art** - Visual design, aesthetic frameworks

All domains share: version control, modular composition, semantic validation, AI-assisted creation.

## 📞 Support

- **Documentation**: Start with [docs/quickstart/QUICK_REFERENCE.md](docs/quickstart/QUICK_REFERENCE.md)
- **Troubleshooting**: See `.github/copilot-instructions.md`
- **Issues**: GitHub Issues in repository

## 📄 License

See [LICENSE](LICENSE)

---

**Last Updated**: December 1, 2025
**Version**: Phase 4 (Production Hardening Complete)
**Status**: ✅ Active Development
"@

$masterReadmePath = Join-Path $rootPath 'README.md'
if ($DryRun) {
    Write-Host '   [DRY RUN] Would create: README.md' -ForegroundColor Yellow
} else {
    Set-Content -Path $masterReadmePath -Value $masterReadme -Force
    Write-Host '   ✅ Created: README.md' -ForegroundColor Green
}

Write-Host ''

# ============================================
# COMPLETION SUMMARY
# ============================================
Write-Host '🎉 Reorganization Complete!' -ForegroundColor Green
Write-Host '=============================' -ForegroundColor Green
Write-Host ''

if ($DryRun) {
    Write-Host 'This was a DRY RUN. No changes were made.' -ForegroundColor Yellow
    Write-Host 'To execute reorganization, run without -DryRun flag:' -ForegroundColor Yellow
    Write-Host '   .\Reorganize-Workspace.ps1 -CreateBackup' -ForegroundColor Cyan
} else {
    Write-Host '✅ Directory structure reorganized' -ForegroundColor Green
    Write-Host '✅ Files moved to appropriate locations' -ForegroundColor Green
    Write-Host '✅ README files created' -ForegroundColor Green
    Write-Host '✅ Legacy files archived' -ForegroundColor Green
    Write-Host ''
    Write-Host '⚠️ IMPORTANT NEXT STEPS:' -ForegroundColor Yellow
    Write-Host '1. Update script references to new paths' -ForegroundColor Yellow
    Write-Host '2. Test all automation with -DryRun flag' -ForegroundColor Yellow
    Write-Host '3. Update .vscode/tasks.json paths' -ForegroundColor Yellow
    Write-Host '4. Review and commit changes' -ForegroundColor Yellow
}

Write-Host ''
