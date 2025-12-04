# 🚀 Phase 4 Production Modules - Quick Start Guide

## Overview

IntelIntent Phase 4 deployment system now includes comprehensive automation, monitoring, and production-ready modules.

### ⚡ New Deployment Automation (2025-11-30)
1. **Deploy-IntelIntentPhase4.ps1** - Unified deployment orchestration
2. **Test-PostInstall.ps1** - Post-installation verification with readiness scoring
3. **POWERBI_PHASE4_SCHEMA.md** - Complete Power BI dashboard schema with DAX measures
4. **PHASE4_DEPLOYMENT_ROADMAP.md** - Interactive Mermaid deployment flow with clickable links

### ✅ Production Modules (2025-11-29)
1. **SecureSecretsManager.psm1** - Azure Key Vault integration (608 lines)
2. **CircuitBreaker.psm1** - Resilience and fault tolerance (530 lines)
3. **AgentBridge.psm1** - Agent routing and orchestration (447 lines)
4. **Integration Configuration** - Universal GitHub ↔ M365 setup

### 📊 Monitoring & Reporting
- **Power BI Dashboard:** 6 pages tracking deployment health, readiness, CoE activation, integration, and Copilot usage
- **SQL Schema:** 8 tables for comprehensive metrics (DeploymentSessions, Week1Checkpoints, CoEActivations, etc.)
- **DAX Measures:** 30+ measures for success rates, duration trends, readiness scores

---

## 🚀 Quick Start: Full Phase 4 Deployment

**Prerequisites:** Administrator privileges, internet connection

### Option 1: Automated Deployment (Recommended)

```powershell
# Download and run unified deployment script
.\Deploy-IntelIntentPhase4.ps1 -DryRun  # Simulate first

# Review output, then run production deployment
.\Deploy-IntelIntentPhase4.ps1 -Context "Developer" -ResourceGroup "Phase4RG"

# Verify installation
.\Test-PostInstall.ps1 -ExportReport -TestAzureConnectivity
```

**This installs:**
- PowerShell 7+, Azure CLI, Python 3.14, Git, VS Code
- Fixes PATH entries for Chocolatey and Python
- Provisions Azure Key Vault with RBAC
- Configures circuit breakers for resilience
- Deploys GitHub ↔ M365 universal integration
- Executes Week 1 automation (26 checkpoints)
- Pushes metrics to Power BI dashboard

### Option 2: Phase-by-Phase Manual Deployment

See [PHASE4_DEPLOYMENT_ROADMAP.md](PHASE4_DEPLOYMENT_ROADMAP.md) for detailed phase-by-phase instructions.

---

## ✅ What's New (2025-11-29)

### SecureSecretsManager.psm1 (600+ lines)
Azure Key Vault abstraction layer with RBAC support.

**Functions:**
- `New-SecretVault` - Provision Key Vault with RBAC
- `Set-SecretValue` - Store secrets securely
- `Get-SecretValue` - Retrieve secrets (plain text or SecureString)
- `Grant-VaultAccess` - RBAC role assignment
- `Remove-SecretValue` - Soft delete with purge option
- `Test-VaultConnection` - Validate Azure CLI auth and vault access

**Usage:**
```powershell
Import-Module .\IntelIntent_Seeding\SecureSecretsManager.psm1

# Create vault
New-SecretVault -VaultName "IntelIntentSecrets" -ResourceGroup "Phase4RG"

# Store secret
Set-SecretValue -SecretName "GraphClientSecret" -SecretValue $secret

# Retrieve secret
$token = Get-SecretValue -SecretName "GraphClientSecret"

# Grant access to managed identity
Grant-VaultAccess -PrincipalId $identityId -RoleName "Key Vault Secrets User"
```

---

### CircuitBreaker.psm1 (550+ lines)
Resilience pattern for external service calls.

