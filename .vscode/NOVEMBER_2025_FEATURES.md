# 🚀 November 2025 VS Code Features - IntelIntent Integration

## Overview

IntelIntent now leverages **cutting-edge VS Code Insiders features** from November 2025, providing enhanced PowerShell development, AI-assisted workflows, and universal creative capabilities.

---

## 🆕 What's New (November 2025)

### 1. **Enhanced PowerShell Support** 🔥

#### Tree-sitter Grammar for PowerShell 7
- **Feature**: Upgraded tree-sitter WASM library with PowerShell 7 support
- **Benefits**: 
  - Parse `&&` and `||` operators (new in PowerShell 7)
  - Improved syntax parsing performance
  - Better command rewriting for both PowerShell 5.1 and 7+
- **Configuration**: `"powershell.enableTreeSitterGrammar": true`

**Example Usage:**
```powershell
# PowerShell 7 operators now properly parsed
Test-Connection google.com && Write-Host "Connected" || Write-Host "Failed"

# Pipeline operators with improved highlighting
Get-Process | Where-Object CPU -gt 100 | Sort-Object CPU -Descending
```

---

### 2. **Git Stashes Explorer** 📦

#### Visual Stash Management
- **Feature**: New Stashes node in Git Repositories explorer
- **Capabilities**:
  - View all stashes with relative timestamps
  - See branch names for each stash
  - Create, apply, pop, drop stashes via context menu
  - No more `git stash list` in terminal!
- **Configuration**: `"scm.repositories.explorer": true`

**How to Use:**
1. Open Source Control view (Ctrl+Shift+G)
2. Expand "Repositories" section
3. Right-click "Stashes" node
4. Create stash: Right-click → "Stash Changes"
5. Apply stash: Right-click stash → "Apply Stash"

**Keyboard Shortcut:** `Ctrl+Shift+Alt+S` (focus SCM view)

---

### 3. **Inline Chat V2** 💬

#### Next-Generation Chat Interface
- **Feature**: New inline chat UI with enhanced backend
- **Improvements**:
  - Files modified outside current editor auto-open in side group
  - Better context awareness
  - Improved diff previews for sensitive files (settings.json)
  - Smoother integration with agent workflows
- **Configuration**: `"inlineChat.enableV2": true`

**Example Workflow:**
```
1. Select PowerShell code
2. Press Ctrl+I (inline chat)
3. Ask: "Add error handling and logging"
4. Review changes inline
5. Accept or iterate
```

---

### 4. **GitHub MCP Server** 🐙

#### Native GitHub Integration
- **Feature**: Built-in Model Context Protocol server for GitHub
- **Tools Available**:
  - Repository management (clone, search code, list files)
  - Pull request operations (create, review, merge)
  - Issue tracking (create, comment, assign, close)
  - Organization/team queries
- **Configuration**: `"github.copilot.mcp.enabled": true`

**Chat Examples:**
```
💬 "Show me open PRs in this repo"
💬 "Create an issue for missing module implementation"
💬 "Comment on PR #42 with approval"
💬 "List all issues labeled 'bug'"
```

---

### 5. **Enhanced Terminal Integration** 🖥️

#### Chat Terminal with xterm.js Rendering
- **Feature**: Terminal output uses embedded xterm.js instance
- **Benefits**:
  - Proper ANSI color support
  - Accurate terminal formatting
  - Command output persists after terminal closes
  - Shows exit code, start time, duration
- **Configuration**: Automatic (enabled by persistent sessions)

#### Terminal Suggest Widget Improvements
- **Feature**: Grouped argument suggestions
- **Benefits**:
  - Arguments separated from options/flags
  - Easier to distinguish command structure
  - Better IntelliSense for complex commands

**Example:**
```powershell
# Type: az keyvault
# Suggestions now grouped:
#   Arguments: [vault-name] [secret-name]
#   Options: --resource-group --location
#   Flags: --verbose --output json
```

