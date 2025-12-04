# 🎯 IntelIntent Workspace Reorganization Guide

## 📋 Overview

This guide walks you through transforming the IntelIntent workspace from its current state into a **model of excellence** with clear organization, standardized naming, and logical structure.

## ⚠️ CRITICAL: Backup First!

```powershell
# Create backup before proceeding
.\Reorganize-Workspace.ps1 -CreateBackup -DryRun

# This creates a timestamped backup at:
# ..\IntelIntent-Backup-YYYYMMDD-HHMMSS\
```

## 🚀 Execution Steps

### Step 1: Review the Plan (DRY RUN)

```powershell
# Run in dry run mode to see what will happen
.\Reorganize-Workspace.ps1 -DryRun

# Review output carefully
# Verify all proposed moves make sense
```

### Step 2: Execute Reorganization

```powershell
# Execute with backup
.\Reorganize-Workspace.ps1 -CreateBackup

# Or execute without backup (if you already have one)
.\Reorganize-Workspace.ps1
```

**What This Does:**
- ✅ Creates new directory structure (docs/, scripts/, modules/, config/, tests/, data/, legacy/)
- ✅ Moves all files to appropriate locations
- ✅ Creates README.md files in all major directories
- ✅ Archives legacy files (boot system, post-install, etc.)
- ✅ Organizes documentation by category
- ✅ Consolidates scripts and modules
- ✅ Creates master README.md

### Step 3: Update References

```powershell
# Preview reference updates
.\Update-References.ps1 -DryRun

# Execute reference updates
.\Update-References.ps1
```

**What This Does:**
- ✅ Updates .vscode/tasks.json paths
- ✅ Updates IntelIntent_Launcher.ps1 module paths
- ✅ Updates Week1_Automation.ps1 imports
- ✅ Updates Orchestrator.ps1 manifest paths
- ✅ Updates test file imports
- ✅ Updates copilot instructions
- ✅ Updates Azure pipeline configuration
- ✅ Creates PathHelper.psm1 module

### Step 4: Validation & Testing

```powershell
# 1. Validate VS Code tasks still work
# Press Ctrl+Shift+P → "Tasks: Run Task" → "Week1: Run DryRun Mode"

# 2. Test Week1 automation
.\scripts\automation\Week1_Automation.ps1 -DryRun -SkipEmail

# 3. Test orchestrator
.\modules\IntelIntent_Seeding\Orchestrator.ps1 -Mode ValidateOnly

# 4. Run tests
Invoke-Pester

# 5. Check module availability
.\scripts\automation\IntelIntent_Launcher.ps1
```

### Step 5: Verify Structure

```powershell
# Check new directory structure
Get-ChildItem -Directory | Format-Table Name

# Expected output:
# .github
# .vscode
# config
# data
# docs
# governance
# legacy
# modules
# sandbox
# scripts
# tests
# tools
```

### Step 6: Commit Changes

```powershell
# Review all changes
git status

# Add all changes
git add .

# Commit with descriptive message
git commit -m "feat: Reorganize workspace into model of excellence

- Create logical directory structure (docs/, scripts/, modules/, config/, tests/, data/, legacy/)
- Move all files to appropriate locations
- Create comprehensive README files for all directories
- Archive legacy boot system and post-install files
- Update all script references and imports
- Create PathHelper.psm1 for standardized path resolution

BREAKING CHANGE: File paths have changed. Update external references."

# Push to repository
git push
```

## 📁 New Directory Structure

