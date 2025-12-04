# VS Code Distribution - Teams Adaptive Card Template

**Purpose**: Sponsor-facing notification card for Power Automate escalations  
**Version**: 1.0.0  
**Last Updated**: 2025-11-28

---

## 🎯 Adaptive Card JSON (Full Template)

This Adaptive Card is sent via Power Automate when:
- SHA256 hash integrity failure detected
- Version drift exceeds threshold
- Distribution download fails

### Complete JSON Payload

```json
{
  "type": "message",
  "attachments": [
    {
      "contentType": "application/vnd.microsoft.card.adaptive",
      "contentUrl": null,
      "content": {
        "type": "AdaptiveCard",
        "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
        "version": "1.5",
        "body": [
          {
            "type": "Container",
            "style": "warning",
            "items": [
              {
                "type": "ColumnSet",
                "columns": [
                  {
                    "type": "Column",
                    "width": "auto",
                    "items": [
                      {
                        "type": "Image",
                        "url": "https://raw.githubusercontent.com/microsoft/vscode/main/resources/win32/code_70x70.png",
                        "size": "Medium",
                        "altText": "VS Code Icon"
                      }
                    ]
                  },
                  {
                    "type": "Column",
                    "width": "stretch",
                    "items": [
                      {
                        "type": "TextBlock",
                        "text": "⚠️ VS Code Distribution Alert",
                        "weight": "Bolder",
                        "size": "Large",
                        "color": "Attention"
                      },
                      {
                        "type": "TextBlock",
                        "text": "IntelIntent Phase 4 - Automated Governance",
                        "isSubtle": true,
                        "spacing": "None"
                      }
                    ]
                  }
                ]
              }
            ]
          },
          {
            "type": "Container",
            "spacing": "Medium",
            "items": [
              {
                "type": "TextBlock",
                "text": "Alert Type",
                "weight": "Bolder",
                "size": "Medium"
              },
              {
                "type": "TextBlock",
                "text": "${AlertType}",
                "wrap": true,
                "color": "Attention",
                "size": "Medium"
              }
            ]
          },
          {
            "type": "Container",
            "separator": true,
            "spacing": "Medium",
            "items": [
              {
                "type": "TextBlock",
                "text": "Distribution Details",
                "weight": "Bolder",
                "size": "Medium"
              },
              {
                "type": "FactSet",
                "facts": [
                  {
                    "title": "Platform",
                    "value": "${Platform}"
                  },
                  {
                    "title": "Architecture",
                    "value": "${Architecture}"
                  },
                  {
                    "title": "Download Type",
                    "value": "${DownloadType}"
                  },
                  {
                    "title": "Current Version",
                    "value": "${CurrentVersion}"
                  },
                  {
                    "title": "Latest Version",
                    "value": "${LatestVersion}"
                  },
                  {
                    "title": "Status",
                    "value": "${Status}"
                  },
                  {
                    "title": "Timestamp",
                    "value": "${Timestamp}"
                  }
                ]
              }
            ]
          },
          {
            "type": "Container",
            "separator": true,
            "spacing": "Medium",
            "items": [
              {
                "type": "TextBlock",
                "text": "Integrity Metrics",
                "weight": "Bolder",
                "size": "Medium"
              },
              {
                "type": "FactSet",
                "facts": [
                  {
                    "title": "SHA256 Hash",
                    "value": "${SHA256Hash}"
                  },
                  {
                    "title": "File Size",
                    "value": "${FileSize} MB"
                  },
                  {
                    "title": "Download Duration",
                    "value": "${DurationSeconds} seconds"
                  },
                  {
                    "title": "Session ID",
                    "value": "${SessionID}"
                  }
                ]
              }
            ]
          },
          {
            "type": "Container",
            "separator": true,
            "spacing": "Medium",
            "style": "emphasis",
            "items": [
              {
                "type": "TextBlock",
                "text": "📋 Recommended Actions",
                "weight": "Bolder",
                "size": "Medium"
              },
              {
                "type": "TextBlock",
                "text": "• **Hash Integrity Failure**: Re-download distribution and verify SHA256 hash\n• **Version Drift**: Update to latest version via `Get-VSCodeDownload.ps1 -Version latest`\n• **Review Checkpoint**: View full checkpoint JSON in GitHub repository\n• **Sponsor Escalation**: Contact Operations Team if issue persists",
                "wrap": true,
                "spacing": "Small"
              }
            ]
          }
        ],
        "actions": [
          {
            "type": "Action.OpenUrl",
            "title": "📊 View Power BI Dashboard",
            "url": "${PowerBIDashboardUrl}",
            "style": "positive"
          },
          {
            "type": "Action.OpenUrl",
            "title": "🔍 View Checkpoint Details",
            "url": "${CheckpointGitHubUrl}"
          },
          {
            "type": "Action.OpenUrl",
            "title": "📥 Download Latest Version",
            "url": "https://code.visualstudio.com/download"
          },
          {
            "type": "Action.Submit",
            "title": "✅ Acknowledge Alert",
            "data": {
              "action": "acknowledge",
              "taskId": "${TaskID}"
            }
          }
        ],
        "msteams": {
          "width": "Full"
        }
      }
    }
  ]
}
```

