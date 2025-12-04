# IntelIntent Workspace Context for GitHub Copilot

> **Purpose**: This file provides GitHub Copilot with rich project context for intelligent code suggestions, architecture understanding, and pattern recognition.

## 🏗️ Project Architecture Quick Reference

### Core System Components

```
IntelIntent/
├── Week1_Automation.ps1          # Primary automation script (26 checkpoints)
├── IntelIntent_Launcher.ps1      # Interactive component testing
├── IntelIntent_Seeding/          # Module library
│   ├── AgentBridge.psm1          # 6 specialized AI agents
│   ├── CircuitBreaker.psm1       # Resilience patterns
│   ├── SecureSecretsManager.psm1 # Azure Key Vault wrapper
│   ├── CopilotLifecycleTracker.psm1 # AI usage tracking
│   ├── ManifestReader.ps1        # Semantic manifest parser
│   └── Orchestrator.ps1          # Central orchestration engine
├── IntelIntent-Seed/             # Semantic manifests & configs
│   ├── sample_manifest.json      # Component definitions
│   ├── creator_of_creators_checklist.json
│   └── config/
│       └── integration-config.json # GitHub ↔ M365 integration
└── .github/
    └── copilot-instructions.md   # AI agent master instructions
```

### Design Patterns Used

1. **Checkpoint-First Orchestration**
   - Every operation creates immutable JSON checkpoint
   - Pattern: `Add-Checkpoint -TaskID "PREFIX-NNN" -Status "Success|Failed|Skipped"`
   - Flows to: Power BI, Codex Scrolls, Email Delivery

2. **Manifest-Guided Generation**
   - Components auto-generate from JSON manifests
   - Semantic priority ordering (1-13 scale)
   - Dependency-aware execution queues

3. **Agent-Based Orchestration**
   - 6 specialized agents: Finance, Boopas, Identity, Deployment, Modality, Orchestrator
   - Consistent return structure: `@{ Status, Agent, Operation, Result/Error }`
   - Keyword-based semantic routing

4. **Graceful Degradation**
   - Modules import with `-ErrorAction SilentlyContinue`
   - Check `Get-Command` before invoking functions
   - DryRun pattern for safe testing

## 🔑 Critical Code Patterns

### Pattern 1: Checkpoint Creation (Non-Negotiable)

```powershell
# Direct creation
Add-Checkpoint `
    -TaskID "KV-001" `
    -Status "Success" `
    -Inputs @{ VaultName = "IntelIntentSecrets" } `
    -Outputs @{ Result = $vaultUrl } `
    -Artifacts @("IntelIntentSecrets") `
    -DurationSeconds 12

# Wrapper (preferred for complex operations)
Invoke-TaskWithCheckpoint `
    -TaskID "RBAC-001" `
    -Description "Create Phase4-Admin RBAC role" `
    -ScriptBlock {
        New-AzRoleAssignment -ObjectId $principalId -RoleDefinitionName "Contributor"
    } `
    -Inputs @{ PrincipalId = $principalId } `
    -Artifacts @("Phase4-Admin")
```

### Pattern 2: Module Import Safety

```powershell
# Always import with graceful fallback
Import-Module .\IntelIntent_Seeding\SecureSecretsManager.psm1 -Force -ErrorAction SilentlyContinue

# Check before use
if (Get-Command New-SecretVault -ErrorAction SilentlyContinue) {
    New-SecretVault -VaultName $VaultName
} else {
    Write-Warning "SecureSecretsManager.psm1 not found, skipping"
}
```

### Pattern 3: Agent Return Structure

```powershell
# Consistent contract across all agents
@{
    Status = "Success" | "Error" | "Pending"
    Agent = "AgentName"
    Operation = "OperationName"
    Result = @{ /* operation-specific data */ }
    # OR
    Error = "Error message"
}

