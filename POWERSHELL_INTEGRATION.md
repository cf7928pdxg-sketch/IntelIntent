# PowerShell Integration Guide for IntelIntent

## ✅ Integration Status: Complete

IntelIntent is now fully integrated with VS Code PowerShell extension (v2025.5.0+). All configurations, tasks, and debugging profiles are ready to use.

---

## 🆕 November 2025 Features

**IntelIntent now includes cutting-edge VS Code Insiders features!**

- 🚀 **Tree-sitter PowerShell 7 grammar** - Enhanced parsing with `&&` and `||` operator support
- 📦 **Git Stashes explorer** - Visual stash management (create/apply/pop/drop)
- 💬 **Inline Chat V2** - Multi-file editing with auto side-editor
- 🐙 **GitHub MCP Server** - Native tools for repos, PRs, issues
- 🖥️ **Terminal xterm.js rendering** - Proper ANSI colors, persistent command output
- 🤖 **Unified Agent Sessions** - All chat/agent sessions in one view
- 💡 **AI Code Actions** - Quick Fix menu (Ctrl+.) integration
- 🌐 **Domain URL approval** - Granular fetch permissions

**See [`.vscode/NOVEMBER_2025_FEATURES.md`](.vscode/NOVEMBER_2025_FEATURES.md) for complete guide and examples.**

---

## 📦 What's Been Configured

### 1. **Workspace Settings** (`.vscode/settings.json`)
- ✅ PowerShell 7+ as default terminal
- ✅ Script analysis enabled with custom rules
- ✅ OTBS formatting style (One True Brace Style)
- ✅ Auto-formatting on save
- ✅ IntelliSense optimized for .ps1/.psm1 files
- ✅ UTF-8 BOM encoding for PowerShell scripts
- ✅ GitHub Copilot enabled for PowerShell

### 2. **Debug Configurations** (`.vscode/launch.json`)
10 pre-configured debug profiles:
- Week1 Automation (DryRun & Live)
- Orchestrator (Full & DryRun)
- Interactive Launcher
- Pester test runners (current file & all tests)
- Current file debugging
- Checkpoint validation

### 3. **Build Tasks** (`.vscode/tasks.json`)
15 automation tasks:
- Week1 DryRun/Live execution
- Orchestrator component generation
- Pester test runners
- Azure CLI validation
- Checkpoint structure validation
- Module status checking
- PSScriptAnalyzer linting

### 4. **Code Quality** (`.vscode/PSScriptAnalyzerSettings.psd1`)
- IntelIntent-specific linting rules
- Best practices enforcement
- Automatic code formatting standards
- Function help block requirements

### 5. **Helper Scripts** (`.vscode/scripts/`)
- `Check-MissingModules.ps1` - Module implementation tracker
- `Validate-Checkpoints.ps1` - Checkpoint schema validator
- `IntelIntent-Profile.ps1` - Development shortcuts

### 6. **Extension Recommendations** (`.vscode/extensions.json`)
Essential extensions for IntelIntent development:
- PowerShell (required)
- GitHub Copilot
- Azure Tools
- Markdown support

---

## 🚀 Getting Started

### Step 1: Install PowerShell Extension
1. Press `Ctrl+Shift+X` (Extensions view)
2. Search for "PowerShell"
3. Install **PowerShell** by Microsoft (v2025.5.0+)
4. Reload VS Code

### Step 2: Install Recommended Extensions
Press `Ctrl+Shift+P` → Type "Show Recommended Extensions" → Install all

