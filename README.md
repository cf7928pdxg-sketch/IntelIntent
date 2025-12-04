# IntelIntent

**Recursive PC Mutation & Orchestration System**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue)](https://github.com/PowerShell/PowerShell)
[![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-blue)](https://www.microsoft.com/windows)

IntelIntent is an AI-driven, checkpoint-based system for orchestrating PC mutations through an 8-phase pipeline. Built for Windows environments with recursive recovery capabilities and semantic agent orchestration.

## 🎯 Overview

IntelIntent provides a modular framework for PC system mutations with:

- **8-Phase Sequential Pipeline**: Automated mutation workflow from backup through recovery
- **Checkpoint-Based Recovery**: Each phase validates completion before progression
- **AI Agent Orchestration**: Semantic routing via URMTO (Unified Recursive Multi-Tier Orchestrator)
- **Manifest-Driven Execution**: JSON/YAML checklists trigger component generation
- **Recursive Architecture**: Self-healing with intelligent rollback capabilities

## 🚀 Quick Start

### Prerequisites

- Windows 10/11
- PowerShell 5.1+ or PowerShell 7+
- Administrator privileges

### Launch the System

```powershell
# Interactive module launcher
.\IntelIntent_Launcher.ps1

# Direct phase execution
.\Backup\Backup.ps1
.\System_Wipe\System_Wipe.ps1
# ... continue through phases
```

## 📋 8-Phase Mutation Pipeline

| Phase | Script | Purpose | Checkpoint |
|-------|--------|---------|------------|
| 1 | `Backup.ps1` | System state preservation | `Recursive_Operations/checkpoint.txt` |
| 2 | `System_Wipe.ps1` | Environment sanitization | `Phase2_Complete` |
| 3 | `Reboot.ps1` | System restart orchestration | `Phase3_Complete` |
| 4 | `Environment_Configuration.ps1` | Base configuration | `Phase4_Complete` |
| 5 | `IntelIntent_Seeding.ps1` | Manifest deployment | `Phase5_Complete` |
| 6 | `Visual_Dashboard_Setup.ps1` | UI initialization | `Phase6_Complete` |
| 7 | `Mutation_Confirmation.ps1` | Validation & verification | `Phase7_Complete` |
| 8 | `Recovery_Logs.ps1` | Audit trail generation | `Phase8_Complete` |

## 🤖 AI Agent Architecture

IntelIntent uses semantic orchestration with specialized domain agents:

```
┌─────────────────────┐
│ OrchestratorAgent   │
│  (URMTO Engine)     │
└──────────┬──────────┘
           │
           ├──► FinanceAgent    (Portfolio & market analysis)
           ├──► BoopasAgent     (Inventory & vendor management)
           ├──► IdentityAgent   (Authentication & RBAC)
           ├──► DeploymentAgent (Infrastructure provisioning)
           └──► ModalityAgent   (Cross-platform integration)
```

### Agent Interaction

Agents communicate through:
- **Manifest Triggers**: JSON/YAML checklists in `IntelIntent-Seed/`
- **Checkpoint Validation**: `Recursive_Operations/checkpoint.txt`
- **Semantic Routing**: Intent analysis via URMTO engine

See [.github/copilot-instructions.md](.github/copilot-instructions.md) for complete agent guidelines.

## 📁 Project Structure

```
IntelIntent/
├── .github/
│   └── copilot-instructions.md    # AI agent guidance (211 lines)
├── Backup/                         # Phase 1: System backup
├── System_Wipe/                    # Phase 2: Environment wipe
├── Reboot/                         # Phase 3: Restart orchestration
├── Environment_Configuration/      # Phase 4: Base config
├── IntelIntent_Seeding/           # Phase 5: Manifest deployment
│   ├── AgentBridge.psm1
│   ├── ManifestReader.ps1
│   └── Orchestrator.ps1
├── Visual_Dashboard_Setup/        # Phase 6: UI setup
├── Mutation_Confirmation/         # Phase 7: Validation
├── Recovery_Logs/                 # Phase 8: Audit logs
├── IntelIntent-Seed/              # Orchestration manifests
│   ├── creator_of_creators_checklist.json
│   ├── Fluent2_Interface_Deployment_Checklist.json
│   ├── intelintent_atomic_checklist.yaml
│   └── Desktop/IntentON/          # 4-tier node architecture
├── Tests/                         # Pester test suites
└── IntelIntent_Launcher.ps1       # Interactive module launcher
```

## 🛠️ Development

### Running Tests

```powershell
# Full test suite
Invoke-Pester -Path .\Tests\

# Specific agent tests
.\Test-FinanceAgent.ps1
.\Test-BoopasAgent.ps1
```

### Adding New Phases

1. Create directory: `New_Phase/New_Phase.ps1`
2. Implement checkpoint pattern:
   ```powershell
   Set-Content -Path "Recursive_Operations/checkpoint.txt" -Value "PhaseX_Complete"
   ```
3. Update `IntelIntent_Launcher.ps1` menu
4. Document in `.github/copilot-instructions.md`

### Working with Manifests

Manifests in `IntelIntent-Seed/` drive component generation:

```json
{
  "task": "Deploy Fluent 2 Interface",
  "dependencies": ["Phase4_Complete"],
  "agents": ["ModalityAgent", "DeploymentAgent"],
  "checkpoints": ["UI_Initialized", "Components_Loaded"]
}
```

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [Copilot Instructions](.github/copilot-instructions.md) | AI agent development guide |
| [Architecture Framework](LIVING_ARCHITECTURE_FRAMEWORK.md) | System design patterns |
| [Governance Guide](Governance/README.md) | Compliance & security |
| [Quick Reference](QUICK_REFERENCE.md) | Command cheat sheet |
| [Phase Roadmaps](PHASE4_DEPLOYMENT_ROADMAP.md) | Implementation tracking |

## 🔐 Security & Compliance

- **Secrets Management**: Azure Key Vault integration via `SecureSecretsManager.psm1`
- **RBAC**: Identity validation through `IdentityAgent`
- **Audit Trails**: Comprehensive logging in `Recovery_Logs/`
- **License Compliance**: See [LICENSE](LICENSE) and [Governance/Compliance_Summary.md](Governance/Compliance_Summary.md)

## 🌐 IntentON Node Architecture

Multi-tier deployment model for different organizational contexts:

- **Personal**: Individual workstation mutations
- **Family**: Home network orchestration  
- **Business**: SMB infrastructure management
- **Enterprise**: Large-scale datacenter operations

Each tier includes isolated root nodes in `IntelIntent-Seed/Desktop/IntentON/`

## 🤝 Contributing

This is a personal/experimental project. For issues or questions, see the [GitHub Issues](https://github.com/cf7928pdxg-sketch/IntelIntent/issues) page.

## 📄 License

MIT License - See [LICENSE](LICENSE) for details.

**Additional Notices:**
- Azure extensions: See license headers in `.github/copilot-instructions.md`
- Third-party tools: Governed by respective vendor licenses

## 🙏 Acknowledgments

Built with:
- PowerShell 7.5+ (.NET runtime)
- Azure SDK for .NET
- GitHub Copilot (AI-assisted development)
- Fluent 2 Design System (Microsoft)

---

**⚠️ Disclaimer**: IntelIntent performs system-level mutations. Always test in isolated environments before production use. Backup critical data independently.

For AI agents working with this repository, consult [.github/copilot-instructions.md](.github/copilot-instructions.md) for coding patterns, checkpoint validation, and orchestration protocols.
