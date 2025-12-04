# Copilot Lifecycle Tracking - Complete Bundle

**IntelIntent Phase 4 - Production Hardening**  
**Version**: 1.0.0  
**Last Updated**: 2025-11-28

---

## 🎯 Quick Start

### For Impatient Developers (< 5 minutes)

```powershell
# 1. Clone/navigate to IntelIntent workspace
cd "c:\Users\BOOPA\OneDrive\IntelIntent!"

# 2. Log your first lifecycle event
.\codex\scripts\Log-CopilotLifecycle.ps1 -Action Enable -Workspace IntelIntent

# 3. Log an invocation event
.\codex\scripts\Log-CopilotInvocation.ps1 -InvocationType Inline -CommandID "editor.action.inlineSuggest.trigger"

# 4. Validate integrity
.\codex\scripts\Test-CodexIntegrity.ps1

# 5. View logs
Get-Content .\codex\logs\CopilotLifecycleLog.json | ConvertFrom-Json | Format-List
```

**Expected Output:**
```
✅ Lifecycle event logged successfully
✅ Invocation event logged successfully
✅ Integrity validation passed
   - Lifecycle Log Valid: True
   - Invocation Log Valid: True
   - Hash Compliance: 30% (10 placeholders remaining)
```

---

## 📦 What's Included

### Complete Deliverables Bundle

```
codex/
├── logs/                          # JSON log files (auto-generated)
│   ├── CopilotLifecycleLog.json   # 10 sample lifecycle events
│   └── CopilotInvocationLog.json  # 15 sample invocation events
│
├── scripts/                       # Logging & validation scripts
│   ├── PowerShell (Windows-native)
│   │   ├── Log-CopilotLifecycle.ps1      # Lifecycle event logger
│   │   ├── Log-CopilotInvocation.ps1     # Invocation event logger
│   │   └── Test-CodexIntegrity.ps1       # Integrity validator
│   │
│   ├── Node.js (Cross-platform)
│   │   ├── log-copilot-lifecycle.js      # Lifecycle logger (crypto)
│   │   ├── log-copilot-invocation.js     # Invocation logger (UUID)
│   │   └── validate-codex-integrity.js   # Schema validator (Ajv)
│   │
│   └── package.json (NOT INCLUDED)       # See Installation section below
│
├── schemas/                       # JSON Schema validation
│   └── copilot-events.schema.json # JSON Schema Draft 2020-12
│
├── dashboards/                    # Power BI integration
│   ├── measures.md                # DAX measures library (35+ measures)
│   └── PBIX_WIRING_GUIDE.md       # Step-by-step setup instructions
│
└── docs/                          # Documentation & CI/CD
    ├── Copilot-Lineage-Guide.md   # Comprehensive guide (16,000+ words)
    ├── github-actions-workflow.yml # GitHub Actions CI/CD pipeline
    └── azure-pipelines-copilot.yml # Azure DevOps 6-stage pipeline
```

---

## 🚀 Installation

### Prerequisites

**PowerShell:**
- PowerShell 7.0+ (check: `pwsh --version`)
- Windows 10/11 or Windows Server 2019+

**Node.js (Optional - for cross-platform):**
- Node.js 20.x+ (check: `node --version`)
- npm 10.x+ (check: `npm --version`)

**Azure CLI (Optional - for CI/CD):**
- Azure CLI 2.50+ (check: `az --version`)
- Authenticated session (run: `az login`)

**Power BI Desktop (Optional - for dashboard):**
- Power BI Desktop (November 2024 or later)
- Download: https://aka.ms/pbidesktop

---

### Step 1: Install Node.js Dependencies (Cross-Platform Only)

If using Node.js scripts for cross-platform environments:

