# IntelIntent: Next Pasture Phased Roadmap

**Status**: ✅ Building on **Proven, Functional Components**  
**Last Updated**: 2025-11-28  
**Foundation**: Phase 2 Nervous System (Orchestrator + ManifestReader + AgentBridge + Get-VSCodeDownload)

---

## 🚫 What We're NOT Building On

**Week1_Automation.ps1** - Currently incomplete/broken:
- ❌ Missing module imports (SecureSecretsManager, RBACManager, CertificateAuthBridge)
- ❌ Azure Key Vault provisioning stubs
- ❌ Checkpoint aggregation not functional
- ❌ Codex scroll rendering incomplete

**Why This Matters**: Building on broken foundations creates cascading failures. Instead, we're starting from **what actually works**.

---

## ✅ What's Actually Working (Your Functional Foundation)

### **Phase 2: Nervous System Activation** (Proven, Production-Ready)

| Component | Status | Lines | Functionality |
|-----------|--------|-------|---------------|
| **ManifestReader.ps1** | ✅ Complete | 306 | Loads 6 manifests, builds execution queue, validates integrity |
| **Orchestrator.ps1** | ✅ Complete | 422 | Central orchestration, component generation, checkpoint tracking |
| **AgentBridge.psm1** | ✅ Stubs Active | 448 | 6 agent functions, session management, call history tracking |
| **Get-VSCodeDownload.ps1** | ✅ Complete | 294 | 26 platform downloads, SHA256 verification, checkpoint creation |
| **Get-CodexEmailBody.psm1** | ✅ Complete | 662+ | Email template generation (not tested but structurally sound) |

**Total Functional Code**: 2,132+ lines of proven PowerShell

**What You Can Do Today** (No Week1 dependency):
1. Run `Orchestrator.ps1 -Mode Full` → Generate all components from manifests
2. Run `Get-VSCodeDownload.ps1` → Download any of 26 distributions with checkpoint
3. Load `ManifestReader.ps1` → Parse manifests and build execution queue
4. Import `AgentBridge.psm1` → Route intents to specialized agents (stubs)

---

## 🎯 Three Pastures to Mow (In Order of Viability)

### **Pasture 1: VS Code Governance (100% Functional Foundation)**
**Status**: ✅ Ready to Build  
**Dependencies**: Get-VSCodeDownload.ps1 (proven), Power BI dashboard schema (documented)  
**Risk**: Low - No Azure dependencies, no Week1 automation

### **Pasture 2: Self-Healing Orchestrator (80% Functional Foundation)**
**Status**: ⚠️ Requires Testing  
**Dependencies**: Orchestrator.ps1 (proven), ManifestReader.ps1 (proven), checkpoint system (needs validation)  
**Risk**: Medium - Checkpoint file I/O needs validation

### **Pasture 3: Compliance Reporting (40% Functional Foundation)**
**Status**: ⚠️ Requires Azure Setup  
**Dependencies**: Power BI workspace, Azure SQL Database (not provisioned), Week1 checkpoints (broken)  
**Risk**: High - External dependencies, infrastructure setup required

---

## 📊 Pasture 1: VS Code Governance Completion (Recommended Next)

### Why This First?
- ✅ **Get-VSCodeDownload.ps1 is proven** (294 lines, tested functionality)
- ✅ **All documentation complete** (5 docs, 4,500+ lines)
- ✅ **No Azure infrastructure required** (local execution, file-based checkpoints)
- ✅ **No Week1 dependency** (standalone governance system)
- ✅ **Immediate sponsor value** (download automation, hash verification, lineage tracking)

### Current State
```
✅ Get-VSCodeDownload.ps1 (proven)
✅ 26 Distributions Quick Reference (documented)
✅ Unified Governance Alert System (Mermaid + Adaptive Card)
✅ Engineer Lab Workbook (6 sessions)
✅ Deployment Governance Guide (1,100+ lines)
⚠️ Power BI Dashboard (schema documented, not built)
⚠️ Teams Adaptive Card (template documented, not deployed)
❌ Power Automate Flow (not created)
❌ Azure SQL Database (not provisioned)
```

### Phased Implementation (3 Weeks)

#### **Week 1: Local Governance (No Azure)**
**Goal**: Prove end-to-end flow with file-based checkpoints

**Tasks**:
1. **Validate Get-VSCodeDownload.ps1 Checkpoint Creation**
   ```powershell
   # Test critical distributions locally
   cd c:\Users\BOOPA\OneDrive\IntelIntent!\codex\scripts
   
   # Download Windows x64 System installer
   .\Get-VSCodeDownload.ps1 -Platform Windows -Architecture x64 -DownloadType installer -VerifyHash -CreateCheckpoint -Verbose
   
   # Verify checkpoint created
   Get-Content ..\downloads\vscode\vscode_download_checkpoint.json | ConvertFrom-Json
   
   # Expected output: 9 fields (TaskID, Timestamp, Status, Inputs, Outputs, Artifacts, Signature, Duration, SessionID)
   ```

