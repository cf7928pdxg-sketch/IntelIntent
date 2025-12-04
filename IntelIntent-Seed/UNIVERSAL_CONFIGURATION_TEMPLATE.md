# 🎯 Universal GitHub ↔ M365 Configuration Template

## Overview

This unified configuration template enables GitHub ↔ Microsoft 365 integration across **5 contexts** with conditional logic that adapts to your environment: Personal, Developer, Family, Business, and Enterprise.

---

## 📋 Configuration Schema

### Master Configuration File

**File:** `IntelIntent-Seed/config/integration-config.json`

```json
{
  "version": "1.0.0",
  "contexts": {
    "personal": {
      "enabled": true,
      "priority": 1,
      "integrations": {
        "onedrive": true,
        "outlook": true,
        "todo": true,
        "teams": false,
        "planner": false,
        "sharepoint": false,
        "powerbi": false
      },
      "github": {
        "repositories": [
          "cf7928pdxg-sketch/personal-projects",
          "cf7928pdxg-sketch/learning"
        ],
        "syncEvents": ["push", "commit"],
        "workflows": ["backup", "reminders"]
      },
      "m365": {
        "driveFolder": "/Personal/GitHub-Backups",
        "calendarName": "Personal",
        "todoList": "GitHub Tasks",
        "notifications": "email"
      }
    },
    "developer": {
      "enabled": true,
      "priority": 2,
      "integrations": {
        "onedrive": true,
        "outlook": true,
        "todo": true,
        "teams": true,
        "planner": false,
        "sharepoint": false,
        "powerbi": false,
        "vscode": true,
        "copilot": true
      },
      "github": {
        "repositories": [
          "cf7928pdxg-sketch/IntelIntent"
        ],
        "syncEvents": ["push", "pull_request", "release"],
        "workflows": ["ci-cd", "notifications", "workspace-sync"]
      },
      "m365": {
        "driveFolder": "/Development/IntelIntent",
        "teamsChannel": "Development",
        "teamsWebhook": "${TEAMS_DEV_WEBHOOK}",
        "todoList": "Dev Tasks",
        "notifications": "teams"
      },
      "vscode": {
        "workspaceSettings": ".vscode/settings.json",
        "syncOnPR": true,
        "copilotContext": true
      }
    },
    "family": {
      "enabled": false,
      "priority": 3,
      "integrations": {
        "onedrive": true,
        "outlook": true,
        "todo": false,
        "teams": false,
        "planner": false,
        "sharepoint": true,
        "powerbi": false
      },
      "github": {
        "repositories": [
          "family-org/budget-scripts",
          "family-org/vacation-planner"
        ],
        "syncEvents": ["push", "milestone"],
        "workflows": ["backup", "calendar-sync"]
      },
      "m365": {
        "driveFolder": "/Family Shared/GitHub",
        "sharepointSite": "Family Hub",
        "calendarName": "Family Calendar",
        "notifications": "email"
      }
    },
    "business": {
      "enabled": true,
      "priority": 4,
      "integrations": {
        "onedrive": true,
        "outlook": true,
        "todo": true,
        "teams": true,
        "planner": true,
        "sharepoint": true,
        "powerbi": false
      },
      "github": {
        "repositories": [
          "cf7928pdxg-sketch/IntelIntent"
        ],
        "syncEvents": ["issues", "pull_request", "release", "project"],
        "workflows": ["issue-planner-sync", "pr-teams-notification", "release-sharepoint"]
      },
      "m365": {
        "driveFolder": "/Business/Projects/IntelIntent",
        "teamsChannel": "IntelIntent Project",
        "teamsWebhook": "${TEAMS_BUSINESS_WEBHOOK}",
        "plannerPlan": "IntelIntent Development",
        "plannerBuckets": {
          "backlog": "Backlog",
          "inProgress": "In Progress",
          "review": "Code Review",
          "done": "Done"
        },
        "sharepointSite": "IntelIntent Docs",
        "sharepointLibrary": "Release Notes",
        "notifications": "teams+email"
      }
    },
    "enterprise": {
      "enabled": true,
      "priority": 5,
      "integrations": {
        "onedrive": true,
        "outlook": true,
        "todo": false,
        "teams": true,
        "planner": true,
        "sharepoint": true,
        "powerbi": true,
        "azuread": true,
        "compliance": true
      },
      "github": {
        "repositories": [
          "cf7928pdxg-sketch/IntelIntent"
        ],
        "enterprise": true,
        "syncEvents": ["all"],
        "workflows": ["full-integration", "compliance-logging", "powerbi-export"]
      },
      "m365": {
        "driveFolder": "/Enterprise/IntelIntent",
        "teamsChannel": "IntelIntent Enterprise",
        "teamsWebhook": "${TEAMS_ENTERPRISE_WEBHOOK}",
        "plannerPlan": "IntelIntent CoE Activation",
        "plannerBuckets": {
          "precursive": "Precursive Layer",
          "coreEngine": "Core Engine",
          "agentic": "Agentic Layer",
          "domain": "Domain Layer",
          "navigation": "Navigation Layer",
          "feedback": "Feedback Layer"
        },
        "sharepointSite": "IntelIntent Enterprise Hub",
        "sharepointLibrary": "CoE Documentation",
        "powerbiWorkspace": "IntelIntent Analytics",
        "powerbiDataset": "CoE Activation Metrics",
        "notifications": "teams+email+sms"
      },
      "azuread": {
        "tenantId": "${AZURE_TENANT_ID}",
        "clientId": "${AZURE_CLIENT_ID}",
        "clientSecret": "${AZURE_CLIENT_SECRET}",
        "ssoEnabled": true,
        "mfaRequired": true
      },
      "compliance": {
        "auditLogging": true,
        "retentionDays": 365,
        "encryptionRequired": true,
        "complianceCenter": true
      }
    }
  },
  "global": {
    "retryPolicy": {
      "maxAttempts": 3,
      "backoffMultiplier": 2,
      "initialDelaySeconds": 5
    },
    "rateLimiting": {
      "github": {
        "requestsPerHour": 5000
      },
      "graphApi": {
        "requestsPerSecond": 10
      }
    },
    "logging": {
      "level": "info",
      "destinations": ["console", "file", "applicationInsights"],
      "format": "json"
    }
  }
}
```