```bash
# Navigate to scripts directory
cd codex/scripts

# Create package.json
cat > package.json << EOF
{
  "name": "intelintent-copilot-tracking",
  "version": "1.0.0",
  "description": "Cross-platform Copilot lifecycle tracking for IntelIntent",
  "main": "index.js",
  "scripts": {
    "log-lifecycle": "node log-copilot-lifecycle.js",
    "log-invocation": "node log-copilot-invocation.js",
    "validate": "node validate-codex-integrity.js"
  },
  "dependencies": {
    "ajv": "^8.12.0",
    "ajv-formats": "^2.1.1"
  },
  "engines": {
    "node": ">=20.0.0"
  },
  "author": "IntelIntent Team",
  "license": "MIT"
}
EOF

# Install dependencies
npm install
```

**Expected Output:**
```
added 5 packages, and audited 6 packages in 2s
found 0 vulnerabilities
```

---

### Step 2: Verify Script Permissions (PowerShell)

```powershell
# Check execution policy
Get-ExecutionPolicy

# If restricted, set to RemoteSigned (run as Administrator)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Test script execution
.\codex\scripts\Log-CopilotLifecycle.ps1 -Action Enable -Workspace "IntelIntent" -DryRun
```

**Expected Output:**
```
[DRY RUN] Would log lifecycle event: Enable
Extension ID: github.copilot
Workspace: IntelIntent
```

---

### Step 3: Initialize Log Files (First Run)

Scripts automatically create log files on first execution, but you can pre-initialize:

```powershell
# Initialize with sample data
Copy-Item -Path ".\codex\logs\CopilotLifecycleLog.json" -Destination ".\codex\logs\CopilotLifecycleLog.bak.json"
Copy-Item -Path ".\codex\logs\CopilotInvocationLog.json" -Destination ".\codex\logs\CopilotInvocationLog.bak.json"

Write-Host "✅ Sample logs backed up to .bak.json files"
```

---

## 🔧 Usage Examples

### PowerShell Scripts

#### Example 1: Log Extension Enable
```powershell
.\codex\scripts\Log-CopilotLifecycle.ps1 `
  -Action "Enable" `
  -Version "v1.389.0" `
  -Workspace "IntelIntent" `
  -Reason "Starting Week 2 orchestration" `
  -Stage "Week2"
```

#### Example 2: Log Inline Suggestion
```powershell
.\codex\scripts\Log-CopilotInvocation.ps1 `
  -InvocationType "Inline" `
  -CommandID "editor.action.inlineSuggest.trigger" `
  -ShortcutUsed "Ctrl+I" `
  -CompletionModel "gpt-4o-2024-05-13" `
  -Workspace "IntelIntent" `
  -Context "Writing Test-CheckpointSchema function" `
  -FilePath ".github/copilot-instructions.md"
```

#### Example 3: Log Agent Task
```powershell
.\codex\scripts\Log-CopilotInvocation.ps1 `
  -InvocationType "Agent" `
  -CommandID "github.copilot.agent.invoke" `
  -CompletionModel "claude-sonnet-4.5-2024-11-27" `
  -Workspace "IntelIntent" `
  -Context "Agent task: Generate Orchestrator.ps1 validation logic" `
  -FilePath "IntelIntent_Seeding/Orchestrator.ps1" `
  -Stage "Week2"
```

#### Example 4: Validate Integrity
```powershell
$result = .\codex\scripts\Test-CodexIntegrity.ps1 -Verbose

if ($result.AllValid) {
    Write-Host "✅ All logs valid!" -ForegroundColor Green
    Write-Host "   Total Events: $($result.TotalEvents)"
    Write-Host "   Hash Compliance: $($result.HashCompliancePercent)%"
} else {
    Write-Host "❌ Validation failed!" -ForegroundColor Red
    $result.Issues | ForEach-Object { Write-Warning $_ }
}
```

---

### Node.js Scripts

#### Example 1: Log Extension Update (Linux/macOS)
```bash
node codex/scripts/log-copilot-lifecycle.js \
  --action Update \
  --version v1.389.0 \
  --workspace IntelIntent \
  --reason "CI/CD pipeline triggered update" \
  --stage Production