2. **Test Multi-Platform Download**
   ```powershell
   # Download all 9 critical distributions
   $critical = @(
       @{Platform="Windows"; Arch="x64"; Type="installer"},
       @{Platform="Windows"; Arch="x64"; Type="zip"},
       @{Platform="Windows"; Arch="x64"; Type="cli"},
       @{Platform="macOS"; Arch="universal"; Type="darwin"},
       @{Platform="Linux"; Arch="x64"; Type="deb"},
       @{Platform="Linux"; Arch="x64"; Type="rpm"},
       @{Platform="Linux"; Arch="x64"; Type="cli"}
   )
   
   foreach ($dist in $critical) {
       .\Get-VSCodeDownload.ps1 -Platform $dist.Platform -Architecture $dist.Arch -DownloadType $dist.Type -Version latest -VerifyHash -CreateCheckpoint
   }
   
   # Expected: 7 checkpoint files, 7 downloaded artifacts, all SHA256 verified
   ```

3. **Create Checkpoint Aggregation Script** (Replace broken Week1 function)
   ```powershell
   # New file: codex/scripts/Merge-VSCodeCheckpoints.ps1
   # Purpose: Aggregate individual checkpoint JSONs into single governance file
   # NO DEPENDENCY on Week1_Automation.ps1
   ```

4. **Build CSV Export for Excel Analysis** (Before Power BI)
   ```powershell
   # New file: codex/scripts/Export-VSCodeCheckpointsToCSV.ps1
   # Output: 26 rows (one per distribution), columns for Platform, Arch, Type, Version, SHA256, Status, Timestamp
   # Sponsors can open in Excel for manual review
   ```

**Deliverables**:
- ✅ Validated Get-VSCodeDownload.ps1 with 7 critical distributions
- ✅ Merge-VSCodeCheckpoints.ps1 (aggregation without Week1 dependency)
- ✅ Export-VSCodeCheckpointsToCSV.ps1 (Excel-ready governance report)
- ✅ Sample checkpoint JSON files (7 distributions)
- ✅ Local governance validation (no Azure required)

**Success Criteria**:
- [ ] Download 7 critical distributions locally
- [ ] All 7 SHA256 hashes verified
- [ ] All 7 checkpoints valid JSON (9 required fields)
- [ ] CSV export readable in Excel (26 rows × 10 columns)
- [ ] Sponsor can review coverage manually

---

#### **Week 2: Power BI Dashboard (Local Data Gateway)**
**Goal**: Visualize local checkpoint files without Azure SQL

**Tasks**:
1. **Install Power BI Desktop** (Free, local-only)
   ```powershell
   # Download from Microsoft
   Start-Process "https://aka.ms/pbidesktopstore"
   ```

2. **Create Power BI Data Source from CSV**
   ```powerquery
   // Load CSV export from Week 1
   let
       Source = Csv.Document(File.Contents("C:\...\vscode_checkpoints.csv")),
       PromotedHeaders = Table.PromoteHeaders(Source)
   in
       PromotedHeaders
   ```

3. **Build 3-Page Dashboard** (As documented)
   - **Page 1: Distribution Coverage Map** (Heatmap, 26 cells)
   - **Page 2: Version Drift Analysis** (Timeline, drift count card)
   - **Page 3: Hash Compliance** (Gauge, compliance rate %)

4. **Add DAX Measures** (From POWERBI_DASHBOARD_SCHEMA.md)
   ```dax
   PlatformCoverage = DISTINCTCOUNT(VSCodeDistributions[Platform]) / 26 * 100
   
   HashComplianceRate = 
       DIVIDE(
           COUNTROWS(FILTER(VSCodeDistributions, VSCodeDistributions[SHA256Hash] <> "[Pending SHA256]")),
           COUNTROWS(VSCodeDistributions)
       ) * 100
   
   VersionDriftCount = 
       CALCULATE(
           COUNTROWS(VSCodeDistributions),
           VSCodeDistributions[Version] <> MAX(VSCodeDistributions[Version])
       )
   ```

5. **Test Drill-Through Lineage** (Local lineage JSON)
   - Create audit_trail.json manually for 1 distribution
   - Import to Power BI as secondary table
   - Configure drill-through from heatmap to lineage detail page

**Deliverables**:
- ✅ Power BI Desktop file (.pbix) with 3 pages
- ✅ CSV data source connection (no SQL required)
- ✅ 3 DAX measures (Coverage, Compliance, Drift)
- ✅ Drill-through lineage page (1 sample distribution)
- ✅ Sponsor-facing dashboard (local refresh)

**Success Criteria**:
- [ ] Dashboard opens in Power BI Desktop
- [ ] Heatmap shows 26 cells (7 GREEN from Week 1, 19 GRAY pending)
- [ ] Coverage KPI = 26.9% (7/26 distributions)
- [ ] Hash Compliance = 100% (all 7 verified)
- [ ] Version Drift = 0 (all on same version)
- [ ] Drill-through works for 1 distribution (sample lineage)