**Functions:**
- `Set-CircuitBreakerConfig` - Configure service thresholds
- `Invoke-WithCircuitBreaker` - Execute with retry/fallback
- `Get-CircuitBreakerStatus` - Check circuit state
- `Reset-CircuitBreaker` - Manual recovery
- `Get-CircuitBreakerMetrics` - Health metrics
- `Export-CircuitBreakerLogs` - Audit trail

**Circuit States:**
- **Closed** - Normal operation (requests allowed)
- **Open** - Service degraded (fast fail, fallback executed)
- **HalfOpen** - Testing recovery (limited requests)

**Usage:**
```powershell
Import-Module .\IntelIntent_Seeding\CircuitBreaker.psm1

# Configure circuit breaker
Set-CircuitBreakerConfig -ServiceName "MicrosoftGraph" -Config @{
    MaxRetries = 3
    TimeoutSeconds = 10
    BackoffMultiplier = 2
    FailureThreshold = 5
}

# Execute with protection
$users = Invoke-WithCircuitBreaker -ServiceName "MicrosoftGraph" -ScriptBlock {
    Invoke-MgGraphRequest -Uri "https://graph.microsoft.com/v1.0/users"
} -FallbackScriptBlock {
    Write-Warning "Using cached data"
    Get-Content .\cache\users.json | ConvertFrom-Json
}

# Check metrics
Get-CircuitBreakerMetrics | Format-Table
```

---

### Universal Configuration (integration-config.json)
GitHub ↔ M365 integration for 5 contexts.

**Contexts:**
- **Personal** - OneDrive backup, To Do reminders
- **Developer** - Teams notifications, VS Code sync
- **Family** - Shared calendars, SharePoint wiki
- **Business** - Planner tasks, release notes
- **Enterprise** - Power BI, compliance, Azure AD

**Location:** `IntelIntent-Seed/config/integration-config.json`

**Documentation:** `IntelIntent-Seed/UNIVERSAL_CONFIGURATION_TEMPLATE.md`

---

## 🧪 Testing

Run comprehensive test suite:

```powershell
# Test all modules (no Azure operations)
.\Test-ProductionModules.ps1 -DryRun

# Test specific module
.\Test-ProductionModules.ps1 -TestModule "SecureSecretsManager"

# Full integration tests (requires Azure auth)
az login
.\Test-ProductionModules.ps1
```

**Expected Output:**
```
✅ Passed: 20+
❌ Failed: 0
⏭️  Skipped: 2 (Azure live operations in DryRun)
Pass Rate: 100%
```

---

## 📦 Integration with Week1_Automation.ps1

Update your automation script to use new modules:

```powershell
# Import production modules
Import-Module .\IntelIntent_Seeding\SecureSecretsManager.psm1 -Force
Import-Module .\IntelIntent_Seeding\CircuitBreaker.psm1 -Force

# Configure circuit breaker for Graph API
Set-CircuitBreakerConfig -ServiceName "MicrosoftGraph" -Config @{
    MaxRetries = 3
    TimeoutSeconds = 10
    BackoffMultiplier = 2
}

# Provision Key Vault with retry logic
Invoke-TaskWithCheckpoint -TaskID "KV-001" -Description "Provision Azure Key Vault" -ScriptBlock {
    $result = Invoke-WithCircuitBreaker -ServiceName "AzureCLI" -ScriptBlock {
        New-SecretVault -VaultName $VaultName -ResourceGroup $ResourceGroup
    }
    
    if ($result.Status -eq "Success") {
        Write-Host "  ✅ Vault URI: $($result.VaultUri)" -ForegroundColor Green
        return $result.VaultUri
    } else {
        throw "Vault creation failed: $($result.Error)"
    }
} -Inputs @{ VaultName = $VaultName; ResourceGroup = $ResourceGroup } `
  -Artifacts @($VaultName)

# Store Graph API secret
Set-SecretValue -SecretName "GraphClientSecret" -SecretValue $clientSecret