```

#### Example 2: Log Chat Invocation
```bash
node codex/scripts/log-copilot-invocation.js \
  --invocation-type Chat \
  --command-id github.copilot.chat.open \
  --completion-model claude-sonnet-4.5-2024-11-27 \
  --workspace IntelIntent \
  --context "Asked: How do I integrate Semantic Kernel?"
```

#### Example 3: Validate with Ajv
```bash
node codex/scripts/validate-codex-integrity.js

# Check exit code
if [ $? -eq 0 ]; then
  echo "✅ Validation passed"
else
  echo "❌ Validation failed"
  exit 1
fi
```

---

### Integration with Existing Scripts

#### Pattern 1: Wrap Existing Automation
```powershell
# Week1_Automation.ps1 (add logging)
Import-Module .\codex\scripts\CopilotLifecycleTracker.psm1 -ErrorAction SilentlyContinue

# Log start
.\codex\scripts\Log-CopilotLifecycle.ps1 -Action Enable -Reason "Starting Week 1 automation"

try {
    # Existing Week 1 automation logic
    Invoke-TaskWithCheckpoint -TaskID "KV-001" -ScriptBlock {
        New-AzKeyVault -ResourceGroupName "Phase4RG" -Name "IntelIntentSecrets"
    }
    
    # Log invocation (if Copilot assisted)
    .\codex\scripts\Log-CopilotInvocation.ps1 `
      -InvocationType "Inline" `
      -Context "Auto-complete for New-AzKeyVault parameters"
    
} finally {
    # Log end
    .\codex\scripts\Log-CopilotLifecycle.ps1 -Action Disable -Reason "Week 1 automation complete"
}
```

#### Pattern 2: CI/CD Pre-Commit Hook
```powershell
# .git/hooks/pre-commit (or use Husky for Git hooks)
#!/usr/bin/env pwsh

Write-Host "🔍 Running Codex integrity check..."

$result = & ".\codex\scripts\Test-CodexIntegrity.ps1"

if (-not $result.AllValid) {
    Write-Host "❌ Integrity check failed! Blocking commit." -ForegroundColor Red
    Write-Host "   Fix errors in codex/logs/*.json before committing."
    exit 1
}

