# GitHub Copilot Quick Command Reference

## 🎯 Essential Copilot Commands

### Chat Commands
```
Ctrl+Alt+I        Open GitHub Copilot Chat
Ctrl+I            Open Inline Chat V2 (edit current file)
Ctrl+.            AI Code Actions (Quick Fix menu)
```

### Chat Slash Commands
```
/explain          Explain selected code
/fix              Suggest fixes for problems
/tests            Generate unit tests
/doc              Add documentation comments
/clear            Clear chat history
/help             Show all available commands
```

### Workspace Queries (Use @ symbol)
```
@workspace How do checkpoints work in IntelIntent?
@workspace Show me the agent orchestration pattern
@workspace What's the DryRun safety pattern?
@workspace How do I create a new Azure operation?
@workspace Explain the manifest-guided generation flow
```

### File Context Queries
```
#file:Week1_Automation.ps1 Explain the checkpoint creation pattern
#file:AgentBridge.psm1 How does agent routing work?
```

---

## 🔍 Project-Specific Prompts

### For Code Generation
```
"Create a new checkpoint task following the Invoke-TaskWithCheckpoint pattern"
"Add Azure Key Vault secret storage with checkpoint tracking"
"Implement circuit breaker pattern for Microsoft Graph API call"
"Generate Pester tests for this module following project conventions"
```

### For Code Review
```
"Does this follow IntelIntent checkpoint patterns?"
"Validate this module import against project standards"
"Check if this agent return structure is correct"
"Is the DryRun pattern implemented correctly here?"
```

### For Architecture Questions
```
"How does checkpoint data flow to Power BI?"
"What's the difference between Add-Checkpoint and Invoke-TaskWithCheckpoint?"
"Explain the agent-based orchestration architecture"
"How does manifest-guided generation work?"
```

### For Refactoring
```
"Convert this to use SecureSecretsManager module pattern"
"Add graceful module import with error handling"
"Refactor to include DryRun support"
"Add checkpoint creation for this Azure operation"
```

---

## 🛠️ VS Code Tasks (Copilot-Aware)

### Run from Command Palette (Ctrl+Shift+P)
```
Tasks: Run Task → Week1: Run DryRun Mode
Tasks: Run Task → Orchestrator: Validate Manifests
Tasks: Run Task → Pester: Run All Tests
Tasks: Run Task → Azure: Validate Connection
Tasks: Run Task → Module: Check Missing Modules
```

### Quick Keyboard Shortcuts
```
Ctrl+Shift+B      Run default build task (Week1 DryRun)
Ctrl+Shift+P      Command Palette
Ctrl+`            Toggle Terminal
```

---

## 📋 Common Development Patterns

### Pattern 1: Add New Azure Operation
```powershell
Invoke-TaskWithCheckpoint `
    -TaskID "PREFIX-NNN" `
    -Description "Description of operation" `
    -ScriptBlock {
        if ($DryRun) {
            Write-Host "  [DRY RUN] Would create resource: $resourceName" -ForegroundColor Yellow
            return $null
        }
        
        # Azure operation
        az resource create --name $Name --resource-group $RG
        
        return $result
    } `
    -Inputs @{ Name = $Name; ResourceGroup = $RG } `
    -Artifacts @($Name)
```

**Copilot Prompt:** "Add Azure Key Vault creation with checkpoint following IntelIntent pattern"

### Pattern 2: Import Module Safely
```powershell
Import-Module .\IntelIntent_Seeding\ModuleName.psm1 -Force -ErrorAction SilentlyContinue

if (Get-Command Function-Name -ErrorAction SilentlyContinue) {
    Function-Name -Parameter "value"
} else {
    Write-Warning "ModuleName.psm1 not found, skipping"
}
```

**Copilot Prompt:** "Import SecureSecretsManager module following project safety pattern"

### Pattern 3: Create New Agent Function
```powershell
function Invoke-NewAgent {
    <#
    .SYNOPSIS
        Brief description
    
    .PARAMETER Operation
        Operation name
    
    .PARAMETER Data
        Operation data
    
    .EXAMPLE
        Invoke-NewAgent -Operation "Action" -Data @{ Key = "Value" }
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Operation,
        
        [hashtable]$Data = @{}
    )
    
    # Log agent call
    $script:AgentContext.CallHistory += @{
        Agent = "NewAgent"
        Operation = $Operation
        Timestamp = Get-Date
    }
    
    # Implementation
    try {
        # ... operation logic ...
        
        return @{
            Status = "Success"
            Agent = "NewAgent"
            Operation = $Operation
            Result = @{ /* data */ }
        }
    }
    catch {
        return @{
            Status = "Error"
            Agent = "NewAgent"
            Operation = $Operation
            Error = $_.Exception.Message
        }
    }
}
```

**Copilot Prompt:** "Create a new ValidationAgent following AgentBridge pattern"