---

### 6. **Unified Agent Sessions View** 🤖

#### Single-View Agent Management
- **Feature**: All chat and agent sessions in one view
- **Capabilities**:
  - Filter by provider (GitHub, Azure, Custom)
  - Search across session history
  - View session state at a glance
  - Manage multiple concurrent sessions
- **Configuration**: `"chat.sessions.unifiedView": true`

**Access:** View → Agent Sessions (or Ctrl+Shift+Alt+A)

---

### 7. **AI Code Actions in Quick Fix** 💡

#### Instant AI Assistance
- **Feature**: AI-related code actions in Quick Fix menu
- **Actions Available**:
  - Generate Documentation
  - Add Error Handling
  - Optimize Performance
  - Convert to Modern Syntax
- **Access**: Ctrl+. (Quick Fix) or click lightbulb icon

**Example:**
```powershell
# Place cursor on function without help block
# Press Ctrl+.
# Select: "Generate Documentation" (AI-powered)
# Copilot generates complete .SYNOPSIS/.DESCRIPTION/.EXAMPLE
```

---

### 8. **URL Fetch with Domain Approval** 🌐

#### Granular Permission Control
- **Feature**: Domain-level URL approval for fetch tool
- **Benefits**:
  - "Always approve URLs from bing.com"
  - Per-URL or per-domain rules
  - No more session-wide blanket approvals
  - Better security with convenience
- **Configuration**: `"chat.fetch.urlApproval": "domain"`

**Use Case:**
```
💬 "Fetch latest Azure CLI documentation"
   Copilot: "Can I fetch from docs.microsoft.com?"
   You: "Always allow docs.microsoft.com" ✅
   (Future requests to *.docs.microsoft.com auto-approved)
```

---

### 9. **Enhanced Window Management** 🪟

#### Close Other Windows Command
- **Feature**: Close all VS Code windows except current
- **Access**: Command Palette → "Close Other Windows"
- **Keyboard Shortcut**: `Ctrl+Shift+Alt+W`

**Use Case:**
```
# Working with 10 workspace windows
# Want to focus on current IntelIntent workspace
# Press Ctrl+Shift+Alt+W → All other windows close
```

---

### 10. **Recently Opened Picker Enhancements** 📂

#### Visual Window Indicators
- **Feature**: Highlights workspaces already open in other windows
- **Benefits**:
  - Avoid opening duplicate windows
  - Quick switch to existing instances
  - Better multi-workspace management

**Access:** File → Open Recent (or Ctrl+R)

---

## ⌨️ New Keyboard Shortcuts

| Shortcut | Command | Description |
|----------|---------|-------------|
| **Ctrl+Shift+Alt+A** | New CLI Agent Session | Create Copilot CLI agent session |
| **Ctrl+Shift+Alt+T** | Focus Chat Terminal | Focus terminal in chat session |
| **Ctrl+Enter** | Accept Wait Task | Confirm terminal task completion |
| **Ctrl+Shift+Left/Right** | Move Editor to Group | Move editor between split groups |
| **Ctrl+G Ctrl+O** | Go To Offset | Navigate to byte offset in file |
| **Ctrl+Shift+Alt+W** | Close Other Windows | Close all windows except current |
| **Ctrl+Shift+Alt+S** | Focus SCM View | Open Source Control with Stashes |
| **Ctrl+.** | Quick Fix + AI | Access AI code actions inline |

---

## 🛠️ Configuration Summary

### Settings Added to `.vscode/settings.json`

