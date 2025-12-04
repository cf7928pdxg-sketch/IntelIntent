# Power BI Desktop Wiring Guide for Copilot Lineage Dashboard

This guide walks you through importing JSON log files, transforming data with Power Query, adding DAX measures, and building sponsor-facing visuals for the GitHub Copilot lifecycle dashboard.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Phase 1: Import JSON Logs](#phase-1-import-json-logs)
3. [Phase 2: Power Query Transformations](#phase-2-power-query-transformations)
4. [Phase 3: Load Data & Create Relationships](#phase-3-load-data--create-relationships)
5. [Phase 4: Import DAX Measures](#phase-4-import-dax-measures)
6. [Phase 5: Build Dashboard Visuals](#phase-5-build-dashboard-visuals)
7. [Phase 6: Save & Publish](#phase-6-save--publish)
8. [Troubleshooting](#troubleshooting)

---

## Prerequisites

- **Power BI Desktop**: Version 2.120.0 or later (November 2024+)
- **JSON Log Files**: `CopilotLifecycleLog.json` and `CopilotInvocationLog.json` in `codex/logs/` directory
- **DAX Measures**: `measures.md` file in `codex/dashboards/` directory
- **Schema Reference**: `copilot-events.schema.json` in `codex/schemas/` directory

**Verify Prerequisites:**
```powershell
# Check files exist
Test-Path ".\codex\logs\CopilotLifecycleLog.json"
Test-Path ".\codex\logs\CopilotInvocationLog.json"
Test-Path ".\codex\dashboards\measures.md"
Test-Path ".\codex\schemas\copilot-events.schema.json"
```

---

## Phase 1: Import JSON Logs

### Step 1: Open Power BI Desktop
1. Launch **Power BI Desktop**
2. Close the splash screen
3. Navigate to **Home → Get Data → More...**

### Step 2: Import CopilotLifecycleLog.json
1. In the **Get Data** dialog:
   - Search for: `JSON`
   - Select: **JSON**
   - Click: **Connect**

2. Browse to: `c:\Users\BOOPA\OneDrive\IntelIntent!\codex\logs\CopilotLifecycleLog.json`

3. Click **Open**

4. Power Query Editor opens showing JSON structure

### Step 3: Import CopilotInvocationLog.json
1. Repeat Step 2 for `CopilotInvocationLog.json`

**Expected Result:**  
Two queries in Power Query Editor:
- `CopilotLifecycleLog`
- `CopilotInvocationLog`

---

## Phase 2: Power Query Transformations

### Transform CopilotLifecycleLog

#### Step 1: Expand SessionMetadata (Optional)
1. In Power Query Editor, select **CopilotLifecycleLog** query
2. You'll see two columns: `SessionMetadata` (Record) and `Events` (List)
3. Click the expand icon (⚏) next to `SessionMetadata`
4. Select fields to extract:
   - `SchemaVersion`
   - `GeneratedBy`
   - `CreatedAt`
   - `WorkspacePath`
5. Uncheck: **Use original column name as prefix**
6. Click **OK**

**Result:** Four new columns added at root level

#### Step 2: Expand Events Array (Critical)
1. Click the expand icon (⚏) next to `Events` column
2. Select: **Expand to New Rows**
3. Click **OK**

**Result:** Each array item becomes a separate row

#### Step 3: Expand Event Properties
1. Click the expand icon (⚏) next to `Events` column again
2. Select all fields:
   - `EventType`
   - `EventTimestamp`
   - `RunId`
   - `SessionID`
   - `LifecycleAction`
   - `ExtensionID`
   - `Version`
   - `WorkspaceName`
   - `Reason`
   - `Hash`
   - `Stage`
   - `Result`
   - `WorkspaceScope`
   - `ExtensionUnification`
   - `ErrorMessage`
3. Uncheck: **Use original column name as prefix**
4. Click **OK**

#### Step 4: Set Data Types
Right-click each column header → **Change Type**:

| Column | Data Type |
|--------|-----------|
| `EventTimestamp` | Date/Time |
| `RunId` | Text |
| `SessionID` | Text |
| `LifecycleAction` | Text |
| `ExtensionID` | Text |
| `Version` | Text |
| `WorkspaceName` | Text |
| `Reason` | Text |
| `Hash` | Text |
| `Stage` | Text |
| `Result` | Text |
| `WorkspaceScope` | Text |
| `ExtensionUnification` | True/False |
| `ErrorMessage` | Text |

#### Step 5: Add Derived Columns
1. **Add Column → Custom Column**
   - Name: `Date`
   - Formula: `Date.From([EventTimestamp])`
   - Type: Date

2. **Add Column → Custom Column**
   - Name: `Hour`
   - Formula: `Time.Hour([EventTimestamp])`
   - Type: Whole Number

3. **Add Column → Custom Column**
   - Name: `DayOfWeek`
   - Formula: `Date.DayOfWeek([EventTimestamp])`
   - Type: Whole Number

#### Step 6: Rename Query
1. In left pane, right-click **CopilotLifecycleLog**
2. Select **Rename**
3. Change to: `CopilotLifecycle`

---

### Transform CopilotInvocationLog

#### Step 1: Expand SessionMetadata (Optional)
Same as CopilotLifecycleLog Step 1

#### Step 2: Expand Events Array
Same as CopilotLifecycleLog Step 2

#### Step 3: Expand Event Properties
1. Click expand icon next to `Events` column
2. Select all fields:
   - `EventType`
   - `EventTimestamp`
   - `RunId`
   - `SessionID`
   - `InvocationType`
   - `CommandID`
   - `ShortcutUsed`
   - `CompletionModel`
   - `ExtensionID`
   - `WorkspaceName`
   - `Context`
   - `Stage`
   - `Result`
   - `DurationMs`
   - `FilePath`
   - `ErrorMessage`
3. Uncheck: **Use original column name as prefix**
4. Click **OK**

#### Step 4: Set Data Types

| Column | Data Type |
|--------|-----------|
| `EventTimestamp` | Date/Time |
| `RunId` | Text |
| `SessionID` | Text |
| `InvocationType` | Text |
| `CommandID` | Text |
| `ShortcutUsed` | Text |
| `CompletionModel` | Text |
| `ExtensionID` | Text |
| `WorkspaceName` | Text |
| `Context` | Text |
| `Stage` | Text |
| `Result` | Text |
| `DurationMs` | Whole Number |
| `FilePath` | Text |
| `ErrorMessage` | Text |

#### Step 5: Add Derived Columns
Same as CopilotLifecycleLog Step 5 (Date, Hour, DayOfWeek)

#### Step 6: Rename Query
Rename to: `CopilotInvocations`

---

## Phase 3: Load Data & Create Relationships

### Step 1: Close & Apply
1. In Power Query Editor: **Home → Close & Apply**
2. Wait for data to load (should be fast for <100 events)

### Step 2: Verify Tables
1. In **Data** view (left sidebar), verify two tables:
   - `CopilotLifecycle`
   - `CopilotInvocations`

### Step 3: Create Relationships (Optional)
If you need cross-filtering between tables:

1. Switch to **Model** view (left sidebar)
2. Drag `RunId` from `CopilotLifecycle` to `RunId` in `CopilotInvocations`
3. Set relationship properties:
   - **Cardinality**: Many to Many
   - **Cross filter direction**: Both
   - **Make this relationship active**: Checked

**Note:** Since lifecycle and invocation events are independent, this relationship is optional.

---

## Phase 4: Import DAX Measures

### Step 1: Create Measures Table (Recommended)
1. Switch to **Data** view
2. **Home → Enter Data**
3. Create empty table named: `_Measures`
4. Click **Load**

**Purpose:** Centralized location for all measures (cleaner model)

### Step 2: Add Measures from measures.md
1. Open `codex/dashboards/measures.md` in text editor
2. For each DAX measure:
   - Select **_Measures** table in **Data** pane
   - **Modeling → New Measure**
   - Copy DAX formula from `measures.md`
   - Paste into formula bar
   - Press **Enter**

**Priority Measures** (add these first):
- `TotalLifecycleEvents`
- `TotalInvocations`
- `Enables`
- `Disables`
- `InlineInvocations`
- `ChatInvocations`
- `AgentInvocations`
- `ActiveStatusPercent`
- `HashComplianceRate`
- `AvgInvocationDuration`

### Step 3: Format Measures
For percentage measures:
1. Select measure in **Data** pane
2. **Measure tools → Format**: Percentage
3. **Decimal places**: 1

For duration measures:
1. Select measure
2. **Format**: Whole number
3. **Thousands separator**: Comma

---

## Phase 5: Build Dashboard Visuals

### Page 1: Executive Summary

#### Visual 1: Active Status KPI Card
1. **Insert → Card** (new visual)
2. **Fields:** `ActiveStatusPercent`
3. **Format visual:**
   - **Callout value → Display units**: Percentage
   - **Data label → Text size**: 72 pt
   - **Category label**: "Active Workspaces %"
   - **Callout value color**: Green if ≥ 80%, Red if < 50%

#### Visual 2: Lifecycle Timeline
1. **Insert → Line chart**
2. **X-axis:** `CopilotLifecycle[Date]`
3. **Y-axis:** `TotalLifecycleEvents`
4. **Legend:** `CopilotLifecycle[LifecycleAction]`
5. **Format:**
   - Title: "Lifecycle Events Over Time"
   - Data labels: On

#### Visual 3: Invocation Breakdown
1. **Insert → Stacked bar chart**
2. **Y-axis:** `CopilotInvocations[InvocationType]`
3. **X-axis:** `TotalInvocations`
4. **Data labels:** On
5. **Sort:** Descending by value

#### Visual 4: Total Events KPI Cards
Create 3 cards side-by-side:
- Card 1: `TotalLifecycleEvents` (Title: "Total Lifecycle Events")
- Card 2: `TotalInvocations` (Title: "Total Invocations")
- Card 3: `UniqueSessions` (Title: "Unique Sessions")

---

### Page 2: Lineage & Compliance

#### Visual 1: Version Lineage Table
1. **Insert → Table**
2. **Columns:**
   - `CopilotLifecycle[EventTimestamp]`
   - `CopilotLifecycle[LifecycleAction]`
   - `CopilotLifecycle[Version]`
   - `CopilotLifecycle[Hash]`
   - `CopilotLifecycle[WorkspaceName]`
   - `CopilotLifecycle[Result]`
3. **Format:**
   - Conditional formatting on `Result` (Green = Success, Red = Failed)
   - Sort by `EventTimestamp` descending

#### Visual 2: Hash Compliance Gauge
1. **Insert → Gauge**
2. **Value:** `HashComplianceRate`
3. **Maximum value:** 1
4. **Format:**
   - Target value: 0.9 (90% goal)
   - Callout color: Green if ≥ 90%, Yellow if 70-90%, Red if < 70%

#### Visual 3: Workspace Activation Matrix
1. **Insert → Matrix**
2. **Rows:** `CopilotLifecycle[WorkspaceName]`
3. **Columns:** `CopilotLifecycle[LifecycleAction]`
4. **Values:** `TotalLifecycleEvents`
5. **Format:**
   - Conditional formatting: Heatmap (darker = more events)

---

### Page 3: Invocation Analysis

#### Visual 1: Invocation Type Distribution
1. **Insert → Donut chart**
2. **Legend:** `CopilotInvocations[InvocationType]`
3. **Values:** `TotalInvocations`
4. **Format:**
   - Detail labels: On (percentage + count)

#### Visual 2: Average Duration by Type
1. **Insert → Clustered column chart**
2. **X-axis:** `CopilotInvocations[InvocationType]`
3. **Y-axis:** `AvgInvocationDuration`
4. **Format:**
   - Y-axis title: "Avg Duration (ms)"
   - Data labels: On

#### Visual 3: Model Usage Comparison
1. **Insert → Pie chart**
2. **Legend:** `CopilotInvocations[CompletionModel]`
3. **Values:** `TotalInvocations`
4. **Format:**
   - Title: "AI Model Distribution"

#### Visual 4: Recent Invocations Table
1. **Insert → Table**
2. **Columns:**
   - `CopilotInvocations[EventTimestamp]`
   - `CopilotInvocations[InvocationType]`
   - `CopilotInvocations[CommandID]`
   - `CopilotInvocations[CompletionModel]`
   - `CopilotInvocations[DurationMs]`
   - `CopilotInvocations[Result]`
3. **Filter:** Top 20 by `EventTimestamp`
4. **Format:**
   - Conditional formatting on `DurationMs` (gradient: green = fast, red = slow)

---

### Page 4: Operational Metrics

#### Visual 1: MTTR KPI Card
1. **Insert → Card**
2. **Fields:** `MTTR_Hours`
3. **Format:**
   - Category label: "Mean Time to Recovery (Hours)"
   - Callout value: 1 decimal place

#### Visual 2: Success Rate Cards
Create 2 cards side-by-side:
- Card 1: `LifecycleSuccessRate` (Title: "Lifecycle Success %")
- Card 2: `InvocationSuccessRate` (Title: "Invocation Success %")

#### Visual 3: Daily Trend Line Chart
1. **Insert → Line chart**
2. **X-axis:** `Date`
3. **Y-axis:** Multiple lines:
   - `EventsToday`
   - `InvocationsToday`
4. **Format:**
   - Title: "Daily Activity Trend"
   - Legend: Bottom

#### Visual 4: Stage Distribution
1. **Insert → Stacked bar chart**
2. **Y-axis:** `CopilotLifecycle[Stage]`
3. **X-axis:** `TotalLifecycleEvents`
4. **Format:**
   - Sort: Descending by value

---

### Cross-Page Filters (Slicers)

Add these slicers to all pages (use **Sync slicers** to apply across pages):

#### Slicer 1: Date Range
1. **Insert → Slicer**
2. **Field:** `CopilotLifecycle[Date]`
3. **Slicer type:** Between

#### Slicer 2: Workspace Name
1. **Insert → Slicer**
2. **Field:** `CopilotLifecycle[WorkspaceName]`
3. **Slicer type:** Dropdown

#### Slicer 3: Stage
1. **Insert → Slicer**
2. **Field:** `CopilotLifecycle[Stage]`
3. **Slicer type**: Dropdown

**To Sync Slicers:**
1. **View → Sync slicers**
2. Select slicer
3. Check all pages to sync

---

## Phase 6: Save & Publish

### Step 1: Save PBIX File
1. **File → Save As**
2. Save to: `c:\Users\BOOPA\OneDrive\IntelIntent!\codex\dashboards\CopilotLineage.pbix`

### Step 2: Publish to Power BI Service (Optional)
1. **Home → Publish**
2. Select workspace: "IntelIntent" (or create new)
3. Click **Select**
4. Wait for upload (should take <30 seconds)

### Step 3: Configure Scheduled Refresh (Optional)
If using Power BI Service:
1. Navigate to workspace in browser
2. Find `CopilotLineage` dataset
3. Click **⋯ → Settings**
4. **Data source credentials:**
   - Set credentials for JSON file path
   - Authentication: Windows
5. **Scheduled refresh:**
   - Enable: On
   - Frequency: Daily (recommended)
   - Time: 6:00 AM UTC
6. Click **Apply**

---

## Troubleshooting

### Issue: "Unable to connect to JSON file"
**Cause:** File path incorrect or file missing

**Solution:**
```powershell
# Verify file exists
Test-Path ".\codex\logs\CopilotLifecycleLog.json"

# Check JSON structure
Get-Content ".\codex\logs\CopilotLifecycleLog.json" | ConvertFrom-Json
```

### Issue: "Events column is not expanding"
**Cause:** JSON structure mismatch

**Solution:**
1. Verify schema version: `jq '.SessionMetadata.SchemaVersion' codex/logs/CopilotLifecycleLog.json`
2. Check for empty Events array: Should have at least 1 event
3. Re-run logging scripts to regenerate files

### Issue: "DAX measure returns error"
**Cause:** Table or column name typo

**Solution:**
1. Verify table names:
   - `CopilotLifecycle` (not `CopilotLifecycleLog`)
   - `CopilotInvocations` (not `CopilotInvocationLog`)
2. Check column names match schema exactly (case-sensitive)
3. Use DAX formatter: **Tools → Options → DAX Editor → Auto-format**

### Issue: "Relationships not working"
**Cause:** Cardinality mismatch or inactive relationship

**Solution:**
1. Switch to **Model** view
2. Double-click relationship line
3. Set **Cross filter direction** to **Both**
4. Ensure **Make this relationship active** is checked

### Issue: "Visuals show no data"
**Cause:** Filters applied or data not loaded

**Solution:**
1. **View → Performance analyzer** → Check load times
2. Clear all filters: **View → Report filters → Clear all**
3. Verify row count:
   - **Data** view → Select table → Check row count at bottom

### Issue: "Timestamps in wrong time zone"
**Cause:** UTC timestamps not converted to local time

**Solution:**
Add custom column in Power Query:
```powerquery
= DateTime.AddZone([EventTimestamp], -8)  // PST (UTC-8)
```
Or use DAX:
```dax
LocalTime = [EventTimestamp] + TIME(8, 0, 0)  // PST offset
```

---

## Best Practices

1. **Incremental Refresh**: For datasets > 1,000 events, enable incremental refresh on `Date` column
2. **Data Validation**: Run `Test-CodexIntegrity.ps1` before importing to Power BI
3. **Version Control**: Save PBIX file to Git repository for lineage tracking
4. **Documentation**: Add descriptions to measures (right-click measure → **Description**)
5. **Performance**: Use calculated columns sparingly; prefer DAX measures for aggregations
6. **Security**: Enable Row-Level Security (RLS) if sharing dashboard with multiple sponsors

---

## Next Steps

1. **Integrate with CI/CD**: Automate PBIX deployment using `azure-pipelines-copilot.yml`
2. **Add Alerts**: Configure Power BI alerts for `HashComplianceRate` < 90%
3. **Embed Dashboard**: Use Power BI Embedded to show dashboard in IntelIntent launcher
4. **Export to PDF**: Set up daily PDF email delivery to sponsors via Power Automate

---

**Last Updated**: 2025-11-28  
**Schema Version**: 1.0.0  
**IntelIntent Phase**: 4 (Production Hardening)