# Usage example
$result = Invoke-IdentityAgent -Operation "EmailOrchestration" -UserEmail "user@example.com"
if ($result.Status -eq "Success") {
    Write-Host "Email sent: $($result.Result.MessageId)"
}
```

### Pattern 4: DryRun Safety Check

```powershell
if ($DryRun) {
    Write-Host "  [DRY RUN] Would create resource: $resourceName" -ForegroundColor Yellow
    Add-Checkpoint -TaskID $taskId -Status "Skipped"
    return $null
}

# Actual Azure operation
az keyvault create --name $VaultName --resource-group $ResourceGroup
```

## 📊 Data Flow Architecture

```
Azure Operation → Add-Checkpoint → Week1_Checkpoints.json
                                   ├─► Power BI (SQL ingestion)
                                   ├─► Codex Scrolls (MD + HTML)
                                   └─► Email Delivery (IdentityAgent)
```

## 🎯 Common Developer Tasks

| Intent | Copilot Should Suggest |
|--------|----------------------|
| "Add a new checkpoint task" | `Invoke-TaskWithCheckpoint` wrapper pattern |
| "Create Azure resource" | DryRun check + checkpoint creation |
| "Import a module" | `-ErrorAction SilentlyContinue` + `Get-Command` validation |
| "Call an agent" | Return structure validation + error handling |
| "Generate component" | Manifest schema + Orchestrator.ps1 invocation |
| "Test automation" | `-DryRun -SkipEmail` flags first |

## 🔐 Security & Compliance Context

- **Azure Key Vault**: All secrets managed via `SecureSecretsManager.psm1`
- **RBAC Roles**: Phase4-Admin, Phase4-Developer, Phase4-Viewer
- **Certificate Auth**: Graph API uses certificate-based authentication
- **Audit Trail**: SHA256 placeholders for cryptographic lineage (Phase 5)
- **SOC 2 Type II**: Checkpoint schema supports compliance requirements

## 🚀 Azure Integration Context

**Services in Use:**
- Azure Key Vault (secrets, certificates)
- Azure RBAC (role assignments)
- Microsoft Graph API (email, identity)
- Azure Container Apps (deployment target)
- Azure SQL Database (Power BI ingestion)
- Azure DevOps Pipelines (CI/CD)

**Common Azure CLI Patterns:**
```powershell
# Key Vault operations
az keyvault create --name $VaultName --resource-group $RG --enable-rbac-authorization
az keyvault secret set --vault-name $VaultName --name $SecretName --value $SecretValue

# RBAC operations
az role assignment create --assignee $PrincipalId --role "Key Vault Secrets Officer" --scope $VaultId

# Resource queries
az resource list --resource-group $RG --query "[].{Name:name, Type:type}" --output table
```

## 📝 Naming Conventions

- **Task IDs**: `PREFIX-NNN` format (e.g., `KV-001`, `RBAC-002`, `GRAPH-003`)
- **Component Files**: `{Module}/{Module}_component.ps1`
- **Checkpoints**: `{Phase}/Recursive_Operations/checkpoint.txt` or `Week1_Checkpoints.json`
- **Agents**: `Invoke-{Domain}Agent` (e.g., `Invoke-FinanceAgent`, `Invoke-IdentityAgent`)
- **Modules**: `{Purpose}.psm1` with `Export-ModuleMember`

## 🧪 Testing Context

**Test Framework**: Pester (PowerShell)

```powershell
# Test structure convention
Describe "ModuleName" {
    Context "FunctionName" {
        It "Should do expected behavior" {
            $result = Invoke-Function -Parameter "value"
            $result | Should -Be "expected"
        }
    }
}

# Common test tasks (VS Code tasks available)
# - Pester: Run All Tests
# - Pester: Run Current Test File
# - Week1: Run DryRun Mode
# - Orchestrator: Validate Manifests
```

## 🌐 Universal Creative Domains

IntelIntent supports multiple creative workflows:

1. **Code/Automation** - Standard PowerShell development
2. **Scriptures** - `.scripture` files (Markdown format)
3. **Temple Architecture** - `.temple` files (YAML format)
4. **Blueprints** - `.blueprint` files (YAML format)
5. **Rituals/Doctrine** - `.ritual`, `.doctrine` files (Markdown)

**Universal Profile Functions:**
```powershell
# Load universal profile
. .vscode/scripts/Universal-Profile.ps1