---

## 🔄 Variable Substitution Reference

Replace these placeholders with actual values from Power Automate dynamic content:

| Placeholder | Power Automate Expression | Example Value |
|-------------|---------------------------|---------------|
| `${AlertType}` | `@{if(equals(triggerBody()?['SHA256Hash'], '[Pending SHA256]'), 'Hash Integrity Failure', 'Version Drift')}` | `Hash Integrity Failure` |
| `${Platform}` | `@{triggerBody()?['Platform']}` | `Windows` |
| `${Architecture}` | `@{triggerBody()?['Architecture']}` | `x64` |
| `${DownloadType}` | `@{triggerBody()?['DownloadType']}` | `installer` |
| `${CurrentVersion}` | `@{triggerBody()?['Version']}` | `1.93.0` |
| `${LatestVersion}` | `@{variables('LatestVersion')}` | `1.95.0` |
| `${Status}` | `@{triggerBody()?['Status']}` | `Failed` |
| `${Timestamp}` | `@{triggerBody()?['DownloadTimestamp']}` | `2025-11-28T14:35:22Z` |
| `${SHA256Hash}` | `@{triggerBody()?['SHA256Hash']}` | `[Pending SHA256]` |
| `${FileSize}` | `@{triggerBody()?['FileSize']}` | `95.23` |
| `${DurationSeconds}` | `@{triggerBody()?['DurationSeconds']}` | `12` |
| `${SessionID}` | `@{triggerBody()?['SessionID']}` | `VSCodeDownload-20251128` |
| `${PowerBIDashboardUrl}` | `@{variables('PowerBIDashboardUrl')}` | `https://app.powerbi.com/...` |
| `${CheckpointGitHubUrl}` | `https://github.com/cf7928pdxg-sketch/IntelIntent/blob/main/codex/downloads/vscode/vscode_download_checkpoint.json` | Static URL |
| `${TaskID}` | `@{triggerBody()?['DistributionID']}` | `VSCODE-WIN-X64-INSTALLER-20251128143522` |

---

## 🛠️ Power Automate Flow Implementation

### Step 1: Create Flow Trigger

**Trigger**: When a row is added or modified  
**Table**: `VSCodeDistributions`  
**Filter**: Status = 'Failed' OR SHA256Hash = '[Pending SHA256]' OR (Version != @variables('LatestVersion'))

### Step 2: Initialize Variables

```
Name: LatestVersion
Type: String
Value: (Query VS Code API or set manually, e.g., "1.95.0")

Name: PowerBIDashboardUrl
Type: String
Value: https://app.powerbi.com/groups/{workspace-id}/dashboards/{dashboard-id}

Name: CheckpointGitHubUrl
Type: String
Value: https://github.com/cf7928pdxg-sketch/IntelIntent/blob/main/codex/downloads/vscode/vscode_download_checkpoint.json
```

### Step 3: Parse Adaptive Card Template

**Action**: Compose  
**Inputs**: (Paste complete Adaptive Card JSON from above)  
**Dynamic Content Substitution**: Replace `${...}` placeholders with:
- `@{triggerBody()?['Platform']}`
- `@{triggerBody()?['Architecture']}`
- etc. (see table above)

### Step 4: Post Adaptive Card to Teams

**Action**: Post adaptive card in a chat or channel  
**Recipient**: IntelIntent Sponsors (Team: IntelIntent Operations, Channel: Alerts)  
**Message**: (Output from Compose action in Step 3)

### Step 5: Send Email (Optional)

**Action**: Send an email (V2)  
**To**: `sponsors@intelintent.com`  
**Subject**: `🚨 VS Code Distribution Alert - @{triggerBody()?['Platform']}-@{triggerBody()?['Architecture']}`  
**Body**: (Use HTML email template from VSCODE_DEPLOYMENT_GOVERNANCE_GUIDE.md)