### Pattern 4: Create Manifest Component
```json
{
  "id": "PREFIX-NNN",
  "title": "Component Title",
  "description": "Detailed description",
  "category": "Category_Name",
  "priority": 5,
  "status": "not-started",
  "dependencies": ["ENV-001", "ENV-002"],
  "tags": ["tag1", "tag2"],
  "estimatedDuration": "10 minutes",
  "semanticTrigger": {
    "type": "trigger-type",
    "condition": "When to trigger",
    "verification": "Test-Function",
    "agentRoute": "AgentName"
  }
}
```

**Copilot Prompt:** "Add a new component to sample_manifest.json for Azure RBAC configuration"

---

## 🧪 Testing Prompts

### Generate Tests
```
"Generate Pester tests for SecureSecretsManager module"
"Create integration tests for Week1_Automation.ps1 DryRun mode"
"Add unit tests for Invoke-OrchestratorAgent function"
```

### Validate Tests
```
"Check if these tests follow IntelIntent conventions"
"Validate Pester test structure against project patterns"
```

---

## 📚 Documentation Prompts

### Generate Documentation
```
"Add comprehensive help documentation to this function"
"Generate README for this module following project style"
"Create docstring following PowerShell standards"
```

### Update Documentation
```
"Update copilot-workspace-context.md with this new pattern"
"Add this module to the implementation status section"
```

---

## 🎨 Advanced Copilot Features (November 2025)

### Multi-File Editing (Inline Chat V2)
```
1. Select code in multiple files
2. Ctrl+I
3. "Refactor all selected code to use new checkpoint pattern"
4. Copilot edits all files at once
```

### AI Code Actions
```
1. Place cursor on problematic code
2. Ctrl+.
3. See AI-suggested fixes specific to IntelIntent patterns
```

### GitHub MCP Server Tools
```
"@github Create an issue for implementing RBACManager module"
"@github Show open PRs related to checkpoint patterns"
"@github Search repository for DryRun pattern usage"
```

---

## 🚨 Troubleshooting Commands

### Verify Setup
```powershell
# Check PowerShell version
$PSVersionTable.PSVersion

# Check Azure CLI
az --version

# Verify module imports
Get-Module -ListAvailable | Where-Object Name -like "*IntelIntent*"

# Test Copilot tracking
Import-Module .\IntelIntent_Seeding\CopilotLifecycleTracker.psm1
Get-CopilotContext
```

### Common Fixes
```
"Fix this module import to use -ErrorAction SilentlyContinue"
"Add missing checkpoint creation to this Azure operation"
"Correct this agent return structure"
"Add DryRun check before this destructive operation"
```

---

## 📊 Metrics Prompts

### Copilot Usage Tracking
```
"Show current Copilot lifecycle session"
"Export Copilot metrics for Power BI"
"Log this Copilot command invocation"
```

---

## 🎯 Workflow Shortcuts

### Start Development Session
```powershell
# 1. Open key context files
code .github/copilot-instructions.md
code .vscode/copilot-workspace-context.md
code Week1_Automation.ps1
code IntelIntent_Seeding/AgentBridge.psm1

# 2. Start Copilot tracking
Import-Module .\IntelIntent_Seeding\CopilotLifecycleTracker.psm1
Add-CopilotLifecycleEvent -Action "Enable" -Reason "Starting development"

# 3. Validate environment
.\Verify-DevelopmentEnvironment.ps1
```

### End Development Session
```powershell
# 1. Export Copilot metrics
Export-CopilotLifecycleForPowerBI -OutputPath ".\Sponsors\Session_$(Get-Date -Format 'yyyyMMdd_HHmmss').json"

# 2. Run tests
Invoke-Pester -Output Detailed

# 3. Validate changes
git status
git diff
```

---

## 💡 Pro Tips

1. **Keep Context Files Open**: Copilot uses open tabs for context. Keep these open:
   - `.github/copilot-instructions.md`
   - `.vscode/copilot-workspace-context.md`
   - Current working file

2. **Use @workspace**: Always prefix architecture questions with `@workspace`

3. **Use #file**: Reference specific files for targeted suggestions

4. **Leverage Inline Chat V2**: For quick edits, use `Ctrl+I` instead of full chat

5. **Check AI Code Actions**: Before manually fixing issues, try `Ctrl+.`

6. **Comment Intent**: Write comments describing what you want, let Copilot generate code

7. **Review Suggestions**: Always review Copilot suggestions for pattern compliance

8. **Use DryRun**: Test all automation with `-DryRun` flag first

---

## 🔗 Quick Links

- **Master Instructions**: `.github/copilot-instructions.md` (2,076 lines)
- **Workspace Context**: `.vscode/copilot-workspace-context.md` (300+ lines)
- **Setup Guide**: `.vscode/COPILOT_SETUP_COMPLETE.md`
- **Architecture**: `PHASE4_ARCHITECTURE_DIAGRAM.md`
- **Workflow**: `WORKFLOW_MAP.md`
- **Implementation**: `WEEK1_IMPLEMENTATION_CHECKLIST.md`

---

**Last Updated**: November 30, 2025  
**Quick access**: Keep this file pinned in VS Code for instant reference!
