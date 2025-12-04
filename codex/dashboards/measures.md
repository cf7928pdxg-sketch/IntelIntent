# Power BI DAX Measures for Copilot Lineage Dashboard

This file contains DAX measure definitions for the Copilot Lineage Dashboard. Import these measures into your Power BI model after loading the JSON log files.

---

## Table of Contents

1. [Lifecycle Event Metrics](#lifecycle-event-metrics)
2. [Invocation Metrics](#invocation-metrics)
3. [Performance Metrics](#performance-metrics)
4. [Compliance & Integrity Metrics](#compliance--integrity-metrics)
5. [Time Intelligence Metrics](#time-intelligence-metrics)
6. [Operational KPIs](#operational-kpis)

---

## Lifecycle Event Metrics

### Total Lifecycle Events
```dax
TotalLifecycleEvents = COUNTROWS(CopilotLifecycle)
```

### Enables
```dax
Enables = 
CALCULATE(
    COUNTROWS(CopilotLifecycle),
    CopilotLifecycle[LifecycleAction] = "Enable"
)
```

### Disables
```dax
Disables = 
CALCULATE(
    COUNTROWS(CopilotLifecycle),
    CopilotLifecycle[LifecycleAction] = "Disable"
)
```

### Toggles
```dax
Toggles = 
CALCULATE(
    COUNTROWS(CopilotLifecycle),
    CopilotLifecycle[LifecycleAction] = "Toggle"
)
```

### Updates
```dax
Updates = 
CALCULATE(
    COUNTROWS(CopilotLifecycle),
    CopilotLifecycle[LifecycleAction] = "Update"
)
```

### Installs
```dax
Installs = 
CALCULATE(
    COUNTROWS(CopilotLifecycle),
    CopilotLifecycle[LifecycleAction] = "Install"
)
```

### Uninstalls
```dax
Uninstalls = 
CALCULATE(
    COUNTROWS(CopilotLifecycle),
    CopilotLifecycle[LifecycleAction] = "Uninstall"
)
```

---

## Invocation Metrics

### Total Invocations
```dax
TotalInvocations = COUNTROWS(CopilotInvocations)
```

### Inline Invocations
```dax
InlineInvocations = 
CALCULATE(
    COUNTROWS(CopilotInvocations),
    CopilotInvocations[InvocationType] = "Inline"
)
```

### Chat Invocations
```dax
ChatInvocations = 
CALCULATE(
    COUNTROWS(CopilotInvocations),
    CopilotInvocations[InvocationType] = "Chat"
)
```

### Agent Invocations
```dax
AgentInvocations = 
CALCULATE(
    COUNTROWS(CopilotInvocations),
    CopilotInvocations[InvocationType] = "Agent"
)
```

### Panel Invocations
```dax
PanelInvocations = 
CALCULATE(
    COUNTROWS(CopilotInvocations),
    CopilotInvocations[InvocationType] = "Panel"
)
```

### Edit Invocations
```dax
EditInvocations = 
CALCULATE(
    COUNTROWS(CopilotInvocations),
    CopilotInvocations[InvocationType] = "Edit"
)
```

### Fix Invocations
```dax
FixInvocations = 
CALCULATE(
    COUNTROWS(CopilotInvocations),
    CopilotInvocations[InvocationType] = "Fix"
)
```

### Test Invocations
```dax
TestInvocations = 
CALCULATE(
    COUNTROWS(CopilotInvocations),
    CopilotInvocations[InvocationType] = "Test"
)
```

### Explain Invocations
```dax
ExplainInvocations = 
CALCULATE(
    COUNTROWS(CopilotInvocations),
    CopilotInvocations[InvocationType] = "Explain"
)
```

### Shortcut Invocations
```dax
ShortcutInvocations = 
CALCULATE(
    COUNTROWS(CopilotInvocations),
    NOT(ISBLANK(CopilotInvocations[ShortcutUsed]))
)
```

---

## Performance Metrics

### Average Invocation Duration (ms)
```dax
AvgInvocationDuration = 
AVERAGE(CopilotInvocations[DurationMs])
```

### Max Invocation Duration (ms)
```dax
MaxInvocationDuration = 
MAX(CopilotInvocations[DurationMs])
```

### Min Invocation Duration (ms)
```dax
MinInvocationDuration = 
MIN(CopilotInvocations[DurationMs])
```

### Total Processing Time (seconds)
```dax
TotalProcessingTime = 
DIVIDE(
    SUM(CopilotInvocations[DurationMs]),
    1000,
    0
)
```

### Avg Duration by Type
```dax
AvgDurationByType = 
CALCULATE(
    AVERAGE(CopilotInvocations[DurationMs]),
    ALLEXCEPT(CopilotInvocations, CopilotInvocations[InvocationType])
)
```

---

## Compliance & Integrity Metrics

### Hash Compliance Rate
```dax
HashComplianceRate = 
VAR TotalEvents = COUNTROWS(CopilotLifecycle)
VAR ValidHashes = 
    CALCULATE(
        COUNTROWS(CopilotLifecycle),
        CopilotLifecycle[Hash] <> "[Pending SHA256]"
    )
RETURN
    DIVIDE(ValidHashes, TotalEvents, 0)
```

### Hash Compliance %
```dax
HashCompliancePercent = 
FORMAT([HashComplianceRate], "0.0%")
```

### Pending Hash Count
```dax
PendingHashCount = 
CALCULATE(
    COUNTROWS(CopilotLifecycle),
    CopilotLifecycle[Hash] = "[Pending SHA256]"
)
```

### Valid Hash Count
```dax
ValidHashCount = 
CALCULATE(
    COUNTROWS(CopilotLifecycle),
    CopilotLifecycle[Hash] <> "[Pending SHA256]"
)
```

### Success Rate (Lifecycle)
```dax
LifecycleSuccessRate = 
VAR TotalEvents = COUNTROWS(CopilotLifecycle)
VAR SuccessfulEvents = 
    CALCULATE(
        COUNTROWS(CopilotLifecycle),
        CopilotLifecycle[Result] = "Success"
    )
RETURN
    DIVIDE(SuccessfulEvents, TotalEvents, 0)
```

### Success Rate (Invocation)
```dax
InvocationSuccessRate = 
VAR TotalInvocations = COUNTROWS(CopilotInvocations)
VAR SuccessfulInvocations = 
    CALCULATE(
        COUNTROWS(CopilotInvocations),
        CopilotInvocations[Result] = "Success"
    )
RETURN
    DIVIDE(SuccessfulInvocations, TotalInvocations, 0)
```

### Failed Events Count
```dax
FailedEventsCount = 
CALCULATE(
    COUNTROWS(CopilotLifecycle),
    CopilotLifecycle[Result] = "Failed"
) + 
CALCULATE(
    COUNTROWS(CopilotInvocations),
    CopilotInvocations[Result] = "Failed"
)
```

---

## Time Intelligence Metrics

### Events Today
```dax
EventsToday = 
CALCULATE(
    [TotalLifecycleEvents],
    DATESBETWEEN(
        CopilotLifecycle[EventTimestamp],
        TODAY(),
        TODAY()
    )
)
```

### Events This Week
```dax
EventsThisWeek = 
CALCULATE(
    [TotalLifecycleEvents],
    DATESINPERIOD(
        CopilotLifecycle[EventTimestamp],
        TODAY(),
        -7,
        DAY
    )
)
```

### Events This Month
```dax
EventsThisMonth = 
CALCULATE(
    [TotalLifecycleEvents],
    DATESMTD(CopilotLifecycle[EventTimestamp])
)
```

### Invocations Today
```dax
InvocationsToday = 
CALCULATE(
    [TotalInvocations],
    DATESBETWEEN(
        CopilotInvocations[EventTimestamp],
        TODAY(),
        TODAY()
    )
)
```

### Invocations This Week
```dax
InvocationsThisWeek = 
CALCULATE(
    [TotalInvocations],
    DATESINPERIOD(
        CopilotInvocations[EventTimestamp],
        TODAY(),
        -7,
        DAY
    )
)
```

### Daily Event Trend
```dax
DailyEventTrend = 
CALCULATE(
    [TotalLifecycleEvents] + [TotalInvocations],
    DATESINPERIOD(
        CopilotLifecycle[EventTimestamp],
        MAX(CopilotLifecycle[EventTimestamp]),
        -30,
        DAY
    )
)
```

---

## Operational KPIs

### Active Status %
Percentage of workspaces where the latest lifecycle event is "Enable"

```dax
ActiveStatusPercent = 
VAR WorkspacesWithEnable = 
    CALCULATETABLE(
        VALUES(CopilotLifecycle[WorkspaceName]),
        FILTER(
            CopilotLifecycle,
            CopilotLifecycle[LifecycleAction] = "Enable" &&
            CopilotLifecycle[EventTimestamp] = 
                CALCULATE(
                    MAX(CopilotLifecycle[EventTimestamp]),
                    ALLEXCEPT(CopilotLifecycle, CopilotLifecycle[WorkspaceName])
                )
        )
    )
VAR TotalWorkspaces = DISTINCTCOUNT(CopilotLifecycle[WorkspaceName])
RETURN
    DIVIDE(COUNTROWS(WorkspacesWithEnable), TotalWorkspaces, 0)
```

### Current Active Workspaces
```dax
CurrentActiveWorkspaces = 
COUNTROWS(
    FILTER(
        VALUES(CopilotLifecycle[WorkspaceName]),
        CALCULATE(
            LASTNONBLANK(
                CopilotLifecycle[LifecycleAction],
                1
            )
        ) = "Enable"
    )
)
```

### Mean Time to Recovery (MTTR)
Average time between Disable and subsequent Enable actions

```dax
MTTR_Hours = 
VAR DisableEvents = 
    FILTER(
        CopilotLifecycle,
        CopilotLifecycle[LifecycleAction] = "Disable"
    )
VAR EnableEvents = 
    FILTER(
        CopilotLifecycle,
        CopilotLifecycle[LifecycleAction] = "Enable"
    )
VAR RecoveryTimes = 
    ADDCOLUMNS(
        DisableEvents,
        "NextEnable",
        CALCULATE(
            MIN(CopilotLifecycle[EventTimestamp]),
            FILTER(
                EnableEvents,
                EnableEvents[EventTimestamp] > EARLIER(CopilotLifecycle[EventTimestamp]) &&
                EnableEvents[WorkspaceName] = EARLIER(CopilotLifecycle[WorkspaceName])
            )
        )
    )
VAR AvgRecoverySeconds = 
    AVERAGEX(
        RecoveryTimes,
        DATEDIFF(
            CopilotLifecycle[EventTimestamp],
            [NextEnable],
            SECOND
        )
    )
RETURN
    DIVIDE(AvgRecoverySeconds, 3600, 0)
```

### Extension Unification Rate
```dax
ExtensionUnificationRate = 
VAR TotalEvents = COUNTROWS(CopilotLifecycle)
VAR UnifiedEvents = 
    CALCULATE(
        COUNTROWS(CopilotLifecycle),
        CopilotLifecycle[ExtensionUnification] = TRUE()
    )
RETURN
    DIVIDE(UnifiedEvents, TotalEvents, 0)
```

### Unique Sessions
```dax
UniqueSessions = 
DISTINCTCOUNT(CopilotLifecycle[SessionID]) + 
DISTINCTCOUNT(CopilotInvocations[SessionID])
```

### Unique Workspaces
```dax
UniqueWorkspaces = 
DISTINCTCOUNT(CopilotLifecycle[WorkspaceName])
```

### Agent Mode Adoption %
```dax
AgentModeAdoption = 
VAR TotalInvocations = [TotalInvocations]
VAR AgentInvocations = [AgentInvocations]
RETURN
    DIVIDE(AgentInvocations, TotalInvocations, 0)
```

### GPT-4o Usage %
```dax
GPT4oUsagePercent = 
VAR TotalInvocations = COUNTROWS(CopilotInvocations)
VAR GPT4oInvocations = 
    CALCULATE(
        COUNTROWS(CopilotInvocations),
        SEARCH("gpt-4o", CopilotInvocations[CompletionModel], 1, 0) > 0
    )
RETURN
    DIVIDE(GPT4oInvocations, TotalInvocations, 0)
```

### Claude Usage %
```dax
ClaudeUsagePercent = 
VAR TotalInvocations = COUNTROWS(CopilotInvocations)
VAR ClaudeInvocations = 
    CALCULATE(
        COUNTROWS(CopilotInvocations),
        SEARCH("claude", CopilotInvocations[CompletionModel], 1, 0) > 0
    )
RETURN
    DIVIDE(ClaudeInvocations, TotalInvocations, 0)
```

---

## Usage Instructions

1. **Import JSON Logs**: Load `CopilotLifecycleLog.json` and `CopilotInvocationLog.json` into Power BI Desktop
2. **Create Tables**: Flatten JSON arrays to create `CopilotLifecycle` and `CopilotInvocations` tables
3. **Add Measures**: Copy DAX definitions above into the model (Modeling tab → New Measure)
4. **Create Visuals**: Use measures in KPI cards, line charts, matrices, and tables
5. **Establish Relationships**: Link tables via `RunId` or `SessionID` if cross-filtering needed
6. **Format Measures**: Apply percentage formatting to rate/percent measures

---

## Recommended Visuals

| Measure | Recommended Visual |
|---------|-------------------|
| `ActiveStatusPercent` | KPI Card (with goal = 100%) |
| `TotalLifecycleEvents` | Line chart (x-axis = EventTimestamp) |
| `InlineInvocations`, `ChatInvocations`, `AgentInvocations` | Stacked bar chart |
| `HashComplianceRate` | Gauge (min = 0, max = 1) |
| `AvgInvocationDuration` | Column chart (grouped by InvocationType) |
| `MTTR_Hours` | KPI Card with trend indicator |
| `LifecycleAction` by `WorkspaceName` | Matrix |
| `GPT4oUsagePercent` vs `ClaudeUsagePercent` | Donut chart |

---

## Notes

- **Time Zone**: All timestamps are in UTC (ISO 8601 format). Convert to local time if needed using Power Query.
- **Null Handling**: All measures use `DIVIDE` with default 0 to handle division by zero gracefully.
- **Performance**: For large datasets (10,000+ events), consider aggregating data in Power Query before loading.
- **Schema Version**: Measures assume schema version 1.0.0 from `copilot-events.schema.json`.

---

**Last Updated**: 2025-11-28  
**Schema Version**: 1.0.0  
**IntelIntent Phase**: 4 (Production Hardening)
