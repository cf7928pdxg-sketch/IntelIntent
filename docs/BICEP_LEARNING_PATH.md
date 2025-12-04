# Bicep Learning Path for IntelIntent

**Azure Infrastructure as Code Integration**

This guide maps the official Microsoft Bicep learning path to IntelIntent's deployment architecture, providing a ceremonial progression from fundamentals to advanced Azure infrastructure automation.

## 🎯 Learning Objectives

Transform IntelIntent's manual Azure deployments into automated, reproducible Infrastructure as Code using Bicep templates integrated with the 8-phase mutation pipeline.

---

## Phase 1: Bicep Fundamentals (Week 1)

### 📚 Learning Resources
- [Microsoft Learn: What is Bicep?](https://learn.microsoft.com/azure/azure-resource-manager/bicep/overview)
- [Bicep vs JSON ARM Templates](https://learn.microsoft.com/azure/azure-resource-manager/bicep/compare-template-syntax)

### ✅ Action Items

1. **Install Bicep CLI** (Automatic via Azure CLI)
   ```powershell
   az bicep install
   az bicep version
   ```

2. **Create First Bicep Template**
   ```bicep
   // infrastructure/resource-group.bicep
   targetScope = 'subscription'
   
   param location string = 'eastus'
   param rgName string = 'rg-intelintent-dev'
   
   resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
     name: rgName
     location: location
     tags: {
       Project: 'IntelIntent'
       Environment: 'Development'
       ManagedBy: 'Bicep'
     }
   }
   ```

3. **Deploy with Azure CLI**
   ```powershell
   az deployment sub create `
     --location eastus `
     --template-file infrastructure/resource-group.bicep
   ```

### 🎓 Checkpoint: Phase1_Bicep_Fundamentals_Complete
- [ ] Bicep CLI installed
- [ ] First template created and deployed
- [ ] Understand Bicep syntax vs JSON

---

## Phase 2: Intermediate Bicep (Week 2)

### 📚 Learning Resources
- [Microsoft Learn: Intermediate Bicep](https://learn.microsoft.com/training/paths/intermediate-bicep/)
- [Bicep Modules](https://learn.microsoft.com/azure/azure-resource-manager/bicep/modules)
- [Parameters and Variables](https://learn.microsoft.com/azure/azure-resource-manager/bicep/parameters)

### ✅ Action Items

1. **Create Modular Templates**
   ```
   infrastructure/
   ├── modules/
   │   ├── storage-account.bicep
   │   ├── key-vault.bicep
   │   └── app-insights.bicep
   ├── parameters/
   │   ├── dev.parameters.json
   │   └── prod.parameters.json
   └── main.bicep
   ```

2. **Storage Account Module Example**
   ```bicep
   // infrastructure/modules/storage-account.bicep
   param storageAccountName string
   param location string = resourceGroup().location
   param skuName string = 'Standard_LRS'
   
   resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
     name: storageAccountName
     location: location
     sku: {
       name: skuName
     }
     kind: 'StorageV2'
     properties: {
       accessTier: 'Hot'
       supportsHttpsTrafficOnly: true
       minimumTlsVersion: 'TLS1_2'
     }
   }
   
   output storageAccountId string = storageAccount.id
   output primaryEndpoints object = storageAccount.properties.primaryEndpoints
   ```

3. **Parameters File**
   ```json
   // infrastructure/parameters/dev.parameters.json
   {
     "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
     "contentVersion": "1.0.0.0",
     "parameters": {
       "storageAccountName": {
         "value": "stintelintentdev001"
       },
       "environment": {
         "value": "Development"
       }
     }
   }
   ```

### 🎓 Checkpoint: Phase2_Bicep_Intermediate_Complete
- [ ] Created modular Bicep templates
- [ ] Implemented parameters and outputs
- [ ] Deployed multi-resource templates

---

## Phase 3: Advanced Bicep (Week 3)

### 📚 Learning Resources
- [Microsoft Learn: Advanced Bicep](https://learn.microsoft.com/training/paths/advanced-bicep/)
- [Bicep Loops and Conditionals](https://learn.microsoft.com/azure/azure-resource-manager/bicep/loops)
- [User-Defined Functions](https://learn.microsoft.com/azure/azure-resource-manager/bicep/user-defined-functions)

### ✅ Action Items

1. **Implement Iterative Loops**
   ```bicep
   // Deploy multiple storage accounts
   param storageAccountNames array = [
     'stintelintentlogs'
     'stintelintentdata'
     'stintelintentbackup'
   ]
   
   resource storageAccounts 'Microsoft.Storage/storageAccounts@2023-01-01' = [for name in storageAccountNames: {
     name: name
     location: resourceGroup().location
     sku: {
       name: 'Standard_LRS'
     }
     kind: 'StorageV2'
   }]
   ```

2. **Conditional Deployments**
   ```bicep
   param deployProduction bool = false
   
   resource prodKeyVault 'Microsoft.KeyVault/vaults@2023-02-01' = if (deployProduction) {
     name: 'kv-intelintent-prod'
     location: resourceGroup().location
     properties: {
       sku: {
         family: 'A'
         name: 'premium'
       }
       tenantId: subscription().tenantId
     }
   }
   ```

3. **User-Defined Data Types**
   ```bicep
   @description('IntelIntent environment configuration')
   type EnvironmentConfig = {
     name: string
     tier: ('Development' | 'Staging' | 'Production')
     location: string
     tags: object
   }
   
   param envConfig EnvironmentConfig
   ```

### 🎓 Checkpoint: Phase3_Bicep_Advanced_Complete
- [ ] Implemented loops for resource arrays
- [ ] Used conditionals for environment-specific resources
- [ ] Created user-defined types

---

## Phase 4: CI/CD Integration (Week 4)

### 📚 Learning Resources
- [Bicep with Azure Pipelines](https://learn.microsoft.com/azure/azure-resource-manager/bicep/add-template-to-azure-pipelines)
- [Bicep with GitHub Actions](https://learn.microsoft.com/azure/azure-resource-manager/bicep/deploy-github-actions)

### ✅ Action Items

1. **GitHub Actions Workflow**
   ```yaml
   # .github/workflows/bicep-deploy.yml
   name: Deploy Bicep Infrastructure
   
   on:
     push:
       branches: [main]
       paths:
         - 'infrastructure/**'
     workflow_dispatch:
   
   jobs:
     validate:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         
         - name: Azure Login
           uses: azure/login@v1
           with:
             creds: ${{ secrets.AZURE_CREDENTIALS }}
         
         - name: Bicep Build
           run: az bicep build --file infrastructure/main.bicep
         
         - name: Validate Template
           run: |
             az deployment group validate \
               --resource-group rg-intelintent-dev \
               --template-file infrastructure/main.bicep \
               --parameters infrastructure/parameters/dev.parameters.json
     
     deploy:
       needs: validate
       runs-on: ubuntu-latest
       environment: Development
       steps:
         - uses: actions/checkout@v4
         
         - name: Azure Login
           uses: azure/login@v1
           with:
             creds: ${{ secrets.AZURE_CREDENTIALS }}
         
         - name: Deploy Infrastructure
           run: |
             az deployment group create \
               --resource-group rg-intelintent-dev \
               --template-file infrastructure/main.bicep \
               --parameters infrastructure/parameters/dev.parameters.json
   ```

2. **Azure Pipeline**
   ```yaml
   # azure-pipelines-bicep.yml
   trigger:
     branches:
       include:
         - main
     paths:
       include:
         - infrastructure/*
   
   pool:
     vmImage: 'ubuntu-latest'
   
   variables:
     azureServiceConnection: 'IntelIntent-Azure-Connection'
     resourceGroupName: 'rg-intelintent-dev'
   
   stages:
     - stage: Validate
       jobs:
         - job: ValidateBicep
           steps:
             - task: AzureCLI@2
               inputs:
                 azureSubscription: $(azureServiceConnection)
                 scriptType: 'bash'
                 scriptLocation: 'inlineScript'
                 inlineScript: |
                   az bicep build --file infrastructure/main.bicep
                   az deployment group validate \
                     --resource-group $(resourceGroupName) \
                     --template-file infrastructure/main.bicep
     
     - stage: Deploy
       dependsOn: Validate
       jobs:
         - deployment: DeployInfrastructure
           environment: Development
           strategy:
             runOnce:
               deploy:
                 steps:
                   - task: AzureCLI@2
                     inputs:
                       azureSubscription: $(azureServiceConnection)
                       scriptType: 'bash'
                       scriptLocation: 'inlineScript'
                       inlineScript: |
                         az deployment group create \
                           --resource-group $(resourceGroupName) \
                           --template-file infrastructure/main.bicep
   ```

### 🎓 Checkpoint: Phase4_CICD_Integration_Complete
- [ ] GitHub Actions workflow configured
- [ ] Azure Pipelines YAML created
- [ ] Automated validation and deployment tested

---

## Phase 5: IntelIntent Integration (Week 5)

### ✅ Action Items

1. **Map Bicep to 8-Phase Pipeline**
   ```
   Environment_Configuration/ (Phase 4)
   └── Deploy-AzureInfrastructure.ps1
       ↓
       Calls: az deployment group create
       Template: infrastructure/main.bicep
       ↓
       Creates: Storage, Key Vault, App Insights
   ```

2. **PowerShell Integration Script**
   ```powershell
   # Environment_Configuration/Deploy-AzureInfrastructure.ps1
   
   param(
       [Parameter(Mandatory)]
       [ValidateSet('Development', 'Staging', 'Production')]
       [string]$Environment
   )
   
   Write-Host "🚀 IntelIntent Phase 4: Deploying Azure Infrastructure via Bicep" -ForegroundColor Cyan
   
   # Load environment-specific parameters
   $paramFile = "infrastructure/parameters/$($Environment.ToLower()).parameters.json"
   $rgName = "rg-intelintent-$($Environment.ToLower())"
   
   # Validate Bicep template
   Write-Host "✅ Validating Bicep template..." -ForegroundColor Yellow
   az deployment group validate `
       --resource-group $rgName `
       --template-file infrastructure/main.bicep `
       --parameters $paramFile
   
   if ($LASTEXITCODE -eq 0) {
       Write-Host "✅ Validation successful!" -ForegroundColor Green
       
       # Deploy infrastructure
       Write-Host "🔧 Deploying infrastructure..." -ForegroundColor Yellow
       az deployment group create `
           --resource-group $rgName `
           --template-file infrastructure/main.bicep `
           --parameters $paramFile `
           --confirm-with-what-if
       
       if ($LASTEXITCODE -eq 0) {
           Write-Host "✅ Deployment complete!" -ForegroundColor Green
           Set-Content -Path "Recursive_Operations/checkpoint.txt" -Value "Phase4_Azure_Infrastructure_Complete"
       } else {
           Write-Error "❌ Deployment failed!"
           exit 1
       }
   } else {
       Write-Error "❌ Validation failed!"
       exit 1
   }
   ```

3. **Update Copilot Instructions**
   ```markdown
   ## Bicep Infrastructure as Code
   
   IntelIntent uses Bicep for Azure resource provisioning in Phase 4 (Environment_Configuration).
   
   **Bicep Template Structure:**
   - `infrastructure/main.bicep` - Main orchestration template
   - `infrastructure/modules/` - Reusable resource modules
   - `infrastructure/parameters/` - Environment-specific configurations
   
   **Deployment Pattern:**
   1. Validate template: `az deployment group validate`
   2. Preview changes: `--confirm-with-what-if`
   3. Deploy: `az deployment group create`
   4. Set checkpoint: `Phase4_Azure_Infrastructure_Complete`
   ```

### 🎓 Checkpoint: Phase5_IntelIntent_Integration_Complete
- [ ] Bicep templates integrated into Phase 4
- [ ] PowerShell deployment script created
- [ ] Copilot instructions updated

---

## Best Practices for Reusable Bicep Files

### 1. **Modular Design**
```bicep
// Break down into logical modules
infrastructure/
├── modules/
│   ├── network.bicep          // VNets, Subnets, NSGs
│   ├── compute.bicep           // VMs, Scale Sets
│   ├── storage.bicep           // Storage Accounts, File Shares
│   ├── data.bicep              // Databases, Cosmos DB
│   └── monitoring.bicep        // App Insights, Log Analytics
└── main.bicep                  // Orchestrates all modules
```

### 2. **Parameterization**
```bicep
// Use parameters for environment-specific values
param environment string
param location string = resourceGroup().location
param namingPrefix string = 'intelintent'

// Generate consistent naming
var storageAccountName = '${namingPrefix}${environment}${uniqueString(resourceGroup().id)}'
```

### 3. **Output Management**
```bicep
// Return essential information for downstream processes
output storageAccountId string = storageAccount.id
output keyVaultName string = keyVault.name
output appInsightsConnectionString string = appInsights.properties.ConnectionString
```

### 4. **Type Safety**
```bicep
// Use decorators for validation
@minLength(3)
@maxLength(24)
param storageAccountName string

@allowed([
  'Development'
  'Staging'
  'Production'
])
param environment string
```

### 5. **DRY Principle**
```bicep
// Define common variables once
var commonTags = {
  Project: 'IntelIntent'
  Environment: environment
  ManagedBy: 'Bicep'
  CostCenter: 'Engineering'
}

resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  tags: commonTags
  // ...
}
```

---

## Deployment Scopes Reference

| Scope | Use Case | Target Scope | Example |
|-------|----------|--------------|---------|
| **Resource Group** | Most common deployments | `targetScope = 'resourceGroup'` | Storage accounts, VMs, databases |
| **Subscription** | Resource group creation, policies | `targetScope = 'subscription'` | Create RGs, assign policies |
| **Management Group** | Multi-subscription governance | `targetScope = 'managementGroup'` | Enterprise-wide policies |
| **Tenant** | Tenant-level resources | `targetScope = 'tenant'` | Management group hierarchies |

---

## IntelIntent-Specific Templates

### Template Specs for Phase Deployment
```bicep
// Create reusable template spec for Phase 4
resource templateSpec 'Microsoft.Resources/templateSpecs@2022-02-01' = {
  name: 'IntelIntent-Phase4-Infrastructure'
  location: location
  properties: {
    description: 'IntelIntent Phase 4: Environment Configuration Infrastructure'
    displayName: 'Phase 4 Azure Resources'
  }
}

resource templateSpecVersion 'Microsoft.Resources/templateSpecs/versions@2022-02-01' = {
  parent: templateSpec
  name: '1.0.0'
  location: location
  properties: {
    mainTemplate: loadTextContent('main.bicep')
  }
}
```

---

## Learning Path Completion Tracker

### Week 1: Fundamentals
- [ ] Read Bicep overview documentation
- [ ] Install Bicep CLI
- [ ] Create first resource group template
- [ ] Deploy first template successfully

### Week 2: Intermediate
- [ ] Create 3+ modular templates
- [ ] Implement parameters and outputs
- [ ] Deploy multi-resource template
- [ ] Create environment-specific parameter files

### Week 3: Advanced
- [ ] Implement loops for resource arrays
- [ ] Add conditional deployments
- [ ] Create user-defined types
- [ ] Use deployment scripts

### Week 4: CI/CD
- [ ] Configure GitHub Actions workflow
- [ ] Set up Azure Pipeline
- [ ] Implement what-if validation
- [ ] Automate deployments

### Week 5: Integration
- [ ] Integrate Bicep into Phase 4 script
- [ ] Test end-to-end deployment
- [ ] Update IntelIntent documentation
- [ ] Create template library

---

## Reference Links

- [Official Bicep Documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Bicep GitHub Repository](https://github.com/Azure/bicep)
- [Azure Quickstart Templates (Bicep)](https://github.com/Azure/azure-quickstart-templates)
- [Bicep Playground](https://aka.ms/bicepdemo)
- [Bicep VS Code Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep)

---

## Next Steps

After completing this learning path:

1. **Create IntelIntent Infrastructure Library**
   - Document all Azure resources used
   - Convert to Bicep modules
   - Version control templates

2. **Implement Deployment Stacks**
   - Group related resources
   - Manage lifecycle as unit
   - Enable rollback capabilities

3. **Advanced Patterns**
   - Implement shared variable files
   - Create configuration set patterns
   - Build multi-region deployments

---

**Checkpoint**: `Bicep_Learning_Path_Complete`  
**Next Phase**: Advanced Azure Architecture & Multi-Region Deployment
