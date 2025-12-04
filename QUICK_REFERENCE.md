# 🚀 Hybrid Execution Quick Reference

**One-page cheat sheet for the Universal Hybrid Execution Framework**

---

## 📊 At a Glance

| Metric | Value |
|--------|-------|
| **Total Phases** | 4 |
| **Time to Foundation** | 5 minutes |
| **Independent Work %** | 60-70% typical |
| **Efficiency Gain** | 20-40% time savings |

---

## ⚡ Quick Start Commands

### IntelIntent (PowerShell)

```powershell
# Phase 1: Foundation (5 min)
.\Install-MVP.ps1 -Phase Foundation

# Phase 2: Build Chains (30-60 min each)
.\IntelIntent_Seeding\Orchestrator.ps1 -Category "Finance" -Mode GenerateOnly
.\IntelIntent_Seeding\Orchestrator.ps1 -Category "Commerce" -Mode GenerateOnly
.\IntelIntent_Seeding\Orchestrator.ps1 -Category "Modality" -Mode GenerateOnly

# Phase 3: Solve Auth (15 min)
az login --use-device-code

# Phase 4: Deploy (as scheduled)
.\Week1_Automation.ps1  # Remove -DryRun flag
```

### Generic (Bash/Node.js)

```bash
# Phase 1: Foundation
npm install -g gh  # GitHub CLI
./setup-tools.sh

# Phase 2: Build Chains
npm run build:finance
npm run build:commerce
npm run build:experience

# Phase 3: Solve Auth
aws configure sso  # or az login, gcloud auth login

# Phase 4: Deploy
npm run deploy:production
```

---

## 🗺️ Dependency Pattern Recognition

### Red Flags (Auth Blockers)

- ❌ "Login required"
- ❌ "API key missing"
- ❌ "MFA needed"
- ❌ "Service principal not found"
- ❌ "OAuth token expired"

### Green Lights (Independent)

- ✅ Uses mock/stub data
- ✅ Local file operations
- ✅ In-memory processing
- ✅ UI/UX rendering
- ✅ Business logic validation

---

## 🎯 Decision Matrix

| Scenario | Action |
|----------|--------|
| **Auth available now** | Sequential: 1→2→3→4 |
| **Auth delayed 1-2 days** | Hybrid: 1→2→3→4 (parallelize 2) |
| **Auth delayed 1+ week** | Full parallel: 1→2 (all chains)→3→4 |
| **POC/Demo needed** | 1→2 (1 chain)→DryRun |

---

## 📋 Phase Checklists

### ✅ Phase 1: Foundation

- [ ] Git/GitHub CLI installed
- [ ] Automation scripts configured
- [ ] Dry-run mode validated
- [ ] Checkpoint system working

### ✅ Phase 2: Build Chains

- [ ] 2+ independent chains built
- [ ] Mock data providers created
- [ ] Local tests passing
- [ ] Checkpoints generated

### ✅ Phase 3: Authentication

- [ ] Cloud login successful
- [ ] Identity services accessible
- [ ] Blocked chains unblocked

### ✅ Phase 4: Deployment

- [ ] Resources provisioned
- [ ] Integration tests passing
- [ ] Monitoring configured
- [ ] Production checkpoints

---

## 🏭 Industry Quick Adaptations

### Finance

**Blocker:** Bloomberg API key, SEC EDGAR access  
**Independent:** Portfolio dashboards, risk analytics, trade simulators

### Healthcare

**Blocker:** Epic/Cerner OAuth, FHIR endpoints  
**Independent:** Patient dashboards, scheduling UI, billing workflows

### Retail

**Blocker:** Payment gateway (Stripe/PayPal), Shopify OAuth  
**Independent:** Product catalog, inventory UI, recommendation engine

### Manufacturing

**Blocker:** ERP credentials (SAP), PLM system access  
**Independent:** CAD viewers, BOM validators, quality dashboards

---

## ⏱️ Time Estimates

| Activity | Sequential | Hybrid | Savings |
|----------|-----------|--------|---------|
| **Foundation** | 5 min | 5 min | 0% |
| **3 Chains** | 90-180 min | 90-180 min | 0% |
| **Auth** | 15 min | 15 min | 0% |
| **Deploy** | 30-60 min | 30-60 min | 0% |
| **Wait for Auth** | 2-4 hours | **0 min** | **100%** |
| **Total** | 4-6 hours | 2-4 hours | **33-50%** |

---

## 🎨 Visual Aids

### Dependency Map Color Code

- 🟢 **Green** = Independent (build now)
- 🔴 **Red** = Blocked (wait for auth)
- 🔒 **Lock** = Critical blocker
- ⚡ **Lightning** = Unlocked after auth

### Chain Structure Template

```
ENV-001 (Environment Setup)
    ├─ 🔴 ID-001 (Identity) 🔒
    │   ├─ ID-002 (Email/Graph)
    │   └─ DEPLOY-001 (Tenancy)
    │       ├─ DEPLOY-002 (Provision)
    │       └─ CICD-001 (Pipeline)
    │
    ├─ 🟢 FIN-001 (Finance)
    │   └─ FIN-002 (Analytics)
    │
    ├─ 🟢 COM-001 (Commerce)
    │   └─ COM-002 (Workflows)
    │
    └─ 🟢 MODAL-001 (Experience)
        └─ MODAL-002 (Interaction)
```

---

## 💡 Pro Tips

1. **Always start with Foundation** - 5 minutes sets up everything
2. **Build highest-value chain first** - Usually Finance/Operations
3. **Don't wait for auth** - 60-70% of work is independent
4. **Use DryRun mode liberally** - Validate without cloud costs
5. **Checkpoint everything** - Makes debugging trivial

---

## 📞 Quick Reference Links

| Document | Purpose |
|----------|---------|
| `UNIVERSAL_HYBRID_EXECUTION_FRAMEWORK.md` | Complete guide (450+ lines) |
| `EXECUTIVE_SUMMARY.md` | One-page stakeholder version |
| `.vscode/UNIVERSAL_DEPENDENCY_MAP.svg` | Visual dependency map |
| `CORE_MVP_VERIFICATION.md` | IntelIntent-specific status |

---

## 🆘 Troubleshooting

| Problem | Solution |
|---------|----------|
| **"Auth required"** | Switch to Phase 2 (build independent chains) |
| **"Module not found"** | Run Phase 1 (Foundation setup) |
| **"No checkpoints"** | Enable dry-run mode (`-DryRun` flag) |
| **"Can't find chain"** | Check manifest file for component definitions |
| **"All chains blocked"** | Review dependency map - likely 60%+ are independent |

---

**Framework Version:** 1.0  
**Last Updated:** November 30, 2025  
**Print/Save:** This page for desk reference

---

**Need help?** Open the full framework document:

```bash
code UNIVERSAL_HYBRID_EXECUTION_FRAMEWORK.md
```