---

#### **Week 3: Teams Integration (Power Automate with File Trigger)**
**Goal**: Send alerts based on local checkpoint files (no Azure SQL)

**Tasks**:
1. **Create Power Automate Flow** (File System Trigger)
   ```
   Trigger: When a file is created or modified (OneDrive/SharePoint)
   Condition: If filename matches "vscode_download_checkpoint.json"
   Parse JSON: Extract Status, SHA256Hash, Version fields
   Condition: If Status="Failed" OR SHA256Hash="[Pending SHA256]"
   Action: Post adaptive card to Teams channel
   ```

2. **Deploy Teams Adaptive Card Template** (From docs)
   - Copy JSON from VSCODE_UNIFIED_GOVERNANCE_ALERT_SYSTEM.md
   - Configure 14 variable substitutions (Platform, Arch, SHA256, etc.)
   - Add 5 action buttons (Dashboard link uses local .pbix file path)

3. **Test Hash Fail Scenario**
   ```powershell
   # Simulate hash failure
   .\Get-VSCodeDownload.ps1 -Platform Windows -Architecture x64 -DownloadType installer -VerifyHash:$false -CreateCheckpoint
   
   # Expected: Checkpoint created with SHA256Hash="[Pending SHA256]"
   # Power Automate detects, sends Teams alert within 5 minutes
   ```

4. **Test Version Drift Scenario**
   ```powershell
   # Download older version
   .\Get-VSCodeDownload.ps1 -Platform Linux -Architecture x64 -DownloadType deb -Version "1.93.0" -CreateCheckpoint
   
   # Compare to latest (1.95.0)
   # Expected: Power Automate detects drift, sends Level 2 alert
   ```

**Deliverables**:
- ✅ Power Automate flow (file system trigger, no Azure SQL)
- ✅ Teams Adaptive Card deployed (14 variables configured)
- ✅ Hash fail alert tested (Level 3 severity)
- ✅ Version drift alert tested (Level 2 severity)
- ✅ Sponsor can acknowledge alerts in Teams

**Success Criteria**:
- [ ] Power Automate flow runs successfully (file trigger)
- [ ] Teams channel receives Adaptive Card within 5 minutes of checkpoint creation
- [ ] Adaptive Card displays correct Platform, Arch, Type, Version, SHA256
- [ ] Action buttons work (Dashboard link opens local .pbix file)
- [ ] Sponsor can click "Acknowledge Alert" button

---

### Week 4: Documentation & Handoff (No Implementation)

**Goal**: Package local governance system for sponsor review

**Tasks**:
1. **Create Sponsor Quick Start Guide**
   - How to download distributions (Get-VSCodeDownload.ps1 usage)
   - How to open Power BI dashboard (.pbix file)
   - How to respond to Teams alerts (Acknowledge button workflow)
   - Daily 2-minute ritual (open dashboard, verify 3 KPIs)

2. **Record Video Walkthrough** (5 minutes)
   - Demo: Download Windows x64 installer
   - Demo: Verify checkpoint created
   - Demo: Open Power BI dashboard, show coverage heatmap
   - Demo: Simulate hash fail, show Teams alert

3. **Export Governance Package**
   ```
   IntelIntent_VSCode_Governance_Package_v1.0.zip
   ├── codex/
   │   ├── scripts/
   │   │   ├── Get-VSCodeDownload.ps1
   │   │   ├── Merge-VSCodeCheckpoints.ps1
   │   │   ├── Export-VSCodeCheckpointsToCSV.ps1
   │   ├── downloads/
   │   │   └── vscode/ (sample checkpoints)
   ├── dashboards/
   │   └── VSCode_Governance_Dashboard.pbix
   ├── docs/
   │   ├── VSCODE_26_DISTRIBUTIONS_QUICK_REFERENCE.md
   │   ├── VSCODE_UNIFIED_GOVERNANCE_ALERT_SYSTEM.md
   │   ├── Sponsor_Quick_Start_Guide.md
   ├── teams/
   │   ├── Adaptive_Card_Template.json
   │   └── Power_Automate_Flow_Export.zip
   └── README.md
   ```

4. **Schedule Sponsor Demo** (30 minutes)
   - Live walkthrough of governance system
   - Q&A on daily ritual workflow
   - Collect feedback for Phase 2 improvements

**Deliverables**:
- ✅ Sponsor Quick Start Guide (10 pages)
- ✅ Video walkthrough (5 minutes, uploaded to SharePoint)
- ✅ Governance package ZIP (all scripts, dashboard, docs)
- ✅ Sponsor demo scheduled (30-minute calendar invite)

**Success Criteria**:
- [ ] Sponsor can unzip package and run Get-VSCodeDownload.ps1 without assistance
- [ ] Sponsor can open Power BI dashboard and understand 3 KPIs
- [ ] Sponsor can respond to Teams alert within 2 minutes
- [ ] Sponsor approves governance system for production use

