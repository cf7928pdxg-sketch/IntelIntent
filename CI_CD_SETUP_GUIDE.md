# CI/CD Pipeline Setup Guide
# IntelIntent Phase 4 - Automated Codex Scroll Delivery

## Overview

This guide provides complete setup instructions for **automated Codex Scroll delivery** using CI/CD pipelines. When you commit changes to `Week1_Automation.ps1` or Phase 4 modules, the pipeline automatically:

1. ✅ Validates Azure environment
2. 🚀 Executes Week 1 automation script
3. 📜 Generates Markdown + HTML Codex Scrolls
4. 📧 Sends email to sponsors via Graph API
5. 📊 Pushes metrics to Power BI
6. 📤 Archives artifacts (checkpoints, scrolls, execution report)

**Two Pipeline Options:**
- **GitHub Actions** (`.github/workflows/phase4-scroll-delivery.yml`) - Windows runner, PowerShell 7
- **Azure DevOps** (`azure-pipelines.yml`) - Multi-stage pipeline with dedicated email delivery stage

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     Git Commit to Main Branch                   │
│   Modified: Week1_Automation.ps1, Get-CodexEmailBody.psm1      │
└─────────────────────┬───────────────────────────────────────────┘
                      │
                      ▼
    ┌─────────────────────────────────────────────┐
    │          CI/CD Pipeline Trigger             │
    │  • GitHub Actions (windows-latest runner)   │
    │  • Azure DevOps (multi-stage pipeline)      │
    └─────────────────┬───────────────────────────┘
                      │
                      ▼
    ┌─────────────────────────────────────────────┐
    │       Stage 1: Validate Environment         │
    │  • Azure CLI authentication                 │
    │  • Resource group existence check           │
    │  • Key Vault validation                     │
    └─────────────────┬───────────────────────────┘
                      │
                      ▼
    ┌─────────────────────────────────────────────┐
    │     Stage 2: Execute Week 1 Automation      │
    │  • Run Week1_Automation.ps1                 │
    │  • 🔐 Key Vault setup (3 secrets)           │
    │  • 👥 RBAC personas (4 groups)              │
    │  • 🔑 Certificate auth (Graph API)          │
    │  • 🛡️ Circuit Breaker deployment           │
    │  • 📡 Health Check API (Container App)      │
    │  • 🧪 Validation protocol                   │
    │  • Generate checkpoints JSON                │
    └─────────────────┬───────────────────────────┘
                      │
                      ▼
    ┌─────────────────────────────────────────────┐
    │    Stage 3: Generate Codex Scrolls          │
    │  • Call New-CodexScroll (Markdown)          │
    │  • Call New-CodexScroll (HTML)              │
    │  • Preserve SHA256 placeholders             │
    │  • Embed Power BI dashboard anchors         │
    │  • Save to Sponsors/ directory              │
    └─────────────────┬───────────────────────────┘
                      │
                      ▼
    ┌─────────────────────────────────────────────┐
    │   Stage 4: Email Delivery (IdentityAgent)   │
    │  • Import Get-CodexEmailBody.psm1           │
    │  • Get Graph API access token               │
    │  • Call Get-CodexEmailBody (wrap HTML)      │
    │  • Test-CodexEmailPayload validation        │
    │  • Send-CodexEmail via /me/sendMail         │
    │  • Attach Markdown scroll                   │
    └─────────────────┬───────────────────────────┘
                      │
                      ▼
    ┌─────────────────────────────────────────────┐
    │    Stage 5: Metrics & Artifact Archival     │
    │  • Parse Week1_Checkpoints.json             │
    │  • Calculate success rate (jq analysis)     │
    │  • Push metrics to Power BI streaming API   │
    │  • Upload artifacts (GitHub/Azure DevOps)   │
    │  • Generate execution report                │
    └─────────────────┬───────────────────────────┘
                      │
                      ▼
    ┌─────────────────────────────────────────────┐
    │           Sponsor Inbox Delivery            │
    │  📧 Email received with:                    │
    │  • Gradient header (Fluent 2 design)        │
    │  • Summary table (Session ID, checkpoints)  │
    │  • Embedded HTML scroll                     │
    │  • Power BI dashboard link                  │
    │  • Markdown attachment                      │
    └─────────────────────────────────────────────┘