Write-Host "✅ Integrity check passed" -ForegroundColor Green
exit 0
```

---

## 📊 Power BI Dashboard Setup

### Quick Setup (15 minutes)

1. **Open Power BI Desktop**

2. **Import JSON Logs**:
   - Home → Get Data → JSON
   - Select: `codex/logs/CopilotLifecycleLog.json`
   - Repeat for: `codex/logs/CopilotInvocationLog.json`

3. **Transform Data** (Power Query):
   - Expand `Events` array → New rows
   - Expand event properties → Columns
   - Set data types (Date/Time, Text, Number)
   - Add derived columns (Date, Hour, DayOfWeek)
   - Rename queries to: `CopilotLifecycle` and `CopilotInvocations`

4. **Import DAX Measures**:
   - Create `_Measures` table
   - Copy measures from `codex/dashboards/measures.md`
   - Paste into New Measure formula bar

5. **Build Visuals**:
   - Page 1: Active Status % KPI, Lifecycle Timeline, Invocation Breakdown
   - Page 2: Version Lineage Table, Hash Compliance Gauge
   - Page 3: Duration by Type, Model Usage Donut Chart
   - Page 4: MTTR KPI, Daily Trend Line

**Detailed Instructions:** See [PBIX_WIRING_GUIDE.md](dashboards/PBIX_WIRING_GUIDE.md)

---

## 🔄 CI/CD Integration

### GitHub Actions

**Setup:**
1. Copy `codex/docs/github-actions-workflow.yml` to `.github/workflows/copilot-lifecycle.yml`
2. Add secrets to GitHub repository:
   - `AZURE_CREDENTIALS`
   - `POWERBI_CLIENT_ID`, `POWERBI_CLIENT_SECRET`, `POWERBI_TENANT_ID`
   - `POWERBI_WORKSPACE_ID`, `POWERBI_DATASET_ID`
3. Commit and push to trigger pipeline

**Features:**
- ✅ Automatic logging on push to main
- ✅ Integrity validation gate (fails pipeline if invalid)
- ✅ Schema validation with Ajv
- ✅ Power BI dataset refresh trigger
- ✅ PR comment with validation results
- ✅ Scheduled snapshots every 6 hours

---

### Azure DevOps

**Setup:**
1. Import `codex/docs/azure-pipelines-copilot.yml` to Azure Pipelines
2. Create service connection: "Phase4-ServiceConnection"
3. Set pipeline variables:
   - `PowerBIWorkspaceID`, `PowerBIDatasetID`
   - `SponsorEmail`, `SmtpUsername`, `SmtpPassword`
4. Run pipeline to validate configuration

**6-Stage Pipeline:**
1. **LifecycleLogging**: Log events, publish artifacts
2. **IntegrityValidation**: PowerShell integrity tests
3. **SchemaValidation**: Node.js Ajv validation
4. **StorageUpload**: Upload to Azure Blob Storage
5. **PowerBIRefresh**: Trigger dataset refresh
6. **Notification**: Email summary to sponsors

---

## 📖 Documentation

### Comprehensive Guides

1. **[Copilot-Lineage-Guide.md](docs/Copilot-Lineage-Guide.md)** (16,000+ words)
   - Executive summary for sponsors
   - System architecture with Mermaid diagrams
   - Event types & interpretation
   - Power BI dashboard guide
   - Best practices & governance model
   - Troubleshooting recipes

2. **[PBIX_WIRING_GUIDE.md](dashboards/PBIX_WIRING_GUIDE.md)** (7,500+ words)
   - Step-by-step Power Query transformations
   - DAX measure import instructions
   - Visual setup with recommended formats
   - Slicer configuration
   - Troubleshooting common issues

3. **[measures.md](dashboards/measures.md)** (2,500+ lines)
   - 35+ pre-built DAX measures
   - Lifecycle metrics (Enables, Disables, Updates)
   - Invocation metrics (Inline, Chat, Agent)
   - Performance metrics (Avg Duration, MTTR)
   - Compliance metrics (Hash Compliance, Success Rate)

4. **[copilot-events.schema.json](schemas/copilot-events.schema.json)** (225 lines)
   - JSON Schema Draft 2020-12
   - Validates both lifecycle and invocation events
   - Required fields, format constraints, enum validation
   - OneOf discriminator for event types

---

## 🐛 Troubleshooting

### Common Issues

#### Issue: "Log file not found"
**Solution:**
```powershell
# Create log directory if missing
New-Item -ItemType Directory -Path ".\codex\logs" -Force

# Initialize log files
.\codex\scripts\Log-CopilotLifecycle.ps1 -Action Enable -Workspace IntelIntent
```

---

#### Issue: "Integrity validation fails: Schema mismatch"
**Solution:**
```powershell
# Validate JSON syntax
Get-Content .\codex\logs\CopilotLifecycleLog.json | ConvertFrom-Json | Out-Null

# Check schema version
$log = Get-Content .\codex\logs\CopilotLifecycleLog.json | ConvertFrom-Json
Write-Host "Schema Version: $($log.SessionMetadata.SchemaVersion)"

# Regenerate log from scratch if corrupted
Remove-Item .\codex\logs\CopilotLifecycleLog.json
.\codex\scripts\Log-CopilotLifecycle.ps1 -Action Enable -Workspace IntelIntent
```

---

#### Issue: "Power BI shows no data after import"
**Solution:**
```powershell
# Verify log files have events
$lifecycleLog = Get-Content .\codex\logs\CopilotLifecycleLog.json | ConvertFrom-Json
Write-Host "Lifecycle Events: $($lifecycleLog.Events.Count)"

$invocationLog = Get-Content .\codex\logs\CopilotInvocationLog.json | ConvertFrom-Json
Write-Host "Invocation Events: $($invocationLog.Events.Count)"

