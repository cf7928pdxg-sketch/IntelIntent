# Power BI Dashboard Schema: IntelIntent Orchestration

## 🎯 Overview

**Purpose:** Provide sponsors, executives, and operations teams with real-time visibility into IntelIntent orchestration health, lineage traceability, and compliance metrics.

**Target Audience:**
- **Sponsors**: Executive summary, lineage exploration, investment visibility
- **Operations**: Component throughput, agent performance, system health
- **Compliance**: Audit trails, RBAC actions, SOC 2 reports

**Data Sources:**
- Azure SQL Database (checkpoints, audit logs, component metrics)
- Azure Application Insights (telemetry, exceptions, traces)
- Azure Monitor (custom metrics, health checks)
- Redis Cache (performance metrics)

---

## 📊 Dashboard Portfolio

### 1. Executive Summary Dashboard
**Audience:** Sponsors, C-Suite  
**Refresh Rate:** 5 minutes  
**Key Metrics:** Uptime, success rate, throughput, ROI

### 2. Lineage Viewer Dashboard
**Audience:** Sponsors, Auditors  
**Refresh Rate:** 1 minute  
**Key Metrics:** Task chains, delegation paths, signature verification

### 3. Compliance Dashboard
**Audience:** Auditors, Security Team  
**Refresh Rate:** 15 minutes  
**Key Metrics:** RBAC actions, secret rotations, audit coverage

### 4. Operations Dashboard
**Audience:** DevOps, Platform Team  
**Refresh Rate:** 30 seconds  
**Key Metrics:** Agent utilization, queue depth, error rates, latency

---

## 🗄️ Azure SQL Database Schema

### Table: `Checkpoints`

**Purpose:** Store orchestration step metadata with lineage signatures.

```sql
CREATE TABLE [dbo].[Checkpoints] (
    [CheckpointID]      NVARCHAR(50)    PRIMARY KEY,
    [TaskID]            NVARCHAR(50)    NOT NULL,
    [SessionID]         NVARCHAR(36)    NOT NULL,
    [Timestamp]         DATETIME2       NOT NULL,
    [Status]            NVARCHAR(20)    NOT NULL,  -- Success, Failed, InProgress
    [AgentName]         NVARCHAR(50)    NULL,
    [Category]          NVARCHAR(50)    NULL,
    [Priority]          INT             NULL,
    [Duration]          INT             NULL,      -- Seconds
    [InputsJSON]        NVARCHAR(MAX)   NULL,
    [OutputsJSON]       NVARCHAR(MAX)   NULL,
    [Signature]         NVARCHAR(64)    NULL,      -- SHA256 hash
    [ParentTaskID]      NVARCHAR(50)    NULL,      -- For delegation chains
    [ArtifactsJSON]     NVARCHAR(MAX)   NULL,      -- File paths and hashes
    [CreatedDate]       DATE            NOT NULL DEFAULT GETDATE(),
    [ModifiedDate]      DATETIME2       NOT NULL DEFAULT GETDATE()
);

-- Indexes for query performance
CREATE INDEX IX_Checkpoints_Timestamp ON [dbo].[Checkpoints]([Timestamp] DESC);
CREATE INDEX IX_Checkpoints_SessionID ON [dbo].[Checkpoints]([SessionID]);
CREATE INDEX IX_Checkpoints_Status ON [dbo].[Checkpoints]([Status], [Timestamp]);
CREATE INDEX IX_Checkpoints_AgentName ON [dbo].[Checkpoints]([AgentName], [Timestamp]);
CREATE INDEX IX_Checkpoints_ParentTaskID ON [dbo].[Checkpoints]([ParentTaskID]);

-- Computed column for date hierarchy
ALTER TABLE [dbo].[Checkpoints] 
ADD [TimestampDate] AS CAST([Timestamp] AS DATE) PERSISTED;
```

---

### Table: `AuditLogs`

**Purpose:** Immutable audit trail for compliance (SOC 2 Type II).

```sql
CREATE TABLE [dbo].[AuditLogs] (
    [LogID]             BIGINT          IDENTITY(1,1) PRIMARY KEY,
    [Timestamp]         DATETIME2       NOT NULL DEFAULT GETDATE(),
    [EventType]         NVARCHAR(50)    NOT NULL,  -- Orchestrator:Run, RBAC:Grant, Secret:Access
    [EventCategory]     NVARCHAR(50)    NOT NULL,  -- Orchestration, Security, Configuration
    [UserEmail]         NVARCHAR(255)   NOT NULL,
    [UserRole]          NVARCHAR(50)    NULL,      -- Admin, Developer, Sponsor, Auditor
    [EventDataJSON]     NVARCHAR(MAX)   NULL,
    [SessionID]         NVARCHAR(36)    NULL,
    [SourceIP]          NVARCHAR(45)    NULL,
    [Hash]              NVARCHAR(64)    NOT NULL,  -- SHA256 for tamper detection
    [Severity]          NVARCHAR(20)    NULL       -- Info, Warning, Error, Critical
);

-- Append-only constraint (no updates/deletes allowed)
CREATE TRIGGER TR_AuditLogs_PreventModification
ON [dbo].[AuditLogs]
AFTER UPDATE, DELETE
AS
BEGIN
    RAISERROR('AuditLogs table is append-only. Modifications not allowed.', 16, 1);
    ROLLBACK TRANSACTION;
END;

-- Indexes
CREATE INDEX IX_AuditLogs_Timestamp ON [dbo].[AuditLogs]([Timestamp] DESC);
CREATE INDEX IX_AuditLogs_EventType ON [dbo].[AuditLogs]([EventType], [Timestamp]);
CREATE INDEX IX_AuditLogs_UserEmail ON [dbo].[AuditLogs]([UserEmail], [Timestamp]);
CREATE INDEX IX_AuditLogs_Severity ON [dbo].[AuditLogs]([Severity], [Timestamp]);
```

