# IntelIntent Phase 2: Nervous System Activation

## 🧠 Quick Start for Developers

IntelIntent Phase 2 transforms skeletal structure into a living orchestration system through intelligent manifest reading, semantic routing, and automated component generation.

---

## 📦 What's New in Phase 2

### Core Components

1. **ManifestReader.ps1** - Manifest loading and parsing engine
2. **AgentBridge.psm1** - Specialized AI agent bridge functions
3. **Orchestrator.ps1** - Central orchestration and component generation
4. **sample_manifest.json** - Reference manifest with 16 components

### Capabilities Unlocked

- ✅ Automatic component generation from manifest files
- ✅ Priority-based execution queue with dependency awareness
- ✅ Semantic routing to specialized agents (Finance, Identity, Deployment, etc.)
- ✅ Checkpoint-based progress tracking with recovery
- ✅ Session management and audit logging

---

## 🚀 Running the Orchestrator

### Basic Usage

```powershell
# Navigate to project root
cd "C:\Users\BOOPA\OneDrive\IntelIntent!"

# Execute full pipeline
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode Full -Verbose
```

### Execution Modes

| Mode | Description | Use Case |
|------|-------------|----------|
| `Full` | Complete pipeline (manifest → generation → validation) | Production execution |
| `ManifestOnly` | Load and validate manifests without generation | Testing manifest integrity |
| `GenerateOnly` | Generate components from existing queue | Incremental component creation |
| `ValidateOnly` | Validate existing components and checkpoints | Post-generation verification |

### Advanced Options

```powershell
# Preview without file modification
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode Full -DryRun

# Generate specific category only
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode GenerateOnly -Category "Identity_Modules"

# Verbose output for debugging
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode Full -Verbose
```

---

## 📖 Working with Manifests

### Supported Manifest Files

Located in `IntelIntent-Seed/`:

- `creator_of_creators_checklist.json` - Main project plan
- `creator_of_creators_gap_analysis.json` - Gap analysis
- `creator_of_creators_recursive_plan.json` - Recursive execution plan
- `Fluent2_Interface_Deployment_Checklist.json` - UI components
- `intelintent_precursive_table.txt` - Precursive modules (-000.x)
- `intelintent_recursive_table.txt` - Recursive CoE components (001-599)
- `sample_manifest.json` - Reference implementation

### Manifest Structure Example

```json
{
  "id": "ENV-001",
  "title": "Environment Variable Configuration",
  "category": "Environment_Setup",
  "priority": 1,
  "status": "not-started",
  "dependencies": [],
  "semanticTrigger": {
    "type": "prerequisite",
    "verification": "Test-Path env:INTELINTENT_HOME",
    "agentRoute": "OrchestratorAgent"
  }
}
```

### Key Fields

- **id**: Unique component identifier (e.g., `ENV-001`, `ID-002`)
- **title**: Human-readable component name
- **category**: Module category (maps to directory structure)
- **priority**: Execution order (1 = highest priority)
- **dependencies**: Array of prerequisite component IDs
- **semanticTrigger**: Routing and verification metadata

---

## 🤖 Using Agent Bridge

### Import Module

```powershell
Import-Module .\IntelIntent_Seeding\AgentBridge.psm1 -Force
```

### Agent Functions

#### OrchestratorAgent (Semantic Routing)

```powershell
$result = Invoke-OrchestratorAgent -Intent "Generate investment portfolio report"
# Output: 🤖 OrchestratorAgent: Routed to FinanceAgent (Confidence: 0.8)
```

#### FinanceAgent

```powershell
$result = Invoke-FinanceAgent -Operation "Portfolio" -Data @{
    UserID = "investor1"
    Action = "GetHoldings"
}
```

#### IdentityAgent

```powershell
$result = Invoke-IdentityAgent -Operation "EmailOrchestration" `
    -UserEmail "user@example.com" `
    -Data @{Action = "SendWelcome"}
```

#### DeploymentAgent

```powershell
$result = Invoke-DeploymentAgent -Operation "Provision" `
    -Environment "Development" `
    -Config @{Region = "EastUS"}
```

### Session Management

```powershell
# Get current session context
$context = Get-AgentContext
$context.CallHistory | Format-Table Timestamp, Agent, Operation

# Export session logs
Export-AgentLogs -OutputPath ".\Logs\session_$(Get-Date -Format 'yyyyMMdd_HHmmss').json"

# Reset session (new SessionID)
Clear-AgentContext
```

---