### Step 3: Verify Setup
Open terminal (`` Ctrl+` ``) and run:
```powershell
# Check PowerShell version (must be 7.0+)
pwsh --version

# Check Azure CLI
az --version

# Test module checker
.\.vscode\scripts\Check-MissingModules.ps1
```

### Step 4: Run Your First Task
Press `Ctrl+Shift+B` → Select **"Week1: Run DryRun Mode"**

---

## 🎯 Daily Workflow

### Morning Setup
```powershell
# 1. Validate Azure connection
az login

# 2. Check module status
.\.vscode\scripts\Check-MissingModules.ps1

# 3. Run DryRun to verify environment
.\Week1_Automation.ps1 -DryRun -SkipEmail
```

### Development Cycle
1. **Edit PowerShell scripts** - IntelliSense and auto-formatting active
2. **Save file** - PSScriptAnalyzer runs automatically
3. **Fix warnings** - Hover over squiggles → Click lightbulb → Apply fix
4. **Test changes** - Press `F5` to debug current file
5. **Run tasks** - `Ctrl+Shift+B` for common automation tasks

### Before Committing
```powershell
# Validate checkpoints
.\.vscode\scripts\Validate-Checkpoints.ps1

# Run all tests
Invoke-Pester -Output Detailed

# Verify no script analysis errors
Invoke-ScriptAnalyzer -Path . -Recurse -Settings .\.vscode\PSScriptAnalyzerSettings.psd1
```

---

## ⌨️ Essential Keyboard Shortcuts

| Action | Shortcut | Description |
|--------|----------|-------------|
| **Build** | `Ctrl+Shift+B` | Run default task (Week1 DryRun) |
| **Debug** | `F5` | Start debugging selected configuration |
| **Run Current** | `F8` | Execute current line/selection in terminal |
| **Terminal** | `` Ctrl+` `` | Toggle integrated terminal |
| **Format** | `Shift+Alt+F` | Format current document |
| **Quick Open** | `Ctrl+P` | Quick file navigation |
| **Command Palette** | `Ctrl+Shift+P` | Access all VS Code commands |
| **Problems** | `Ctrl+Shift+M` | View linting errors/warnings |
| **Test Explorer** | `Ctrl+Shift+T` | Run tests (custom binding) |

---

## 🧪 Testing Workflow

### Run Tests via Tasks
1. `Ctrl+Shift+P` → "Tasks: Run Task"
2. Select "Pester: Run All Tests" or "Pester: Run Current Test File"

### Debug Tests
1. Open test file (e.g., `AgentBridge.Tests.ps1`)
2. Set breakpoints (`F9`)
3. `F5` → Select "PowerShell: Pester Tests (Current File)"
4. Step through code (`F10` = step over, `F11` = step into)

### Test File Pattern
```powershell
# Tests/MyModule.Tests.ps1
BeforeAll {
    Import-Module "$PSScriptRoot\..\IntelIntent_Seeding\MyModule.psm1" -Force
}

Describe "MyModule Tests" {
    Context "Function Tests" {
        It "Should return expected result" {
            $result = Invoke-MyFunction -Param "test"
            $result | Should -Be "expected"
        }
    }
}

AfterAll {
    Remove-Module MyModule -Force -ErrorAction SilentlyContinue
}
```

---

## 🔍 Debugging Tips

### Debug Week1 Automation
1. Open `Week1_Automation.ps1`
2. Set breakpoint on line you want to inspect (`F9`)
3. Press `F5` → Select **"PowerShell: Week1 Automation (DryRun)"**
4. Execution stops at breakpoint
5. Inspect variables in Debug Console
6. Step through code (`F10`, `F11`)

### Debug Modules
```powershell
# In terminal, import module and call function
Import-Module .\IntelIntent_Seeding\AgentBridge.psm1 -Force
Invoke-OrchestratorAgent -Intent "test" # Set breakpoint in module first
```

### View Call Stack
When paused at breakpoint:
- **Debug sidebar** shows call stack
- **Variables panel** shows all in-scope variables
- **Watch panel** lets you monitor expressions
- **Debug Console** allows REPL-style evaluation

---

## 🛠️ Customization

### Personal Settings
Create `.vscode/settings.local.json` (gitignored):
```json
{
  "editor.fontSize": 14,
  "powershell.codeFormatting.preset": "Stroustrup",
  "terminal.integrated.fontSize": 12
}
```

### Add Custom Task
Edit `.vscode/tasks.json`:
```json
{
  "label": "My Custom Script",
  "type": "shell",
  "command": "pwsh",
  "args": ["-File", "${workspaceFolder}/MyScript.ps1", "-Verbose"],
  "problemMatcher": []
}
```

### Add Debug Configuration
Edit `.vscode/launch.json`:
```json
{
  "name": "Debug My Script",
  "type": "PowerShell",
  "request": "launch",
  "script": "${workspaceFolder}/MyScript.ps1",
  "args": ["-DryRun"],
  "cwd": "${workspaceFolder}"
}
```

---

## 📊 Code Quality

### PSScriptAnalyzer Rules
Runs on save. Check `.vscode/PSScriptAnalyzerSettings.psd1` for active rules.

**IntelIntent-specific exclusions:**
- `PSAvoidUsingWriteHost` - We use colored output intentionally
- `PSUseShouldProcessForStateChangingFunctions` - Not all functions need -WhatIf
- `PSAvoidUsingPositionalParameters` - Allow for common cmdlets

**To manually run:**
```powershell
Invoke-ScriptAnalyzer -Path .\MyScript.ps1 -Settings .\.vscode\PSScriptAnalyzerSettings.psd1
```

### Code Formatting
Format on save enabled by default. Manual format: `Shift+Alt+F`

**Style: OTBS (One True Brace Style)**
```powershell
# ✅ Correct
function Get-Data {
    if ($condition) {
        # code
    }
}

# ❌ Incorrect (Allman style)
function Get-Data
{
    if ($condition)
    {
        # code
    }
}
```

---

## 🔗 Integration Points

### Azure CLI
Tasks and debug configs assume Azure CLI installed:
```powershell
# Verify installation
az --version

# Login
az login

# Validate task
Task → "Azure: Validate Connection"
```

### GitHub Copilot
Enabled for PowerShell, Markdown, and JSON files:
- Inline suggestions appear as you type
- Press `Tab` to accept
- Press `Ctrl+Enter` for alternatives
- Use `@workspace` in chat for context-aware suggestions

### Pester Testing
Install Pester if not already:
```powershell
Install-Module -Name Pester -Force -SkipPublisherCheck
```

Tasks and debug configs assume Pester v5.0+.

---

## 🐛 Troubleshooting

### "PowerShell extension not working"
**Solutions:**
1. Ensure PowerShell 7+ installed: `pwsh --version`
2. Restart VS Code
3. Check extension installed: Extensions → "PowerShell" by Microsoft
4. Check Output panel: View → Output → PowerShell Extension

### "Tasks not appearing"
**Solutions:**
1. Verify `.vscode/tasks.json` has no JSON syntax errors
2. Reload window: `Ctrl+Shift+P` → "Developer: Reload Window"
3. Check terminal profile: Settings → Search "terminal.integrated.defaultProfile.windows"

### "PSScriptAnalyzer not running"
**Solutions:**
1. Install module: `Install-Module -Name PSScriptAnalyzer`
2. Check settings: `.vscode/PSScriptAnalyzerSettings.psd1` exists
3. Enable in settings: `"powershell.scriptAnalysis.enable": true`

### "Debug configuration not working"
**Solutions:**
1. Ensure PowerShell extension installed and active
2. Check script path in `.vscode/launch.json` is correct
3. Try "PowerShell: Launch Current File" first
4. Check Debug Console for error messages

### "Azure CLI commands fail"
**Solutions:**
1. Install Azure CLI: https://aka.ms/azure-cli
2. Login: `az login`
3. Verify: `az account show`
4. Run task: "Azure: Validate Connection"

---

## 📚 Additional Resources

### IntelIntent Documentation
- [Copilot Instructions](../.github/copilot-instructions.md) - AI agent guidance
- [Week1 Checklist](../WEEK1_IMPLEMENTATION_CHECKLIST.md) - Implementation tasks
- [Workflow Map](../WORKFLOW_MAP.md) - Service boundaries
- [Phase 4 Architecture](../PHASE4_ARCHITECTURE_DIAGRAM.md) - System design

### PowerShell Extension
- [Official Docs](https://aka.ms/ps-vscode)
- [GitHub Repository](https://github.com/PowerShell/vscode-powershell)
- [Issue Tracker](https://github.com/PowerShell/vscode-powershell/issues)

### PowerShell Resources
- [PowerShell Docs](https://docs.microsoft.com/powershell/)
- [PSScriptAnalyzer Rules](https://github.com/PowerShell/PSScriptAnalyzer/blob/master/RuleDocumentation/README.md)
- [Pester Documentation](https://pester.dev/)

---

## 💡 Pro Tips

1. **Use Profile Shortcuts**: Add `.vscode/scripts/IntelIntent-Profile.ps1` to your `$PROFILE` for quick commands
2. **Multi-cursor Editing**: `Alt+Click` to add cursors, great for batch edits
3. **IntelliSense**: Press `Ctrl+Space` anywhere for context-aware suggestions
4. **Parameter Help**: When typing cmdlet, press `Ctrl+Shift+Space` for parameter info
5. **Quick Fix**: Hover over PSScriptAnalyzer warning → Lightbulb → Apply fix
6. **Terminal Split**: `` Ctrl+Shift+` `` to create split terminal
7. **Workspace Search**: `Ctrl+Shift+F` to search entire codebase
8. **Go to Definition**: `F12` on function/variable to jump to definition
9. **Find References**: `Shift+F12` to find all usages
10. **Rename Symbol**: `F2` to rename variable/function across all files

---

## 🎉 You're All Set!

PowerShell is now fully integrated. Start with:
```powershell
# Quick test
.\Week1_Automation.ps1 -DryRun -SkipEmail

# Or press Ctrl+Shift+B → "Week1: Run DryRun Mode"
```

**Questions?** Check `.vscode/README.md` or IntelIntent team documentation.