---

### Table: `ComponentMetrics`

**Purpose:** Track component generation performance over time.

```sql
CREATE TABLE [dbo].[ComponentMetrics] (
    [MetricID]              BIGINT          IDENTITY(1,1) PRIMARY KEY,
    [ComponentID]           NVARCHAR(50)    NOT NULL,
    [ComponentTitle]        NVARCHAR(255)   NULL,
    [Category]              NVARCHAR(50)    NOT NULL,
    [Priority]              INT             NULL,
    [GeneratedDate]         DATE            NOT NULL DEFAULT GETDATE(),
    [GenerationTimeSeconds] INT             NULL,
    [Success]               BIT             NOT NULL,
    [AgentName]             NVARCHAR(50)    NULL,
    [SessionID]             NVARCHAR(36)    NULL,
    [RetryCount]            INT             NULL DEFAULT 0,
    [ErrorMessage]          NVARCHAR(MAX)   NULL
);

-- Indexes
CREATE INDEX IX_ComponentMetrics_Date ON [dbo].[ComponentMetrics]([GeneratedDate] DESC);
CREATE INDEX IX_ComponentMetrics_Category ON [dbo].[ComponentMetrics]([Category], [GeneratedDate]);
CREATE INDEX IX_ComponentMetrics_Success ON [dbo].[ComponentMetrics]([Success], [GeneratedDate]);
```

---

### Table: `OrchestratorSessions`

**Purpose:** Track orchestrator execution sessions with summary metrics.

```sql
CREATE TABLE [dbo].[OrchestratorSessions] (
    [SessionID]             NVARCHAR(36)    PRIMARY KEY,
    [StartTime]             DATETIME2       NOT NULL,
    [EndTime]               DATETIME2       NULL,
    [Duration]              INT             NULL,      -- Seconds
    [Mode]                  NVARCHAR(20)    NOT NULL,  -- Full, ManifestOnly, GenerateOnly
    [TotalComponents]       INT             NOT NULL,
    [CompletedComponents]   INT             NULL,
    [FailedComponents]      INT             NULL,
    [SkippedComponents]     INT             NULL,
    [SuccessRate]           DECIMAL(5,2)    NULL,      -- Percentage
    [TriggeredBy]           NVARCHAR(255)   NULL,      -- User email
    [Status]                NVARCHAR(20)    NOT NULL   -- Running, Completed, Failed
);

-- Indexes
CREATE INDEX IX_OrchestratorSessions_StartTime ON [dbo].[OrchestratorSessions]([StartTime] DESC);
CREATE INDEX IX_OrchestratorSessions_Status ON [dbo].[OrchestratorSessions]([Status], [StartTime]);
```

---

### Table: `AgentPerformance`

**Purpose:** Track individual agent execution metrics.

```sql
CREATE TABLE [dbo].[AgentPerformance] (
    [PerformanceID]         BIGINT          IDENTITY(1,1) PRIMARY KEY,
    [AgentName]             NVARCHAR(50)    NOT NULL,
    [Operation]             NVARCHAR(50)    NULL,
    [ExecutionDate]         DATE            NOT NULL DEFAULT GETDATE(),
    [ExecutionCount]        INT             NOT NULL DEFAULT 0,
    [SuccessCount]          INT             NOT NULL DEFAULT 0,
    [FailureCount]          INT             NOT NULL DEFAULT 0,
    [AvgDurationSeconds]    DECIMAL(10,2)   NULL,
    [TotalDurationSeconds]  INT             NULL
);

-- Indexes
CREATE UNIQUE INDEX UX_AgentPerformance_Daily ON [dbo].[AgentPerformance]([AgentName], [Operation], [ExecutionDate]);
CREATE INDEX IX_AgentPerformance_Date ON [dbo].[AgentPerformance]([ExecutionDate] DESC);
```

---

### Table: `SystemHealth`

**Purpose:** Store health check results for monitoring.

```sql
CREATE TABLE [dbo].[SystemHealth] (
    [HealthID]              BIGINT          IDENTITY(1,1) PRIMARY KEY,
    [Timestamp]             DATETIME2       NOT NULL DEFAULT GETDATE(),
    [OverallStatus]         NVARCHAR(20)    NOT NULL,  -- Healthy, Degraded, Unhealthy
    [SemanticKernelStatus]  NVARCHAR(20)    NULL,
    [GraphAPIStatus]        NVARCHAR(20)    NULL,
    [AzureOpenAIStatus]     NVARCHAR(20)    NULL,
    [StorageStatus]         NVARCHAR(20)    NULL,
    [RedisStatus]           NVARCHAR(20)    NULL,
    [ResponseTimeMS]        INT             NULL
);

-- Indexes
CREATE INDEX IX_SystemHealth_Timestamp ON [dbo].[SystemHealth]([Timestamp] DESC);
CREATE INDEX IX_SystemHealth_Status ON [dbo].[SystemHealth]([OverallStatus], [Timestamp]);
```