---

## 🔧 Power Automate Universal Flow Template

### Flow with Context Switching

**File:** `IntelIntent-Seed/flows/universal-github-m365-sync.json`

```json
{
  "name": "Universal GitHub to M365 Sync",
  "description": "Adaptive flow with context-based routing",
  "trigger": {
    "type": "Webhook",
    "inputs": {
      "schema": {
        "type": "object",
        "properties": {
          "repository": { "type": "string" },
          "event": { "type": "string" },
          "context": { "type": "string" },
          "payload": { "type": "object" }
        }
      }
    }
  },
  "actions": [
    {
      "name": "Load Configuration",
      "type": "HTTP",
      "inputs": {
        "method": "GET",
        "uri": "https://raw.githubusercontent.com/cf7928pdxg-sketch/IntelIntent/main/IntelIntent-Seed/config/integration-config.json"
      }
    },
    {
      "name": "Parse Config",
      "type": "Parse_JSON",
      "inputs": {
        "content": "@outputs('Load_Configuration')?['body']",
        "schema": {
          "type": "object",
          "properties": {
            "contexts": { "type": "object" }
          }
        }
      }
    },
    {
      "name": "Determine Context",
      "type": "Compose",
      "inputs": "@coalesce(triggerBody()?['context'], 'business')"
    },
    {
      "name": "Get Context Config",
      "type": "Compose",
      "inputs": "@outputs('Parse_Config')?['contexts'][@{outputs('Determine_Context')}]"
    },
    {
      "name": "Check if Enabled",
      "type": "Condition",
      "expression": {
        "and": [
          {
            "equals": [
              "@outputs('Get_Context_Config')?['enabled']",
              true
            ]
          }
        ]
      },
      "actions": {
        "Context_Router": {
          "type": "Switch",
          "expression": "@outputs('Determine_Context')",
          "cases": {
            "personal": {
              "case": "personal",
              "actions": {
                "Personal_OneDrive_Backup": {
                  "type": "Scope",
                  "actions": {
                    "Check_OneDrive_Integration": {
                      "type": "Condition",
                      "expression": {
                        "equals": [
                          "@outputs('Get_Context_Config')?['integrations']?['onedrive']",
                          true
                        ]
                      },
                      "actions": {
                        "Upload_to_OneDrive": {
                          "type": "HTTP",
                          "inputs": {
                            "method": "PUT",
                            "uri": "https://graph.microsoft.com/v1.0/me/drive/root:@{outputs('Get_Context_Config')?['m365']?['driveFolder']}/@{triggerBody()?['payload']?['commit']?['id']}.zip:/content",
                            "headers": {
                              "Authorization": "Bearer @{parameters('GraphToken')}"
                            },
                            "body": "@triggerBody()?['payload']?['zipball_url']"
                          }
                        }
                      }
                    },
                    "Check_Todo_Integration": {
                      "type": "Condition",
                      "expression": {
                        "equals": [
                          "@outputs('Get_Context_Config')?['integrations']?['todo']",
                          true
                        ]
                      },
                      "actions": {
                        "Create_Todo_Task": {
                          "type": "HTTP",
                          "inputs": {
                            "method": "POST",
                            "uri": "https://graph.microsoft.com/v1.0/me/todo/lists/@{outputs('Get_Context_Config')?['m365']?['todoList']}/tasks",
                            "headers": {
                              "Authorization": "Bearer @{parameters('GraphToken')}"
                            },
                            "body": {
                              "title": "Review commit: @{triggerBody()?['payload']?['commit']?['message']}",
                              "linkedResources": [
                                {
                                  "webUrl": "@{triggerBody()?['payload']?['commit']?['url']}",
                                  "applicationName": "GitHub",
                                  "displayName": "@{triggerBody()?['repository']}"
                                }
                              ]
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            },
            "developer": {
              "case": "developer",
              "actions": {
                "Developer_Integration": {
                  "type": "Scope",
                  "actions": {
                    "Post_to_Teams_Dev": {
                      "type": "HTTP",
                      "inputs": {
                        "method": "POST",
                        "uri": "@outputs('Get_Context_Config')?['m365']?['teamsWebhook']",
                        "body": {
                          "type": "message",
                          "attachments": [{
                            "contentType": "application/vnd.microsoft.card.adaptive",
                            "content": {
                              "type": "AdaptiveCard",
                              "version": "1.4",
                              "body": [{
                                "type": "TextBlock",
                                "text": "💻 Developer Update",
                                "weight": "Bolder"
                              }, {
                                "type": "TextBlock",
                                "text": "@{triggerBody()?['event']}: @{triggerBody()?['payload']?['title']}"
                              }],
                              "actions": [{
                                "type": "Action.OpenUrl",
                                "title": "View on GitHub",
                                "url": "@{triggerBody()?['payload']?['html_url']}"
                              }]
                            }
                          }]
                        }
                      }
                    },
                    "Sync_VS_Code_Settings": {
                      "type": "Condition",
                      "expression": {
                        "equals": [
                          "@outputs('Get_Context_Config')?['vscode']?['syncOnPR']",
                          true
                        ]
                      },
                      "actions": {
                        "Trigger_Workspace_Sync": {
                          "type": "HTTP",
                          "inputs": {
                            "method": "POST",
                            "uri": "https://api.github.com/repos/@{triggerBody()?['repository']}/dispatches",
                            "headers": {
                              "Authorization": "Bearer @{parameters('GitHubToken')}"
                            },
                            "body": {
                              "event_type": "vscode-sync",
                              "client_payload": {
                                "pr_number": "@{triggerBody()?['payload']?['number']}"
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            },
            "business": {
              "case": "business",
              "actions": {
                "Business_Integration": {
                  "type": "Scope",
                  "actions": {
                    "Create_Planner_Task": {
                      "type": "HTTP",
                      "inputs": {
                        "method": "POST",
                        "uri": "https://graph.microsoft.com/v1.0/planner/tasks",
                        "headers": {
                          "Authorization": "Bearer @{parameters('GraphToken')}"
                        },
                        "body": {
                          "planId": "@{outputs('Get_Context_Config')?['m365']?['plannerPlan']}",
                          "bucketId": "@{outputs('Get_Context_Config')?['m365']?['plannerBuckets']?['backlog']}",
                          "title": "[GH-@{triggerBody()?['payload']?['number']}] @{triggerBody()?['payload']?['title']}",
                          "details": {
                            "description": "@{triggerBody()?['payload']?['body']}",
                            "references": {
                              "@{triggerBody()?['payload']?['html_url']}": {
                                "alias": "GitHub Issue",
                                "type": "Other"
                              }
                            }
                          }
                        }
                      }
                    },
                    "Update_SharePoint": {
                      "type": "HTTP",
                      "inputs": {
                        "method": "POST",
                        "uri": "https://graph.microsoft.com/v1.0/sites/@{outputs('Get_Context_Config')?['m365']?['sharepointSite']}/lists/@{outputs('Get_Context_Config')?['m365']?['sharepointLibrary']}/items",
                        "headers": {
                          "Authorization": "Bearer @{parameters('GraphToken')}"
                        },
                        "body": {
                          "fields": {
                            "Title": "@{triggerBody()?['payload']?['tag_name']}",
                            "ReleaseNotes": "@{triggerBody()?['payload']?['body']}",
                            "GitHubUrl": "@{triggerBody()?['payload']?['html_url']}"
                          }
                        }
                      }
                    }
                  }
                }
              }
            },
            "enterprise": {
              "case": "enterprise",
              "actions": {
                "Enterprise_Integration": {
                  "type": "Scope",
                  "actions": {
                    "Log_to_Compliance": {
                      "type": "HTTP",
                      "inputs": {
                        "method": "POST",
                        "uri": "https://graph.microsoft.com/v1.0/auditLogs/directoryAudits",
                        "headers": {
                          "Authorization": "Bearer @{parameters('GraphToken')}"
                        },
                        "body": {
                          "activityDisplayName": "GitHub Integration Event",
                          "activityDateTime": "@{utcNow()}",
                          "category": "ApplicationManagement",
                          "result": "success",
                          "targetResources": [{
                            "displayName": "@{triggerBody()?['repository']}",
                            "type": "Application"
                          }]
                        }
                      }
                    },
                    "Update_Power_BI": {
                      "type": "HTTP",
                      "inputs": {
                        "method": "POST",
                        "uri": "https://api.powerbi.com/v1.0/myorg/groups/@{outputs('Get_Context_Config')?['m365']?['powerbiWorkspace']}/datasets/@{outputs('Get_Context_Config')?['m365']?['powerbiDataset']}/rows?key=@{parameters('PowerBIKey')}",
                        "body": {
                          "rows": [{
                            "Timestamp": "@{utcNow()}",
                            "Repository": "@{triggerBody()?['repository']}",
                            "Event": "@{triggerBody()?['event']}",
                            "Context": "@{outputs('Determine_Context')}",
                            "Payload": "@{string(triggerBody()?['payload'])}"
                          }]
                        }
                      }
                    },
                    "Execute_Full_Business_Flow": {
                      "type": "Execute_Flow",
                      "inputs": {
                        "flowId": "@outputs('Get_Context_Config')?['workflows']?['full-integration']"
                      }
                    }
                  }
                }
              }
            }
          },
          "default": {
            "actions": {
              "Log_Unknown_Context": {
                "type": "Compose",
                "inputs": "Unknown context: @{outputs('Determine_Context')}"
              }
            }
          }
        }
      }
    }
  ]
}
```