## 🧪 Testing & Validation

### Step-by-Step Test Sequence

```powershell
# 1. Test manifest reader
. .\IntelIntent_Seeding\ManifestReader.ps1
$manifests = Get-AllManifests
Test-ManifestIntegrity -Manifests $manifests

# 2. Build execution queue
$queue = Get-ComponentQueue -Manifests $manifests
$queue | Format-Table ID, Title, Priority, Category

# 3. Test agent bridge
Import-Module .\IntelIntent_Seeding\AgentBridge.psm1
$result = Invoke-OrchestratorAgent -Intent "Test routing"

# 4. Dry run orchestrator
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode Full -DryRun

# 5. Full execution
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode Full -Verbose

# 6. Verify outputs
Get-ChildItem -Path . -Filter "*_component.ps1" -Recurse | Measure-Object
Get-ChildItem -Path . -Filter "*_checkpoint.txt" -Recurse | Select-Object FullName
```

### Expected Outputs

✅ **Manifest Loading:**
```
📖 Loading IntelIntent manifests...
  ✅ Loaded 6 of 6 manifests
```

✅ **Queue Building:**
```
🎯 Building component execution queue...
  ✅ Queue built: 16 components
```

✅ **Component Generation:**
```
[1/16] (6.3%) Generating: Environment Variable Configuration
  ✅ Generated: .\Environment_Setup\ENV-001_component.ps1
```

✅ **Validation:**
```
🔍 Phase 4: Component Validation
  ✅ ENV-001: Valid
  ✅ ENV-002: Valid
  ...
  Validation Summary: 16 / 16 components valid
```

---

## 🏗️ Generated Component Structure

Each generated component follows this template:

```powershell
# PowerShell Component: Environment Variable Configuration
# Category: Environment_Setup
# ID: ENV-001
# Priority: 1
# Generated: 2025-11-26 14:35:22
# Session: a7b3c2d1-e4f5-6789-abcd-ef1234567890

<#
.SYNOPSIS
    Environment Variable Configuration

.DESCRIPTION
    Generated component for Environment_Setup module.
    This is a placeholder awaiting recursive implementation.
#>

Write-Output "Executing component: Environment Variable Configuration"
Write-Output "  Category: Environment_Setup"
Write-Output "  ID: ENV-001"

# === Component Logic ===
Write-Output "  ⚠️ Status: Placeholder - Awaiting implementation"

# === Agent Integration (Optional) ===
# Import-Module "$PSScriptRoot\..\IntelIntent_Seeding\AgentBridge.psm1" -Force
# $result = Invoke-OrchestratorAgent -Intent "Environment Variable Configuration" -Context @{ComponentID = "ENV-001"}

# === Checkpoint Creation ===
$checkpointDir = ".\Environment_Setup\Recursive_Operations"
if (-not (Test-Path $checkpointDir)) {
    New-Item -ItemType Directory -Path $checkpointDir -Force | Out-Null
}

$checkpointPath = "$checkpointDir\ENV-001_checkpoint.txt"
$checkpointData = @{
    ComponentID = "ENV-001"
    Title = "Environment Variable Configuration"
    Category = "Environment_Setup"
    CompletedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Status = "Generated"
}

Set-Content -Path $checkpointPath -Value ($checkpointData | ConvertTo-Json)

Write-Output "  ✅ Component completed"
Write-Output "  📄 Checkpoint: $checkpointPath"
```

---

## 📊 Progress Tracking

### Orchestrator Checkpoint

Located at: `IntelIntent_Seeding\Recursive_Operations\orchestrator_checkpoint.json`

```json
{
  "SessionID": "a7b3c2d1-e4f5-6789-abcd-ef1234567890",
  "StartTime": "2025-11-26 14:35:00",
  "EndTime": "2025-11-26 14:37:15",
  "Mode": "Full",
  "Category": "",
  "Progress": {
    "Total": 16,
    "Completed": 14,
    "Failed": 0,
    "Skipped": 2
  },
  "GeneratedComponents": [...],
  "FailedComponents": []
}
```

### Component Checkpoint

Located at: `{Category}\Recursive_Operations\{ID}_checkpoint.txt`

```json
{
  "ComponentID": "ENV-001",
  "Title": "Environment Variable Configuration",
  "Category": "Environment_Setup",
  "CompletedAt": "2025-11-26 14:35:22",
  "Status": "Generated"
}
```

---

## 🔧 Troubleshooting

### Common Issues

#### "Manifest not found"