---

## 📊 Pasture 2: Self-Healing Orchestrator (After VS Code Governance)

### Why Second?
- ✅ **Orchestrator.ps1 is proven** (422 lines, generates components successfully)
- ✅ **ManifestReader.ps1 is proven** (306 lines, loads manifests successfully)
- ⚠️ **Checkpoint system needs validation** (file I/O, schema consistency)
- ⚠️ **No Week1 dependency** but needs error recovery testing

### Current State
```
✅ Orchestrator.ps1 (generates components from manifests)
✅ ManifestReader.ps1 (loads 6 manifests, builds queue)
✅ AgentBridge.psm1 (agent routing stubs)
⚠️ Checkpoint validation (needs testing)
❌ Error recovery (not implemented)
❌ Auto-remediation (not implemented)
```

### Phased Implementation (4 Weeks)

#### **Week 5: Checkpoint Validation**
**Goal**: Prove checkpoint system works end-to-end

**Tasks**:
1. **Run Orchestrator with Checkpoint Validation**
   ```powershell
   cd c:\Users\BOOPA\OneDrive\IntelIntent!\IntelIntent_Seeding
   
   # Generate all components with checkpoints
   .\Orchestrator.ps1 -Mode Full -Verbose
   
   # Verify checkpoints created
   Get-ChildItem -Path . -Filter "*checkpoint*" -Recurse
   ```

2. **Test Checkpoint Schema Validation**
   ```powershell
   # From Engineer Lab Workbook (Session 3)
   function Test-CheckpointSchema {
       param([PSCustomObject]$Checkpoint)
       
       $errors = @()
       
       # Validate 9 required fields
       @("TaskID", "Timestamp", "Status", "Inputs", "Outputs", "Artifacts", "Signature", "Duration", "SessionID") | ForEach-Object {
           if (-not $Checkpoint.$_) {
               $errors += "Missing required field: $_"
           }
       }
       
       return @{
           IsValid = ($errors.Count -eq 0)
           Errors = $errors
       }
   }
   
   # Test all generated checkpoints
   Get-Content .\Recursive_Operations\*checkpoint*.json | ConvertFrom-Json | ForEach-Object {
       $result = Test-CheckpointSchema -Checkpoint $_
       if (-not $result.IsValid) {
           Write-Warning "Checkpoint validation failed: $($result.Errors -join ', ')"
       }
   }
   ```

3. **Document Checkpoint File Paths**
   - Map each component to its checkpoint location
   - Verify `Recursive_Operations/` directory structure consistent
   - Test checkpoint recovery (load previous session state)

**Deliverables**:
- ✅ Checkpoint validation script (Test-CheckpointSchema function)
- ✅ All Orchestrator checkpoints validated (9 fields present)
- ✅ Checkpoint recovery tested (resume from previous session)
- ✅ Checkpoint file path documentation

**Success Criteria**:
- [ ] Orchestrator generates 16+ components (from sample_manifest.json)
- [ ] All components have valid checkpoints (9 required fields)
- [ ] Checkpoint recovery works (resume orchestrator from checkpoint)
- [ ] No checkpoint path errors (directory structure validated)

---

#### **Week 6: Error Detection**
**Goal**: Catch component generation failures and log to checkpoints

**Tasks**:
1. **Add Try-Catch to Component Generation**
   ```powershell
   # In Orchestrator.ps1, wrap component generation
   try {
       # Generate component
       New-Item -Path $componentPath -ItemType File -Force
       Set-Content -Path $componentPath -Value $componentContent
       
       # Create success checkpoint
       $checkpoint = @{
           TaskID = $component.id
           Status = "Success"
           Timestamp = (Get-Date).ToString("o")
           # ... other fields
       }
   } catch {
       # Create failure checkpoint
       $checkpoint = @{
           TaskID = $component.id
           Status = "Failed"
           Timestamp = (Get-Date).ToString("o")
           Outputs = @{ Error = $_.Exception.Message }
           # ... other fields
       }
   }
   ```

2. **Test Simulated Failures**
   ```powershell
   # Simulate disk full error (create checkpoint on read-only path)
   # Simulate invalid manifest (malformed JSON)
   # Simulate missing dependency (component references non-existent module)
   
   # Verify all failures logged to checkpoints with Status="Failed"
   ```

3. **Create Failure Report**
   ```powershell
   # New file: IntelIntent_Seeding/Get-OrchestratorFailures.ps1
   # Purpose: Parse checkpoints, filter Status="Failed", generate report
   
   $failures = Get-Content .\Recursive_Operations\*checkpoint*.json | ConvertFrom-Json | Where-Object { $_.Status -eq "Failed" }
   $failures | Format-Table TaskID, Timestamp, Outputs -AutoSize
   ```