# Retrieve for use
$token = Get-SecretValue -SecretName "GraphClientSecret"
```

---

## 🔐 Security Best Practices

### Key Vault Setup
1. **Enable RBAC** (not access policies)
2. **Enable purge protection** for production
3. **Use managed identities** for service authentication
4. **Rotate secrets** with expiration dates
5. **Audit vault access** via Azure Monitor

### Circuit Breaker Configuration
1. **Set realistic thresholds** (5-10 failures typical)
2. **Configure fallbacks** for critical operations
3. **Monitor metrics** via `Get-CircuitBreakerMetrics`
4. **Export logs** for compliance with `Export-CircuitBreakerLogs`
5. **Test failure scenarios** before production

---

## 📋 Deployment Checklist

### Prerequisites
- [ ] PowerShell 7.0+
- [ ] Azure CLI authenticated (`az login`)
- [ ] Contributor permissions on subscription
- [ ] Resource group created

### SecureSecretsManager
- [ ] Import module
- [ ] Create Key Vault
- [ ] Grant RBAC access to identity
- [ ] Store secrets
- [ ] Test retrieval

### CircuitBreaker
- [ ] Import module
- [ ] Configure services (Graph API, Azure SQL, etc.)
- [ ] Set thresholds and timeouts
- [ ] Add fallback handlers
- [ ] Test retry logic

### Universal Configuration
- [ ] Review `integration-config.json`
- [ ] Enable desired contexts
- [ ] Configure GitHub repositories
- [ ] Set M365 integration toggles
- [ ] Add secrets to GitHub or Key Vault

---

## 🎯 Next Steps

### New to IntelIntent? Start Here:
1. **Review Deployment Roadmap:** [PHASE4_DEPLOYMENT_ROADMAP.md](PHASE4_DEPLOYMENT_ROADMAP.md)
2. **Run Full Deployment:** `.\Deploy-IntelIntentPhase4.ps1 -DryRun`
3. **Verify Environment:** `.\Test-PostInstall.ps1 -ExportReport`
4. **Check Readiness Score:** Should be ≥ 80% after deployment

### Already Have Environment Set Up?
1. **Run tests:** `.\Test-ProductionModules.ps1 -DryRun`
2. **Update Week1_Automation.ps1** with new modules
3. **Deploy universal config** for GitHub ↔ M365 sync
4. **Configure circuit breakers** for external services
5. **Provision Key Vault** and store secrets
6. **Monitor metrics** via Power BI dashboard

### Setting Up Power BI Dashboard?
1. **Review Schema:** [POWERBI_PHASE4_SCHEMA.md](POWERBI_PHASE4_SCHEMA.md)
2. **Create Azure SQL Database:** `IntelIntentMetrics`
3. **Execute SQL scripts:** DeploymentSessions, Week1Checkpoints, CoEActivations, etc.
4. **Implement ingestion script:** `Push-CheckpointsToSQL.ps1`
5. **Build 6-page dashboard:** Executive Summary, Environment Readiness, Deployment Execution, CoE Activation, Universal Integration, Copilot Lineage

---

## 📊 Power BI Dashboard Integration

**New:** Complete Power BI schema with SQL tables, DAX measures, and dashboard designs.

**Dashboard Pages:**
1. **Executive Summary:** Readiness score, success rate, deployment trends
2. **Environment Readiness:** Tool installation, PATH config, Azure auth status
3. **Deployment Execution:** Session tracking, checkpoint details, phase breakdown
4. **CoE Activation Progress:** Component activation rates, semantic priority distribution
5. **Universal Integration Health:** GitHub ↔ M365 sync events, success rates
6. **Copilot Lineage:** AI-assisted development metrics, adoption trends

**Key Metrics:**
- **Readiness Score:** 0-100% based on tool installation and configuration
- **Deployment Success Rate:** % of successful deployments over time
- **Checkpoint Success Rate:** % of Week 1 checkpoints completed successfully
- **CoE Activation Rate:** % of components activated by priority
- **Integration Success Rate:** % of GitHub ↔ M365 sync events successful
- **Copilot Adoption Rate:** Daily invocations (inline, chat, agent mode)

**SQL Ingestion:**
```powershell
# Push checkpoints to Power BI after automation
.\IntelIntent_Seeding\Push-CheckpointsToSQL.ps1 `
    -SqlServer "intelintent.database.windows.net" `
    -Database "IntelIntentMetrics" `
    -UseManagedIdentity $true
```