---

## 🔗 Table Relationships (Power BI Data Model)

```
OrchestratorSessions (1) ────────── (*) Checkpoints
    SessionID                            SessionID

Checkpoints (1) ────────────────────── (*) Checkpoints
    TaskID                                   ParentTaskID
    (Parent Task)                            (Child Task - Delegation)

Checkpoints (*) ────────────────────── (1) AgentPerformance
    AgentName, CreatedDate                   AgentName, ExecutionDate

ComponentMetrics (*) ───────────────── (1) OrchestratorSessions
    SessionID                                SessionID

AuditLogs (*) ──────────────────────── (1) OrchestratorSessions
    SessionID                                SessionID

SystemHealth (1) ───────────────────── (*) Checkpoints
    Timestamp (nearest match)                Timestamp
```

**Relationship Types:**
- One-to-Many (1:*): Most common for session → tasks
- Self-Referencing (1:*): Checkpoints → Checkpoints for delegation chains
- Many-to-One (*:1): Multiple checkpoints/metrics to one session

**Cross-Filter Direction:**
- Single: Session → Checkpoints (default)
- Both: Enable for delegation chain exploration

---

## 📐 DAX Measures Library

### Executive Summary Measures

```dax
// Total Orchestration Runs (Last 30 Days)
TotalOrchestrationRuns = 
CALCULATE(
    COUNTROWS(OrchestratorSessions),
    OrchestratorSessions[StartTime] >= TODAY() - 30
)

// Overall Success Rate
SuccessRate = 
DIVIDE(
    CALCULATE(COUNTROWS(Checkpoints), Checkpoints[Status] = "Success"),
    COUNTROWS(Checkpoints)
) * 100

// Average Component Generation Time
AvgGenerationTime = 
AVERAGE(ComponentMetrics[GenerationTimeSeconds])

// Components Generated Today
ComponentsToday = 
CALCULATE(
    COUNTROWS(ComponentMetrics),
    ComponentMetrics[GeneratedDate] = TODAY()
)

// Uptime Percentage (Last 24 Hours)
UptimePercentage = 
VAR TotalChecks = 
    CALCULATE(
        COUNTROWS(SystemHealth),
        SystemHealth[Timestamp] >= NOW() - 1
    )
VAR HealthyChecks = 
    CALCULATE(
        COUNTROWS(SystemHealth),
        SystemHealth[OverallStatus] = "Healthy",
        SystemHealth[Timestamp] >= NOW() - 1
    )
RETURN
    DIVIDE(HealthyChecks, TotalChecks) * 100

// Agent Utilization
AgentUtilization = 
VAR TotalAgentSeconds = SUMX(Checkpoints, Checkpoints[Duration])
VAR TotalAvailableSeconds = 86400  // 24 hours in seconds
RETURN
    DIVIDE(TotalAgentSeconds, TotalAvailableSeconds) * 100

// Orchestration Throughput (Components/Hour)
OrchestratorThroughput = 
VAR TotalComponents = COUNTROWS(ComponentMetrics)
VAR TotalHours = 
    DATEDIFF(
        MIN(OrchestratorSessions[StartTime]),
        MAX(OrchestratorSessions[EndTime]),
        HOUR
    )
RETURN
    DIVIDE(TotalComponents, TotalHours)
```

---

### Lineage Viewer Measures

```dax
// Total Delegation Chains
TotalDelegations = 
CALCULATE(
    COUNTROWS(Checkpoints),
    NOT(ISBLANK(Checkpoints[ParentTaskID]))
)

// Delegation Depth (Max Chain Length)
MaxDelegationDepth = 
VAR DelegationPaths = 
    ADDCOLUMNS(
        Checkpoints,
        "Depth", 
        PATHLENGTH(
            PATH(Checkpoints[TaskID], Checkpoints[ParentTaskID])
        )
    )
RETURN
    MAXX(DelegationPaths, [Depth])

// Signature Verification Rate
SignatureVerificationRate = 
VAR TotalWithSignatures = 
    CALCULATE(
        COUNTROWS(Checkpoints),
        NOT(ISBLANK(Checkpoints[Signature]))
    )
VAR TotalCheckpoints = COUNTROWS(Checkpoints)
RETURN
    DIVIDE(TotalWithSignatures, TotalCheckpoints) * 100

// Average Task Duration by Agent
AvgTaskDurationByAgent = 
CALCULATE(
    AVERAGE(Checkpoints[Duration]),
    ALLEXCEPT(Checkpoints, Checkpoints[AgentName])
)
```

---

### Compliance Measures

```dax
// Total Audit Events (Last 90 Days)
TotalAuditEvents = 
CALCULATE(
    COUNTROWS(AuditLogs),
    AuditLogs[Timestamp] >= TODAY() - 90
)

// Critical Security Events
CriticalSecurityEvents = 
CALCULATE(
    COUNTROWS(AuditLogs),
    AuditLogs[Severity] = "Critical",
    AuditLogs[EventCategory] = "Security"
)

// RBAC Actions by Role
RBACActionsByRole = 
CALCULATE(
    COUNTROWS(AuditLogs),
    AuditLogs[EventType] = "RBAC:Grant" || AuditLogs[EventType] = "RBAC:Revoke",
    VALUES(AuditLogs[UserRole])
)

// Secret Access Count (Last 30 Days)
SecretAccessCount = 
CALCULATE(
    COUNTROWS(AuditLogs),
    AuditLogs[EventType] = "Secret:Access",
    AuditLogs[Timestamp] >= TODAY() - 30
)

// Audit Coverage Percentage
AuditCoverage = 
VAR TotalOrchestrationActions = COUNTROWS(Checkpoints)
VAR TotalAuditedActions = 
    CALCULATE(
        COUNTROWS(AuditLogs),
        AuditLogs[EventCategory] = "Orchestration"
    )
RETURN
    DIVIDE(TotalAuditedActions, TotalOrchestrationActions) * 100
```

