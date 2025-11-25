# IntelIntent AI Agent Instructions

## System Overview

**IntelIntent** is a recursive, modular PC mutation and orchestration system built on PowerShell with Microsoft ecosystem integration. The project transforms Windows environments through phased execution pipelines with semantic checkpointing.

### Architecture Philosophy
- **Recursive Operations**: Each module follows a pattern of execution  checkpoint  validation
- **Modular Components**: Self-contained, independently executable PowerShell scripts organized by function
- **Semantic Orchestration**: Components are guided by manifest files and copilot prompts in `IntelIntent-Seed/`
- **Checkpoint-based Recovery**: Every phase creates checkpoints in `Recursive_Operations/` subdirectories

## Critical Workflows

### Prerequisites and Environment Setup
Before running any phase scripts:
```powershell
# Run PowerShell as Administrator
# Set execution policy (if not already configured):
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Verify checkpoint directories exist before execution
# Scripts will create Recursive_Operations/ subdirectories automatically
```

**Required Environment:**
- Windows 10/11 with PowerShell 5.1+ or PowerShell 7+
- Administrator privileges for system mutation phases
- Microsoft 365 account for Graph API integration (optional for seeding)
- Azure subscription for cloud orchestration (optional)

### Mutation Pipeline (Sequential Phases)
Run phases in order from project root:
```powershell
# Phase sequence (DO NOT skip or reorder):
.\Backup\Backup.ps1
.\System_Wipe\System_Wipe.ps1
.\Reboot\Reboot.ps1
.\Environment_Configuration\Environment_Configuration.ps1
.\IntelIntent_Seeding\IntelIntent_Seeding.ps1
.\Visual_Dashboard_Setup\Visual_Dashboard_Setup.ps1
.\Mutation_Confirmation\Mutation_Confirmation.ps1
.\Recovery_Logs\Recovery_Logs.ps1
```

### Module Launcher (Interactive)
Use `IntelIntent_Launcher.ps1` for component selection:
- Presents numbered menu for 9 modular components
- Option "0" runs all modules sequentially
- Each module self-contained in `*_component.ps1` files

## Project Structure Patterns

### Component Naming Convention
- **Phase Scripts**: `{PhaseName}/{PhaseName}.ps1` (e.g., `Backup/Backup.ps1`)
- **Component Scripts**: `{Module}/{Module}_component.ps1` (e.g., `Identity_Modules/Identity_Modules_component.ps1`)
- **Checkpoints**: `{Phase}/Recursive_Operations/checkpoint.txt` or `{Phase}/Recursive_Operations/{Phase}_checkpoint.txt`

### Key Directories
- **`IntelIntent-Seed/`**: Semantic manifests, copilot prompts, checklists, and architectural blueprints
- **`IntelIntent_Mutation_Launchpad/`**: Mirrored module structure for orchestration
- **`Recursive_Operations/`**: Checkpoint files for phase validation and recovery

### Manifest and Configuration Files
The system uses three critical copilot orchestration prompts:
- `intelintent_copilot_prompt.txt`: Core modular agent definitions (FinanceAgent, BoopasAgent, IdentityAgent, etc.)
- `IntelIntent_Copilot_Orchestration_Prompt.txt`: Recursive layer architecture with Fluent 2 and URMTO semantic engine
- `copilot_prompt.txt`: GitHub orchestration and reset protocol

**How Manifests Trigger Components:**
1. **Seeding Process**: `IntelIntent_Seeding.ps1` reads checklists from `IntelIntent-Seed/` directory
2. **Semantic Priority**: JSON/YAML files define task ordering and dependencies (e.g., `creator_of_creators_checklist.json`)
3. **Recursive Execution**: Each checklist item triggers atomic component generation and validation
4. **Bootstrap Chain**: `IntelIntent_Bootstrap.ps1` files initiate the recursive orchestration using manifest metadata

## Semantic Concepts

### URMTO Semantic Engine
Hierarchical alignment framework:
- **Institutional Layer**: Strategic alignment with Microsoft principles
- **Operational Layer**: Modular task decomposition
- **Recursive Layer**: Feedback loops and agentic orchestration

### Center of Excellence (CoE) Pattern
Each enhancement is modularized as a CoE with:
- Atomic component breakdown
- Semantic priority tagging
- Recursive decomposition before progression

### Fluent 2 Interface Layer
Visual representation of recursive modules using Microsoft Fluent 2 design system. Deployment checklist in `Fluent2_Interface_Deployment_Checklist.json`.

## Code Patterns

### PowerShell Script Template
All phase scripts follow this structure:
```powershell
# PowerShell Script for {PhaseName}
Write-Output "Starting {PhaseName} phase..."
# Placeholder for actual logic
Write-Output "Executing recursive operations..."
# Create checkpoint
$checkpointPath = "IntelIntent_PC_Reset/{PhaseName}/Recursive_Operations\checkpoint.txt"
Set-Content -Path $checkpointPath -Value "Checkpoint for {PhaseName} completed."
Write-Output "{PhaseName} phase completed."
```