```
IntelIntent/
├── 📚 docs/                    # ALL DOCUMENTATION
│   ├── architecture/           # System architecture & implementation plans
│   ├── deployment/             # Deployment & CI/CD guides
│   ├── phase5/                 # Phase 5 documentation
│   ├── phase6/                 # Phase 6 expansion
│   ├── agents/                 # Agent implementation guides
│   ├── compliance/             # Security & compliance
│   ├── powerbi/                # Power BI schemas
│   ├── quickstart/             # Getting started guides
│   ├── week1/                  # Week 1 implementation
│   ├── analysis/               # Gap analysis & roadmaps
│   ├── integration/            # Integration guides
│   ├── summary/                # Executive summaries
│   └── legacy/                 # Archived docs
│
├── 🚀 scripts/                 # EXECUTABLE SCRIPTS
│   ├── automation/             # Main automation scripts
│   ├── phase5/                 # Phase 5 scripts
│   ├── verification/           # Environment verification
│   └── legacy/                 # Archived scripts
│
├── 🧩 modules/                 # POWERSHELL MODULES
│   ├── IntelIntent_Seeding/    # Core orchestration modules
│   ├── Identity_Modules/       # Identity & authentication
│   ├── Environment_Setup/      # Environment configuration
│   ├── Tooling/                # Development tools
│   ├── Services/               # Service integrations
│   ├── Enhancements/           # System enhancements
│   ├── Security_Validation/    # Security checks
│   ├── Remote_Updates/         # Remote updates
│   ├── Autopilot_Provisioning/ # Autopilot setup
│   └── CI_CD_Workflows/        # CI/CD automation
│
├── ⚙️ config/                  # CONFIGURATION
│   ├── manifests/              # Component manifests (JSON)
│   ├── integration/            # Integration configs
│   ├── pipelines/              # CI/CD pipelines
│   └── prompts/                # Copilot prompts
│
├── 🧪 tests/                   # TEST FILES
│   ├── checkpoints/            # Test checkpoint data
│   └── fixtures/               # Test fixtures
│
├── 💾 data/                    # DATA & OUTPUTS
│   ├── checkpoints/            # Execution checkpoints
│   ├── logs/                   # System logs
│   ├── sponsors/               # Sponsor reports
│   └── codex/                  # Codex artifacts
│
├── 📋 governance/              # GOVERNANCE & COMPLIANCE
├── 🔧 tools/                   # DEVELOPER TOOLS
├── 🗄️ legacy/                  # ARCHIVED FILES
│   ├── boot-system/            # Legacy boot files
│   ├── post-install/           # Legacy post-install
│   └── java-artifacts/         # Java dependencies
│
└── 🧪 sandbox/                 # EXPERIMENTAL WORKSPACE
```

## 🔑 Key Improvements

### Before (Current State)
```
IntelIntent/
├── Week1_Automation.ps1
├── IntelIntent_Launcher.ps1
├── PHASE4_ARCHITECTURE_DIAGRAM.md
├── Boopas_Agent_Guide.md
├── Test-BoopasAgent.ps1
├── bootmgr
├── autorun.inf
├── IntelIntent_Seeding/
└── (80+ items in root directory)
```

### After (Model of Excellence)
```
IntelIntent/
├── README.md (comprehensive)
├── LICENSE
├── .gitignore
├── docs/                    (all 40+ markdown files organized)
├── scripts/                 (all executable scripts)
├── modules/                 (all PowerShell modules)
├── config/                  (all configuration)
├── tests/                   (all test files)
├── data/                    (all data/outputs)
├── legacy/                  (archived artifacts)
└── (8 clean root items)
```

### Benefits
- ✅ **Clean root directory** - Only essential items visible
- ✅ **Logical categorization** - Find files intuitively
- ✅ **Clear documentation** - README in every folder
- ✅ **Standardized paths** - PathHelper.psm1 module
- ✅ **Legacy preservation** - Nothing deleted, safely archived
- ✅ **Git-friendly** - Better diff and merge experience
- ✅ **Onboarding** - New developers can navigate easily
- ✅ **Maintainability** - Easier to locate and update files

## 📊 Migration Statistics

| Category | Files Affected | New Location |
|----------|----------------|--------------|
| **Documentation** | 42 markdown files | `docs/` (8 subdirectories) |
| **Scripts** | 8 automation scripts | `scripts/` (3 subdirectories) |
| **Modules** | 10 component modules | `modules/` (standardized) |
| **Tests** | 6 test files + 4 JSON | `tests/` |
| **Configuration** | 15+ manifests/configs | `config/` |
| **Data** | 3 checkpoint files | `data/checkpoints/` |
| **Legacy** | 20+ boot/system files | `legacy/` (archived) |

## 🛠️ Troubleshooting

### Issue: "File not found" after reorganization

**Solution:**
```powershell
# Use PathHelper module
Import-Module .\modules\IntelIntent_Seeding\PathHelper.psm1

# Get correct paths
$week1Path = Get-Week1AutomationPath
$orchestratorPath = Get-OrchestratorPath

# Or use direct paths
.\scripts\automation\Week1_Automation.ps1 -DryRun
```