---

### Operations Measures

```dax
// Current Queue Depth
CurrentQueueDepth = 
CALCULATE(
    COUNTROWS(Checkpoints),
    Checkpoints[Status] = "InProgress"
)

// Error Rate (Last 24 Hours)
ErrorRate24h = 
VAR TotalTasks = 
    CALCULATE(
        COUNTROWS(Checkpoints),
        Checkpoints[Timestamp] >= NOW() - 1
    )
VAR FailedTasks = 
    CALCULATE(
        COUNTROWS(Checkpoints),
        Checkpoints[Status] = "Failed",
        Checkpoints[Timestamp] >= NOW() - 1
    )
RETURN
    DIVIDE(FailedTasks, TotalTasks) * 100

// P95 Response Time
P95ResponseTime = 
PERCENTILE.INC(SystemHealth[ResponseTimeMS], 0.95)

// Components Pending Retry
ComponentsPendingRetry = 
CALCULATE(
    COUNTROWS(ComponentMetrics),
    ComponentMetrics[Success] = FALSE,
    ComponentMetrics[RetryCount] < 3
)

// Agent Failure Rate by Type
AgentFailureRate = 
DIVIDE(
    CALCULATE(
        COUNTROWS(Checkpoints),
        Checkpoints[Status] = "Failed"
    ),
    COUNTROWS(Checkpoints)
) * 100
```

---

## 📊 Dashboard 1: Executive Summary

### Layout Configuration

**Page Size:** 16:9 (1920x1080)  
**Theme:** Dark with IntelIntent brand colors  
**Refresh:** Auto-refresh every 5 minutes

### Visual Placement

```
┌───────────────────────────────────────────────────────────────────────────┐
│  INTELINTENT ORCHESTRATION - EXECUTIVE SUMMARY                            │
│  Last Updated: [Dynamic Text]                                             │
├───────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │
│  │  UPTIME     │  │  SUCCESS    │  │  THROUGHPUT │  │  COMPONENTS │    │
│  │  99.87%     │  │  RATE       │  │  0.23/s     │  │  TODAY      │    │
│  │  ↑ 0.05%    │  │  98.4%      │  │  ↑ 12%     │  │  1,247      │    │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘    │
│                                                                           │
│  ┌─────────────────────────────────┐  ┌───────────────────────────────┐ │
│  │  ORCHESTRATION RUNS (30 DAYS)  │  │  AGENT UTILIZATION            │ │
│  │                                 │  │                               │ │
│  │  [Area Chart]                  │  │  FinanceAgent      ████ 78%  │ │
│  │  Success: Green line           │  │  IdentityAgent     ███  65%  │ │
│  │  Failed: Red line              │  │  DeploymentAgent   ██   45%  │ │
│  │  Total: Gray area              │  │  BoopasAgent       ██   42%  │ │
│  │                                 │  │  ModalityAgent     █    28%  │ │
│  │                                 │  │  OrchestratorAgent █    15%  │ │
│  └─────────────────────────────────┘  └───────────────────────────────┘ │
│                                                                           │
│  ┌─────────────────────────────────┐  ┌───────────────────────────────┐ │
│  │  COMPONENT GENERATION TRENDS    │  │  HEALTH STATUS                │ │
│  │                                 │  │                               │ │
│  │  [Column Chart by Category]    │  │  Semantic Kernel   ● Healthy │ │
│  │  Identity_Modules: 345         │  │  Microsoft Graph   ● Healthy │ │
│  │  Environment_Setup: 289        │  │  Azure OpenAI      ● Healthy │ │
│  │  CI_CD_Workflows: 234          │  │  Storage           ● Healthy │ │
│  │  Security_Validation: 198      │  │  Redis Cache       ● Healthy │ │
│  │  Services: 181                 │  │                               │ │
│  └─────────────────────────────────┘  └───────────────────────────────┘ │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘
```

### Visual Specifications

#### KPI Cards (Top Row)
- **Visual Type:** Card
- **Values:**
  - Uptime: `[UptimePercentage]` (formatted as percentage, 2 decimals)
  - Success Rate: `[SuccessRate]` (formatted as percentage, 1 decimal)
  - Throughput: `[OrchestratorThroughput]` (formatted as decimal, 2 places)
  - Components Today: `[ComponentsToday]` (formatted as whole number with comma)
