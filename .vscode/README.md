# IntelIntent VS Code Configuration

This directory contains VS Code workspace settings optimized for IntelIntent PowerShell development.

## 📁 Files Overview

### Core Configuration
- **`settings.json`** - Workspace settings for PowerShell development
  - Script analysis enabled with custom rules
  - OTBS code formatting style
  - PowerShell 7+ as default terminal
  - Editor settings optimized for .ps1/.psm1 files

- **`launch.json`** - Debug configurations
  - Week1 Automation (DryRun & Live modes)
  - Orchestrator (Full & DryRun modes)
  - Interactive Launcher
  - Pester test runners
  - Current file debugging

- **`tasks.json`** - Build and automation tasks
  - Week1 automation runners (DryRun/Live)
  - Orchestrator component generation
  - Pester test execution
  - Azure CLI validation
  - Checkpoint validation
  - Module status checks

- **`extensions.json`** - Recommended VS Code extensions
  - PowerShell extension (required)
  - GitHub Copilot (AI assistance)
  - Azure tools
  - Markdown support

- **`PSScriptAnalyzerSettings.psd1`** - PowerShell linting rules
  - IntelIntent-specific conventions
  - Best practices enforcement
  - Code formatting standards

### Helper Scripts (`scripts/`)
- **`Check-MissingModules.ps1`** - Module implementation status checker
- **`Validate-Checkpoints.ps1`** - Checkpoint JSON schema validator
- **`IntelIntent-Profile.ps1`** - PowerShell profile snippet with shortcuts

## 🚀 Quick Start

### 1. Install Recommended Extensions
Press `Ctrl+Shift+P` → "Extensions: Show Recommended Extensions"

### 2. Load PowerShell Profile (Optional)
Add to your `$PROFILE`:
```powershell
. "C:\Path\To\IntelIntent\.vscode\scripts\IntelIntent-Profile.ps1"
```

### 3. Run Tasks
- Press `Ctrl+Shift+B` → Select task (default: Week1 DryRun)
- Or: `Ctrl+Shift+P` → "Tasks: Run Task"

### 4. Start Debugging
- Press `F5` → Select configuration
- Or: Debug panel → Choose from dropdown

## ⌨️ Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Run build task (Week1 DryRun) | `Ctrl+Shift+B` |
| Run task menu | `Ctrl+Shift+P` → "Tasks: Run Task" |
| Start debugging | `F5` |
| Run current file | `F8` (PowerShell extension) |
| Format document | `Shift+Alt+F` |
| Toggle terminal | `` Ctrl+` `` |

## 🎯 Common Tasks

### Week1 Automation
```powershell
# From VS Code terminal
.\Week1_Automation.ps1 -DryRun -SkipEmail

# Or use task: Ctrl+Shift+B → "Week1: Run DryRun Mode"
```

### Check Module Status
```powershell
# From VS Code terminal
.\.vscode\scripts\Check-MissingModules.ps1

# Or use task: "Module: Check Missing Modules"
```

### Validate Checkpoints
```powershell
# From VS Code terminal
.\.vscode\scripts\Validate-Checkpoints.ps1

# Or use task: "Checkpoint: Validate Structure"
```

### Generate Components
```powershell
# From VS Code terminal
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode GenerateOnly

# Or use task: "Orchestrator: Generate Components"
```

## 🧪 Testing

### Run All Pester Tests
```powershell
Invoke-Pester -Output Detailed
```
Or: Task → "Pester: Run All Tests" (`Ctrl+Shift+T`)

### Run Current Test File
```powershell
Invoke-Pester -Path $file -Output Detailed
```
Or: Debug → "PowerShell: Pester Tests (Current File)"

## 🔍 Script Analysis

PSScriptAnalyzer runs automatically on save. To run manually:
```powershell
Invoke-ScriptAnalyzer -Path .\YourScript.ps1 -Settings .\.vscode\PSScriptAnalyzerSettings.psd1
```

## 🛠️ Customization

### Personal Settings Override
Create `.vscode/settings.local.json` (gitignored) for personal preferences:
```json
{
  "powershell.codeFormatting.preset": "Stroustrup",
  "editor.fontSize": 14
}
```

### Add Custom Tasks
Edit `tasks.json` and add to the `tasks` array:
```json
{
  "label": "My Custom Task",
  "type": "shell",
  "command": "pwsh",
  "args": ["-File", "${workspaceFolder}/MyScript.ps1"]
}
```

## 📚 IntelIntent-Specific Patterns

### Module Import Convention
```powershell
# Always use absolute paths with -Force
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module "$scriptPath\MyModule.psm1" -Force
```

### Checkpoint Pattern
```powershell
# Use wrapper function for automatic timing
Invoke-TaskWithCheckpoint `
    -TaskID "PREFIX-001" `
    -Description "Task description" `
    -ScriptBlock { /* implementation */ } `
    -Inputs @{ /* input data */ } `
    -Artifacts @("artifact1", "artifact2")
```

### DryRun Pattern
```powershell
if ($DryRun) {
    Write-Host "  [DRY RUN] Would perform action" -ForegroundColor Yellow
    return $null
}
# Actual operation
```

## 🔗 Related Documentation
- [Main README](../README.txt)
- [Week1 Implementation Checklist](../WEEK1_IMPLEMENTATION_CHECKLIST.md)
- [Workflow Map](../WORKFLOW_MAP.md)
- [Phase 4 Architecture](../PHASE4_ARCHITECTURE_DIAGRAM.md)
- [Copilot Instructions](../.github/copilot-instructions.md)

## 🐛 Troubleshooting

### PowerShell Extension Not Working
1. Ensure PowerShell 7+ installed: `pwsh --version`
2. Reload VS Code: `Ctrl+Shift+P` → "Developer: Reload Window"
3. Check extension version: Should be 2024.x or newer

### Tasks Not Appearing
- Verify `tasks.json` has no syntax errors
- Reload window: `Ctrl+Shift+P` → "Developer: Reload Window"

### Script Analysis Errors
- Check `.vscode/PSScriptAnalyzerSettings.psd1` exists
- Install PSScriptAnalyzer: `Install-Module -Name PSScriptAnalyzer`

### Azure CLI Commands Fail
- Login: `az login`
- Verify connection: Task → "Azure: Validate Connection"

## 💡 Pro Tips

1. **Use IntelliSense**: Type cmdlet names and press `Ctrl+Space` for parameters
2. **Quick Fix**: Hover over PSScriptAnalyzer warnings → Click lightbulb → Apply fix
3. **Snippet Expansion**: Type `function` → press `Tab` for function template
4. **Multi-cursor**: `Alt+Click` to add cursors for batch editing
5. **Terminal History**: Press `Up` in terminal to cycle through command history

---

**Need help?** Check [PowerShell extension documentation](https://aka.ms/ps-vscode) or IntelIntent team documentation.
