# GitHub Copilot Lifecycle Tracking

## Quick Start

### 1. Initialize Tracker
```powershell
Import-Module .\IntelIntent_Seeding\CopilotLifecycleTracker.psm1
Initialize-CopilotLifecycleLog
```

### 2. Test with Sample Data
```powershell
.\Test-CopilotLifecycleTracker.ps1
```

This generates:
- **CopilotLifecycleLog.json** at `%USERPROFILE%\Documents\IntelIntent\`
- **Copilot_Dashboard_Sample.json** in `.\Sponsors\` directory

### 3. Import to Power BI
1. Open Power BI Desktop
2. Get Data → JSON → Select `Copilot_Dashboard_Sample.json`
3. Transform Data → Expand "Events" column
4. Follow schema in [COPILOT_LINEAGE_OVERLAY.md](./COPILOT_LINEAGE_OVERLAY.md)

## Files Overview

| File | Purpose |
|------|---------|
| `CopilotLifecycleTracker.psm1` | Core tracking module (7 functions) |
| `COPILOT_LINEAGE_OVERLAY.md` | Complete documentation with Power BI schema |
| `Test-CopilotLifecycleTracker.ps1` | Demo script with 57 sample events |
| `Copilot_Dashboard_Sample.json` | Power BI-ready export with metrics |

## Integration Points

### Week1_Automation.ps1
Add at script start:
```powershell
Import-Module .\IntelIntent_Seeding\CopilotLifecycleTracker.psm1
Initialize-CopilotLifecycleLog
Add-CopilotLifecycleEvent -Action "Enable" -Reason "Week 1 automation started"
```

### Orchestrator.ps1
Log component generation:
```powershell
Add-CopilotCommandInvocation `
    -CommandID "github.copilot.agent" `
    -InvocationType "Agent" `
    -Context "Generating $($component.ID) from manifest"
```

### Azure DevOps Pipeline
Export as artifact:
```yaml
- task: PowerShell@2
  displayName: 'Export Copilot Lineage'
  inputs:
    targetType: 'inline'
    script: |
      Import-Module .\IntelIntent_Seeding\CopilotLifecycleTracker.psm1
      Export-CopilotLifecycleForPowerBI -OutputPath "$(Build.ArtifactStagingDirectory)/Copilot_Lineage.json" -IncludeMetrics
```

## Key Functions

| Function | Purpose |
|----------|---------|
| `Add-CopilotLifecycleEvent` | Log Enable/Disable/Toggle |
| `Add-CopilotCommandInvocation` | Log Inline/Chat/Agent usage |
| `Get-CopilotLifecycleLogs` | Query events with filters |
| `Export-CopilotLifecycleForPowerBI` | Export with metrics |
| `Initialize-CopilotLifecycleLog` | Setup log file |
| `Clear-CopilotLifecycleLog` | Archive and reset |

## Power BI Measures

```dax
// Total Events
TotalEvents = COUNTROWS(CopilotEvents)

// Enable/Disable Split
EnableActions = CALCULATE([TotalEvents], CopilotEvents[Action] = "Enable")
DisableActions = CALCULATE([TotalEvents], CopilotEvents[Action] = "Disable")

// Invocation Breakdown
InlineInvocations = CALCULATE([TotalEvents], CopilotEvents[InvocationType] = "Inline")
ChatInvocations = CALCULATE([TotalEvents], CopilotEvents[InvocationType] = "Chat")
AgentInvocations = CALCULATE([TotalEvents], CopilotEvents[InvocationType] = "Agent")
```

## Troubleshooting

**Issue:** "Log file not found"
```powershell
Initialize-CopilotLifecycleLog
```

**Issue:** "Module not loaded"
```powershell
Import-Module .\IntelIntent_Seeding\CopilotLifecycleTracker.psm1 -Force
```

**Issue:** "Power BI JSON parse error"
```powershell
# Validate JSON syntax
Get-Content .\Sponsors\Copilot_Dashboard_Sample.json | ConvertFrom-Json | Out-Null
```

## Next Steps

1. ✅ Run `Test-CopilotLifecycleTracker.ps1` to generate sample data
2. ✅ Import `Copilot_Dashboard_Sample.json` to Power BI
3. ✅ Review [COPILOT_LINEAGE_OVERLAY.md](./COPILOT_LINEAGE_OVERLAY.md) for schema details
4. ✅ Integrate tracker into `Week1_Automation.ps1`
5. ✅ Configure Azure DevOps pipeline artifact export

---

**Documentation:** [COPILOT_LINEAGE_OVERLAY.md](./COPILOT_LINEAGE_OVERLAY.md)  
**Module Location:** `IntelIntent_Seeding\CopilotLifecycleTracker.psm1`  
**Test Script:** `Test-CopilotLifecycleTracker.ps1`