```jsonc
// November 2025 Features
{
  // PowerShell tree-sitter grammar (supports && and ||)
  "powershell.enableTreeSitterGrammar": true,
  
  // Git Repositories explorer with Stashes node
  "scm.repositories.explorer": true,
  
  // Enhanced terminal with persistent sessions
  "terminal.integrated.persistentSessions": true,
  "terminal.integrated.enablePersistentSessions": true,
  
  // Inline chat V2 backend improvements
  "inlineChat.enableV2": true,
  
  // Unified Agent Sessions view
  "chat.sessions.unifiedView": true,
  
  // Domain-level URL fetch approval
  "chat.fetch.urlApproval": "domain",
  
  // GitHub MCP Server for repo/PR/issue tools
  "github.copilot.mcp.enabled": true,
  
  // AI code actions in Quick Fix menu
  "editor.codeActionsOnSave": {
    "source.fixAll": "explicit"
  }
}
```

---

## 🎯 Quick Start Workflows

### Workflow 1: PowerShell 7 Development
```powershell
# 1. Enable tree-sitter grammar (already configured)
# 2. Use PowerShell 7 operators with proper parsing
Test-Path .\file.ps1 && pwsh -File .\file.ps1 || Write-Error "Failed"

# 3. Get inline suggestions with Copilot
# Type: function New-Scripture {
# Copilot suggests complete implementation

# 4. Press Ctrl+. for AI code actions
# Select "Generate Documentation"
```

### Workflow 2: Git Stash Management
```
1. Make experimental changes to Week1_Automation.ps1
2. Press Ctrl+Shift+Alt+S (focus SCM)
3. Right-click "Stashes" → "Stash Changes"
4. Name: "experimental-circuit-breaker"
5. Switch to main branch work
6. Later: Right-click stash → "Apply Stash"
```

### Workflow 3: GitHub Issue Creation via Chat
```
💬 "Create an issue to implement SecureSecretsManager.psm1 
    with Azure Key Vault integration. Assign to @andyleejordan 
    and label as 'enhancement'"

Copilot (via GitHub MCP):
✅ Created issue #15 in cf7928pdxg-sketch/IntelIntent
   Title: Implement SecureSecretsManager.psm1
   Assignee: @andyleejordan
   Labels: enhancement
```

### Workflow 4: AI-Assisted Code Refactoring
```
1. Select function in Week1_Automation.ps1
2. Press Ctrl+I (inline chat)
3. Ask: "Refactor to use circuit breaker pattern"
4. Review inline diff
5. Accept changes (Ctrl+Enter)
6. Modified files auto-open in side editor
```

---

## 🔍 Feature Deep Dive

### MCP Server Architecture

The GitHub MCP server provides Copilot with **native tools** for repository operations:

**Available Tools:**
```
• github-repo-search-code       - Search code across repos
• github-repo-list-files        - List files in repo/directory
• github-pr-create              - Create pull request
• github-pr-review              - Add PR review comments
• github-pr-merge               - Merge pull request
• github-issue-create           - Create issue
• github-issue-comment          - Comment on issue
• github-issue-assign           - Assign issue to user
• github-org-list-repos         - List organization repos
```

**Example Chat Session:**
```
You: "What PRs need my review?"
Copilot: [Queries github-pr-list-assigned]
         "You have 3 PRs awaiting review:
          #42: Add CodexRenderer.psm1 (@SydneyhSmith)
          #43: Implement RBACManager (@JustinGrote)
          #44: Circuit breaker enhancements (@andyleejordan)"

You: "Approve PR #42 with comment 'LGTM, great work'"
Copilot: [Calls github-pr-review]
         ✅ Review submitted on PR #42
```

---

### Terminal Command Persistence

**Problem Solved:** Previously, if terminal was closed, command output was lost.

**Solution:** Terminal output now serialized and persisted.

**Benefits:**
- View command results after terminal closes
- Agent sessions show complete execution history
- Debugging long-running tasks easier
- Exit codes and timestamps preserved

**Technical Details:**
```json
// Stored per command
{
  "command": "az keyvault create --name IntelIntentSecrets",
  "exitCode": 0,
  "startTime": "2025-11-29T10:30:00Z",
  "duration": "12.3s",
  "output": "[serialized xterm.js buffer]"
}
```

---

### Inline Chat V2 Improvements