```

---

## Prerequisites

### Common Requirements (Both Pipelines)

1. **Azure Subscription**
   - Active Azure subscription with Owner or Contributor role
   - Resource group: `Phase4RG` (or custom name)
   - Region: `centralus` (or custom region)

2. **Azure Service Principal**
   ```bash
   # Create service principal with Contributor role
   az ad sp create-for-rbac --name "Phase4-ServicePrincipal" \
     --role Contributor \
     --scopes /subscriptions/{subscription-id}/resourceGroups/Phase4RG \
     --sdk-auth
   
   # Output format (save this JSON):
   {
     "clientId": "...",
     "clientSecret": "...",
     "subscriptionId": "...",
     "tenantId": "...",
     "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
     "resourceManagerEndpointUrl": "https://management.azure.com/",
     "activeDirectoryGraphResourceId": "https://graph.windows.net/",
     "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
     "galleryEndpointUrl": "https://gallery.azure.com/",
     "managementEndpointUrl": "https://management.core.windows.net/"
   }
   ```

3. **Graph API Permissions**
   ```bash
   # Grant Mail.Send permission to service principal
   az ad app permission add --id {app-id} \
     --api 00000003-0000-0000-c000-000000000000 \
     --api-permissions e1fe6dd8-ba31-4d61-89e7-88639da4683d=Scope
   
   # Admin consent (requires Global Administrator)
   az ad app permission admin-consent --id {app-id}
   ```

4. **PowerShell Modules**
   - `Az.KeyVault` (Azure Key Vault management)
   - `Az.Resources` (Resource group operations)
   - `Microsoft.Graph` (Graph API calls, optional - uses Invoke-RestMethod fallback)

---

## GitHub Actions Setup

### Step 1: Configure Repository Secrets

Navigate to **GitHub Repository → Settings → Secrets and variables → Actions → New repository secret**

| Secret Name | Value | Description |
|-------------|-------|-------------|
| `AZURE_CREDENTIALS` | Service principal JSON | Output from `az ad sp create-for-rbac --sdk-auth` |
| `SPONSOR_EMAIL` | sponsor@intelintent.com | Primary sponsor email address |
| `POWERBI_DASHBOARD_URL` | https://app.powerbi.com/... | Power BI dashboard URL for email link |
| `POWERBI_PUSH_URL` | https://api.powerbi.com/... | (Optional) Power BI streaming dataset push URL |

### Step 2: Verify Workflow File

Ensure `.github/workflows/phase4-scroll-delivery.yml` exists with correct trigger:

```yaml
on:
  push:
    branches:
      - main
    paths:
      - 'Week1_Automation.ps1'
      - 'IntelIntent_Seeding/*.psm1'
      - '.github/workflows/phase4-scroll-delivery.yml'
```

### Step 3: Test Workflow Dispatch

```bash
# Manual workflow trigger (first-time test)
gh workflow run phase4-scroll-delivery.yml \
  --ref main \
  --field dryRun=true \
  --field skipEmail=false