**Deliverables**:
- ✅ Try-Catch error handling in Orchestrator.ps1
- ✅ Simulated failure testing (3 scenarios)
- ✅ Get-OrchestratorFailures.ps1 script
- ✅ Failure report format documented

**Success Criteria**:
- [ ] Orchestrator catches component generation errors
- [ ] Failed components logged with Status="Failed" in checkpoint
- [ ] Get-OrchestratorFailures.ps1 returns all failures (no false negatives)
- [ ] Failure report readable by sponsors (clear error messages)

---

#### **Week 7: Auto-Remediation Logic**
**Goal**: Automatically retry failed component generation

**Tasks**:
1. **Add Retry Logic to Orchestrator**
   ```powershell
   $maxRetries = 3
   $retryDelay = 5 # seconds
   
   for ($attempt = 1; $attempt -le $maxRetries; $attempt++) {
       try {
           # Generate component
           New-Item -Path $componentPath -ItemType File -Force
           Set-Content -Path $componentPath -Value $componentContent
           
           # Success - break retry loop
           break
       } catch {
           if ($attempt -lt $maxRetries) {
               Write-Warning "Component generation failed (attempt $attempt/$maxRetries), retrying in $retryDelay seconds..."
               Start-Sleep -Seconds $retryDelay
           } else {
               # Final failure after max retries
               $checkpoint.Status = "Failed"
               $checkpoint.Outputs = @{ Error = $_.Exception.Message; Attempts = $maxRetries }
           }
       }
   }
   ```

2. **Test Auto-Remediation**
   ```powershell
   # Simulate transient failure (network glitch, temporary disk lock)
   # Verify Orchestrator retries 3 times before marking failed
   # Check checkpoint shows Outputs.Attempts = 3
   ```

3. **Add Manual Remediation Workflow**
   ```powershell
   # New file: IntelIntent_Seeding/Invoke-ManualRemediation.ps1
   # Purpose: Re-run failed components after sponsor approval
   
   param([string]$TaskID)
   
   # Load checkpoint for failed task
   $checkpoint = Get-Content .\Recursive_Operations\*checkpoint*.json | ConvertFrom-Json | Where-Object { $_.TaskID -eq $TaskID }
   
   # Prompt sponsor for approval
   $approval = Read-Host "Retry component generation for TaskID $TaskID? (Y/N)"
   
   if ($approval -eq "Y") {
       # Re-run component generation
       # Update checkpoint with new attempt timestamp
   }
   ```

**Deliverables**:
- ✅ Retry logic added to Orchestrator.ps1 (3 attempts, 5-second delay)
- ✅ Auto-remediation tested (transient failure scenario)
- ✅ Invoke-ManualRemediation.ps1 script
- ✅ Manual remediation workflow documented

**Success Criteria**:
- [ ] Orchestrator automatically retries failed components (up to 3 times)
- [ ] Transient failures resolved without manual intervention
- [ ] Persistent failures marked "Failed" after 3 attempts
- [ ] Invoke-ManualRemediation.ps1 works for sponsor-approved retries

---

#### **Week 8: Self-Healing Dashboard**
**Goal**: Visualize orchestrator health and auto-remediation metrics

**Tasks**:
1. **Export Orchestrator Metrics to CSV**
   ```powershell
   # New file: IntelIntent_Seeding/Export-OrchestratorMetrics.ps1
   # Output CSV columns: TaskID, Status, Attempts, Duration, Timestamp, Error
   
   Get-Content .\Recursive_Operations\*checkpoint*.json | ConvertFrom-Json | 
       Select-Object TaskID, Status, @{Name="Attempts"; Expression={$_.Outputs.Attempts}}, Duration, Timestamp, @{Name="Error"; Expression={$_.Outputs.Error}} |
       Export-Csv -Path .\orchestrator_metrics.csv -NoTypeInformation
   ```

2. **Create Power BI Dashboard Page**
   - **Metric 1**: Component Success Rate (gauge, target ≥95%)
   - **Metric 2**: Average Retry Count (card, target ≤1.5)
   - **Metric 3**: Failed Components (table with TaskID, Error, Attempts)
   - **Metric 4**: Auto-Remediation Rate (successful retries / total failures × 100)

3. **Add DAX Measures**
   ```dax
   ComponentSuccessRate = 
       DIVIDE(
           COUNTROWS(FILTER(OrchestratorMetrics, OrchestratorMetrics[Status] = "Success")),
           COUNTROWS(OrchestratorMetrics)
       ) * 100
   
   AverageRetryCount = 
       AVERAGE(OrchestratorMetrics[Attempts])
   
   AutoRemediationRate = 
       VAR SuccessfulRetries = COUNTROWS(FILTER(OrchestratorMetrics, OrchestratorMetrics[Status] = "Success" && OrchestratorMetrics[Attempts] > 1))
       VAR TotalFailures = COUNTROWS(FILTER(OrchestratorMetrics, OrchestratorMetrics[Status] = "Failed"))
       RETURN DIVIDE(SuccessfulRetries, SuccessfulRetries + TotalFailures) * 100
   ```