See [POWERBI_PHASE4_SCHEMA.md](POWERBI_PHASE4_SCHEMA.md) for complete schema, DAX measures, and dashboard design specifications.

---

## 🆘 Troubleshooting

### "Circuit breaker not configured"
```powershell
# Solution: Configure before use
Set-CircuitBreakerConfig -ServiceName "MyService" -Config @{}
```

### "VaultName not set"
```powershell
# Solution: Set context or pass parameter
Set-VaultContext -VaultName "MyVault"
# OR
Get-SecretValue -SecretName "MySecret" -VaultName "MyVault"
```

### "Not authenticated to Azure"
```powershell
# Solution: Login to Azure
az login
az account show
```

### Test failures
```powershell
# Solution: Check module import
Get-Module SecureSecretsManager, CircuitBreaker

# Reimport if needed
Import-Module .\IntelIntent_Seeding\*.psm1 -Force
```

---

## 📚 Documentation

### Deployment & Automation
- **Deployment Roadmap:** [PHASE4_DEPLOYMENT_ROADMAP.md](PHASE4_DEPLOYMENT_ROADMAP.md) - Interactive Mermaid flow with clickable links
- **Deployment Script:** [Deploy-IntelIntentPhase4.ps1](Deploy-IntelIntentPhase4.ps1) - Unified deployment orchestration
- **Post-Install Verification:** [Test-PostInstall.ps1](Test-PostInstall.ps1) - Readiness scoring and environment check
- **Chocolatey Guide:** [CHOCOLATEY_QUICKSTART.md](CHOCOLATEY_QUICKSTART.md) - Tool installation reference

### Power BI & Monitoring
- **Power BI Schema:** [POWERBI_PHASE4_SCHEMA.md](POWERBI_PHASE4_SCHEMA.md) - SQL tables, DAX measures, dashboard designs
- **Original Dashboard Schema:** [POWERBI_DASHBOARD_SCHEMA.md](POWERBI_DASHBOARD_SCHEMA.md) - Week 1 checkpoint schema

### Module Documentation
- **Module Help:** `Get-Help New-SecretVault -Full`
- **Examples:** See function help blocks in module files
- **Remaining Modules:** [REMAINING_MODULES_ROADMAP.md](REMAINING_MODULES_ROADMAP.md) - RBACManager, CertificateAuthBridge, HealthCheckAPI, etc.

### Architecture & Planning
- **Architecture Diagram:** [PHASE4_ARCHITECTURE_DIAGRAM.md](PHASE4_ARCHITECTURE_DIAGRAM.md) - Visual system architecture
- **Phase 4 Preview:** [PHASE4_PREVIEW.md](PHASE4_PREVIEW.md) - Production hardening roadmap (2,847 lines)
- **Week 1 Checklist:** [WEEK1_IMPLEMENTATION_CHECKLIST.md](WEEK1_IMPLEMENTATION_CHECKLIST.md) - Task breakdown (855 lines)
- **Copilot Instructions:** `.github/copilot-instructions.md` - Development guidelines

### Integration
- **Universal Configuration:** [IntelIntent-Seed/UNIVERSAL_CONFIGURATION_TEMPLATE.md](IntelIntent-Seed/UNIVERSAL_CONFIGURATION_TEMPLATE.md) - GitHub ↔ M365 integration (800+ lines)
- **Integration Config:** [IntelIntent-Seed/config/integration-config.json](IntelIntent-Seed/config/integration-config.json) - 5 context profiles

---

*Production modules deployed: 2025-11-29*  
*Phase 4 deployment automation: 2025-11-30*  
*Phase 4 - Week 1 Hardening Complete*