```

### Step 4: Monitor Execution

Navigate to **Actions → Phase 4 Codex Scroll Delivery → Latest run**

**Expected Artifacts:**
- `week1-checkpoints` (Week1_Checkpoints.json)
- `codex-scroll-markdown` (Week1_Codex_Scroll.md)
- `codex-scroll-html` (Week1_Codex_Scroll.html)

**Expected Output:**
```
✅ Subscription: Azure Subscription 1
✅ Resource group exists: Phase4RG
🚀 Executing Phase 4 Week 1 Automation
🔐 Task: Create Key Vault - Success (12.3s)
👥 Task: Create RBAC Groups - Success (8.7s)
🔑 Task: Certificate Authentication - Success (15.2s)
🛡️ Task: Circuit Breaker Deployment - Success (6.1s)
📡 Task: Health Check API - Success (22.4s)
🧪 Task: Validation Protocol - Success (9.5s)
📜 Codex Scroll generated: Week1_Codex_Scroll.md
📜 Codex Scroll generated: Week1_Codex_Scroll.html
✅ Codex Scroll delivered to sponsors
```

---

## Azure DevOps Setup

### Step 1: Create Service Connection

Navigate to **Azure DevOps Project → Project Settings → Service connections → New service connection → Azure Resource Manager**

1. **Connection type:** Service principal (automatic)
2. **Subscription:** Select your Azure subscription
3. **Resource group:** Phase4RG
4. **Service connection name:** `Phase4-ServiceConnection`
5. **Grant access permission to all pipelines:** ✅ Checked

### Step 2: Configure Pipeline Variables

Navigate to **Pipelines → Library → + Variable group**

**Variable Group Name:** `Phase4-Variables`

| Variable Name | Value | Secret? | Description |
|---------------|-------|---------|-------------|
| `SponsorEmail` | sponsor@intelintent.com | ❌ No | Primary sponsor email |
| `PowerBIDashboardUrl` | https://app.powerbi.com/... | ❌ No | Dashboard URL for email |
| `PowerBIPushUrl` | https://api.powerbi.com/... | ✅ Yes | (Optional) Streaming dataset push URL |

### Step 3: Create Pipeline

Navigate to **Pipelines → New pipeline → Azure Repos Git → Select repository → Existing Azure Pipelines YAML file**

1. **Path:** `/azure-pipelines.yml`
2. **Branch:** `main`
3. Click **Continue** → **Run**

### Step 4: Configure Pipeline Parameters

On first run, configure runtime parameters:

| Parameter | Default | Options | Description |
|-----------|---------|---------|-------------|
| `skipEmail` | `false` | true/false | Skip email delivery to sponsors |
| `dryRun` | `false` | true/false | Simulation mode (no Azure changes) |

### Step 5: Monitor Execution

Navigate to **Pipelines → Recent → Latest run**

**Expected Stages:**
1. ✅ **Build** - Validate Azure environment
2. ✅ **Execute** - Run Week 1 automation
3. ✅ **Deliver** - Send Codex Scroll email
4. ✅ **Analyze** - Parse metrics and push to Power BI
5. ✅ **Notify** - Pipeline status notification

**Expected Artifacts:**
- `week1-checkpoints` (Week1_Checkpoints.json)
- `codex-scroll-markdown` (Week1_Codex_Scroll.md)
- `codex-scroll-html` (Week1_Codex_Scroll.html)
- `execution-report` (ExecutionReport.md)

---

## Email Template Preview

When sponsors receive the automated email:

```html
Subject: IntelIntent Phase 4 Week 1 Complete - Codex Lineage Report