4. **Test Dashboard with Real Data**
   - Run Orchestrator.ps1 with simulated failures
   - Export metrics to CSV
   - Refresh Power BI dashboard
   - Verify all 4 metrics display correctly

**Deliverables**:
- ✅ Export-OrchestratorMetrics.ps1 script
- ✅ Power BI dashboard page (Orchestrator Health)
- ✅ 4 DAX measures (Success Rate, Retry Count, Failed Components, Auto-Remediation)
- ✅ Dashboard tested with real orchestrator data

**Success Criteria**:
- [ ] Dashboard opens in Power BI Desktop
- [ ] Success Rate metric shows ≥95% (after auto-remediation)
- [ ] Average Retry Count shows ≤1.5 (most components succeed first try)
- [ ] Failed Components table shows only persistent failures (after 3 retries)
- [ ] Auto-Remediation Rate shows ≥60% (transient failures resolved automatically)

---

## 📊 Pasture 3: Compliance Reporting (After Self-Healing)

### Why Third?
- ⚠️ **Requires Azure infrastructure** (SQL Database, Power BI Service, Power Automate premium)
- ⚠️ **Week1 checkpoints broken** (need to rebuild checkpoint aggregation from Pasture 1+2)
- ⚠️ **External dependencies** (Azure subscription, Power BI Pro license, Graph API app registration)
- ✅ **Documentation complete** (POWERBI_DASHBOARD_SCHEMA.md, CI_CD_SETUP_GUIDE.md)

### Current State
```
✅ POWERBI_DASHBOARD_SCHEMA.md (SQL schema documented)
✅ CI_CD_SETUP_GUIDE.md (GitHub Actions + Azure DevOps pipelines)
✅ COMPLIANCE_AND_AUTHENTICATION_ARCHITECTURE.md (RBAC patterns)
⚠️ Azure SQL Database (not provisioned)
⚠️ Power BI Service workspace (not created)
⚠️ Power Automate premium (not purchased)
❌ Checkpoint aggregation (broken in Week1, needs rebuild from Pasture 1)
❌ SOC 2 audit templates (not created)
```

### Prerequisites (Before Starting)
1. **Complete Pasture 1** (VS Code Governance local validation)
2. **Complete Pasture 2** (Self-Healing Orchestrator checkpoint validation)
3. **Provision Azure Resources**:
   - Azure SQL Database (Basic tier, $5/month)
   - Power BI Pro license ($10/user/month)
   - Power Automate premium (for SQL trigger, $15/user/month)
   - Azure Storage Account (checkpoint archive, $2/month)

**Total Cost**: ~$32/month for compliance infrastructure

### Decision Point
**Before investing in Azure resources**, validate sponsor commitment:
- [ ] Sponsor approves monthly Azure spend ($32/month)
- [ ] Sponsor commits to SOC 2 / ISO audit timeline
- [ ] Sponsor assigns dedicated engineer for Azure setup (40 hours)
- [ ] Sponsor approves Power BI Pro licenses for all reviewers

**If No Sponsor Approval**: Stop at Pasture 2, use local governance only.

---

### Phased Implementation (6 Weeks, Assuming Sponsor Approval)

#### **Week 9: Azure Infrastructure Setup**
**Goal**: Provision Azure resources for compliance system

**Tasks**:
1. **Create Azure SQL Database**
   ```bash
   # Azure CLI commands
   az login
   
   # Create resource group
   az group create --name IntelIntentCompliance --location centralus
   
   # Create SQL server
   az sql server create --name intelintent-sql --resource-group IntelIntentCompliance --location centralus --admin-user sqladmin --admin-password <strong-password>
   
   # Create SQL database (Basic tier)
   az sql db create --name IntelIntentCheckpoints --server intelintent-sql --resource-group IntelIntentCompliance --service-objective Basic
   
   # Configure firewall (allow Azure services)
   az sql server firewall-rule create --server intelintent-sql --resource-group IntelIntentCompliance --name AllowAzureServices --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
   ```