### Issue: VS Code tasks not working

**Solution:**
```powershell
# Reload VS Code window
# Press Ctrl+Shift+P → "Developer: Reload Window"

# Or manually update .vscode/tasks.json paths
# Already updated by Update-References.ps1
```

### Issue: Import-Module errors

**Solution:**
```powershell
# Use absolute paths
$rootPath = "c:\Users\BOOPA\OneDrive\IntelIntent!"
Import-Module "$rootPath\modules\IntelIntent_Seeding\AgentBridge.psm1" -Force

# Or update working directory
Set-Location "c:\Users\BOOPA\OneDrive\IntelIntent!"
```

### Issue: Want to restore original structure

**Solution:**
```powershell
# Restore from backup
$backupPath = "..\IntelIntent-Backup-YYYYMMDD-HHMMSS"
Copy-Item "$backupPath\*" -Destination . -Recurse -Force

# Or use git reset
git reset --hard HEAD~1
git clean -fd
```

## ✅ Validation Checklist

After completing all steps, verify:

- [ ] All VS Code tasks execute successfully
- [ ] `.\scripts\automation\Week1_Automation.ps1 -DryRun -SkipEmail` completes without errors
- [ ] `.\scripts\automation\IntelIntent_Launcher.ps1` displays menu correctly
- [ ] `.\modules\IntelIntent_Seeding\Orchestrator.ps1 -Mode ValidateOnly` validates manifests
- [ ] `Invoke-Pester` runs all tests successfully
- [ ] All README.md files present and accurate
- [ ] No files lost (check backup vs new structure)
- [ ] Git status shows reorganized files, not deleted files
- [ ] Documentation links in README.md work correctly

## 📞 Support

If you encounter issues:

1. **Review dry run output** - Check what changes were proposed
2. **Check backup** - Verify backup was created successfully
3. **Review Update-References.ps1 output** - Ensure all paths updated
4. **Test incrementally** - Test each script individually
5. **Restore from backup if needed** - Backup is your safety net

## 🎓 Best Practices Going Forward

### File Placement Guidelines

| File Type | Location | Example |
|-----------|----------|---------|
| **Documentation** | `docs/[category]/` | `docs/architecture/WORKFLOW_MAP.md` |
| **Automation Scripts** | `scripts/automation/` | `scripts/automation/Week1_Automation.ps1` |
| **PowerShell Modules** | `modules/IntelIntent_Seeding/` | `modules/IntelIntent_Seeding/AgentBridge.psm1` |
| **Component Modules** | `modules/[ComponentName]/` | `modules/Identity_Modules/` |
| **Configuration** | `config/[type]/` | `config/manifests/sample_manifest.json` |
| **Tests** | `tests/` | `tests/Test-BoopasAgent.ps1` |
| **Test Data** | `tests/checkpoints/` | `tests/checkpoints/TestCheckpoints.json` |
| **Runtime Data** | `data/[type]/` | `data/checkpoints/Week1_Checkpoints.json` |
| **Logs** | `data/logs/` | `data/logs/Recovery_Logs/` |
| **Legacy/Deprecated** | `legacy/[category]/` | `legacy/boot-system/bootmgr` |
| **Experimental** | `sandbox/` | `sandbox/experimental-feature.ps1` |

### Naming Conventions

- **Directories**: lowercase with hyphens (e.g., `boot-system`, `post-install`)
- **Scripts**: PascalCase (e.g., `Week1_Automation.ps1`, `Deploy-Phase4-Complete.ps1`)
- **Modules**: PascalCase with .psm1 extension (e.g., `AgentBridge.psm1`)
- **Documentation**: UPPERCASE with underscores for multi-word (e.g., `WORKFLOW_MAP.md`)
- **READMEs**: Always `README.md` (uppercase)

### When Adding New Files

1. **Determine category** - Does it fit docs/, scripts/, modules/, config/, tests/, or data/?
2. **Check for existing subdirectory** - Use existing structure when possible
3. **Create README if new category** - Document purpose of new subdirectories
4. **Update master README** - Add links to new major documentation
5. **Use PathHelper** - Reference new paths via PathHelper module when possible

---

**Last Updated**: December 1, 2025
**Author**: GitHub Copilot
**Status**: Ready for Execution