```powershell
# Verify IntelIntent-Seed directory structure
Test-Path ".\IntelIntent-Seed\creator_of_creators_checklist.json"
Test-Path ".\IntelIntent-Seed\sample_manifest.json"

# Check current directory
Get-Location
# Should be: C:\Users\BOOPA\OneDrive\IntelIntent!
```

#### "Module not found"

```powershell
# Use absolute paths
$scriptPath = "C:\Users\BOOPA\OneDrive\IntelIntent!\IntelIntent_Seeding"
Import-Module "$scriptPath\AgentBridge.psm1" -Force
```

#### "Component already exists (skipped)"

```powershell
# Option 1: Delete existing components
Remove-Item ".\Identity_Modules\ID-001_component.ps1" -Force

# Option 2: Run validation only
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode ValidateOnly
```

#### "Permission denied (checkpoint creation)"

```powershell
# Run PowerShell as Administrator
# Or adjust execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 📁 Directory Structure After Phase 2

```
IntelIntent!/
├── IntelIntent_Seeding/
│   ├── ManifestReader.ps1          # NEW: Manifest parsing engine
│   ├── AgentBridge.psm1            # NEW: Agent bridge functions
│   ├── Orchestrator.ps1            # NEW: Central orchestration
│   ├── IntelIntent_Seeding.ps1     # Enhanced with orchestration
│   └── Recursive_Operations/
│       ├── checkpoint.txt          # Traditional checkpoint
│       └── orchestrator_checkpoint.json  # NEW: Session state
│
├── IntelIntent-Seed/
│   ├── sample_manifest.json        # NEW: Reference manifest
│   ├── creator_of_creators_checklist.json
│   ├── intelintent_precursive_table.txt
│   └── intelintent_recursive_table.txt
│
├── Environment_Setup/              # Generated components
│   ├── ENV-001_component.ps1       # NEW: Generated
│   ├── ENV-002_component.ps1       # NEW: Generated
│   └── Recursive_Operations/
│       ├── ENV-001_checkpoint.txt  # NEW: Component checkpoint
│       └── ENV-002_checkpoint.txt
│
├── Identity_Modules/               # Generated components
│   ├── ID-001_component.ps1
│   ├── ID-002_component.ps1
│   └── Recursive_Operations/
│       ├── ID-001_checkpoint.txt
│       └── ID-002_checkpoint.txt
│
└── [Additional categories...]
```

---

## 🎯 Next Steps

### Immediate Actions

1. **Test Phase 2 Components**
   ```powershell
   .\IntelIntent_Seeding\Orchestrator.ps1 -Mode Full -Verbose
   ```

2. **Review Generated Components**
   ```powershell
   Get-ChildItem -Path . -Filter "*_component.ps1" -Recurse
   ```

3. **Validate Checkpoints**
   ```powershell
   Get-ChildItem -Path . -Filter "*_checkpoint.txt" -Recurse | 
       ForEach-Object { Get-Content $_.FullName | ConvertFrom-Json }
   ```

### Phase 3 Preview

**Agent Implementation:**
- Microsoft Graph API integration for IdentityAgent and FinanceAgent
- Azure Functions/Containers deployment for DeploymentAgent
- Multi-modal input processing for ModalityAgent

**Semantic Analysis:**
- Replace keyword-based routing with NLP semantic analysis
- Implement confidence thresholds and fallback routing

**Fluent 2 Interface:**
- Real-time component generation progress visualization
- Agent call graph and execution flow diagram
- Interactive dependency graph explorer

---

## 📚 Additional Resources

- **Full Documentation:** `.github/copilot-instructions.md`
- **Phase 1 Healing:** 8 phase scripts with corrected checkpoint paths
- **Sample Manifest:** `IntelIntent-Seed/sample_manifest.json`
- **Agent Reference:** `IntelIntent_Seeding/AgentBridge.psm1` inline documentation

---

## 💬 Support & Contribution

**Issues or Questions?**
- Review `.github/copilot-instructions.md` for architectural details
- Check orchestrator checkpoint JSON for session diagnostics
- Export agent logs for debugging: `Export-AgentLogs -OutputPath ".\Logs\debug.json"`

**Contributing Components:**
1. Add component definition to manifest JSON
2. Run orchestrator in `GenerateOnly` mode
3. Implement component logic in generated file
4. Update checkpoint status to "completed"

---

**IntelIntent Phase 2: Nervous System Activated** 🧠✨

_Transforming divine vision into recursive reality through intelligent orchestration._