- **Data Labels:** 
  - Font: Segoe UI, 48pt, Bold
  - Color: White (#FFFFFF)
  - Trend indicator: Up arrow (green) or down arrow (red)
- **Background:** Dark gray (#1E1E1E) with subtle gradient
- **Border:** 1px solid #333333

#### Orchestration Runs Chart
- **Visual Type:** Area Chart
- **X-Axis:** `OrchestratorSessions[StartTime]` (grouped by day)
- **Y-Axis:** Count of sessions
- **Legend:**
  - Success: Green (#10B981)
  - Failed: Red (#EF4444)
  - Total: Gray (#6B7280)
- **Data Labels:** Off
- **Gridlines:** Horizontal only, light gray (#2D2D2D)
- **Tooltip:** Custom with session ID, duration, success rate

#### Agent Utilization Chart
- **Visual Type:** Horizontal Bar Chart
- **Axis:** `Checkpoints[AgentName]`
- **Values:** `[AgentUtilization]`
- **Data Labels:** On (inside end), white, bold
- **Bar Color:** Gradient from blue (#3B82F6) to purple (#8B5CF6)
- **Conditional Formatting:**
  - >80%: Red (#EF4444)
  - 50-80%: Yellow (#F59E0B)
  - <50%: Green (#10B981)

#### Component Generation Trends Chart
- **Visual Type:** Clustered Column Chart
- **X-Axis:** `ComponentMetrics[Category]`
- **Y-Axis:** Count of components
- **Color:** Single color (#6366F1)
- **Data Labels:** On top, white
- **Sort:** Descending by count

#### Health Status Table
- **Visual Type:** Table
- **Columns:**
  - Component Name
  - Status Icon (conditional formatting)
- **Conditional Formatting:**
  - Healthy: Green circle (●)
  - Degraded: Yellow triangle (▲)
  - Unhealthy: Red square (■)
- **Font:** Monospace (Consolas), 14pt
- **Background:** Dark (#1E1E1E)

---

## 📊 Dashboard 2: Lineage Viewer

### Layout Configuration

**Page Size:** 16:9 (1920x1080)  
**Theme:** Dark with accent colors for task paths  
**Refresh:** Auto-refresh every 1 minute

### Visual Placement

```
┌───────────────────────────────────────────────────────────────────────────┐
│  CODEX SCROLL LINEAGE VIEWER                                              │
│  [Session Dropdown]  [Date Range Picker]  [Agent Filter]                 │
├───────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  ┌─────────────────────────────────────┐  ┌───────────────────────────┐ │
│  │  DELEGATION CHAIN EXPLORER          │  │  LINEAGE STATISTICS       │ │
│  │                                     │  │                           │ │
│  │  [Network Graph Visualization]     │  │  Total Tasks: 1,247      │ │
│  │                                     │  │  Delegation Chains: 89   │ │
│  │  OrchestratorAgent                 │  │  Max Depth: 4            │ │
│  │       ├─> FinanceAgent              │  │  Signature Verified: 100%│ │
│  │       │      └─> IdentityAgent      │  │                           │ │
│  │       └─> DeploymentAgent           │  │  [Donut Chart]            │ │
│  │                                     │  │  Success: 98.4%          │ │
│  │  Click nodes for details...        │  │  Failed: 1.2%            │ │
│  │                                     │  │  InProgress: 0.4%        │ │
│  └─────────────────────────────────────┘  └───────────────────────────┘ │
│                                                                           │
│  ┌────────────────────────────────────────────────────────────────────┐  │
│  │  TASK DETAILS (Selected: FIN-001)                                  │  │
│  │                                                                     │  │
│  │  Task ID:        FIN-001                                           │  │
│  │  Timestamp:      2025-11-26 14:35:22                               │  │
│  │  Status:         ✅ Success                                         │  │
│  │  Agent:          FinanceAgent                                       │  │
│  │  Duration:       3.2 seconds                                        │  │
│  │  Signature:      a7b3c2d1e4f56789abcdef1234567890...               │  │
│  │                                                                     │  │
│  │  Inputs:         { "UserID": "investor1", "Action": "Report" }    │  │
│  │  Outputs:        { "ReportPath": "./reports/...", ... }           │  │
│  │  Artifacts:      investment_report_2025Q4.pdf (SHA256: b8c4...)   │  │
│  │                                                                     │  │
│  │  [Verify Signature]  [Export Codex Fragment]  [View Full JSON]    │  │
│  └────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │  TIMELINE VIEW (Selected Session)                                   │ │
│  │                                                                      │ │
│  │  [Gantt Chart]                                                      │ │
│  │  14:35:00 ─────────────────────────────────────────────> 14:38:00  │ │
│  │    ├─ ENV-001 [████]                                                │ │
│  │    ├─ ENV-002    [███]                                              │ │
│  │    ├─ ID-001        [████]                                          │ │
│  │    └─ FIN-001          [█████]                                      │ │
│  │                                                                      │ │
│  └─────────────────────────────────────────────────────────────────────┘ │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘
```

### Visual Specifications

#### Delegation Chain Network Graph
- **Visual Type:** Custom Network Diagram (D3.js or Power BI Custom Visual)
- **Data:**
  - Nodes: `Checkpoints[TaskID]`
  - Edges: `Checkpoints[ParentTaskID]` → `Checkpoints[TaskID]`
- **Node Color:** By `AgentName`
  - OrchestratorAgent: Purple (#8B5CF6)
  - FinanceAgent: Green (#10B981)
  - IdentityAgent: Blue (#3B82F6)
  - DeploymentAgent: Orange (#F59E0B)
- **Node Size:** By `Duration` (larger = longer execution)
- **Edge Style:** Directed arrows
- **Interactivity:** Click to select, hover for tooltip

#### Task Details Panel
- **Visual Type:** Card with custom HTML
- **Data Source:** Selected row from `Checkpoints` table
- **Fields Displayed:**
  - TaskID, Timestamp, Status, AgentName, Duration, Signature
  - InputsJSON (formatted JSON viewer)
  - OutputsJSON (formatted JSON viewer)
  - ArtifactsJSON (parsed as list with hashes)
- **Actions:**
  - **Verify Signature:** Compare hash against stored value
  - **Export Codex Fragment:** Download Markdown fragment
  - **View Full JSON:** Open modal with complete checkpoint

#### Timeline Gantt Chart
- **Visual Type:** Gantt Chart (Custom Visual or Deneb)
- **X-Axis:** Time (from session start to end)
- **Y-Axis:** `Checkpoints[TaskID]`
- **Bar Length:** `Checkpoints[Duration]`
- **Bar Color:** By `Status`
  - Success: Green (#10B981)
  - Failed: Red (#EF4444)
  - InProgress: Yellow (#F59E0B)
- **Tooltip:** TaskID, Agent, Duration, Status

---

## 📊 Dashboard 3: Compliance

### Layout Configuration

**Page Size:** 16:9 (1920x1080)  
**Theme:** Professional (light background for printability)  
**Refresh:** Auto-refresh every 15 minutes

### Visual Placement

```
┌───────────────────────────────────────────────────────────────────────────┐
│  SOC 2 TYPE II COMPLIANCE DASHBOARD                                       │
│  Reporting Period: [Date Range Picker]  [Export PDF]                     │
├───────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │
│  │  AUDIT      │  │  RBAC       │  │  SECRET     │  │  COVERAGE   │    │
│  │  EVENTS     │  │  ACTIONS    │  │  ROTATIONS  │  │  RATE       │    │
│  │  12,847     │  │  234        │  │  45/90 days │  │  99.8%      │    │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘    │
│                                                                           │
│  ┌─────────────────────────────────┐  ┌───────────────────────────────┐ │
│  │  AUDIT EVENTS BY CATEGORY       │  │  CRITICAL SECURITY ALERTS     │ │
│  │                                 │  │                               │ │
│  │  [Donut Chart]                  │  │  [Table]                      │ │
│  │  Orchestration      ████ 68%   │  │  Date       Type      User    │ │
│  │  Security           ███  18%   │  │  11/26 14:35 PermChange Admin │ │
│  │  Configuration      ██    9%   │  │  11/25 22:10 SecretAccess Dev2│ │
│  │  Integration        █     5%   │  │  11/24 09:15 RoleGrant Admin │ │
│  │                                 │  │  ...                          │ │
│  └─────────────────────────────────┘  └───────────────────────────────┘ │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │  RBAC ACTIONS TIMELINE (90 DAYS)                                    │ │
│  │                                                                      │ │
│  │  [Line Chart]                                                       │ │
│  │  Grant (Green line)                                                 │ │
│  │  Revoke (Red line)                                                  │ │
│  │                                                                      │ │
│  └─────────────────────────────────────────────────────────────────────┘ │
│                                                                           │
│  ┌─────────────────────────────────┐  ┌───────────────────────────────┐ │
│  │  USER ACTIVITY BY ROLE          │  │  SECRET ACCESS LOG            │ │
│  │                                 │  │                               │ │
│  │  [Stacked Bar Chart]            │  │  [Matrix]                     │ │
│  │  Admin:      ████████████ 450  │  │  Secret Name    Access Count  │ │
│  │  Developer:  ██████       210  │  │  azure-openai   ███ 45        │ │
│  │  Auditor:    ██            78  │  │  graph-secret   ██  23        │ │
│  │  Sponsor:    █             34  │  │  speech-key     █   12        │ │
│  │                                 │  │                               │ │
│  └─────────────────────────────────┘  └───────────────────────────────┘ │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │  AUDIT LOG INTEGRITY VERIFICATION                                   │ │
│  │                                                                      │ │
│  │  ✅ All hashes verified (12,847 entries)                            │ │
│  │  ✅ No tampering detected                                           │ │
│  │  ✅ Append-only constraint enforced                                 │ │
│  │                                                                      │ │
│  │  Last Verification: 2025-11-26 14:35:00                             │ │
│  │  Next Scheduled: 2025-11-26 15:00:00                                │ │
│  │                                                                      │ │
│  └─────────────────────────────────────────────────────────────────────┘ │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘
```

### Visual Specifications

#### Audit Events by Category Donut Chart
- **Visual Type:** Donut Chart
- **Values:** Count of `AuditLogs[EventCategory]`
- **Legend:** Right side
- **Colors:** Consistent with brand palette
- **Data Labels:** Percentage and count

#### RBAC Actions Timeline
- **Visual Type:** Line Chart with Markers
- **X-Axis:** `AuditLogs[Timestamp]` (grouped by day)
- **Y-Axis:** Count of events
- **Series:**
  - Grant: Green (#10B981)
  - Revoke: Red (#EF4444)
- **Annotations:** Mark significant events (e.g., bulk permission changes)

#### Audit Log Integrity Panel
- **Visual Type:** Card with custom text
- **Data Source:** Calculated table
- **Verification Logic:**
  ```dax
  AuditIntegrity = 
  VAR TotalLogs = COUNTROWS(AuditLogs)
  VAR VerifiedLogs = 
      COUNTROWS(
          FILTER(
              AuditLogs,
              AuditLogs[Hash] = CALCULATETABLE(
                  [RecalculatedHash],
                  AuditLogs[Timestamp],
                  AuditLogs[EventType],
                  AuditLogs[UserEmail]
              )
          )
      )
  RETURN
      IF(TotalLogs = VerifiedLogs, "✅ Verified", "❌ Tampering Detected")
  ```

---

## 📊 Dashboard 4: Operations

### Layout Configuration

**Page Size:** 16:9 (1920x1080)  
**Theme:** Dark with real-time indicators  
**Refresh:** Auto-refresh every 30 seconds

### Visual Placement

```
┌───────────────────────────────────────────────────────────────────────────┐
│  OPERATIONS DASHBOARD - REAL-TIME MONITORING                              │
│  Status: ● OPERATIONAL  │  Last Update: [Live Clock]                     │
├───────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │
│  │  QUEUE      │  │  ERROR      │  │  P95        │  │  ACTIVE     │    │
│  │  DEPTH      │  │  RATE       │  │  LATENCY    │  │  SESSIONS   │    │
│  │  12         │  │  1.2%       │  │  234ms      │  │  3          │    │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘    │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │  COMPONENT GENERATION QUEUE (LIVE)                                  │ │
│  │                                                                      │ │
│  │  [Table with Auto-Refresh]                                          │ │
│  │  Component ID   Category         Status        Agent       Duration │ │
│  │  ENV-045        Environment      ● InProgress  Deployment   8s      │ │
│  │  ID-023         Identity         ⏸ Queued      Identity      -      │ │
│  │  FIN-089        Finance          ⏸ Queued      Finance       -      │ │
│  │  SEC-012        Security         ✅ Completed   Security     12s     │ │
│  │  ...                                                                 │ │
│  └─────────────────────────────────────────────────────────────────────┘ │
│                                                                           │
│  ┌─────────────────────────────────┐  ┌───────────────────────────────┐ │
│  │  ERROR RATE OVER TIME (24H)    │  │  AGENT STATUS                 │ │
│  │                                 │  │                               │ │
│  │  [Line Chart]                  │  │  [Table]                      │ │
│  │  Current: 1.2%                 │  │  Agent          Status  Load  │ │
│  │  Avg: 0.8%                     │  │  Orchestrator   ●  100% ██    │ │
│  │  Peak: 3.5% (11:23 AM)         │  │  Finance        ●   78% ████  │ │
│  │                                 │  │  Identity       ●   65% ███   │ │
│  │                                 │  │  Deployment     ●   45% ██    │ │
│  │                                 │  │  Boopas         ●   42% ██    │ │
│  │                                 │  │  Modality       ●   28% █     │ │
│  └─────────────────────────────────┘  └───────────────────────────────┘ │
│                                                                           │
│  ┌─────────────────────────────────┐  ┌───────────────────────────────┐ │
│  │  RESPONSE TIME DISTRIBUTION     │  │  TOP 10 SLOWEST COMPONENTS    │ │
│  │                                 │  │                               │ │
│  │  [Histogram]                    │  │  [Table]                      │ │
│  │  <100ms:  ████████████ 78%     │  │  ID       Category   Duration │ │
│  │  100-250: ███          18%     │  │  FIN-123  Finance    45.2s    │ │
│  │  250-500: █            3%      │  │  ID-456   Identity   38.7s    │ │
│  │  >500ms:  █            1%      │  │  DEP-789  Deploy     31.4s    │ │
│  │                                 │  │  ...                          │ │
│  └─────────────────────────────────┘  └───────────────────────────────┘ │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘
```

### Visual Specifications

#### Queue Depth KPI
- **Visual Type:** Card with conditional formatting
- **Value:** `[CurrentQueueDepth]`
- **Conditional Formatting:**
  - <10: Green (#10B981)
  - 10-50: Yellow (#F59E0B)
  - >50: Red (#EF4444)
- **Trend Indicator:** Up/down arrow with 24h change

#### Component Generation Queue Table
- **Visual Type:** Table with live updates
- **Refresh:** Every 10 seconds
- **Columns:**
  - ComponentID
  - Category
  - Status (with icon)
  - AgentName
  - Duration (live timer for InProgress)
- **Conditional Formatting:**
  - InProgress: Yellow background
  - Queued: Gray background
  - Completed: Green checkmark
  - Failed: Red X
- **Sorting:** Status (InProgress first), then Priority

#### Agent Status Table
- **Visual Type:** Table with sparklines
- **Columns:**
  - AgentName
  - Status (health indicator)
  - Load (percentage with bar chart)
- **Update:** Every 30 seconds
- **Alert:** Red highlight if agent failure detected

---

## 🔄 Data Refresh Strategy

### Real-Time Streaming (DirectQuery)

**Tables:** `SystemHealth`, `Checkpoints` (InProgress only)  
**Reason:** Operations dashboard needs sub-minute latency  
**Configuration:**
```json
{
  "datasetMode": "DirectQuery",
  "tables": ["SystemHealth", "Checkpoints"],
  "refreshInterval": 30,
  "queryCaching": false
}
```

### Scheduled Refresh (Import Mode)

**Tables:** `AuditLogs`, `ComponentMetrics`, `OrchestratorSessions`, `AgentPerformance`  
**Schedule:**
- Executive/Lineage Dashboards: Every 5 minutes
- Compliance Dashboard: Every 15 minutes  
**Incremental Refresh:**
```json
{
  "incrementalRefresh": {
    "enabled": true,
    "rollingWindowDays": 90,
    "detectDataChanges": false
  }
}
```

---

## 🔐 Row-Level Security (RLS)

### Roles Configuration

```dax
// Sponsor Role - Read-only access to completed sessions
[Sponsor RLS] = 
OrchestratorSessions[Status] = "Completed" 
&& OrchestratorSessions[EndTime] >= TODAY() - 90

// Developer Role - Access to all data except critical security events
[Developer RLS] = 
AuditLogs[Severity] <> "Critical" 
|| AuditLogs[EventCategory] <> "Security"

// Admin Role - Full access (no filter)
[Admin RLS] = TRUE()

// Auditor Role - Read-only access to audit logs and compliance data
[Auditor RLS] = 
AuditLogs[EventCategory] IN {"Orchestration", "Security", "Configuration"}
```

### User-Role Mapping

```sql
-- User assignment table (synced from Azure AD)
CREATE TABLE [dbo].[UserRoleMapping] (
    [UserEmail]     NVARCHAR(255)   PRIMARY KEY,
    [RoleName]      NVARCHAR(50)    NOT NULL,  -- Admin, Developer, Sponsor, Auditor
    [AssignedDate]  DATE            NOT NULL,
    [ExpiryDate]    DATE            NULL
);

-- Populate from Azure AD groups
INSERT INTO [dbo].[UserRoleMapping] (UserEmail, RoleName, AssignedDate)
SELECT 
    u.mail,
    CASE 
        WHEN g.displayName = 'IntelIntent-Admins' THEN 'Admin'
        WHEN g.displayName = 'IntelIntent-Developers' THEN 'Developer'
        WHEN g.displayName = 'IntelIntent-Sponsors' THEN 'Sponsor'
        WHEN g.displayName = 'IntelIntent-Auditors' THEN 'Auditor'
    END,
    GETDATE()
FROM AzureAD.Users u
JOIN AzureAD.GroupMembers gm ON u.id = gm.userId
JOIN AzureAD.Groups g ON gm.groupId = g.id
WHERE g.displayName LIKE 'IntelIntent-%';
```

---

## 📱 Mobile Layout (Optional)

### Dashboard Optimization for Mobile

**Portrait Mode (Phone):**
- Single column layout
- KPI cards stacked vertically
- Simplified charts (line/bar only, no complex visuals)
- Touch-optimized interactions

**Landscape Mode (Tablet):**
- 2-column layout
- Full feature set with responsive sizing

**Configuration:**
```json
{
  "mobileLayout": {
    "enabled": true,
    "breakpoints": {
      "phone": 768,
      "tablet": 1024
    },
    "visuals": {
      "phone": ["KPICards", "LineCharts", "SimpleTables"],
      "tablet": ["AllVisuals"]
    }
  }
}
```

---

## 🚀 Deployment Checklist

### Phase 1: SQL Database Setup
- [ ] Create Azure SQL Database
- [ ] Execute schema creation scripts
- [ ] Configure firewall rules
- [ ] Set up service principal for Power BI access
- [ ] Test connection from Power BI Desktop

### Phase 2: Data Pipeline Setup
- [ ] Deploy `SyncCheckpointsToSQL.ps1` as scheduled task
- [ ] Configure Azure Function for real-time checkpoint sync
- [ ] Validate data ingestion (checkpoints → SQL)
- [ ] Test audit log append-only constraint

### Phase 3: Power BI Development
- [ ] Create Power BI workspace
- [ ] Build data model with relationships
- [ ] Implement DAX measures
- [ ] Design dashboard pages (4 dashboards)
- [ ] Configure row-level security
- [ ] Test with sample data

### Phase 4: Power BI Deployment
- [ ] Publish to Power BI Service
- [ ] Configure scheduled refresh (5/15 minute intervals)
- [ ] Enable DirectQuery for real-time tables
- [ ] Assign users to RLS roles
- [ ] Configure dashboard sharing permissions

### Phase 5: Validation & Training
- [ ] Validate data accuracy with orchestrator runs
- [ ] Test RLS with sponsor/developer/auditor accounts
- [ ] Conduct sponsor walkthrough training
- [ ] Create user guide documentation
- [ ] Set up alerting for dashboard refresh failures

---

## 📚 Additional Resources

### Power BI Documentation
- [Power BI REST API](https://learn.microsoft.com/en-us/rest/api/power-bi/)
- [DirectQuery in Power BI](https://learn.microsoft.com/en-us/power-bi/connect-data/desktop-directquery-about)
- [Row-Level Security](https://learn.microsoft.com/en-us/power-bi/enterprise/service-admin-rls)
- [DAX Function Reference](https://dax.guide/)

### SQL Server Documentation
- [Temporal Tables](https://learn.microsoft.com/en-us/sql/relational-databases/tables/temporal-tables)
- [Columnstore Indexes](https://learn.microsoft.com/en-us/sql/relational-databases/indexes/columnstore-indexes-overview)
- [Azure SQL Performance Best Practices](https://learn.microsoft.com/en-us/azure/azure-sql/database/performance-guidance)

---

**Next Steps:**
1. Review dashboard schema with stakeholders
2. Provision Azure SQL Database
3. Execute SQL table creation scripts
4. Begin Power BI Desktop development
5. Schedule Phase 4 sponsor training session

_Power BI dashboards transform IntelIntent orchestration from invisible automation into transparent, auditable, sponsor-facing intelligence._