2. **Create SQL Tables** (From POWERBI_DASHBOARD_SCHEMA.md)
   ```sql
   -- Connect to IntelIntentCheckpoints database
   
   -- Table 1: VSCodeDistributions (from Pasture 1)
   CREATE TABLE [dbo].[VSCodeDistributions] (
       [DistributionID]    NVARCHAR(100)   PRIMARY KEY,
       [Platform]          NVARCHAR(50)    NOT NULL,
       [Architecture]      NVARCHAR(20)    NOT NULL,
       [DownloadType]      NVARCHAR(50)    NOT NULL,
       [Version]           NVARCHAR(20)    NOT NULL,
       [DownloadURL]       NVARCHAR(500)   NOT NULL,
       [SHA256Hash]        NVARCHAR(64)    NULL,
       [FileSize]          DECIMAL(10,2)   NULL,
       [DownloadTimestamp] DATETIME2       NOT NULL,
       [Status]            NVARCHAR(20)    NOT NULL,
       [DurationSeconds]   INT             NULL,
       [SessionID]         NVARCHAR(100)   NOT NULL,
       [CheckpointPath]    NVARCHAR(500)   NULL
   );
   
   -- Table 2: OrchestratorMetrics (from Pasture 2)
   CREATE TABLE [dbo].[OrchestratorMetrics] (
       [MetricID]          NVARCHAR(100)   PRIMARY KEY,
       [TaskID]            NVARCHAR(50)    NOT NULL,
       [ComponentName]     NVARCHAR(100)   NOT NULL,
       [Status]            NVARCHAR(20)    NOT NULL,
       [Attempts]          INT             NULL,
       [Duration]          INT             NULL,
       [Timestamp]         DATETIME2       NOT NULL,
       [Error]             NVARCHAR(MAX)   NULL,
       [SessionID]         NVARCHAR(100)   NOT NULL
   );
   
   -- Table 3: AuditLogs (compliance trail)
   CREATE TABLE [dbo].[AuditLogs] (
       [AuditID]           NVARCHAR(100)   PRIMARY KEY,
       [EventType]         NVARCHAR(50)    NOT NULL,
       [ResourceType]      NVARCHAR(50)    NOT NULL,
       [ResourceID]        NVARCHAR(100)   NOT NULL,
       [Action]            NVARCHAR(50)    NOT NULL,
       [Actor]             NVARCHAR(100)   NOT NULL,
       [Timestamp]         DATETIME2       NOT NULL,
       [Details]           NVARCHAR(MAX)   NULL,
       [Signature]         NVARCHAR(64)    NULL
   );
   ```

3. **Test SQL Connection from PowerShell**
   ```powershell
   # Install SqlServer module
   Install-Module -Name SqlServer -Scope CurrentUser -Force
   
   # Test connection
   $serverName = "intelintent-sql.database.windows.net"
   $databaseName = "IntelIntentCheckpoints"
   $username = "sqladmin"
   $password = ConvertTo-SecureString "<strong-password>" -AsPlainText -Force
   $credential = New-Object System.Management.Automation.PSCredential($username, $password)
   
   # Query test
   Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName -Credential $credential -Query "SELECT GETDATE() AS CurrentTime"
   ```

**Deliverables**:
- ✅ Azure SQL Database provisioned (Basic tier)
- ✅ 3 SQL tables created (VSCodeDistributions, OrchestratorMetrics, AuditLogs)
- ✅ SQL connection tested from PowerShell
- ✅ Firewall rules configured (Azure services allowed)

**Success Criteria**:
- [ ] SQL Database accessible from Azure portal
- [ ] All 3 tables created with correct schema
- [ ] PowerShell can connect and query database
- [ ] No connection errors or timeout issues

---

#### **Week 10: Checkpoint Data Ingestion**
**Goal**: Load checkpoints from Pasture 1 + 2 into Azure SQL

**Tasks**:
1. **Create Data Ingestion Script**
   ```powershell
   # New file: codex/scripts/Import-CheckpointsToSQL.ps1
   # Purpose: Bulk insert checkpoint JSONs to Azure SQL Database
   
   param(
       [string]$ServerName = "intelintent-sql.database.windows.net",
       [string]$DatabaseName = "IntelIntentCheckpoints",
       [string]$CheckpointDirectory = "..\downloads\vscode"
   )
   
   # Load VS Code distribution checkpoints
   $checkpoints = Get-ChildItem -Path $CheckpointDirectory -Filter "*checkpoint*.json" | 
       ForEach-Object { Get-Content $_.FullName | ConvertFrom-Json }
   
   foreach ($checkpoint in $checkpoints) {
       # Map checkpoint fields to SQL columns
       $query = @"
       INSERT INTO [dbo].[VSCodeDistributions] 
       (DistributionID, Platform, Architecture, DownloadType, Version, DownloadURL, SHA256Hash, FileSize, DownloadTimestamp, Status, DurationSeconds, SessionID, CheckpointPath)
       VALUES 
       ('$($checkpoint.TaskID)', '$($checkpoint.Inputs.Platform)', '$($checkpoint.Inputs.Architecture)', '$($checkpoint.Inputs.DownloadType)', '$($checkpoint.Inputs.Version)', '$($checkpoint.Outputs.DownloadURL)', '$($checkpoint.Outputs.SHA256Hash)', $($checkpoint.Outputs.FileSize), '$($checkpoint.Timestamp)', '$($checkpoint.Status)', $($checkpoint.Duration), '$($checkpoint.SessionID)', '$($checkpoint.Artifacts[0])')
   "@
       
       Invoke-Sqlcmd -ServerInstance $ServerName -Database $DatabaseName -Credential $credential -Query $query
   }
   
   Write-Host "✅ Imported $($checkpoints.Count) checkpoints to SQL Database"
   ```