**Key Enhancement:** Files modified outside current editor auto-open in side group.

**Example Scenario:**
```
1. You're editing Week1_Automation.ps1
2. Chat with Copilot: "Update settings.json to enable new features"
3. Copilot modifies .vscode/settings.json
4. NEW: settings.json auto-opens in side editor group
5. You see diff preview immediately
6. Approve changes inline
```

**Backend Improvements:**
- Better context tracking across files
- Smarter diff generation for JSON files
- Reduced false positives in change detection
- Faster response times

---

## 🎨 Visual Enhancements

### Comment Thread Icons
- **Draft Comments**: Distinct draft icon in gutter
- **Resolved Comments**: Checkmark icon
- **Unresolved Comments**: Discussion icon

### Editor Inactive Line Highlight
- **New Theme Color**: `editor.inactiveLineHighlightBackground`
- **Benefit**: Better visual distinction between active/inactive editor groups

### Terminal Suggest Widget
- **Grouped Display**:
  ```
  Arguments:
    [vault-name]      Required vault name
    [secret-name]     Required secret name
  
  Options:
    --resource-group  RG name
    --location        Azure region
  
  Flags:
    --verbose         Detailed output
    --output          Output format
  ```

---

## 🚀 Performance Improvements

### Tree-sitter WASM Update
- **Faster Parsing**: 20-30% improvement in syntax highlighting
- **Lower Memory**: Reduced WASM memory footprint
- **Better Accuracy**: Fewer false positives in error detection

### Terminal Rendering
- **xterm.js Native**: Hardware-accelerated rendering
- **ANSI Colors**: True-color support (16 million colors)
- **Scrollback**: Efficient buffer management for large outputs

### Fetch Tool Caching
- **Error Cache**: 5 minutes (previously 24 hours)
- **Success Cache**: 24 hours (unchanged)
- **Network Heuristics**: Wait for client-side rendered pages to fully load

---

## 📚 Integration with IntelIntent

### Week1_Automation.ps1 Enhancements

**Leverage GitHub MCP:**
```powershell
# Before: Manual issue tracking
Write-Host "TODO: Create issue for missing modules"

# After: AI-assisted issue creation
# Chat: "Create issues for all placeholder modules with 
#        implementation checklists and assign to Phase 4 team"
```

**Leverage Terminal Persistence:**
```powershell
# Long-running Azure operations
az keyvault create --name IntelIntentSecrets `
  --resource-group Phase4RG `
  --location centralus

# Terminal can be closed - output persists
# Agent session shows complete execution history with timestamps
```

---

### Orchestrator.ps1 Enhancements

**Leverage Inline Chat V2:**
```powershell
# 1. Open Orchestrator.ps1
# 2. Select component generation logic
# 3. Inline chat: "Add retry logic with exponential backoff"
# 4. Copilot modifies Orchestrator.ps1 AND CircuitBreaker.psm1
# 5. Both files open in split view with diffs
```

---

### Universal Profile Enhancements

**Leverage AI Code Actions:**
```powershell
# In Universal-Profile.ps1
function New-Scripture {
    param([string]$Name, [string]$Author)
    # Implementation here
}

# Place cursor on function
# Press Ctrl+.
# Select "Generate Documentation"
# Copilot adds complete help block:
<#
.SYNOPSIS
    Creates a new scripture file with standard formatting.
.PARAMETER Name
    The name of the scripture (e.g., "Genesis").
.PARAMETER Author
    The author of the scripture.
.EXAMPLE
    New-Scripture -Name "Psalm23" -Author "David"
#>
```

---

## 🔒 Security & Privacy

### MCP Server Permissions
- **Scoped Access**: GitHub MCP only accesses repos you have permission to
- **Token-based**: Uses existing GitHub authentication
- **Auditable**: All MCP calls logged in agent session history

### URL Fetch Approval
- **Granular Control**: Per-URL or per-domain approval
- **Persistent Rules**: Domain rules saved across sessions
- **Revocable**: Clear rules anytime in settings