---

## 🔨 PowerShell Universal Deployment Script

### Script with Context Detection

**File:** `IntelIntent-Seed/scripts/Deploy-UniversalIntegration.ps1`

```powershell
<#
.SYNOPSIS
    Universal GitHub ↔ M365 integration deployment with context switching.

.DESCRIPTION
    Deploys integration workflows based on detected or specified context.
    Supports: Personal, Developer, Family, Business, Enterprise.

.PARAMETER Context
    Integration context to deploy. Auto-detects if not specified.

.PARAMETER ConfigPath
    Path to integration configuration JSON.

.PARAMETER DryRun
    Simulate deployment without making changes.

.EXAMPLE
    .\Deploy-UniversalIntegration.ps1 -Context "developer"
    
.EXAMPLE
    .\Deploy-UniversalIntegration.ps1 -Context "enterprise" -DryRun
#>

param(
    [ValidateSet("personal", "developer", "family", "business", "enterprise", "auto")]
    [string]$Context = "auto",
    
    [string]$ConfigPath = ".\IntelIntent-Seed\config\integration-config.json",
    
    [switch]$DryRun
)

# Load configuration
function Get-IntegrationConfig {
    param([string]$Path)
    
    if (-not (Test-Path $Path)) {
        throw "Configuration file not found: $Path"
    }
    
    return Get-Content $Path | ConvertFrom-Json
}

# Auto-detect context
function Get-AutoDetectedContext {
    Write-Host "🔍 Auto-detecting context..." -ForegroundColor Cyan
    
    # Check for enterprise indicators
    if (Get-Command az -ErrorAction SilentlyContinue) {
        $account = az account show 2>$null | ConvertFrom-Json
        if ($account) {
            Write-Host "  ✅ Azure subscription detected" -ForegroundColor Green
            return "enterprise"
        }
    }
    
    # Check for business indicators
    $teamsPath = "$env:LOCALAPPDATA\Microsoft\Teams"
    if (Test-Path $teamsPath) {
        Write-Host "  ✅ Microsoft Teams detected" -ForegroundColor Green
        return "business"
    }
    
    # Check for developer indicators
    $vscodePath = "$env:APPDATA\Code"
    if (Test-Path $vscodePath) {
        Write-Host "  ✅ VS Code detected" -ForegroundColor Green
        return "developer"
    }
    
    # Default to personal
    Write-Host "  ℹ️ No specific context detected, using 'personal'" -ForegroundColor Yellow
    return "personal"
}

# Deploy GitHub Actions workflow
function Deploy-GitHubWorkflow {
    param(
        [string]$WorkflowName,
        [hashtable]$ContextConfig,
        [bool]$DryRun
    )
    
    $workflowPath = ".github\workflows\$WorkflowName.yml"
    
    if ($DryRun) {
        Write-Host "  [DRY RUN] Would deploy workflow: $workflowPath" -ForegroundColor Yellow
        return
    }
    
    # Create workflow directory if needed
    $workflowDir = Split-Path $workflowPath -Parent
    if (-not (Test-Path $workflowDir)) {
        New-Item -ItemType Directory -Path $workflowDir -Force | Out-Null
    }
    
    # Generate workflow YAML based on context
    $yaml = Generate-WorkflowYAML -Name $WorkflowName -Config $ContextConfig
    Set-Content -Path $workflowPath -Value $yaml
    
    Write-Host "  ✅ Deployed workflow: $workflowPath" -ForegroundColor Green
}

# Generate workflow YAML
function Generate-WorkflowYAML {
    param(
        [string]$Name,
        [hashtable]$Config
    )
    
    $template = @"
name: $Name

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      
      - name: Get Graph Token
        id: token
        run: |
          TOKEN=`$(curl -X POST "https://login.microsoftonline.com/`${{ secrets.TENANT_ID }}/oauth2/v2.0/token" \
            -d "client_id=`${{ secrets.CLIENT_ID }}" \
            -d "client_secret=`${{ secrets.CLIENT_SECRET }}" \
            -d "scope=https://graph.microsoft.com/.default" \
            -d "grant_type=client_credentials" | jq -r '.access_token')
          echo "::add-mask::`$TOKEN"
          echo "token=`$TOKEN" >> `$GITHUB_OUTPUT
"@
    
    # Add context-specific steps
    if ($Config.integrations.onedrive) {
        $template += @"
      
      - name: Upload to OneDrive
        run: |
          curl -X PUT "https://graph.microsoft.com/v1.0/me/drive/root:$($Config.m365.driveFolder)/backup-`$(date +%Y%m%d).zip:/content" \
            -H "Authorization: Bearer `${{ steps.token.outputs.token }}" \
            --data-binary @backup.zip
"@
    }
    
    if ($Config.integrations.teams) {
        $template += @"
      
      - name: Post to Teams
        run: |
          curl -X POST "`${{ secrets.TEAMS_WEBHOOK }}" \
            -H "Content-Type: application/json" \
            -d '{
              "text": "GitHub workflow completed: $Name"
            }'