### Step 6: Create GitHub Issue (Optional)

**Action**: Create an issue (GitHub connector)  
**Repository**: `IntelIntent`  
**Title**: `🚨 VS Code Distribution Alert - @{triggerBody()?['Platform']}-@{triggerBody()?['Architecture']}`  
**Body**: (Use Markdown issue template from VSCODE_DEPLOYMENT_GOVERNANCE_GUIDE.md)  
**Labels**: `alert`, `vscode-distribution`, `governance`

---

## 📊 Sample Rendered Card (Success Case)

For comparison, here's a **Success Notification** variant (send when distribution completes successfully):

```json
{
  "type": "AdaptiveCard",
  "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
  "version": "1.5",
  "body": [
    {
      "type": "Container",
      "style": "good",
      "items": [
        {
          "type": "TextBlock",
          "text": "✅ VS Code Distribution Complete",
          "weight": "Bolder",
          "size": "Large",
          "color": "Good"
        },
        {
          "type": "TextBlock",
          "text": "IntelIntent Phase 4 - Automated Deployment",
          "isSubtle": true,
          "spacing": "None"
        }
      ]
    },
    {
      "type": "FactSet",
      "facts": [
        {
          "title": "Platform",
          "value": "${Platform}"
        },
        {
          "title": "Architecture",
          "value": "${Architecture}"
        },
        {
          "title": "Version",
          "value": "${CurrentVersion}"
        },
        {
          "title": "SHA256 Hash",
          "value": "${SHA256Hash}"
        },
        {
          "title": "Timestamp",
          "value": "${Timestamp}"
        }
      ]
    },
    {
      "type": "TextBlock",
      "text": "Distribution downloaded and validated successfully. Hash compliance: ✅",
      "wrap": true,
      "color": "Good"
    }
  ],
  "actions": [
    {
      "type": "Action.OpenUrl",
      "title": "View Dashboard",
      "url": "${PowerBIDashboardUrl}"
    }
  ]
}
```

---

## 🎨 Design Customization Options

### Color Schemes

**Warning (Default)**:
```json
"style": "warning",
"color": "Attention"
```

**Error (Critical)**:
```json
"style": "attention",
"color": "Attention"
```

**Success**:
```json
"style": "good",
"color": "Good"
```

### Icon Customization

Replace VS Code icon URL with:
- **IntelIntent Logo**: `https://your-cdn.com/intelintent-logo.png`
- **Custom Alert Icon**: `https://your-cdn.com/alert-icon.png`

### Width Options

```json
"msteams": {
  "width": "Full"  // Options: "Full", "Medium", "Small"
}
```

---

## 🧪 Testing the Adaptive Card

### Online Designer Tool

1. Visit: https://adaptivecards.io/designer/
2. Paste JSON template
3. Replace `${...}` placeholders with sample values
4. Preview in **Microsoft Teams** mode
5. Test actions (buttons) for navigation

### Power Automate Test Mode

1. Edit flow
2. Click **Test** → **Manually**
3. Insert sample row into `VSCodeDistributions` table with `Status = 'Failed'`
4. Verify card appears in Teams channel
5. Click buttons to test URLs

### Sample Test Data

```sql
INSERT INTO VSCodeDistributions 
(DistributionID, Platform, Architecture, DownloadType, Version, DownloadURL, DownloadTimestamp, FileSize, SHA256Hash, DurationSeconds, Status, SessionID)
VALUES 
('VSCODE-TEST-001', 'Windows', 'x64', 'installer', '1.93.0', 
 'https://update.code.visualstudio.com/1.93.0/win32-x64/stable', 
 '2025-11-28T14:35:22Z', 95.23, '[Pending SHA256]', 12, 'Failed', 'TEST-SESSION');
```

Expected Result: Adaptive Card posted to Teams with **Hash Integrity Failure** alert.

---

## 📚 Reference Links

- [Adaptive Cards Documentation](https://learn.microsoft.com/en-us/adaptive-cards/)
- [Adaptive Cards Designer](https://adaptivecards.io/designer/)
- [Power Automate Teams Connector](https://learn.microsoft.com/en-us/connectors/teams/)
- [Teams Incoming Webhooks](https://learn.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook)

---

**Template Version**: 1.0.0  
**Last Updated**: 2025-11-28  
**Maintained By**: IntelIntent Operations Team
