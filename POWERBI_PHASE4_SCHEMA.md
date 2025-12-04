# IntelIntent Phase 4 Power BI Schema and DAX Measures

**Purpose:** Complete Power BI dashboard schema for tracking IntelIntent Phase 4 deployment readiness, automation health, and CoE activation progress.

**Version:** 1.0.0  
**Created:** 2025-11-30  
**Author:** IntelIntent Orchestration Team

---

## Table of Contents

1. [SQL Database Schema](#sql-database-schema)
2. [DAX Measures](#dax-measures)
3. [Dashboard Pages](#dashboard-pages)
4. [Data Refresh Configuration](#data-refresh-configuration)
5. [Integration Pattern](#integration-pattern)

---

## SQL Database Schema

### 1. DeploymentSessions Table

**Purpose:** Track Phase 4 deployment sessions and overall execution metrics.

```sql
CREATE TABLE [dbo].[DeploymentSessions] (
    [SessionID]         NVARCHAR(36)    PRIMARY KEY,
    [StartTime]         DATETIME2       NOT NULL,
    [EndTime]           DATETIME2       NULL,
    [DurationSeconds]   INT             NULL,
    [Context]           NVARCHAR(50)    NOT NULL,  -- Personal, Developer, Family, Business, Enterprise
    [IsDryRun]          BIT             NOT NULL DEFAULT 0,
    [ReadinessScore]    INT             NULL,      -- 0-100%
    [SuccessCount]      INT             NULL,
    [FailedCount]       INT             NULL,
    [SkippedCount]      INT             NULL,
    [TotalSteps]        INT             NULL,
    [Status]            NVARCHAR(20)    NOT NULL,  -- Running, Success, Failed
    [CreatedAt]         DATETIME2       DEFAULT GETUTCDATE()
);

CREATE INDEX IX_DeploymentSessions_StartTime ON [dbo].[DeploymentSessions] ([StartTime] DESC);
CREATE INDEX IX_DeploymentSessions_Context ON [dbo].[DeploymentSessions] ([Context]);
CREATE INDEX IX_DeploymentSessions_Status ON [dbo].[DeploymentSessions] ([Status]);
```

### 2. DeploymentCheckpoints Table

**Purpose:** Granular checkpoint tracking for each deployment phase and step.

```sql
CREATE TABLE [dbo].[DeploymentCheckpoints] (
    [CheckpointID]      INT             IDENTITY(1,1) PRIMARY KEY,
    [SessionID]         NVARCHAR(36)    NOT NULL,
    [Timestamp]         DATETIME2       NOT NULL,
    [Phase]             NVARCHAR(50)    NOT NULL,  -- Environment, Security, Integration, Automation, Monitoring
    [Step]              NVARCHAR(100)   NOT NULL,
    [Status]            NVARCHAR(20)    NOT NULL,  -- Success, Failed, Skipped, Warning
    [Metadata]          NVARCHAR(MAX)   NULL,      -- JSON metadata
    [CreatedAt]         DATETIME2       DEFAULT GETUTCDATE(),
    
    CONSTRAINT FK_DeploymentCheckpoints_SessionID 
        FOREIGN KEY ([SessionID]) 
        REFERENCES [dbo].[DeploymentSessions]([SessionID])
);

CREATE INDEX IX_DeploymentCheckpoints_SessionID ON [dbo].[DeploymentCheckpoints] ([SessionID]);
CREATE INDEX IX_DeploymentCheckpoints_Phase ON [dbo].[DeploymentCheckpoints] ([Phase]);
CREATE INDEX IX_DeploymentCheckpoints_Status ON [dbo].[DeploymentCheckpoints] ([Status]);
CREATE INDEX IX_DeploymentCheckpoints_Timestamp ON [dbo].[DeploymentCheckpoints] ([Timestamp] DESC);
```

### 3. EnvironmentReadiness Table

**Purpose:** Track environment readiness scores over time.

```sql
CREATE TABLE [dbo].[EnvironmentReadiness] (
    [ReadinessID]       INT             IDENTITY(1,1) PRIMARY KEY,
    [Timestamp]         DATETIME2       NOT NULL,
    [SessionID]         NVARCHAR(36)    NULL,
    [ReadinessScore]    INT             NOT NULL,  -- 0-100%
    [ToolsInstalled]    INT             NOT NULL,
    [TotalTools]        INT             NOT NULL,
    [MissingTools]      NVARCHAR(MAX)   NULL,      -- JSON array of missing tools
    [PathConfigured]    BIT             NOT NULL DEFAULT 0,
    [AzureAuthenticated] BIT            NOT NULL DEFAULT 0,
    [ModulesPresent]    INT             NULL,      -- Count of IntelIntent modules found
    [CreatedAt]         DATETIME2       DEFAULT GETUTCDATE()
);

CREATE INDEX IX_EnvironmentReadiness_Timestamp ON [dbo].[EnvironmentReadiness] ([Timestamp] DESC);
CREATE INDEX IX_EnvironmentReadiness_ReadinessScore ON [dbo].[EnvironmentReadiness] ([ReadinessScore]);
```

### 4. Week1Checkpoints Table

**Purpose:** Track Week 1 automation checkpoints (existing schema from POWERBI_DASHBOARD_SCHEMA.md).

```sql
CREATE TABLE [dbo].[Week1Checkpoints] (
    [CheckpointID]      NVARCHAR(50)    PRIMARY KEY,
    [TaskID]            NVARCHAR(50)    NOT NULL,
    [SessionID]         NVARCHAR(36)    NOT NULL,
    [Timestamp]         DATETIME2       NOT NULL,
    [Status]            NVARCHAR(20)    NOT NULL,  -- Success, Failed, Skipped
    [Description]       NVARCHAR(500)   NULL,
    [Duration]          INT             NULL,      -- Seconds
    [Signature]         NVARCHAR(64)    NULL,      -- SHA256 hash
    [ParentTaskID]      NVARCHAR(50)    NULL,
    [InputsJSON]        NVARCHAR(MAX)   NULL,
    [OutputsJSON]       NVARCHAR(MAX)   NULL,
    [ArtifactsJSON]     NVARCHAR(MAX)   NULL,
    [CreatedAt]         DATETIME2       DEFAULT GETUTCDATE()
);

CREATE INDEX IX_Week1Checkpoints_TaskID ON [dbo].[Week1Checkpoints] ([TaskID]);
CREATE INDEX IX_Week1Checkpoints_SessionID ON [dbo].[Week1Checkpoints] ([SessionID]);
CREATE INDEX IX_Week1Checkpoints_Status ON [dbo].[Week1Checkpoints] ([Status]);
CREATE INDEX IX_Week1Checkpoints_Timestamp ON [dbo].[Week1Checkpoints] ([Timestamp] DESC);
```

### 5. CoEActivations Table

**Purpose:** Track Center of Excellence (CoE) component activations.

```sql
CREATE TABLE [dbo].[CoEActivations] (
    [ActivationID]      INT             IDENTITY(1,1) PRIMARY KEY,
    [ComponentID]       NVARCHAR(50)    NOT NULL,  -- e.g., ENV-001, ID-002
    [ComponentTitle]    NVARCHAR(200)   NOT NULL,
    [Category]          NVARCHAR(100)   NOT NULL,  -- Identity_Modules, Environment_Setup, etc.
    [Priority]          INT             NOT NULL,  -- 1-13+ semantic priority
    [Status]            NVARCHAR(20)    NOT NULL,  -- NotStarted, InProgress, Completed, Failed
    [StartTime]         DATETIME2       NULL,
    [EndTime]           DATETIME2       NULL,
    [DurationSeconds]   INT             NULL,
    [SessionID]         NVARCHAR(36)    NULL,
    [ErrorMessage]      NVARCHAR(MAX)   NULL,
    [CreatedAt]         DATETIME2       DEFAULT GETUTCDATE(),
    [UpdatedAt]         DATETIME2       DEFAULT GETUTCDATE()
);

CREATE INDEX IX_CoEActivations_ComponentID ON [dbo].[CoEActivations] ([ComponentID]);
CREATE INDEX IX_CoEActivations_Category ON [dbo].[CoEActivations] ([Category]);
CREATE INDEX IX_CoEActivations_Priority ON [dbo].[CoEActivations] ([Priority]);
CREATE INDEX IX_CoEActivations_Status ON [dbo].[CoEActivations] ([Status]);
```

### 6. UniversalIntegrationLogs Table

**Purpose:** Track GitHub ↔ M365 universal integration events.

```sql
CREATE TABLE [dbo].[UniversalIntegrationLogs] (
    [LogID]             INT             IDENTITY(1,1) PRIMARY KEY,
    [Timestamp]         DATETIME2       NOT NULL,
    [Context]           NVARCHAR(50)    NOT NULL,  -- Personal, Developer, Family, Business, Enterprise
    [IntegrationType]   NVARCHAR(100)   NOT NULL,  -- IssueToTask, PRToTeams, CommitToDocs, ProjectToCalendar
    [Direction]         NVARCHAR(20)    NOT NULL,  -- GitHubToM365, M365ToGitHub
    [SourceEntity]      NVARCHAR(200)   NOT NULL,
    [TargetEntity]      NVARCHAR(200)   NULL,
    [Status]            NVARCHAR(20)    NOT NULL,  -- Success, Failed, Pending
    [ErrorMessage]      NVARCHAR(MAX)   NULL,
    [DurationMs]        INT             NULL,
    [CreatedAt]         DATETIME2       DEFAULT GETUTCDATE()
);

CREATE INDEX IX_UniversalIntegrationLogs_Timestamp ON [dbo].[UniversalIntegrationLogs] ([Timestamp] DESC);
CREATE INDEX IX_UniversalIntegrationLogs_Context ON [dbo].[UniversalIntegrationLogs] ([Context]);
CREATE INDEX IX_UniversalIntegrationLogs_IntegrationType ON [dbo].[UniversalIntegrationLogs] ([IntegrationType]);
CREATE INDEX IX_UniversalIntegrationLogs_Status ON [dbo].[UniversalIntegrationLogs] ([Status]);
```

### 7. CopilotLifecycleEvents Table

**Purpose:** Track GitHub Copilot usage across IntelIntent development (existing schema).

```sql
CREATE TABLE [dbo].[CopilotLifecycleEvents] (
    [EventID]           INT             IDENTITY(1,1) PRIMARY KEY,
    [Timestamp]         DATETIME2       NOT NULL,
    [Action]            NVARCHAR(50)    NOT NULL,  -- Enable, Disable, Toggle
    [Reason]            NVARCHAR(500)   NULL,
    [Workspace]         NVARCHAR(500)   NULL,
    [SessionID]         NVARCHAR(36)    NULL,
    [CreatedAt]         DATETIME2       DEFAULT GETUTCDATE()
);

CREATE INDEX IX_CopilotLifecycleEvents_Timestamp ON [dbo].[CopilotLifecycleEvents] ([Timestamp] DESC);
CREATE INDEX IX_CopilotLifecycleEvents_Action ON [dbo].[CopilotLifecycleEvents] ([Action]);
```

### 8. CopilotCommandInvocations Table

**Purpose:** Track Copilot command usage (inline suggestions, chat, agent mode).

```sql
CREATE TABLE [dbo].[CopilotCommandInvocations] (
    [InvocationID]      INT             IDENTITY(1,1) PRIMARY KEY,
    [Timestamp]         DATETIME2       NOT NULL,
    [CommandID]         NVARCHAR(200)   NOT NULL,
    [InvocationType]    NVARCHAR(50)    NOT NULL,  -- Inline, Chat, Agent
    [Context]           NVARCHAR(MAX)   NULL,
    [Workspace]         NVARCHAR(500)   NULL,
    [SessionID]         NVARCHAR(36)    NULL,
    [CreatedAt]         DATETIME2       DEFAULT GETUTCDATE()
);

CREATE INDEX IX_CopilotCommandInvocations_Timestamp ON [dbo].[CopilotCommandInvocations] ([Timestamp] DESC);
CREATE INDEX IX_CopilotCommandInvocations_InvocationType ON [dbo].[CopilotCommandInvocations] ([InvocationType]);
```

---

## DAX Measures

### 1. Deployment Health Measures

#### Total Deployments
```dax
TotalDeployments = COUNTROWS(DeploymentSessions)
```

#### Successful Deployments
```dax
SuccessfulDeployments = 
CALCULATE(
    COUNTROWS(DeploymentSessions),
    DeploymentSessions[Status] = "Success"
)
```

#### Success Rate
```dax
SuccessRate = 
DIVIDE(
    [SuccessfulDeployments],
    [TotalDeployments],
    0
) * 100
```

#### Average Deployment Duration
```dax
AvgDeploymentDuration = 
AVERAGE(DeploymentSessions[DurationSeconds]) / 60
```

#### Failed Deployments (Last 7 Days)
```dax
FailedDeploymentsLast7Days = 
CALCULATE(
    COUNTROWS(DeploymentSessions),
    DeploymentSessions[Status] = "Failed",
    DeploymentSessions[StartTime] >= TODAY() - 7
)
```

### 2. Readiness Score Measures

#### Current Readiness Score
```dax
CurrentReadinessScore = 
CALCULATE(
    MAX(EnvironmentReadiness[ReadinessScore]),
    EnvironmentReadiness[Timestamp] = MAX(EnvironmentReadiness[Timestamp])
)
```

#### Readiness Trend (7-Day Average)
```dax
ReadinessTrend7Day = 
CALCULATE(
    AVERAGE(EnvironmentReadiness[ReadinessScore]),
    EnvironmentReadiness[Timestamp] >= TODAY() - 7
)
```

#### Tools Missing Count
```dax
ToolsMissingCount = 
CALCULATE(
    MAX(EnvironmentReadiness[TotalTools]) - MAX(EnvironmentReadiness[ToolsInstalled]),
    EnvironmentReadiness[Timestamp] = MAX(EnvironmentReadiness[Timestamp])
)
```

#### Azure Authentication Status
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

### 3. Checkpoint Measures

#### Total Checkpoints (Week 1)
```dax
TotalWeek1Checkpoints = COUNTROWS(Week1Checkpoints)
```

#### Checkpoint Success Rate
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

#### Average Checkpoint Duration
```dax
AvgCheckpointDuration = 
AVERAGE(Week1Checkpoints[Duration])
```

#### Critical Failures (Failed Checkpoints)
```dax
CriticalFailures = 
CALCULATE(
    COUNTROWS(Week1Checkpoints),
    Week1Checkpoints[Status] = "Failed"
)
```

### 4. CoE Activation Measures

#### Total CoE Components
```dax
TotalCoEComponents = COUNTROWS(CoEActivations)
```

#### Activated CoE Components
```dax
ActivatedCoEComponents = 
CALCULATE(
    COUNTROWS(CoEActivations),
    CoEActivations[Status] = "Completed"
)
```

#### CoE Activation Rate
```dax
CoEActivationRate = 
DIVIDE(
    [ActivatedCoEComponents],
    [TotalCoEComponents],
    0
) * 100
```

#### Average CoE Activation Time
```dax
AvgCoEActivationTime = 
AVERAGE(CoEActivations[DurationSeconds]) / 60
```

#### CoE Components by Priority
```dax
CoEByPriority = 
SUMMARIZE(
    CoEActivations,
    CoEActivations[Priority],
    "Count", COUNTROWS(CoEActivations)
)
```

### 5. Universal Integration Measures

#### Total Integration Events
```dax
TotalIntegrationEvents = COUNTROWS(UniversalIntegrationLogs)
```

#### Integration Success Rate
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

#### Average Integration Duration (ms)
```dax
AvgIntegrationDuration = 
AVERAGE(UniversalIntegrationLogs[DurationMs])
```

#### Integration Events by Type
```dax
IntegrationByType = 
SUMMARIZE(
    UniversalIntegrationLogs,
    UniversalIntegrationLogs[IntegrationType],
    "Count", COUNTROWS(UniversalIntegrationLogs),
    "SuccessRate", 
        DIVIDE(
            CALCULATE(
                COUNTROWS(UniversalIntegrationLogs),
                UniversalIntegrationLogs[Status] = "Success"
            ),
            COUNTROWS(UniversalIntegrationLogs),
            0
        ) * 100
)
```

### 6. Copilot Usage Measures

#### Total Copilot Invocations
```dax
TotalCopilotInvocations = COUNTROWS(CopilotCommandInvocations)
```

#### Copilot Inline Suggestions
```dax
CopilotInlineSuggestions = 
CALCULATE(
    COUNTROWS(CopilotCommandInvocations),
    CopilotCommandInvocations[InvocationType] = "Inline"
)
```

#### Copilot Chat Invocations
```dax
CopilotChatInvocations = 
CALCULATE(
    COUNTROWS(CopilotCommandInvocations),
    CopilotCommandInvocations[InvocationType] = "Chat"
)
```

#### Copilot Agent Mode Usage
```dax
CopilotAgentModeUsage = 
CALCULATE(
    COUNTROWS(CopilotCommandInvocations),
    CopilotCommandInvocations[InvocationType] = "Agent"
)
```

#### Copilot Adoption Rate (Last 30 Days)
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

## Dashboard Pages

### Page 1: Executive Summary

**Purpose:** High-level overview of IntelIntent Phase 4 health.

**Visuals:**
- **Card:** Current Readiness Score (gauge: 0-100%)
- **Card:** Successful Deployments (last 30 days)
- **Card:** Average Deployment Duration (minutes)
- **Card:** CoE Activation Rate (%)
- **Line Chart:** Readiness Score Trend (7-day rolling average)
- **Donut Chart:** Deployment Status Distribution (Success, Failed, Running)
- **Bar Chart:** Deployments by Context (Personal, Developer, Family, Business, Enterprise)

### Page 2: Environment Readiness

**Purpose:** Detailed environment configuration and tool installation tracking.

**Visuals:**
- **Card:** Tools Installed Count / Total Tools
- **Card:** Azure Authentication Status (✅/❌)
- **Card:** PATH Configuration Status (✅/❌)
- **Table:** Missing Tools List (from EnvironmentReadiness.MissingTools JSON)
- **Bar Chart:** Readiness Score Over Time (daily)
- **Stacked Bar Chart:** Tools Installed by Category (Dev Tools, CLI, Languages)
- **Gauge:** Current Readiness Score (with conditional formatting: <60% Red, 60-80% Yellow, >80% Green)

### Page 3: Deployment Execution

**Purpose:** Track deployment sessions and checkpoint-level details.

**Visuals:**
- **Card:** Total Deployment Sessions
- **Card:** Success Rate (%)
- **Card:** Failed Deployments (last 7 days)
- **Table:** Recent Deployment Sessions (SessionID, Context, StartTime, Duration, Status)
- **Stacked Bar Chart:** Checkpoints by Phase and Status (Environment, Security, Integration, Automation, Monitoring)
- **Line Chart:** Deployment Duration Trend (over time)
- **Waterfall Chart:** Deployment Phase Breakdown (step counts per phase)

### Page 4: CoE Activation Progress

**Purpose:** Track Center of Excellence component activation and semantic priority distribution.

**Visuals:**
- **Card:** Activated CoE Components / Total
- **Card:** CoE Activation Rate (%)
- **Card:** Average Activation Time (minutes)
- **Treemap:** CoE Components by Category (Identity_Modules, Environment_Setup, Tooling, etc.)
- **Bar Chart:** CoE Components by Priority (1-13+ semantic priority scale)
- **Table:** Failed CoE Activations (ComponentID, Title, ErrorMessage)
- **Line Chart:** CoE Activation Rate Trend (over time)

### Page 5: Universal Integration Health

**Purpose:** Monitor GitHub ↔ M365 integration events and success rates.

**Visuals:**
- **Card:** Total Integration Events
- **Card:** Integration Success Rate (%)
- **Card:** Average Integration Duration (ms)
- **Table:** Recent Integration Events (Context, IntegrationType, Direction, Status, Timestamp)
- **Stacked Bar Chart:** Integration Events by Type (IssueToTask, PRToTeams, CommitToDocs, ProjectToCalendar)
- **Line Chart:** Integration Success Rate Trend (daily)
- **Map (if applicable):** Integration Events by Context (geographic visualization if context includes location metadata)

### Page 6: Copilot Lineage & AI Adoption

**Purpose:** Track GitHub Copilot usage and AI-assisted development metrics.

**Visuals:**
- **Card:** Total Copilot Invocations
- **Card:** Copilot Adoption Rate (invocations per day, last 30 days)
- **Donut Chart:** Copilot Invocations by Type (Inline, Chat, Agent)
- **Line Chart:** Copilot Usage Trend (daily invocations over time)
- **Bar Chart:** Copilot Lifecycle Events (Enable, Disable, Toggle counts)
- **Table:** Recent Copilot Sessions (SessionID, Workspace, Action, Timestamp)

---

## Data Refresh Configuration

### PowerShell Ingestion Script

**Purpose:** Push IntelIntent checkpoint and session data to SQL database for Power BI consumption.

**Location:** `IntelIntent_Seeding/Push-CheckpointsToSQL.ps1`

```powershell
<#
.SYNOPSIS
    Pushes IntelIntent checkpoints to SQL database for Power BI dashboard.

.PARAMETER CheckpointFile
    Path to checkpoint JSON file (default: .\Week1_Checkpoints.json).

.PARAMETER DeploymentSessionFile
    Path to deployment session JSON file (default: .\Sponsors\Phase4_Deployment_Session.json).

.PARAMETER SqlServer
    SQL Server instance name.

.PARAMETER Database
    Database name (default: IntelIntentMetrics).

.PARAMETER UseManagedIdentity
    Use Azure Managed Identity for authentication (default: $true).

.EXAMPLE
    .\Push-CheckpointsToSQL.ps1 -SqlServer "intelintent.database.windows.net" -Database "IntelIntentMetrics"
#>

param(
    [string]$CheckpointFile = ".\Week1_Checkpoints.json",
    [string]$DeploymentSessionFile = ".\Sponsors\Phase4_Deployment_Session.json",
    [Parameter(Mandatory=$true)]
    [string]$SqlServer,
    [string]$Database = "IntelIntentMetrics",
    [bool]$UseManagedIdentity = $true
)

# Import SqlServer module
Import-Module SqlServer -ErrorAction Stop

# Build connection string
if ($UseManagedIdentity) {
    $connectionString = "Server=$SqlServer;Database=$Database;Authentication=Active Directory Managed Identity;"
} else {
    $connectionString = "Server=$SqlServer;Database=$Database;Integrated Security=True;"
}

# Load checkpoint data
if (Test-Path $CheckpointFile) {
    $checkpointData = Get-Content $CheckpointFile | ConvertFrom-Json
    
    foreach ($checkpoint in $checkpointData.Checkpoints) {
        $query = @"
INSERT INTO [dbo].[Week1Checkpoints] (
    CheckpointID, TaskID, SessionID, Timestamp, Status, Description, Duration, Signature,
    ParentTaskID, InputsJSON, OutputsJSON, ArtifactsJSON
) VALUES (
    @CheckpointID, @TaskID, @SessionID, @Timestamp, @Status, @Description, @Duration, @Signature,
    @ParentTaskID, @InputsJSON, @OutputsJSON, @ArtifactsJSON
)
"@
        
        Invoke-Sqlcmd -ConnectionString $connectionString -Query $query -Variable @(
            "CheckpointID=$($checkpoint.CheckpointID)",
            "TaskID=$($checkpoint.TaskID)",
            "SessionID=$($checkpointData.SessionID)",
            "Timestamp=$($checkpoint.Timestamp)",
            "Status=$($checkpoint.Status)",
            "Description=$($checkpoint.Description ?? '')",
            "Duration=$($checkpoint.Duration ?? 0)",
            "Signature=$($checkpoint.Signature ?? '[Pending SHA256]')",
            "ParentTaskID=$($checkpoint.ParentTaskID ?? '')",
            "InputsJSON=$(ConvertTo-Json $checkpoint.Inputs -Compress)",
            "OutputsJSON=$(ConvertTo-Json $checkpoint.Outputs -Compress)",
            "ArtifactsJSON=$(ConvertTo-Json $checkpoint.Artifacts -Compress)"
        )
    }
    
    Write-Host "✅ Pushed $($checkpointData.Checkpoints.Count) checkpoints to SQL" -ForegroundColor Green
}

# Load deployment session data
if (Test-Path $DeploymentSessionFile) {
    $sessionData = Get-Content $DeploymentSessionFile | ConvertFrom-Json
    
    $sessionQuery = @"
INSERT INTO [dbo].[DeploymentSessions] (
    SessionID, StartTime, EndTime, DurationSeconds, Context, IsDryRun, ReadinessScore,
    SuccessCount, FailedCount, SkippedCount, TotalSteps, Status
) VALUES (
    @SessionID, @StartTime, @EndTime, @DurationSeconds, @Context, @IsDryRun, @ReadinessScore,
    @SuccessCount, @FailedCount, @SkippedCount, @TotalSteps, @Status
)
"@
    
    $successCount = ($sessionData.Checkpoints | Where-Object { $_.Status -eq "Success" }).Count
    $failedCount = ($sessionData.Checkpoints | Where-Object { $_.Status -eq "Failed" }).Count
    $skippedCount = ($sessionData.Checkpoints | Where-Object { $_.Status -eq "Skipped" }).Count
    
    Invoke-Sqlcmd -ConnectionString $connectionString -Query $sessionQuery -Variable @(
        "SessionID=$($sessionData.SessionID)",
        "StartTime=$($sessionData.StartTime)",
        "EndTime=$($sessionData.EndTime)",
        "DurationSeconds=$($sessionData.DurationSeconds)",
        "Context=$($sessionData.Context)",
        "IsDryRun=$(if ($sessionData.DryRun) { 1 } else { 0 })",
        "ReadinessScore=0",
        "SuccessCount=$successCount",
        "FailedCount=$failedCount",
        "SkippedCount=$skippedCount",
        "TotalSteps=$($sessionData.Checkpoints.Count)",
        "Status=$(if ($failedCount -eq 0) { 'Success' } else { 'Failed' })"
    )
    
    # Push deployment checkpoints
    foreach ($checkpoint in $sessionData.Checkpoints) {
        $checkpointQuery = @"
INSERT INTO [dbo].[DeploymentCheckpoints] (
    SessionID, Timestamp, Phase, Step, Status, Metadata
) VALUES (
    @SessionID, @Timestamp, @Phase, @Step, @Status, @Metadata
)
"@
        
        Invoke-Sqlcmd -ConnectionString $connectionString -Query $checkpointQuery -Variable @(
            "SessionID=$($sessionData.SessionID)",
            "Timestamp=$($checkpoint.Timestamp)",
            "Phase=$($checkpoint.Phase)",
            "Step=$($checkpoint.Step)",
            "Status=$($checkpoint.Status)",
            "Metadata=$(ConvertTo-Json $checkpoint.Metadata -Compress)"
        )
    }
    
    Write-Host "✅ Pushed deployment session and $($sessionData.Checkpoints.Count) deployment checkpoints to SQL" -ForegroundColor Green
}

Write-Host "`n📊 Data ready for Power BI refresh" -ForegroundColor Cyan
```

### Power BI Refresh Schedule

**Recommended Configuration:**
- **Frequency:** Every 1 hour during active development
- **Retention:** 90 days for detailed logs, 1 year for aggregate metrics
- **Gateway:** Use Azure Data Gateway for on-premises SQL Server, or direct connection for Azure SQL Database

**Power BI Service Configuration:**
1. Navigate to dataset settings
2. Configure scheduled refresh: Hourly (8 AM - 6 PM local time)
3. Enable incremental refresh for `Week1Checkpoints` and `DeploymentCheckpoints` tables
4. Configure email alerts for refresh failures

---

## Integration Pattern

### End-to-End Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│         Week1_Automation.ps1                                │
│         Deploy-IntelIntentPhase4.ps1                        │
│         Test-PostInstall.ps1                                │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼ (Generate JSON)
    ┌────────────────────────────────────────────┐
    │  Week1_Checkpoints.json                    │
    │  Phase4_Deployment_Session.json            │
    │  PostInstall_Verification_Report.json      │
    └────────────────┬───────────────────────────┘
                     │
                     ▼ (Push to SQL)
    ┌────────────────────────────────────────────┐
    │  Push-CheckpointsToSQL.ps1                 │
    │  (Uses SqlServer module + Managed Identity)│
    └────────────────┬───────────────────────────┘
                     │
                     ▼ (Insert/Update)
┌────────────────────────────────────────────────────────────┐
│         Azure SQL Database (IntelIntentMetrics)            │
│  • DeploymentSessions                                      │
│  • DeploymentCheckpoints                                   │
│  • EnvironmentReadiness                                    │
│  • Week1Checkpoints                                        │
│  • CoEActivations                                          │
│  • UniversalIntegrationLogs                                │
│  • CopilotLifecycleEvents                                  │
│  • CopilotCommandInvocations                               │
└────────────────────┬───────────────────────────────────────┘
                     │
                     ▼ (Scheduled Refresh)
    ┌────────────────────────────────────────────┐
    │  Power BI Service                          │
    │  • Executive Summary Dashboard             │
    │  • Environment Readiness Dashboard         │
    │  • Deployment Execution Dashboard          │
    │  • CoE Activation Dashboard                │
    │  • Universal Integration Dashboard         │
    │  • Copilot Lineage Dashboard               │
    └────────────────┬───────────────────────────┘
                     │
                     ▼ (View/Export)
    ┌────────────────────────────────────────────┐
    │  Stakeholders & Sponsors                   │
    │  • Real-time deployment health             │
    │  • Readiness score tracking                │
    │  • CoE activation progress                 │
    │  • AI adoption metrics                     │
    └────────────────────────────────────────────┘
```

---

## Usage Examples

### 1. Integrate Power BI Ingestion into Week1_Automation.ps1

```powershell
# At end of Week1_Automation.ps1
Write-Host "`n📊 Pushing checkpoints to Power BI dashboard..." -ForegroundColor Cyan

.\IntelIntent_Seeding\Push-CheckpointsToSQL.ps1 `
    -SqlServer "intelintent.database.windows.net" `
    -Database "IntelIntentMetrics" `
    -UseManagedIdentity $true

Write-Host "✅ Power BI dashboard updated" -ForegroundColor Green
```

### 2. Integrate into Deploy-IntelIntentPhase4.ps1

```powershell
# In Invoke-MonitoringSetup function
Write-DeploymentStep "Pushing metrics to Power BI" "Running"

.\IntelIntent_Seeding\Push-CheckpointsToSQL.ps1 `
    -CheckpointFile ".\Week1_Checkpoints.json" `
    -DeploymentSessionFile ".\Sponsors\Phase4_Deployment_Session.json" `
    -SqlServer $PowerBISqlServer `
    -Database "IntelIntentMetrics"

Write-DeploymentStep "Metrics pushed to Power BI" "Success"
```

### 3. Manual Power BI Update

```powershell
# Push checkpoints manually after automation
.\IntelIntent_Seeding\Push-CheckpointsToSQL.ps1 `
    -SqlServer "intelintent.database.windows.net" `
    -Database "IntelIntentMetrics"

# Verify in SQL
Invoke-Sqlcmd -ServerInstance "intelintent.database.windows.net" `
    -Database "IntelIntentMetrics" `
    -Query "SELECT TOP 10 * FROM DeploymentSessions ORDER BY StartTime DESC"
```

---

## Summary

This Power BI schema provides comprehensive tracking for:
- ✅ **Deployment Health:** Success rates, duration trends, phase-level checkpoints
- ✅ **Environment Readiness:** Tool installation, PATH configuration, Azure authentication
- ✅ **CoE Activation:** Semantic priority tracking, component completion rates
- ✅ **Universal Integration:** GitHub ↔ M365 event success rates and types
- ✅ **Copilot Lineage:** AI-assisted development metrics and adoption rates

**Next Steps:**
1. Create Azure SQL Database: `IntelIntentMetrics`
2. Execute SQL schema scripts (DeploymentSessions, DeploymentCheckpoints, etc.)
3. Implement `Push-CheckpointsToSQL.ps1` ingestion script
4. Build Power BI dashboard with 6 pages (Executive, Readiness, Deployment, CoE, Integration, Copilot)
5. Configure scheduled refresh (hourly during development)
6. Share dashboard with sponsors and stakeholders

**Power BI Dataset Configuration:**
- **Import Mode:** For historical trend analysis
- **DirectQuery Mode:** For real-time monitoring during deployments
- **Hybrid Mode:** Aggregate tables in Import, detail tables in DirectQuery