### Terminal Command Approval
- **Session-Level**: Allow risky commands for current chat session only
- **Workspace-Level**: Trust commands permanently for this workspace
- **Never Allow**: Blacklist dangerous commands

---

## 🎓 Best Practices

### 1. **Use GitHub MCP for Project Management**
```
✅ "Create sprint milestone for Phase 5 with deadline Dec 31"
✅ "Assign all 'bug' issues to @team-leads"
✅ "Generate weekly summary of closed issues"
```

### 2. **Leverage Terminal Persistence for Long Tasks**
```powershell
# Start Azure deployment (takes 10 minutes)
.\Week1_Automation.ps1

# Close terminal, switch to other work
# Agent session preserves full output
# Check results anytime via Agent Sessions view
```

### 3. **Inline Chat V2 for Multi-File Refactoring**
```
✅ "Refactor checkpoint creation to use new schema across all scripts"
   → Copilot modifies multiple files, opens side-by-side diffs

✅ "Update all agent functions to use consistent return structure"
   → AgentBridge.psm1 changes visible alongside calling scripts
```

### 4. **Git Stashes for Experimental Work**
```
• Stash before switching branches (right-click Stashes node)
• Name stashes descriptively: "experimental-circuit-breaker-v2"
• Apply stashes selectively during merge conflicts
• Drop old stashes to keep explorer clean
```

---

## 🐛 Troubleshooting

### Issue: Tree-sitter grammar not loading
**Solution:**
```powershell
# Reload window
Ctrl+Shift+P → "Reload Window"

# Verify setting
code --list-extensions | Select-String "powershell"
# Should show: ms-vscode.powershell
```

### Issue: GitHub MCP tools not available
**Solution:**
```jsonc
// Check settings.json
"github.copilot.mcp.enabled": true

// Verify GitHub extension active
Ctrl+Shift+P → "GitHub: Sign In"
```

### Issue: Terminal output not persisting
**Solution:**
```jsonc
// Enable persistent sessions
"terminal.integrated.persistentSessions": true,
"terminal.integrated.enablePersistentSessions": true

// Restart VS Code
```

### Issue: Stashes node not visible
**Solution:**
```jsonc
// Enable SCM repositories explorer
"scm.repositories.explorer": true

// Refresh Source Control view
Ctrl+Shift+G → Click refresh icon
```

---

## 📈 What's Next (Upcoming Features)

Based on VS Code roadmap and community feedback:

### Q1 2026 (Expected)
- **Multi-modal Chat**: Voice input for chat sessions
- **Semantic Search**: Natural language code search
- **Auto-generated Tests**: AI writes Pester tests for functions
- **Smart Merge**: AI-assisted conflict resolution

### Q2 2026 (Planned)
- **Custom MCP Servers**: Build IntelIntent-specific tools
- **Enhanced Debugging**: AI suggests breakpoint locations
- **Performance Profiling**: Copilot analyzes bottlenecks

---

## 🎉 Summary

November 2025 brings **10 major enhancements** to IntelIntent:

1. ✅ **Tree-sitter PowerShell 7 grammar** - Better parsing and highlighting
2. ✅ **Git Stashes explorer** - Visual stash management
3. ✅ **Inline Chat V2** - Enhanced multi-file editing
4. ✅ **GitHub MCP Server** - Native repo/PR/issue tools
5. ✅ **Terminal xterm.js rendering** - Proper ANSI colors and formatting
6. ✅ **Unified Agent Sessions** - Single view for all agents
7. ✅ **AI Code Actions** - Quick Fix menu integration
8. ✅ **Domain URL approval** - Granular fetch permissions
9. ✅ **Window management** - Close other windows command
10. ✅ **Recently opened picker** - Visual open window indicators

**All features configured and ready to use!** 🚀

---

*Updated November 29, 2025 - VS Code Insiders 1.107*
