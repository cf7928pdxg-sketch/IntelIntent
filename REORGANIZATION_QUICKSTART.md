# 🎯 Quick Reference Card - IntelIntent Reorganization

## ⚡ TL;DR

```powershell
# 1. BACKUP & DRY RUN
.\Reorganize-Workspace.ps1 -CreateBackup -DryRun

# 2. EXECUTE REORGANIZATION
.\Reorganize-Workspace.ps1 -CreateBackup

# 3. UPDATE REFERENCES
.\Update-References.ps1

# 4. TEST EVERYTHING
.\scripts\automation\Week1_Automation.ps1 -DryRun -SkipEmail
.\modules\IntelIntent_Seeding\Orchestrator.ps1 -Mode ValidateOnly
Invoke-Pester

# 5. COMMIT
git add .
git commit -m "feat: Reorganize workspace into model of excellence"
git push
```

## 📂 New Structure at a Glance

```
IntelIntent/
├── docs/         # 📚 All documentation (42 files → 8 categories)
├── scripts/      # 🚀 Executable scripts (automation, verification)
├── modules/      # 🧩 PowerShell modules (10 component modules)
├── config/       # ⚙️ Configuration (manifests, prompts, pipelines)
├── tests/        # 🧪 Test files + test data
├── data/         # 💾 Checkpoints, logs, sponsors, codex
├── governance/   # 📋 Governance & compliance
├── tools/        # 🔧 Developer tools
├── legacy/       # 🗄️ Archived (boot system, post-install, java)
└── sandbox/      # 🧪 Experimental workspace
```

## 🎯 Key Path Changes

| Old Path | New Path |
|----------|----------|
| `.\Week1_Automation.ps1` | `.\scripts\automation\Week1_Automation.ps1` |
| `.\IntelIntent_Launcher.ps1` | `.\scripts\automation\IntelIntent_Launcher.ps1` |
| `.\IntelIntent_Seeding\` | `.\modules\IntelIntent_Seeding\` |
| `.\PHASE4_ARCHITECTURE_DIAGRAM.md` | `.\docs\architecture\PHASE4_ARCHITECTURE_DIAGRAM.md` |
| `.\Test-BoopasAgent.ps1` | `.\tests\Test-BoopasAgent.ps1` |
| `.\Week1_Checkpoints.json` | `.\data\checkpoints\Week1_Checkpoints.json` |
| `.\IntelIntent-Seed\*.json` | `.\config\manifests\*.json` |
| `.\bootmgr` (+ boot files) | `.\legacy\boot-system\bootmgr` |

## ✅ Validation Commands

```powershell
# Check structure
Get-ChildItem -Directory | Format-Table Name

# Test VS Code task
# Ctrl+Shift+P → "Tasks: Run Task" → "Week1: Run DryRun Mode"

# Test automation
.\scripts\automation\Week1_Automation.ps1 -DryRun -SkipEmail

# Test orchestrator
.\modules\IntelIntent_Seeding\Orchestrator.ps1 -Mode ValidateOnly

# Run all tests
Invoke-Pester

# Verify no broken imports
Get-ChildItem .\modules -Recurse -Filter *.ps1 | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    if ($content -match 'Import-Module.*IntelIntent_Seeding' -and $content -notmatch '\.\.[/\\]') {
        Write-Warning "Check imports in: $($_.FullName)"
    }
}
```

## 🆘 Rollback (If Needed)

```powershell
# Option 1: Restore from backup
$backup = Get-ChildItem ..\IntelIntent-Backup-* | Sort-Object Name -Descending | Select-Object -First 1
Copy-Item "$($backup.FullName)\*" -Destination . -Recurse -Force

# Option 2: Git reset
git reset --hard HEAD~1
git clean -fd
```

## 📊 Impact Summary

- **Files Reorganized**: 100+ files moved to logical locations
- **Directories Created**: 30+ new subdirectories with READMEs
- **Root Directory Cleanup**: 80+ items → 8 clean categories
- **Documentation Organized**: 42 markdown files → 8 categories
- **Legacy Archived**: 20+ boot/system files preserved in legacy/
- **Scripts Updated**: All paths and imports automatically updated
- **New Helper Module**: PathHelper.psm1 for standardized paths

## 🎓 Quick Tips

1. **Always DryRun First** - Test changes before applying
2. **Create Backups** - Use `-CreateBackup` flag
3. **Test Incrementally** - Validate each script individually
4. **Use PathHelper** - Import and use for standardized paths
5. **Update README Links** - Keep documentation current
6. **Clean Sandbox Regularly** - Don't commit experimental code
7. **Archive, Don't Delete** - Move to legacy/ instead of removing

## 📞 Help

- **Full Guide**: [REORGANIZATION_GUIDE.md](REORGANIZATION_GUIDE.md)
- **Architecture**: [docs/architecture/WORKFLOW_MAP.md](docs/architecture/WORKFLOW_MAP.md)
- **Quick Start**: [docs/quickstart/QUICK_REFERENCE.md](docs/quickstart/QUICK_REFERENCE.md)

---

**Status**: ✅ Ready to Execute
**Last Updated**: December 1, 2025