# If zero events, logs are empty - add sample data
if ($lifecycleLog.Events.Count -eq 0) {
    .\codex\scripts\Log-CopilotLifecycle.ps1 -Action Enable -Workspace IntelIntent
    .\codex\scripts\Log-CopilotInvocation.ps1 -InvocationType Inline -CommandID "editor.action.inlineSuggest.trigger"
}
```

---

#### Issue: "Node.js script: 'ajv is not defined'"
**Solution:**
```bash
# Install dependencies
cd codex/scripts
npm install ajv@8.12.0 ajv-formats@2.1.1

# Verify installation
npm list ajv

# Expected output: ajv@8.12.0
```

---

#### Issue: "CI/CD pipeline fails: PowerShell script not found"
**GitHub Actions:**
```yaml
# Ensure checkout includes full path
- uses: actions/checkout@v4
  with:
    fetch-depth: 0

# Use relative path from repo root
- run: ./codex/scripts/Log-CopilotLifecycle.ps1 -Action Enable
  shell: pwsh
```

**Azure DevOps:**
```yaml
# Use $(System.DefaultWorkingDirectory) for absolute paths
- task: PowerShell@2
  inputs:
    filePath: '$(System.DefaultWorkingDirectory)/codex/scripts/Log-CopilotLifecycle.ps1'
    pwsh: true
```

---

## 🔐 Security & Privacy

### Data Handling

**What is Logged:**
- Extension version and hash
- Extension unification status (`github.copilot-chat` vs. legacy `github.copilot`)
- Command IDs (e.g., `github.copilot.agent.invoke`)
- Timestamps and durations
- Workspace names
- File paths (sanitized, no PII)
- AI model names (e.g., `claude-sonnet-4.5`)

**What is NOT Logged:**
- ❌ Source code content
- ❌ Inline suggestion text
- ❌ Chat conversation details
- ❌ User credentials or tokens
- ❌ Personal identifiable information (PII)

### Compliance

- **GDPR**: No PII collected, workspace names are configurable
- **SOC 2 Type II**: Audit trail with SHA256 integrity validation
- **Data Retention**: 90 days active, 7 years archive tier
- **Encryption**: AES-256 at rest, TLS 1.3 in transit

---

## 🤝 Contributing

### Adding New Event Types

**Step 1: Update JSON Schema**
```json
// codex/schemas/copilot-events.schema.json
"InvocationType": {
  "enum": ["Inline", "Chat", "Agent", "Panel", "Edit", "Fix", "Test", "Explain", "NewFeature"]
}
```

**Step 2: Add DAX Measure**
```dax
// codex/dashboards/measures.md
NewFeatureInvocations = 
CALCULATE(
    COUNTROWS(CopilotInvocations),
    CopilotInvocations[InvocationType] = "NewFeature"
)
```

**Step 3: Update Documentation**
```markdown
// codex/docs/Copilot-Lineage-Guide.md
#### Invocation Type: **NewFeature**
Interpretation: [Add description]
```

---

### Testing New Scripts

```powershell
# Create test log directory
New-Item -ItemType Directory -Path ".\codex\logs\test" -Force

# Run script with test output path
.\codex\scripts\Log-CopilotLifecycle.ps1 `
  -Action Enable `
  -Workspace "TestWorkspace" `
  -OutputPath ".\codex\logs\test\CopilotLifecycleLog.json"

# Validate test log
.\codex\scripts\Test-CodexIntegrity.ps1 -LogPath ".\codex\logs\test"

# Clean up test data
Remove-Item -Path ".\codex\logs\test" -Recurse -Force
```

---

## 📞 Support

### Quick Links

- **Documentation**: [Copilot-Lineage-Guide.md](docs/Copilot-Lineage-Guide.md)
- **Power BI Setup**: [PBIX_WIRING_GUIDE.md](dashboards/PBIX_WIRING_GUIDE.md)
- **DAX Measures**: [measures.md](dashboards/measures.md)
- **JSON Schema**: [copilot-events.schema.json](schemas/copilot-events.schema.json)
- **IntelIntent Architecture**: [PHASE4_ARCHITECTURE_DIAGRAM.md](../PHASE4_ARCHITECTURE_DIAGRAM.md)