┌────────────────────────────────────────────────────────────┐
│ Phase 4 Codex Scroll Update                                │
│ [Gradient Header: #0078D4 → #005A9E]                       │
└────────────────────────────────────────────────────────────┘

Execution Summary
─────────────────
Session ID: WK1-20250115-103045
Total Checkpoints: 26
Success Rate: 100%
Timestamp: 2025-01-15 10:30:45 UTC

Codex Scroll Lineage
────────────────────
[Embedded HTML scroll with preserved SHA256 placeholders]

🔐 Secrets & Key Vault (4 checkpoints)
  ├─ Create Key Vault: IntelIntentSecrets
  ├─ Store Graph API Secret: [Pending SHA256]
  ├─ Store OpenAI Secret: [Pending SHA256]
  └─ Managed Identity Validation: [Pending SHA256]

👥 RBAC Personas (4 checkpoints)
  ├─ Create Phase4-Admin group
  ├─ Create Phase4-Developer group
  ├─ Create Phase4-Sponsor group
  └─ Create Phase4-Auditor group

[...additional checkpoints...]

Cryptographic Verification
──────────────────────────
⚠️ SHA256 signatures pending final execution.
Once generated, validate against Power BI dashboard.

📊 View Live Dashboard
[https://app.powerbi.com/groups/...]

─────────────────────────────────────────────────────────────
IntelIntent Phase 4 Production Hardening
Automated Delivery via IdentityAgent
─────────────────────────────────────────────────────────────

Attachments:
📎 Week1_Codex_Scroll.md (Markdown format for audit archives)
```

---

## Customization Options

### 1. Change Trigger Paths

**GitHub Actions:**
```yaml
on:
  push:
    paths:
      - 'Week1_Automation.ps1'
      - 'IntelIntent_Seeding/*.psm1'
      - 'CustomModule/*.ps1'  # Add custom module
```

**Azure DevOps:**
```yaml
trigger:
  paths:
    include:
      - Week1_Automation.ps1
      - IntelIntent_Seeding/*.psm1
      - CustomModule/*.ps1  # Add custom module
```

### 2. Add Multiple Sponsor Recipients

Update email delivery step:

```powershell
$payload = Get-CodexEmailBody `
  -ScrollPath ".\Sponsors\Week1_Codex_Scroll.html" `
  -Recipients @(
    "sponsor1@intelintent.com",
    "sponsor2@intelintent.com",
    "executive@intelintent.com"
  ) `
  -CcRecipients @("auditor@intelintent.com") `
  -Subject "IntelIntent Phase 4 Week 1 Complete - Codex Lineage Report"
```

### 3. Custom Email Template Style

Change `Get-CodexEmailBody` call:

```powershell
-Template "TechnicalDeepDive"  # Options: Executive, TechnicalDeepDive, ComplianceAudit
```

### 4. Dry Run Mode (No Azure Changes)

**GitHub Actions:**
```bash
gh workflow run phase4-scroll-delivery.yml --field dryRun=true
```

**Azure DevOps:**
- Navigate to **Run pipeline** → Set `dryRun` parameter to `true`

### 5. Skip Email Delivery

**GitHub Actions:**
```bash
gh workflow run phase4-scroll-delivery.yml --field skipEmail=true
```

**Azure DevOps:**
- Navigate to **Run pipeline** → Set `skipEmail` parameter to `true`

---

## Troubleshooting

### Issue 1: Azure Authentication Failed

**Error Message:**
```
ERROR: AADSTS700016: Application with identifier '...' was not found
```

**Solution:**
1. Verify service principal credentials in GitHub Secrets or Azure DevOps Service Connection
2. Re-create service principal:
   ```bash
   az ad sp create-for-rbac --name "Phase4-ServicePrincipal" --role Contributor --sdk-auth
   ```
3. Update secret/service connection with new credentials

### Issue 2: Graph API Permission Denied

**Error Message:**
```
ERROR: Insufficient privileges to complete the operation (Mail.Send)
```

**Solution:**
1. Grant Mail.Send permission:
   ```bash
   az ad app permission add --id {app-id} \
     --api 00000003-0000-0000-c000-000000000000 \
     --api-permissions e1fe6dd8-ba31-4d61-89e7-88639da4683d=Scope
   ```
2. Admin consent required:
   ```bash
   az ad app permission admin-consent --id {app-id}
   ```
3. Wait 5-10 minutes for permission propagation

### Issue 3: Email Payload Validation Failed

**Error Message:**
```
ERROR: Email payload validation failed - HTML scroll not found
```

**Solution:**
1. Verify HTML scroll generated:
   ```powershell
   Test-Path ".\Sponsors\Week1_Codex_Scroll.html"
   ```
2. Check scroll generation in Week1_Automation.ps1:
   ```powershell
   New-CodexScroll -Format HTML -OutputPath ".\Sponsors\Week1_Codex_Scroll.html"
   ```
3. Verify `CodexRenderer.psm1` module imported before scroll generation

### Issue 4: Checkpoint JSON Not Found

**Error Message:**
```
ERROR: Week1_Checkpoints.json not found
```

**Solution:**
1. Verify checkpoint creation in Week1_Automation.ps1:
   ```powershell
   $checkpoints | ConvertTo-Json -Depth 10 | Set-Content "Week1_Checkpoints.json"
   ```
2. Check file path is relative to repository root (not Sponsors/ subdirectory)

### Issue 5: Power BI Push Failed

**Error Message:**
```
ERROR: 401 Unauthorized - Power BI streaming dataset
```

**Solution:**
1. Verify `POWERBI_PUSH_URL` secret/variable is correctly formatted:
   ```
   https://api.powerbi.com/beta/{workspaceId}/datasets/{datasetId}/rows?key={key}
   ```
2. Regenerate streaming dataset API key in Power BI
3. Update secret/variable with new key

### Issue 6: Artifact Upload Failed (GitHub Actions)

**Error Message:**
```
ERROR: Unable to upload artifact 'week1-checkpoints' - file not found
```

**Solution:**
1. Verify file exists before upload:
   ```yaml
   - name: Verify Checkpoint Exists
     run: |
       if (-not (Test-Path "Week1_Checkpoints.json")) {
         Write-Error "Checkpoint JSON not found"
         exit 1
       }
   ```
2. Check path is relative to `$(Build.SourcesDirectory)` (Azure DevOps) or `$GITHUB_WORKSPACE` (GitHub Actions)

---

## Pipeline Metrics

### GitHub Actions

**Average Execution Time:**
- Validation: ~30 seconds
- Week 1 Automation: ~5-7 minutes (depends on Azure resource creation)
- Scroll Generation: ~15 seconds
- Email Delivery: ~10 seconds
- Artifact Upload: ~20 seconds
- **Total: ~8-10 minutes**

**Artifact Retention:**
- Checkpoints: 90 days
- Scrolls: 90 days
- Execution logs: 90 days

### Azure DevOps

**Average Execution Time:**
- Stage 1 (Build/Validate): ~45 seconds
- Stage 2 (Execute): ~5-7 minutes
- Stage 3 (Deliver): ~30 seconds
- Stage 4 (Analyze): ~1 minute
- Stage 5 (Notify): ~10 seconds
- **Total: ~9-12 minutes**

**Artifact Retention:**
- Checkpoints: Default (30 days, configurable)
- Scrolls: Default (30 days)
- Execution Report: Default (30 days)

---

## Security Considerations

### 1. Secrets Management

**✅ DO:**
- Store service principal credentials in GitHub Secrets or Azure DevOps Variable Groups
- Mark sensitive variables as "Secret" in Azure DevOps
- Use Azure Key Vault for certificate storage (not pipeline secrets)
- Rotate service principal client secrets every 90 days

**❌ DON'T:**
- Hardcode credentials in YAML files
- Commit secrets to repository
- Share service principal credentials via email or chat
- Use personal Azure credentials for service principals

### 2. Graph API Access

**✅ DO:**
- Use application permissions (Mail.Send) instead of delegated permissions
- Limit service principal to specific mailbox (shared mailbox recommended)
- Enable conditional access policies for service principal
- Monitor Graph API audit logs for unauthorized access

**❌ DON'T:**
- Grant User.ReadWrite.All or Directory.ReadWrite.All permissions (excessive privilege)
- Use personal user accounts for Graph API authentication
- Skip admin consent step (permissions won't work)

### 3. Azure Resources

**✅ DO:**
- Use dedicated resource group for Phase 4 resources
- Apply resource locks to prevent accidental deletion
- Enable Azure Policy for governance (e.g., required tags, allowed regions)
- Use managed identities for Azure service authentication

**❌ DON'T:**
- Grant pipeline service principal Owner role (use Contributor)
- Deploy to production subscription during testing
- Skip resource validation step before execution

---

## Next Steps

### Week 2-12 Pipeline Extensions

1. **Update Trigger Paths:**
   ```yaml
   paths:
     - 'Week*_Automation.ps1'  # Match all week automation scripts
     - 'IntelIntent_Seeding/*.psm1'
   ```

2. **Parameterize Week Number:**
   ```powershell
   [CmdletBinding()]
   param(
       [Parameter(Mandatory = $false)]
       [int]$WeekNumber = 1
   )
   
   $scriptPath = "Week$($WeekNumber)_Automation.ps1"
   & $scriptPath
   ```

3. **Aggregate Codex Scrolls:**
   - Combine Week 1-12 checkpoints into master lineage report
   - Generate cumulative Power BI metrics
   - Email quarterly executive summary

### Integration with Phase 5 (Scale Testing)

1. **Load Testing Pipeline:**
   - Trigger Phase 5 scale tests after Week 12 completion
   - Simulate 1000+ concurrent API calls to Health Check API
   - Validate Circuit Breaker fallback under throttling

2. **Disaster Recovery Validation:**
   - Schedule weekly DR drills (automated Key Vault restore, RBAC re-configuration)
   - Test cross-region failover for Health Check API
   - Validate backup artifact retrieval from GitHub/Azure DevOps

---

## Appendix: Full Environment Variable Reference

### GitHub Actions Environment Variables

| Variable | Example Value | Source |
|----------|---------------|--------|
| `AZURE_RESOURCE_GROUP` | Phase4RG | Workflow file (`env:`) |
| `AZURE_LOCATION` | centralus | Workflow file (`env:`) |
| `VAULT_NAME` | IntelIntentSecrets | Workflow file (`env:`) |
| `AZURE_CREDENTIALS` | (JSON) | Repository secret |
| `SPONSOR_EMAIL` | sponsor@intelintent.com | Repository secret |
| `POWERBI_DASHBOARD_URL` | https://app.powerbi.com/... | Repository secret |
| `POWERBI_PUSH_URL` | https://api.powerbi.com/... | Repository secret (optional) |
| `GITHUB_TOKEN` | (auto-generated) | GitHub Actions default |

### Azure DevOps Pipeline Variables

| Variable | Example Value | Source |
|----------|---------------|--------|
| `azureResourceGroup` | Phase4RG | Pipeline variables |
| `azureLocation` | centralus | Pipeline variables |
| `vaultName` | IntelIntentSecrets | Pipeline variables |
| `SponsorEmail` | sponsor@intelintent.com | Variable group |
| `PowerBIDashboardUrl` | https://app.powerbi.com/... | Variable group |
| `PowerBIPushUrl` | https://api.powerbi.com/... | Variable group (secret) |
| `Build.SourcesDirectory` | $(Pipeline.Workspace)/s | System variable |
| `System.ArtifactsDirectory` | $(Pipeline.Workspace)/a | System variable |

---

## Support

**Questions or Issues?**
- Review pipeline logs in GitHub Actions or Azure DevOps
- Check `Week1_Checkpoints.json` for task-level errors
- Verify Azure resource creation in Azure Portal
- Test email delivery manually with `Send-CodexScrollEmail` cmdlet

**Documentation:**
- GitHub Actions: https://docs.github.com/actions
- Azure DevOps Pipelines: https://learn.microsoft.com/azure/devops/pipelines
- Graph API Mail: https://learn.microsoft.com/graph/api/user-sendmail

---

**Last Updated:** 2025-01-15
**Version:** 1.0.0
**Maintainer:** IntelIntent Phase 4 Team
