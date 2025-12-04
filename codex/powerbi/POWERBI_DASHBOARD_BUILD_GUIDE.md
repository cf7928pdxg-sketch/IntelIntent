# Power BI Dashboard Build Guide - VS Code Governance

**IntelIntent Pasture 1 Week 2**  
**Document Version**: 1.0.0  
**Last Updated**: 2025-11-28  
**Status**: Ready for Execution

---

## 📋 Prerequisites

### Before Starting
- ✅ Completed Week 1: 7 critical distributions downloaded and validated
- ✅ CSV export generated: `codex\downloads\vscode_checkpoints.csv`
- ✅ Power BI Desktop installed (free download: https://aka.ms/pbidesktopstore)

### Expected CSV Structure
**Columns** (13 total):
- DistributionID (Primary Key)
- Platform, Architecture, DownloadType
- Version, DownloadURL, SHA256Hash, FileSize
- DownloadTimestamp, Status, DurationSeconds, SessionID, CheckpointPath

**Sample Row**:
```csv
DistributionID,Platform,Architecture,DownloadType,Version,DownloadURL,SHA256Hash,FileSize,DownloadTimestamp,Status,DurationSeconds,SessionID,CheckpointPath
VSCODE-WIN-X64-INSTALLER-20251128143522,Windows,x64,installer,1.95.0,https://update.code.visualstudio.com/1.95.0/win32-x64/stable,a3f7b2c1e5d4...,95.23,2025-11-28T14:35:22Z,Success,12,VSCodeDownload-20251128,C:\...\vscode_download_checkpoint.json
```

---

## 🎨 Dashboard Design (3 Pages)

### **Page 1: Distribution Coverage Map** (Primary Sponsor View)
**Goal**: Show at-a-glance coverage status for all 26 distributions

**Layout**:
```
┌────────────────────────────────────────────────────────────┐
│  VS Code Distribution Coverage - IntelIntent Governance   │
│  Last Refreshed: 2025-11-28 14:35:22                      │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │ Coverage     │  │ Hash         │  │ Version      │    │
│  │   26.9%      │  │ Compliance   │  │ Drift        │    │
│  │              │  │   100%       │  │   0          │    │
│  │ 7/26 Dists   │  │              │  │              │    │
│  └──────────────┘  └──────────────┘  └──────────────┘    │
│                                                            │
│  ┌────────────────────────────────────────────────────┐   │
│  │         Distribution Coverage Heatmap              │   │
│  │                                                    │   │
│  │       installer  zip  cli  darwin  deb  rpm       │   │
│  │  Win x64   🟢    🟢   🟢    -      -     -        │   │
│  │  Win arm64  ⚪    ⚪   ⚪    -      -     -        │   │
│  │  macOS uni  -     -    -    🟢    -     -        │   │
│  │  macOS x64  -     -    🟢    ⚪    -     -        │   │
│  │  macOS arm  -     -    ⚪    ⚪    -     -        │   │
│  │  Linux x64  -     -    🟢    -    🟢   🟢       │   │
│  │  Linux arm  -     -    ⚪    -    ⚪   ⚪       │   │
│  │  Linux armhf -    -    ⚪    -    ⚪   ⚪       │   │
│  │                                                    │   │
│  │  Legend: 🟢 Verified  ⚪ Pending  🔴 Failed       │   │
│  └────────────────────────────────────────────────────┘   │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

---

### **Page 2: Version Drift Analysis** (Operations View)
**Goal**: Identify distributions not on latest version

**Layout**:
```
┌────────────────────────────────────────────────────────────┐
│  Version Drift Analysis - Track Update Lag                │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  ┌────────────────────────────────────────────────────┐   │
│  │         Version Timeline (Line Chart)             │   │
│  │                                                    │   │
│  │  1.95.0 ─────────────────────────●───────────     │   │
│  │         │                         │Windows        │   │
│  │  1.94.0 │        ●───────────────────────         │   │
│  │         │        │macOS                           │   │
│  │  1.93.0 ●────────                                 │   │
│  │         │Linux                                    │   │
│  │         │                                         │   │
│  │         Oct    Nov    Dec    Jan                  │   │
│  └────────────────────────────────────────────────────┘   │
│                                                            │
│  ┌────────────────────────────────────────────────────┐   │
│  │         Drift Details Table                       │   │
│  │ ┌──────┬─────┬────────┬─────────┬────────┬──────┐│   │
│  │ │Platf.│Arch │Type    │Current  │Latest  │Drift ││   │
│  │ ├──────┼─────┼────────┼─────────┼────────┼──────┤│   │
│  │ │Linux │x64  │deb     │1.93.0   │1.95.0  │30d   ││   │
│  │ │macOS │x64  │darwin  │1.94.0   │1.95.0  │15d   ││   │
│  │ └──────┴─────┴────────┴─────────┴────────┴──────┘│   │
│  └────────────────────────────────────────────────────┘   │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

---

### **Page 3: Hash Compliance Gauge** (Security View)
**Goal**: Track SHA256 verification status

**Layout**:
```
┌────────────────────────────────────────────────────────────┐
│  Hash Integrity Compliance - Security Posture             │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  ┌────────────────────────────────────────────────────┐   │
│  │         Hash Compliance Gauge                      │   │
│  │                                                    │   │
│  │              ┌────────────┐                        │   │
│  │              │            │                        │   │
│  │          ┌───┤   100%     ├───┐                   │   │
│  │          │   │            │   │                   │   │
│  │         RED  YELLOW    GREEN                       │   │
│  │        <85%  85-94%   95-100%                      │   │
│  │                                                    │   │
│  └────────────────────────────────────────────────────┘   │
│                                                            │
│  ┌────────────────────────────────────────────────────┐   │
│  │   Distributions with Pending Hashes               │   │
│  │ ┌──────┬─────┬────────┬────────┬──────────────┐  │   │
│  │ │Platf.│Arch │Type    │Status  │SHA256Hash    │  │   │
│  │ ├──────┼─────┼────────┼────────┼──────────────┤  │   │
│  │ │(No pending hashes - all verified)           │  │   │
│  │ └──────┴─────┴────────┴────────┴──────────────┘  │   │
│  └────────────────────────────────────────────────────┘   │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

---

## 🛠️ Step-by-Step Build Instructions

### Step 1: Import CSV Data Source

1. **Open Power BI Desktop**
   - Download from: https://aka.ms/pbidesktopstore
   - Launch application

2. **Get Data from CSV**
   - Click **Get Data** → **Text/CSV**
   - Navigate to: `C:\Users\BOOPA\OneDrive\IntelIntent!\codex\downloads\vscode_checkpoints.csv`
   - Click **Open**

3. **Preview and Transform**
   - Power BI will show data preview (7 rows if Week 1 completed)
   - Click **Transform Data** to open Power Query Editor

4. **Set Data Types** (Critical for DAX measures)
   ```
   DistributionID     → Text
   Platform           → Text
   Architecture       → Text
   DownloadType       → Text
   Version            → Text
   DownloadURL        → Text
   SHA256Hash         → Text
   FileSize           → Decimal Number
   DownloadTimestamp  → Date/Time
   Status             → Text
   DurationSeconds    → Whole Number
   SessionID          → Text
   CheckpointPath     → Text
   ```

5. **Rename Table**
   - In Power Query Editor, right-click table name
   - Rename to: `VSCodeDistributions`

6. **Close and Apply**
   - Click **Close & Apply** to load data into model

---

### Step 2: Create DAX Measures

In Power BI Desktop, go to **Modeling** → **New Measure**. Create these 10 measures:

#### **1. Platform Coverage**
```dax
PlatformCoverage = 
    VAR TotalDistributions = 26  // All possible distributions
    VAR DownloadedDistributions = DISTINCTCOUNT(VSCodeDistributions[DistributionID])
    RETURN
        DIVIDE(DownloadedDistributions, TotalDistributions) * 100
```

#### **2. Hash Compliance Rate**
```dax
HashComplianceRate = 
    VAR VerifiedHashes = 
        COUNTROWS(
            FILTER(
                VSCodeDistributions,
                VSCodeDistributions[SHA256Hash] <> "[Pending SHA256]" &&
                NOT(ISBLANK(VSCodeDistributions[SHA256Hash]))
            )
        )
    VAR TotalDistributions = COUNTROWS(VSCodeDistributions)
    RETURN
        DIVIDE(VerifiedHashes, TotalDistributions) * 100
```

#### **3. Version Drift Count**
```dax
VersionDriftCount = 
    VAR LatestVersion = 
        CALCULATE(
            MAX(VSCodeDistributions[Version]),
            ALLEXCEPT(VSCodeDistributions, VSCodeDistributions[Platform])
        )
    RETURN
        CALCULATE(
            COUNTROWS(VSCodeDistributions),
            VSCodeDistributions[Version] <> LatestVersion
        )
```

#### **4. Total Downloads**
```dax
TotalDownloads = COUNTROWS(VSCodeDistributions)
```

#### **5. Success Rate**
```dax
SuccessRate = 
    VAR SuccessfulDownloads = 
        COUNTROWS(FILTER(VSCodeDistributions, VSCodeDistributions[Status] = "Success"))
    VAR TotalDownloads = COUNTROWS(VSCodeDistributions)
    RETURN
        DIVIDE(SuccessfulDownloads, TotalDownloads) * 100
```

#### **6. Total Downloaded Size**
```dax
TotalDownloadedSize = 
    SUM(VSCodeDistributions[FileSize])
```

#### **7. Average Download Duration**
```dax
AvgDownloadDuration = 
    AVERAGE(VSCodeDistributions[DurationSeconds])
```

#### **8. Latest Download Timestamp**
```dax
LatestDownload = 
    MAX(VSCodeDistributions[DownloadTimestamp])
```

#### **9. Pending Hash Count**
```dax
PendingHashCount = 
    COUNTROWS(
        FILTER(
            VSCodeDistributions,
            VSCodeDistributions[SHA256Hash] = "[Pending SHA256]"
        )
    )
```

#### **10. Distribution Coverage by Platform**
```dax
PlatformDistributionCount = 
    CALCULATE(
        COUNTROWS(VSCodeDistributions),
        ALLEXCEPT(VSCodeDistributions, VSCodeDistributions[Platform])
    )
```

---

### Step 3: Build Page 1 - Distribution Coverage Map

#### **Add KPI Cards** (Top Row)

1. **Platform Coverage Card**
   - Visual: **Card**
   - Field: `[PlatformCoverage]`
   - Format: Percentage, 1 decimal place
   - Title: "Platform Coverage"
   - Target: 100%

2. **Hash Compliance Card**
   - Visual: **Card**
   - Field: `[HashComplianceRate]`
   - Format: Percentage, 1 decimal place
   - Title: "Hash Compliance"
   - Target: 95%

3. **Version Drift Card**
   - Visual: **Card**
   - Field: `[VersionDriftCount]`
   - Format: Whole number
   - Title: "Version Drift Count"
   - Target: 0

#### **Add Heatmap Matrix**

1. **Insert Matrix Visual**
   - Click **Matrix** icon in Visualizations pane

2. **Configure Matrix**
   - **Rows**: `Platform`, `Architecture`
   - **Columns**: `DownloadType`
   - **Values**: `Status` (First value)

3. **Conditional Formatting**
   - Right-click `Status` → **Conditional formatting** → **Background color**
   - **Format style**: Rules
   - **Rules**:
     - If `Status` = "Success" → #2E7D32 (Green)
     - If `Status` = "Pending" → #FFA000 (Yellow)
     - If `Status` = "Failed" → #C62828 (Red)

4. **Add Legend**
   - Insert **Text Box**
   - Type: `Legend: 🟢 Verified  ⚪ Pending  🔴 Failed`
   - Position below matrix

---

### Step 4: Build Page 2 - Version Drift Analysis

#### **Add Version Timeline**

1. **Insert Line Chart**
   - Click **Line chart** icon

2. **Configure Chart**
   - **X-Axis**: `DownloadTimestamp`
   - **Y-Axis**: `Version`
   - **Legend**: `Platform`
   - **Values**: Count of `DistributionID`

3. **Format**
   - Title: "Version Timeline"
   - X-Axis label: "Download Date"
   - Y-Axis label: "Version"

#### **Add Drift Table**

1. **Insert Table Visual**
   - Click **Table** icon

2. **Configure Table**
   - **Columns**:
     - `Platform`
     - `Architecture`
     - `DownloadType`
     - `Version` (rename to "Current Version")
     - `LatestDownload` (rename to "Latest Version")
     - (Calculate drift days manually or add DAX measure)

3. **Filter**
   - Add filter: `Version` ≠ `MAX(Version)`
   - Sort: `DownloadTimestamp` descending

---

### Step 5: Build Page 3 - Hash Compliance Gauge

#### **Add Gauge Chart**

1. **Insert Gauge Visual**
   - Click **Gauge** icon

2. **Configure Gauge**
   - **Value**: `[HashComplianceRate]`
   - **Minimum**: 0
   - **Maximum**: 100
   - **Target**: 95

3. **Format**
   - **Target line**: Red (critical threshold)
   - **Gauge axis**: 
     - 0-85%: Red zone
     - 85-94%: Yellow zone
     - 95-100%: Green zone

#### **Add Pending Hashes Table**

1. **Insert Table Visual**
   - Click **Table** icon

2. **Configure Table**
   - **Columns**:
     - `Platform`
     - `Architecture`
     - `DownloadType`
     - `Status`
     - `SHA256Hash`

3. **Filter**
   - Add filter: `SHA256Hash` = "[Pending SHA256]"

4. **Empty State**
   - If no pending hashes, table shows: "(No pending hashes - all verified)"

---

## 🎨 Dashboard Styling (Fluent 2 Design)

### Color Palette
- **Primary**: #0078D4 (Microsoft Blue)
- **Success**: #2E7D32 (Green)
- **Warning**: #FFA000 (Yellow)
- **Error**: #C62828 (Red)
- **Background**: #F3F2F1 (Light Gray)
- **Text**: #201F1E (Dark Gray)

### Typography
- **Title**: Segoe UI, 18pt, Bold
- **Headers**: Segoe UI, 14pt, Semibold
- **Body**: Segoe UI, 11pt, Regular
- **KPI Values**: Segoe UI, 32pt, Bold

### Layout Grid
- **Page Size**: 1280 × 720 (16:9 aspect ratio)
- **Margins**: 20px all sides
- **Gutter**: 16px between visuals

---

## 💾 Save and Test Dashboard

### Step 6: Save Power BI File

1. **File** → **Save As**
2. **File Name**: `VSCode_Governance_Dashboard.pbix`
3. **Location**: `C:\Users\BOOPA\OneDrive\IntelIntent!\codex\dashboards\`

### Step 7: Test Dashboard Functionality

**Test Checklist**:
- [ ] All 3 pages load without errors
- [ ] KPI cards display correct values (Coverage, Compliance, Drift)
- [ ] Heatmap matrix shows 7 GREEN cells (Week 1 downloads)
- [ ] Version timeline chart displays all platforms
- [ ] Drift table filters correctly (empty if no drift)
- [ ] Gauge chart displays 100% (all hashes verified)
- [ ] Pending hashes table empty (all verified)

### Step 8: Test Data Refresh

1. **Home** → **Refresh**
2. Verify data refreshes from CSV source
3. Confirm all visuals update correctly

---

## 📊 Expected Results (Week 1 Data)

### Platform Coverage
- **Value**: 26.9% (7 of 26 distributions)
- **Target**: 100%
- **Status**: In Progress (Week 1 baseline)

### Hash Compliance Rate
- **Value**: 100% (all 7 verified)
- **Target**: 95%
- **Status**: ✅ Compliant

### Version Drift Count
- **Value**: 0 (all on v1.95.0)
- **Target**: 0
- **Status**: ✅ No Drift

### Heatmap Visual
```
       installer  zip  cli  darwin  deb  rpm
Win x64    🟢     🟢   🟢    -      -     -
macOS uni  -       -    -    🟢    -     -
Linux x64  -       -    🟢    -    🟢   🟢
```

---

## 🚀 Next Steps (Week 3)

After dashboard build completes:
1. **Export dashboard screenshot** for sponsor demo
2. **Test drill-through functionality** (if added)
3. **Configure automatic refresh** (optional, local file monitoring)
4. **Prepare Week 3**: Teams Adaptive Card alerts (Power Automate Desktop)

---

## 🆘 Troubleshooting

### Issue: CSV Import Fails
**Solution**: 
- Verify CSV path exists
- Check CSV file is not open in Excel
- Validate CSV has 13 columns with headers

### Issue: DAX Measure Error
**Solution**:
- Check table name is `VSCodeDistributions` (case-sensitive)
- Verify column names match exactly (Platform, Status, etc.)
- Test measure with simple `COUNTROWS(VSCodeDistributions)`

### Issue: Matrix Visual Empty
**Solution**:
- Verify data loaded (check Data view in Power BI)
- Check no filters applied accidentally
- Confirm `Status` field has values ("Success", not blank)

### Issue: Gauge Shows Blank
**Solution**:
- Verify `[HashComplianceRate]` measure calculated correctly
- Check no DIVIDE by zero errors (need at least 1 distribution)
- Test with `COUNTROWS(VSCodeDistributions)` to confirm data exists

---

**Document Status**: ✅ Ready for Week 2 Execution  
**Next Review Date**: After Week 2 completion  
**Maintained By**: IntelIntent Governance Team