### Interactive Launcher Pattern
Menu-driven selection with switch statement:
```powershell
$choice = Read-Host "Enter your choice"
switch ($choice) {
    "1" { & .\Module\Module_component.ps1 }
    "0" { # Run all modules sequentially }
    default { Write-Host "Invalid choice." }
}
```

## Integration Points

### Microsoft Stack Dependencies
- **Azure Functions/Containers**: Cloud orchestration layer
- **Microsoft Graph API**: Identity, calendar, communication services
- **Power Platform**: Workflow automation
- **Entra ID**: Secure identity and access control
- **GitHub Actions**: CI/CD pipelines

### Modular Agents
System includes specialized agents (defined in `intelintent_copilot_prompt.txt`):

**Core Orchestration:**
- **OrchestratorAgent**: Semantic routing, intent verification, and agent lifecycle management. Routes requests to specialized agents based on semantic analysis.

**Domain Specialists:**
- **FinanceAgent**: Investment dashboard management, semantic triggers for market events, recursive portfolio queries and optimization.
- **BoopasAgent**: Point-of-sale integration for Boopa's Bagels, vendor workflow automation, reconciliation logic and inventory management.
- **IdentityAgent**: Secure email orchestration, Entra ID access control, multi-factor authentication workflows, and identity governance.
- **DeploymentAgent**: PC system reset orchestration, Azure tenancy validation, configuration routine automation, and environment provisioning.
- **ModalityAgent**: Multi-modal input handling (voice commands, audio transcription, screen capture, webcam input), file system access, and cross-device synchronization.

**Agent Interaction Pattern:**
```
User Intent  OrchestratorAgent  Semantic Router  Domain Agent  Execution  Feedback Loop
                                                                                    
                                                                                    |
                                                                         Semantic Kernel Memory
```

All agents share context through Microsoft Graph API and Semantic Kernel memory architecture.

## Development Guidelines

### When Modifying Phase Scripts
1. Preserve checkpoint creation pattern
2. Maintain `Recursive_Operations/` subdirectory structure
3. Update corresponding entries in `IntelIntent-Seed/` checklists
4. Test checkpoint file creation before committing

### When Adding New Modules
1. Create `{Module}/{Module}_component.ps1`
2. Add menu entry to `IntelIntent_Launcher.ps1`
3. Mirror structure in `IntelIntent_Mutation_Launchpad/`
4. Document in applicable checklist (see `creator_of_creators_checklist.json`)

### Checkpoint Validation
Always verify checkpoint existence after phase execution:
```powershell
if (Test-Path ".\{Phase}\Recursive_Operations\checkpoint.txt") {
    Write-Host " Checkpoint verified"
}
```

**Common Checkpoint Failures:**
1. **Path Mismatch**: Scripts reference `IntelIntent_PC_Reset/{Phase}/Recursive_Operations` but actual path is relative from project root
2. **Missing Directory**: `Recursive_Operations/` subdirectory must exist before `Set-Content` call
3. **Permission Issues**: Administrator privileges required for system-level phase checkpoints
4. **Path Separators**: Windows backslash `\` vs forward slash `/` inconsistencies in cross-platform scenarios

**Recovery Pattern:**
```powershell
# Ensure directory exists before checkpoint creation
$checkpointDir = ".\{Phase}\Recursive_Operations"
if (-not (Test-Path $checkpointDir)) {
    New-Item -ItemType Directory -Path $checkpointDir -Force | Out-Null
}
Set-Content -Path "$checkpointDir\checkpoint.txt" -Value "Checkpoint completed."
```

## Known Architectural Decisions

### Why PowerShell Scripts Are Placeholders
Current phase scripts contain minimal logicthis is intentional. The system is designed for recursive generation and completion by AI agents, with scripts serving as scaffolding for semantic orchestration.

### Why Dual Launcher Structures
Both root-level `IntelIntent_Launcher.ps1` and `IntelIntent_Mutation_Launchpad/IntelIntent_Launcher.ps1` exist to support both direct execution and launchpad-based orchestration patterns.

### Why Boot/EFI Files Present
The project originated as a bootable system mutation environment, hence `bootmgr`, `bootmgr.efi`, and `boot/` directory. These support bare-metal PC reset scenarios.

## Testing and Validation

### Pre-Flight Checklist
Reference `creator_of_creators_checklist.md` for launch readiness:
- Security gates validation
- GitHub CLI authentication
- OIDC federation setup
- Flight Readiness Review

### Recursive Execution Simulation
Use `intelintent_atomic_checklist.yaml` for workload simulation and stress testing across CPU/GPU/I/O bounds.