### Contact

- **Operations Team**: For daily monitoring and alerts
- **Development Team**: For script customization and enhancements
- **Sponsors**: For governance and compliance questions
- **Compliance Auditors**: For SOC 2 Type II audit trail exports

---

## 📋 Checklist: Production Readiness

### Pre-Production Validation

- [ ] **PowerShell Scripts**:
  - [ ] `Log-CopilotLifecycle.ps1` executes without errors
  - [ ] `Log-CopilotInvocation.ps1` executes without errors
  - [ ] `Test-CodexIntegrity.ps1` returns AllValid = True

- [ ] **Node.js Scripts** (if using cross-platform):
  - [ ] `npm install` completes without vulnerabilities
  - [ ] `node log-copilot-lifecycle.js` executes successfully
  - [ ] `node validate-codex-integrity.js` returns exit code 0

- [ ] **JSON Logs**:
  - [ ] `CopilotLifecycleLog.json` contains ≥1 event
  - [ ] `CopilotInvocationLog.json` contains ≥1 event
  - [ ] JSON schema validation passes (`AllValid = True`)

- [ ] **Power BI Dashboard**:
  - [ ] JSON files imported successfully
  - [ ] Power Query transformations applied
  - [ ] DAX measures loaded (≥20 measures)
  - [ ] Visuals render data correctly
  - [ ] Slicers sync across pages

- [ ] **CI/CD Integration**:
  - [ ] GitHub Actions workflow triggers on push
  - [ ] Azure DevOps pipeline runs successfully
  - [ ] Integrity validation gate works (fails on invalid logs)
  - [ ] Power BI refresh triggers automatically
  - [ ] Email notifications sent to sponsors

- [ ] **Documentation**:
  - [ ] Team trained on logging patterns
  - [ ] Sponsors briefed on dashboard usage
  - [ ] Governance model reviewed and approved
  - [ ] Troubleshooting guide accessible

---

## 🎉 Success Metrics

After 30 days of production use, you should observe:

| Metric | Target | Current |
|--------|--------|---------|
| **Active Status %** | ≥90% | _[Track in dashboard]_ |
| **Hash Compliance** | ≥95% | _[Track in dashboard]_ |
| **Success Rate** | ≥98% | _[Track in dashboard]_ |
| **MTTR (Hours)** | ≤2 | _[Track in dashboard]_ |
| **Agent Mode Adoption** | ≥15% | _[Track in dashboard]_ |
| **Daily Invocations** | >50 | _[Track in dashboard]_ |

**Review quarterly** with sponsors to validate ROI and adjust targets.

---

## 📜 License

**IntelIntent Copilot Lifecycle Tracking System**  
© 2025 IntelIntent Team  
Licensed under MIT License

**Third-Party Dependencies:**
- Ajv (MIT License)
- Ajv-Formats (MIT License)
- Power BI Desktop (Microsoft Commercial License)
- Azure CLI (MIT License)

---

## 🚀 Next Steps

1. **Immediate** (Today):
   - Run PowerShell scripts to generate first events
   - Validate integrity with `Test-CodexIntegrity.ps1`
   - Review sample logs

2. **This Week**:
   - Set up Power BI dashboard
   - Import DAX measures
   - Configure CI/CD pipeline
   - Train team on logging patterns

3. **This Month**:
   - Integrate logging into existing automation scripts
   - Establish weekly dashboard review cadence
   - Compute SHA256 hashes for pending events (target 95% compliance)

4. **This Quarter**:
   - Achieve ≥90% Active Status %
   - Automate Power BI scheduled refresh
   - Export first quarterly compliance report for sponsors

---

**Welcome to transparent AI-assisted development with full lineage tracking!** 🎯

For questions or feedback, contact the IntelIntent Operations Team.

**Document Version**: 1.0.0  
**Last Updated**: 2025-11-28  
**Next Review**: 2025-12-28
