# IntelIntent Phase 4 Power BI Dashboard Template Instructions

**Version:** 1.0.0  
**Created:** 2025-11-30  
**Purpose:** Guide for creating Power BI dashboard from template configuration

---

## Overview

This guide provides step-by-step instructions for building the IntelIntent Phase 4 Power BI dashboard using the exported configuration and DAX measures.

### Dashboard Components

- **6 Dashboard Pages:** Executive Summary, Environment Readiness, Deployment Execution, CoE Activation, Universal Integration, Copilot Lineage
- **8 SQL Tables:** DeploymentSessions, DeploymentCheckpoints, EnvironmentReadiness, Week1Checkpoints, CoEActivations, UniversalIntegrationLogs, CopilotLifecycleEvents, CopilotCommandInvocations
- **30+ DAX Measures:** Success rates, duration trends, readiness scores, activation rates

---

## Prerequisites

1. **Power BI Desktop:** Download from [Microsoft Store](https://aka.ms/pbidesktopstore) or [Microsoft Download Center](https://www.microsoft.com/en-us/download/details.aspx?id=58494)
2. **Azure SQL Database:** `IntelIntentMetrics` database with schema deployed (see [POWERBI_PHASE4_SCHEMA.md](../POWERBI_PHASE4_SCHEMA.md))
3. **Power BI Pro License:** Required for Power BI Service publishing and scheduled refresh
4. **Azure Permissions:** Database reader permissions on `IntelIntentMetrics` database

---

## Step 1: Create New Power BI Report

1. Open **Power BI Desktop**
2. Click **Get Data** → **More** → **Azure** → **Azure SQL Database**
3. Enter server name: `intelintent.database.windows.net` (or your SQL server)
4. Database: `IntelIntentMetrics`
5. **Data Connectivity Mode:**
   - **Import** (recommended for historical analysis and fast performance)
   - **DirectQuery** (for real-time data, slower performance)
   - **Composite Model** (hybrid: Import for aggregates, DirectQuery for details)
6. Click **OK**

### Authentication Options

- **Azure Active Directory:** Recommended for Azure SQL Database
- **Database Credentials:** Use SQL authentication if configured
- **Managed Identity:** For automated refresh in Azure environments

### Select Tables

Check the following tables:


- ✅ DeploymentSessions
- ✅ DeploymentCheckpoints
- ✅ EnvironmentReadiness
- ✅ Week1Checkpoints
- ✅ CoEActivations
- ✅ UniversalIntegrationLogs
- ✅ CopilotLifecycleEvents
- ✅ CopilotCommandInvocations

Click **Load** to import data.

---

## Step 2: Create DAX Measures

### Go to Modeling Tab → New Measure

Create each measure below by copying the DAX formula:

#### Deployment Health Measures

```dax
TotalDeployments = COUNTROWS(DeploymentSessions)
```

```dax
SuccessfulDeployments = 
CALCULATE(
    COUNTROWS(DeploymentSessions),
    DeploymentSessions[Status] = "Success"
)
```

```dax
DeploymentSuccessRate = 
DIVIDE(
    [SuccessfulDeployments],
    [TotalDeployments],
    0
) * 100
```

```dax
AvgDeploymentDuration = 
AVERAGE(DeploymentSessions[DurationSeconds]) / 60
```

```dax
FailedDeploymentsLast7Days = 
CALCULATE(
    COUNTROWS(DeploymentSessions),
    DeploymentSessions[Status] = "Failed",
    DeploymentSessions[StartTime] >= TODAY() - 7
)
```

#### Readiness Score Measures

```dax
CurrentReadinessScore = 
CALCULATE(
    MAX(EnvironmentReadiness[ReadinessScore]),
    EnvironmentReadiness[Timestamp] = MAX(EnvironmentReadiness[Timestamp])
)
```

```dax
ReadinessTrend7Day = 
CALCULATE(
    AVERAGE(EnvironmentReadiness[ReadinessScore]),
    EnvironmentReadiness[Timestamp] >= TODAY() - 7
)
```

```dax
ToolsMissingCount = 
CALCULATE(
    MAX(EnvironmentReadiness[TotalTools]) - MAX(EnvironmentReadiness[ToolsInstalled]),
    EnvironmentReadiness[Timestamp] = MAX(EnvironmentReadiness[Timestamp])
)
```

```dax
AzureAuthStatus = 
IF(
    CALCULATE(
        MAX(EnvironmentReadiness[AzureAuthenticated]),
        EnvironmentReadiness[Timestamp] = MAX(EnvironmentReadiness[Timestamp])
    ) = 1,
    "✅ Authenticated",
    "❌ Not Authenticated"
)
```

#### Checkpoint Measures

```dax
TotalWeek1Checkpoints = COUNTROWS(Week1Checkpoints)
```

```dax
CheckpointSuccessRate = 
DIVIDE(
    CALCULATE(
        COUNTROWS(Week1Checkpoints),
        Week1Checkpoints[Status] = "Success"
    ),
    [TotalWeek1Checkpoints],
    0
) * 100
```

```dax
AvgCheckpointDuration = 
AVERAGE(Week1Checkpoints[Duration])
```

```dax
CriticalFailures = 
CALCULATE(
    COUNTROWS(Week1Checkpoints),
    Week1Checkpoints[Status] = "Failed"
)
```

#### CoE Activation Measures

```dax
TotalCoEComponents = COUNTROWS(CoEActivations)
```

```dax
ActivatedCoEComponents = 
CALCULATE(
    COUNTROWS(CoEActivations),
    CoEActivations[Status] = "Completed"
)
```

```dax
CoEActivationRate = 
DIVIDE(
    [ActivatedCoEComponents],
    [TotalCoEComponents],
    0
) * 100
```

```dax
AvgCoEActivationTime = 
AVERAGE(CoEActivations[DurationSeconds]) / 60
```

#### Universal Integration Measures

```dax
TotalIntegrationEvents = COUNTROWS(UniversalIntegrationLogs)
```

```dax
IntegrationSuccessRate = 
DIVIDE(
    CALCULATE(
        COUNTROWS(UniversalIntegrationLogs),
        UniversalIntegrationLogs[Status] = "Success"
    ),
    [TotalIntegrationEvents],
    0
) * 100
```

```dax
AvgIntegrationDuration = 
AVERAGE(UniversalIntegrationLogs[DurationMs])
```

#### Copilot Usage Measures

```dax
TotalCopilotInvocations = COUNTROWS(CopilotCommandInvocations)
```

```dax
CopilotInlineSuggestions = 
CALCULATE(
    COUNTROWS(CopilotCommandInvocations),
    CopilotCommandInvocations[InvocationType] = "Inline"
)
```

```dax
CopilotChatInvocations = 
CALCULATE(
    COUNTROWS(CopilotCommandInvocations),
    CopilotCommandInvocations[InvocationType] = "Chat"
)
```

```dax
CopilotAgentModeUsage = 
CALCULATE(
    COUNTROWS(CopilotCommandInvocations),
    CopilotCommandInvocations[InvocationType] = "Agent"
)
```

```dax
CopilotAdoptionRate30Days = 
DIVIDE(
    CALCULATE(
        COUNTROWS(CopilotCommandInvocations),
        CopilotCommandInvocations[Timestamp] >= TODAY() - 30
    ),
    30,
    0
)
```

---

## Step 3: Create Dashboard Pages

### Page 1: Executive Summary

**Purpose:** High-level overview of Phase 4 deployment health

**Visuals:**

1. **Card Visual - Current Readiness Score**
   - Field: `[CurrentReadinessScore]`
   - Format: Percentage, 0 decimals
   - Conditional Formatting: Green (≥80%), Yellow (60-79%), Red (<60%)

2. **Card Visual - Deployment Success Rate**
   - Field: `[DeploymentSuccessRate]`
   - Format: Percentage, 1 decimal

3. **Card Visual - Average Deployment Duration**
   - Field: `[AvgDeploymentDuration]`
   - Format: Number, suffix " min"

4. **Card Visual - CoE Activation Rate**
   - Field: `[CoEActivationRate]`
   - Format: Percentage, 1 decimal

5. **Line Chart - Readiness Score Trend**
   - X-axis: `EnvironmentReadiness[Timestamp]`
   - Y-axis: `[ReadinessTrend7Day]`
   - Trend Line: Enabled

6. **Donut Chart - Deployment Status Distribution**
   - Legend: `DeploymentSessions[Status]`
   - Values: `[TotalDeployments]`
   - Colors: Success (Green), Failed (Red), Running (Yellow)

7. **Bar Chart - Deployments by Context**
   - Axis: `DeploymentSessions[Context]`
   - Values: `[TotalDeployments]`
   - Sort: Descending by count

### Page 2: Environment Readiness

**Purpose:** Detailed tool installation and configuration tracking

**Visuals:**

1. **Card Visual - Tools Installed Fraction**
   - Field: `EnvironmentReadiness[ToolsInstalled]` & `EnvironmentReadiness[TotalTools]`
   - Format: "X / Y (Z%)"

2. **Card Visual - Azure Authentication Status**
   - Field: `[AzureAuthStatus]`
   - Conditional Formatting: Green (Authenticated), Red (Not Authenticated)

3. **Card Visual - PATH Configuration Status**
   - Field: `EnvironmentReadiness[PathConfigured]`
   - Format: Boolean → "✅ Configured" or "❌ Not Configured"

4. **Table - Missing Tools**
   - Field: `EnvironmentReadiness[MissingTools]` (JSON array, parse if possible)
   - Filter: Latest timestamp only

5. **Bar Chart - Readiness Score Over Time**
   - X-axis: `EnvironmentReadiness[Timestamp]` (Date hierarchy)
   - Y-axis: `EnvironmentReadiness[ReadinessScore]`
   - Trend Line: Enabled

6. **Gauge - Current Readiness Score**
   - Value: `[CurrentReadinessScore]`
   - Min: 0, Max: 100
   - Target: 80
   - Conditional Formatting: Red (<60%), Yellow (60-80%), Green (>80%)

### Page 3: Deployment Execution

**Purpose:** Track deployment sessions and checkpoint-level details

**Visuals:**

1. **Card - Total Deployment Sessions**
   - Field: `[TotalDeployments]`

2. **Card - Deployment Success Rate**
   - Field: `[DeploymentSuccessRate]`

3. **Card - Failed Deployments (Last 7 Days)**
   - Field: `[FailedDeploymentsLast7Days]`

4. **Table - Recent Deployment Sessions**
   - Columns: SessionID, Context, StartTime, Duration, Status
   - Sort: StartTime descending
   - Top N: 10

5. **Stacked Bar Chart - Checkpoints by Phase and Status**
   - Axis: `DeploymentCheckpoints[Phase]`
   - Legend: `DeploymentCheckpoints[Status]`
   - Values: Count of checkpoints
   - Colors: Success (Green), Failed (Red), Skipped (Gray), Warning (Yellow)

6. **Line Chart - Deployment Duration Trend**
   - X-axis: `DeploymentSessions[StartTime]`
   - Y-axis: `[AvgDeploymentDuration]`

7. **Waterfall Chart - Deployment Phase Breakdown**
   - Category: `DeploymentCheckpoints[Phase]`
   - Y-axis: Count of steps per phase

### Page 4: CoE Activation Progress

**Purpose:** Track Center of Excellence component activation

**Visuals:**

1. **Card - CoE Activation Rate**
   - Field: `[CoEActivationRate]`

2. **Card - Activated CoE Components Fraction**
   - Field: `[ActivatedCoEComponents]` / `[TotalCoEComponents]`

3. **Card - Average Activation Time**
   - Field: `[AvgCoEActivationTime]`
   - Format: Number, suffix " min"

4. **Treemap - CoE Components by Category**
   - Group: `CoEActivations[Category]`
   - Values: Count of components
   - Colors: By count (gradient)

5. **Bar Chart - CoE Components by Priority**
   - Axis: `CoEActivations[Priority]`
   - Values: Count of components
   - Sort: Priority ascending

6. **Table - Failed CoE Activations**
   - Columns: ComponentID, ComponentTitle, ErrorMessage, StartTime
   - Filter: Status = "Failed"

7. **Line Chart - CoE Activation Rate Trend**
   - X-axis: `CoEActivations[StartTime]` (Date hierarchy)
   - Y-axis: `[CoEActivationRate]`

### Page 5: Universal Integration Health

**Purpose:** Monitor GitHub ↔ M365 integration events

**Visuals:**

1. **Card - Total Integration Events**
   - Field: `[TotalIntegrationEvents]`

2. **Card - Integration Success Rate**
   - Field: `[IntegrationSuccessRate]`

3. **Card - Average Integration Duration**
   - Field: `[AvgIntegrationDuration]`
   - Format: Number, suffix " ms"

4. **Table - Recent Integration Events**
   - Columns: Timestamp, Context, IntegrationType, Direction, Status
   - Sort: Timestamp descending
   - Top N: 20

5. **Stacked Bar Chart - Integration Events by Type**
   - Axis: `UniversalIntegrationLogs[IntegrationType]`
   - Legend: `UniversalIntegrationLogs[Status]`
   - Values: Count of events

6. **Line Chart - Integration Success Rate Trend**
   - X-axis: `UniversalIntegrationLogs[Timestamp]` (Date hierarchy)
   - Y-axis: `[IntegrationSuccessRate]`

### Page 6: Copilot Lineage & AI Adoption

**Purpose:** Track GitHub Copilot usage and AI-assisted development

**Visuals:**

1. **Card - Total Copilot Invocations**
   - Field: `[TotalCopilotInvocations]`

2. **Card - Copilot Adoption Rate (Last 30 Days)**
   - Field: `[CopilotAdoptionRate30Days]`
   - Format: Number, suffix " invocations/day"

3. **Donut Chart - Copilot Invocations by Type**
   - Legend: `CopilotCommandInvocations[InvocationType]`
   - Values: Count
   - Colors: Inline (Blue), Chat (Green), Agent (Orange)

4. **Line Chart - Copilot Usage Trend**
   - X-axis: `CopilotCommandInvocations[Timestamp]` (Date hierarchy)
   - Y-axis: Count of invocations
   - Trend Line: Enabled

5. **Bar Chart - Copilot Lifecycle Events**
   - Axis: `CopilotLifecycleEvents[Action]`
   - Values: Count of events

6. **Table - Recent Copilot Sessions**
   - Columns: Timestamp, Action, Reason, Workspace
   - Sort: Timestamp descending
   - Top N: 15

---

## Step 4: Apply Theme and Formatting

### Color Scheme (Fluent 2 Design System)

- **Primary:** #0078D4 (Microsoft Blue)
- **Success:** #107C10 (Green)
- **Warning:** #FFB900 (Yellow)
- **Error:** #D13438 (Red)
- **Neutral:** #605E5C (Gray)

### Apply to Report

1. Go to **View** tab → **Themes** → **Customize current theme**
2. Set colors for Data colors, Sentiment colors, and Divergent colors
3. Font: **Segoe UI** (standard Microsoft font)
4. Apply consistent padding and alignment across visuals

---

## Step 5: Configure Data Refresh

### Power BI Desktop (Local Development)

1. Go to **Home** → **Refresh** to manually refresh data
2. Or set up **Scheduled Refresh** after publishing to Power BI Service

### Power BI Service (Production)

1. Publish report: **File** → **Publish** → Select workspace
2. Go to Power BI Service (app.powerbi.com)
3. Navigate to **Settings** for the dataset
4. Configure **Scheduled Refresh:**
   - **Frequency:** Hourly (8 AM - 6 PM)
   - **Timezone:** Local time
   - **Failure notifications:** Enable email alerts
5. **Gateway Connection:** Configure if using on-premises SQL Server
6. **Credentials:** Set data source credentials (Azure AD or SQL auth)

---

## Step 6: Share Dashboard

### Internal Sharing

1. In Power BI Service, click **Share** on the report
2. Add email addresses of stakeholders
3. Set permissions:
   - **Can view:** Read-only access
   - **Can build:** Edit access for developers

### Embed in SharePoint/Teams

1. In Power BI Service, go to **File** → **Embed in SharePoint Online**
2. Copy embed code or link
3. Paste into SharePoint page or Teams tab

### Public Sharing (Sponsors)

1. In Power BI Service, click **File** → **Publish to web**
2. Generate embed code (⚠️ **Warning:** Data becomes publicly accessible)
3. Share embed link with external sponsors

---

## Step 7: Validation Checklist

Before finalizing, verify:

- ✅ All 8 tables imported successfully
- ✅ All 30+ DAX measures created and working
- ✅ All 6 dashboard pages created with visuals
- ✅ Data refresh working (manual or scheduled)
- ✅ Conditional formatting applied (colors for status, thresholds)
- ✅ Filters working correctly (date slicers, status filters)
- ✅ Drill-through actions configured for detailed views
- ✅ Performance optimized (query reduction, aggregations)
- ✅ Mobile layout configured for mobile viewing
- ✅ Dashboard shared with stakeholders

---

## Troubleshooting

### "Cannot connect to database"

**Solution:** Verify firewall rules, database credentials, and Azure AD permissions.

```powershell
# Allow Azure services in firewall
az sql server firewall-rule create `
    --resource-group "Phase4RG" `
    --server "intelintent" `
    --name "AllowAzureServices" `
    --start-ip-address "0.0.0.0" `
    --end-ip-address "0.0.0.0"
```

### "Refresh failed: credentials expired"

**Solution:** Update credentials in Power BI Service dataset settings.

1. Go to dataset settings in Power BI Service
2. Click **Edit credentials** under Data source credentials
3. Re-enter Azure AD or SQL authentication credentials

### "Visuals show no data"

**Solution:** Check table relationships and measure syntax.

1. Go to **Model** view in Power BI Desktop
2. Verify relationships between tables (e.g., SessionID linking DeploymentSessions ↔ DeploymentCheckpoints)
3. Check DAX measure syntax with **DAX Studio** or built-in formula bar

### "Performance is slow"

**Solution:** Optimize queries and use aggregations.

1. Go to **Transform Data** → **Query Editor**
2. Remove unnecessary columns
3. Apply filters at source (e.g., `WHERE StartTime >= DATEADD(day, -90, GETDATE())`)
4. Create aggregation tables for large datasets
5. Use **DirectQuery** only when real-time data is critical

---

## Advanced Features

### Incremental Refresh

For large datasets (Week1Checkpoints, CopilotCommandInvocations), configure incremental refresh:

1. In Power BI Desktop, go to **Model** view
2. Right-click table → **Incremental refresh**
3. Set parameters:
   - **Archive data:** 1 year
   - **Incrementally refresh data:** Last 30 days
4. Publish to Power BI Premium or Premium Per User workspace

### Row-Level Security (RLS)

Restrict data access by context (Personal, Developer, Enterprise):

1. Go to **Modeling** → **Manage Roles**
2. Create role: "DeveloperContext"
3. Add filter: `[Context] = "Developer"`
4. Test with **View as Roles** before publishing

### Real-Time Dashboard

For live monitoring during deployments:

1. Use **DirectQuery** connection mode
2. Configure Power BI dataset to refresh every 15 minutes (minimum)
3. Use **Push API** for real-time updates (requires Power BI Premium)

---

## Summary

This template provides a complete Power BI dashboard for IntelIntent Phase 4 deployment monitoring. Follow the steps above to create, configure, and share the dashboard with stakeholders.


**Next Steps:**

1. Import data from Azure SQL Database
2. Create DAX measures using provided formulas
3. Build 6 dashboard pages with specified visuals
4. Apply Fluent 2 theme and formatting
5. Configure scheduled refresh
6. Share with sponsors and stakeholders


For questions or issues, refer to:

- [POWERBI_PHASE4_SCHEMA.md](../POWERBI_PHASE4_SCHEMA.md) - Complete SQL schema and DAX measures
- [PHASE4_DEPLOYMENT_ROADMAP.md](../PHASE4_DEPLOYMENT_ROADMAP.md) - Deployment flow and troubleshooting
- [Microsoft Power BI Documentation](https://docs.microsoft.com/en-us/power-bi/)

---

*IntelIntent Phase 4 - Power BI Dashboard Template v1.0.0*