"@
    }
    
    return $template
}

# Deploy Power Automate flow
function Deploy-PowerAutomateFlow {
    param(
        [string]$FlowName,
        [hashtable]$ContextConfig,
        [bool]$DryRun
    )
    
    Write-Host "  📋 Power Automate flow deployment..." -ForegroundColor Cyan
    
    if ($DryRun) {
        Write-Host "  [DRY RUN] Would deploy flow: $FlowName" -ForegroundColor Yellow
        return
    }
    
    # Export flow definition
    $flowPath = ".\IntelIntent-Seed\flows\$FlowName.json"
    if (Test-Path $flowPath) {
        Write-Host "  ✅ Flow definition ready: $FlowPath" -ForegroundColor Green
        Write-Host "  ℹ️ Import manually at: https://flow.microsoft.com" -ForegroundColor Yellow
    } else {
        Write-Warning "Flow definition not found: $flowPath"
    }
}

# Configure Azure AD
function Configure-AzureAD {
    param(
        [hashtable]$ContextConfig,
        [bool]$DryRun
    )
    
    Write-Host "🔐 Configuring Azure AD..." -ForegroundColor Cyan
    
    if (-not $ContextConfig.azuread) {
        Write-Host "  ℹ️ Azure AD not enabled for this context" -ForegroundColor Yellow
        return
    }
    
    if ($DryRun) {
        Write-Host "  [DRY RUN] Would configure Azure AD app" -ForegroundColor Yellow
        return
    }
    
    # Create app registration
    $appName = "IntelIntent-GitHub-M365-$($Context)"
    Write-Host "  Creating app registration: $appName" -ForegroundColor Cyan
    
    $app = az ad app create --display-name $appName --query appId -o tsv
    
    # Grant permissions
    Write-Host "  Granting Microsoft Graph permissions..." -ForegroundColor Cyan
    az ad app permission add --id $app --api 00000003-0000-0000-c000-000000000000 `
        --api-permissions `
            e1fe6dd8-ba31-4d61-89e7-88639da4683d=Scope `  # User.Read
            7ab1d382-f21e-4acd-a863-ba3e13f7da61=Role     # Directory.Read.All
    
    az ad app permission admin-consent --id $app
    
    Write-Host "  ✅ Azure AD configured: $app" -ForegroundColor Green
}

# Main deployment logic
Write-Host @"

╔══════════════════════════════════════════════════════════╗
║   Universal GitHub ↔ M365 Integration Deployment      ║
╚══════════════════════════════════════════════════════════╝

"@ -ForegroundColor Cyan

# Load config
$config = Get-IntegrationConfig -Path $ConfigPath

# Determine context
if ($Context -eq "auto") {
    $Context = Get-AutoDetectedContext
}

Write-Host "`n📍 Deploying for context: $Context" -ForegroundColor Green

# Get context-specific config
$contextConfig = $config.contexts.$Context

if (-not $contextConfig.enabled) {
    Write-Error "Context '$Context' is not enabled in configuration"
    exit 1
}

Write-Host "`n📦 Integration summary for $Context context:" -ForegroundColor Cyan
$contextConfig.integrations.PSObject.Properties | Where-Object { $_.Value -eq $true } | ForEach-Object {
    Write-Host "  ✅ $($_.Name)" -ForegroundColor Green
}

# Deploy components
Write-Host "`n🚀 Deploying components..." -ForegroundColor Cyan

# 1. GitHub Actions workflows
Write-Host "`n1️⃣ GitHub Actions Workflows" -ForegroundColor Yellow
foreach ($workflow in $contextConfig.github.workflows) {
    Deploy-GitHubWorkflow -WorkflowName $workflow -ContextConfig $contextConfig -DryRun:$DryRun
}

# 2. Power Automate flows
if ($contextConfig.integrations.planner -or $contextConfig.integrations.teams) {
    Write-Host "`n2️⃣ Power Automate Flows" -ForegroundColor Yellow
    Deploy-PowerAutomateFlow -FlowName "universal-github-m365-sync" -ContextConfig $contextConfig -DryRun:$DryRun
}

# 3. Azure AD configuration
if ($contextConfig.azuread) {
    Write-Host "`n3️⃣ Azure AD Configuration" -ForegroundColor Yellow
    Configure-AzureAD -ContextConfig $contextConfig -DryRun:$DryRun
}

# 4. Verification
Write-Host "`n✅ Deployment complete!" -ForegroundColor Green

Write-Host @"

📋 Next Steps:
1. Add GitHub secrets (Settings → Secrets):
   - TENANT_ID
   - CLIENT_ID
   - CLIENT_SECRET
   - TEAMS_WEBHOOK

2. Import Power Automate flows:
   https://flow.microsoft.com

3. Test integration:
   git commit -m "test: Verify integration"
   git push

"@ -ForegroundColor Cyan
```

---

## 🎯 Context-Specific Deployment Guides

### Personal Context

```powershell
# Deploy personal integration
.\IntelIntent-Seed\scripts\Deploy-UniversalIntegration.ps1 -Context "personal"

# What gets deployed:
# ✅ OneDrive backup workflow
# ✅ Outlook reminders for commits
# ✅ To Do task creation
# ❌ No Teams/Planner/SharePoint
```

**Use Case:** Backup personal projects, track learning tasks

---

### Developer Context

```powershell
# Deploy developer integration
.\IntelIntent-Seed\scripts\Deploy-UniversalIntegration.ps1 -Context "developer"

# What gets deployed:
# ✅ VS Code workspace sync
# ✅ Teams notifications for PRs
# ✅ OneDrive code backups
# ✅ Copilot context updates
# ❌ No enterprise features
```

**Use Case:** Enhance development workflow with AI assistance

---

### Family Context

```powershell
# Deploy family integration
.\IntelIntent-Seed\scripts\Deploy-UniversalIntegration.ps1 -Context "family"

# What gets deployed:
# ✅ Shared OneDrive folder sync
# ✅ Family calendar milestones
# ✅ SharePoint family wiki
# ❌ No business/enterprise features
```

**Use Case:** Coordinate family projects and schedules

---

### Business Context

```powershell
# Deploy business integration
.\IntelIntent-Seed\scripts\Deploy-UniversalIntegration.ps1 -Context "business"

# What gets deployed:
# ✅ GitHub Issues → Planner Tasks
# ✅ PR notifications → Teams
# ✅ Release notes → SharePoint
# ✅ Full M365 suite integration
# ❌ No compliance/Power BI
```

**Use Case:** Professional project management and collaboration

---

### Enterprise Context

```powershell
# Deploy enterprise integration
.\IntelIntent-Seed\scripts\Deploy-UniversalIntegration.ps1 -Context "enterprise"

# What gets deployed:
# ✅ All business features +
# ✅ Azure AD SSO
# ✅ Compliance logging
# ✅ Power BI dashboards
# ✅ CoE activation tracking
# ✅ Enterprise security
```

**Use Case:** Large-scale deployment with governance and analytics

---

## 🔄 Context Switching Examples

### Switch from Personal to Developer

```powershell
# Update config
$config = Get-Content .\IntelIntent-Seed\config\integration-config.json | ConvertFrom-Json
$config.contexts.personal.enabled = $false
$config.contexts.developer.enabled = $true
$config | ConvertTo-Json -Depth 10 | Set-Content .\IntelIntent-Seed\config\integration-config.json

# Redeploy
.\IntelIntent-Seed\scripts\Deploy-UniversalIntegration.ps1 -Context "developer"
```

### Enable Multiple Contexts Simultaneously

```json
{
  "contexts": {
    "personal": { "enabled": true, "priority": 1 },
    "developer": { "enabled": true, "priority": 2 },
    "business": { "enabled": true, "priority": 4 }
  }
}
```

**Priority determines routing when multiple contexts enabled:**

- Higher priority = preferred context
- Events route to highest priority enabled context

---

## 📊 Monitoring & Verification

### Verify Context Deployment

```powershell
# Check deployed workflows
Get-ChildItem .github\workflows\*.yml | Select-Object Name, LastWriteTime

# Verify Power Automate flows
# Visit: https://flow.microsoft.com → My flows

# Test GitHub → M365 sync
git commit --allow-empty -m "test: Verify $Context context"
git push

# Check results:
# - Personal: OneDrive backup created
# - Developer: Teams notification posted
# - Business: Planner task created
# - Enterprise: Power BI updated
```

### Context Health Check

```powershell
# Run health check
function Test-ContextHealth {
    param([string]$Context)
    
    $config = Get-Content .\IntelIntent-Seed\config\integration-config.json | ConvertFrom-Json
    $ctx = $config.contexts.$Context
    
    Write-Host "Health Check: $Context Context" -ForegroundColor Cyan
    
    # Check enabled
    if (-not $ctx.enabled) {
        Write-Warning "Context is disabled"
        return
    }
    
    # Check integrations
    $ctx.integrations.PSObject.Properties | Where-Object { $_.Value } | ForEach-Object {
        Write-Host "  ✅ $($_.Name) enabled" -ForegroundColor Green
    }
    
    # Check GitHub repos exist
    foreach ($repo in $ctx.github.repositories) {
        $response = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo" -ErrorAction SilentlyContinue
        if ($response) {
            Write-Host "  ✅ Repository accessible: $repo" -ForegroundColor Green
        } else {
            Write-Warning "  ❌ Repository not found: $repo"
        }
    }
}

Test-ContextHealth -Context "developer"
```

---

## 🎓 Best Practices

### 1. Start with Lower Context, Scale Up

```
Personal → Developer → Business → Enterprise
```

### 2. Test in DryRun Mode First

```powershell
.\Deploy-UniversalIntegration.ps1 -Context "enterprise" -DryRun
```

### 3. Use Environment-Specific Configs

```
integration-config.dev.json
integration-config.staging.json
integration-config.prod.json
```

### 4. Secure Secrets Properly

```powershell
# Never commit secrets
# Use GitHub Secrets or Azure Key Vault
az keyvault secret set --vault-name "IntelIntentVault" --name "GraphToken" --value "$token"
```

### 5. Monitor Integration Health

```powershell
# Schedule daily health check
# Via GitHub Actions or Azure Function
```

---

## 🔐 Security Considerations

### Context-Specific Permissions

| Context | GitHub | M365 | Azure AD |
|---------|--------|------|----------|
| Personal | Public repos | User.Read | N/A |
| Developer | Private repos | Files.ReadWrite | Optional |
| Family | Private repos | Sites.ReadWrite.All | Optional |
| Business | Private repos | Group.ReadWrite.All | Required |
| Enterprise | Private + SSO | Directory.ReadWrite.All | Required + MFA |

---

## 🚀 Deployment Checklist

- [ ] Clone IntelIntent repository
- [ ] Review `integration-config.json`
- [ ] Set context: Personal/Developer/Family/Business/Enterprise
- [ ] Run deployment script with `-DryRun`
- [ ] Configure GitHub secrets
- [ ] Deploy workflows
- [ ] Import Power Automate flows
- [ ] Test integration (commit + push)
- [ ] Verify M365 sync (OneDrive/Teams/Planner/etc.)
- [ ] Monitor first 24 hours
- [ ] Document customizations

---

*Universal configuration template created November 29, 2025*