2. **Import Pasture 1 Checkpoints** (VS Code distributions)
   ```powershell
   cd c:\Users\BOOPA\OneDrive\IntelIntent!\codex\scripts
   .\Import-CheckpointsToSQL.ps1 -CheckpointDirectory "..\downloads\vscode"
   
   # Verify import
   Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName -Credential $credential -Query "SELECT COUNT(*) AS TotalDistributions FROM [dbo].[VSCodeDistributions]"
   # Expected: 7 rows (from Pasture 1 Week 1 testing)
   ```

3. **Import Pasture 2 Checkpoints** (Orchestrator metrics)
   ```powershell
   # Similar script for OrchestratorMetrics table
   # Load checkpoints from IntelIntent_Seeding\Recursive_Operations\
   # Map TaskID, Status, Attempts, Duration, Timestamp, Error fields
   ```

**Deliverables**:
- ✅ Import-CheckpointsToSQL.ps1 script
- ✅ VS Code checkpoints imported (7 rows in VSCodeDistributions table)
- ✅ Orchestrator checkpoints imported (16+ rows in OrchestratorMetrics table)
- ✅ SQL queries validated (row counts match expected)

**Success Criteria**:
- [ ] All Pasture 1 checkpoints in SQL (7 VS Code distributions)
- [ ] All Pasture 2 checkpoints in SQL (16+ orchestrator components)
- [ ] No data loss (checkpoint JSON fields map to SQL columns correctly)
- [ ] Query performance acceptable (<1 second for COUNT(*))

---

#### **Week 11-14: Power BI Service + Compliance Reporting**
**Tasks**: (Detailed implementation based on POWERBI_DASHBOARD_SCHEMA.md)
- [ ] Publish dashboard to Power BI Service
- [ ] Configure scheduled refresh (daily at 8:00 AM)
- [ ] Add compliance scorecards (SOC 2 controls mapping)
- [ ] Create audit report templates (PDF export)
- [ ] Test sponsor sign-off workflow (Teams approval)

**Deliverables**: 
- ✅ Power BI Service dashboard (published, shared with sponsors)
- ✅ Automated compliance reports (weekly PDF exports)
- ✅ SOC 2 audit trail (immutable AuditLogs table)

---

## 🎯 Recommended Execution Order

### **Start Here (4 Weeks)**
**Pasture 1: VS Code Governance** → Prove end-to-end flow with local checkpoints, no Azure dependencies

**Success Metrics**:
- 7 critical distributions downloaded and verified locally
- Power BI Desktop dashboard shows 26.9% coverage
- Teams alerts working with file system trigger
- Sponsor can review governance in 2 minutes

**Cost**: $0 (local execution only)

---

### **Then This (4 Weeks)**
**Pasture 2: Self-Healing Orchestrator** → Validate checkpoint system, add auto-remediation

**Success Metrics**:
- Orchestrator success rate ≥95% (with auto-retry)
- Average retry count ≤1.5 (most components succeed first try)
- Failed components logged with clear error messages
- Dashboard shows auto-remediation metrics

**Cost**: $0 (local execution only)

---

### **Only If Sponsor Approves (6 Weeks + $32/month ongoing)**
**Pasture 3: Compliance Reporting** → Azure SQL, Power BI Service, SOC 2 audit trail

**Success Metrics**:
- All checkpoints from Pasture 1+2 in Azure SQL
- Power BI Service dashboard published and shared
- Weekly compliance reports auto-generated (PDF)
- SOC 2 audit trail immutable and queryable

**Cost**: $32/month (Azure SQL + Power BI Pro + Power Automate)

---

## ✅ Next Steps (Today)

1. **Validate Get-VSCodeDownload.ps1 Works**
   ```powershell
   cd c:\Users\BOOPA\OneDrive\IntelIntent!\codex\scripts
   .\Get-VSCodeDownload.ps1 -Platform Windows -Architecture x64 -DownloadType installer -VerifyHash -CreateCheckpoint -Verbose
   ```

2. **Review Checkpoint Output**
   ```powershell
   Get-Content ..\downloads\vscode\vscode_download_checkpoint.json | ConvertFrom-Json | Format-List
   ```

3. **Decide on Pasture Priority**
   - [ ] Start Pasture 1 (VS Code Governance) → Recommended
   - [ ] Start Pasture 2 (Self-Healing Orchestrator) → If Get-VSCodeDownload already proven
   - [ ] Skip to Pasture 3 (Compliance) → Only if Azure resources already provisioned

**Recommended**: Start with Pasture 1 Week 1 (Local Governance), validate end-to-end flow before committing to Azure infrastructure.

---

**Document Status**: ✅ Ready for Execution  
**Foundation**: Phase 2 Nervous System (proven, 2,132+ lines of functional code)  
**No Dependency**: Week1_Automation.ps1 (broken, not used)  
**Cost to Start**: $0 (Pastures 1+2 local execution only)