# Create creative artifacts
scripture -Name "Genesis" -Author "Moses"
temple -Name "Solomon" -Type "Temple"
blueprint -Name "Complex" -Scale "1:100"
validate -Path ".\Scriptures\Genesis.scripture"
```

## 📚 Essential Documentation References

**For Architecture Questions:**
- `PHASE4_ARCHITECTURE_DIAGRAM.md` - Visual system architecture with Mermaid diagrams
- `WORKFLOW_MAP.md` - User journeys and service boundaries
- `SERVICE_PATHWAYS.md` - High-frequency interaction patterns

**For Implementation:**
- `WEEK1_IMPLEMENTATION_CHECKLIST.md` - 855 lines of concrete Azure CLI tasks
- `PRODUCTION_MODULES_QUICKSTART.md` - Module usage examples
- `.github/copilot-instructions.md` - Complete AI agent instructions (2,076 lines)

**For Integration:**
- `CI_CD_SETUP_GUIDE.md` - GitHub Actions + Azure DevOps setup
- `POWERBI_DASHBOARD_SCHEMA.md` - SQL schema and DAX measures
- `IntelIntent-Seed/UNIVERSAL_CONFIGURATION_TEMPLATE.md` - GitHub ↔ M365 integration

## 🎨 November 2025 VS Code Features

**New capabilities to leverage:**
- **Tree-sitter PowerShell Grammar**: Supports `&&` and `||` operators
- **Git Stashes Explorer**: `Ctrl+Shift+Alt+S` for stash management
- **GitHub MCP Server**: Repo/PR/issue management tools
- **Inline Chat V2**: Multi-file editing with `Ctrl+I`
- **AI Code Actions**: Quick Fix menu integration (`Ctrl+.`)
- **Unified Agent Sessions**: All chat/agent sessions in one view

## 🔧 Module Implementation Status

**Production-Ready Modules:**
- ✅ `AgentBridge.psm1` (448 lines) - 6 agent functions + lifecycle management
- ✅ `SecureSecretsManager.psm1` (600+ lines) - Azure Key Vault integration
- ✅ `CircuitBreaker.psm1` (550+ lines) - Resilience patterns with exponential backoff
- ✅ `CopilotLifecycleTracker.psm1` (381 lines) - GitHub Copilot tracking
- ✅ `ManifestReader.ps1` (323 lines) - Manifest parsing and queue building
- ✅ `Orchestrator.ps1` (422 lines) - Central orchestration engine

**Placeholder Modules (Awaiting Implementation):**
- ⚠️ `CodexRenderer.psm1` - Checkpoint → HTML/Markdown rendering
- ⚠️ `RBACManager.psm1` - Azure RBAC automation
- ⚠️ `CertificateAuthBridge.psm1` - Certificate-based Graph API auth
- ⚠️ `HealthCheckAPI.ps1` - Azure Container App health endpoint

## 🎯 Copilot Guidance

**When suggesting code:**
1. Always include checkpoint creation for Azure operations
2. Use `-ErrorAction SilentlyContinue` for module imports
3. Validate commands exist with `Get-Command` before invoking
4. Include DryRun checks for destructive operations
5. Follow agent return structure contract
6. Use TaskID format: `PREFIX-NNN`

**When analyzing existing code:**
1. Identify checkpoint patterns
2. Check module import safety
3. Validate agent return structures
4. Look for DryRun support
5. Verify error handling

**When suggesting architecture changes:**
1. Reference `PHASE4_ARCHITECTURE_DIAGRAM.md` for system design
2. Consider checkpoint flow to Power BI
3. Maintain agent-based orchestration patterns
4. Preserve graceful degradation
5. Keep cryptographic lineage compatibility

---

**Last Updated**: November 30, 2025  
**Project Phase**: Phase 4 (Production Hardening)  
**PowerShell Version**: 7.0+  
**Primary Automation**: `Week1_Automation.ps1` (26 checkpoints)
