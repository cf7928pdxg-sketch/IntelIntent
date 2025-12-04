# 🔧 Remaining Modules - Implementation Roadmap

## Overview

With **CodexRenderer.psm1** now complete, here's the status of all IntelIntent modules and what remains to be implemented for Phase 4 completion.

---

## ✅ **COMPLETED MODULES** (4/7 Core Modules)

### 1. **AgentBridge.psm1** ✅ (447 lines)

**Status:** Stub functions active, awaiting API integration

**Functions:**

- `Invoke-OrchestratorAgent` - Semantic routing
- `Invoke-FinanceAgent` - Investment dashboards, portfolio
- `Invoke-BoopasAgent` - POS, inventory, vendor workflows
- `Invoke-IdentityAgent` - Email, Entra ID, MFA
- `Invoke-DeploymentAgent` - Azure provisioning, validation
- `Invoke-ModalityAgent` - Voice, screen, file processing
- `Get-AgentContext` - Session state tracking
- `Clear-AgentContext` - Session reset
- `Export-AgentLogs` - Audit trail export

**Next Steps:**

- Replace stub responses with real Microsoft Graph API calls
- Integrate Semantic Kernel for memory/context
- Add NLP-based intent parsing (replace keyword matching)

---

### 2. **SecureSecretsManager.psm1** ✅ (608 lines) - **NEW!**

**Status:** Production-ready

**Functions:**

- `New-SecretVault` - Provision Key Vault with RBAC
- `Set-SecretValue` - Store secrets (plain text or SecureString)
- `Get-SecretValue` - Retrieve secrets
- `Grant-VaultAccess` - RBAC role assignment
- `Remove-SecretValue` - Soft delete with purge option
- `Set-VaultContext` - Module-level vault config
- `Get-VaultContext` - Current vault state
- `Test-VaultConnection` - Validate Azure CLI auth

**Implementation Complete:** Ready for Week1_Automation.ps1 integration

---

### 3. **CircuitBreaker.psm1** ✅ (530 lines) - **NEW!**

**Status:** Production-ready

**Functions:**

- `Set-CircuitBreakerConfig` - Service thresholds
- `Invoke-WithCircuitBreaker` - Execute with retry/fallback
- `Get-CircuitBreakerStatus` - Circuit state
- `Reset-CircuitBreaker` - Manual recovery
- `Get-CircuitBreakerMetrics` - Health metrics
- `Export-CircuitBreakerLogs` - Audit trail

**Circuit States:** Closed → Open → HalfOpen

**Implementation Complete:** Ready for external service protection

---

### 4. **CodexRenderer.psm1** ✅ (650+ lines) - **NEW!**

**Status:** Production-ready

**Functions:**

- `Render-CodexScroll` - Main entry point
- `New-MarkdownScroll` - Archive-friendly Markdown
- `New-HtmlScroll` - Fluent 2 HTML with interactive design
- `Get-CheckpointMetrics` - Aggregated metrics
- `New-MermaidDependencyGraph` - Task dependency visualization
- `Test-CodexRenderer` - Sample data testing

**Features:**

- Fluent 2 design tokens (colors, typography)
- Responsive HTML with CSS grid
- Mermaid graph integration
- Cryptographic lineage visualization

**Implementation Complete:** Ready to render Week1_Checkpoints.json

---

## ⚠️ **REMAINING MODULES** (3/7 Core Modules)

### 5. **RBACManager.psm1** ⚠️ (Not Started)

**Status:** Referenced but not in repository

**Purpose:** Azure RBAC role assignment automation

**Required Functions:**

```powershell
# Core RBAC operations
function New-RBACRole {
    param([string]$RoleName, [string]$Description, [array]$Permissions)
}

function Grant-RBACRole {
    param([string]$PrincipalId, [string]$RoleName, [string]$Scope)
}

function Revoke-RBACRole {
    param([string]$PrincipalId, [string]$RoleName, [string]$Scope)
}

function Get-RBACAssignments {
    param([string]$Scope, [string]$PrincipalId)
}

function Test-RBACAccess {
    param([string]$PrincipalId, [string]$Resource, [string]$Action)
}
```

**Integration Points:**

- Week1_Automation.ps1 (Task ID: RBAC-001 through RBAC-004)
- Phase 4 roles: Phase4-Admin, Phase4-Developer, Phase4-Auditor, Phase4-Sponsor

**Implementation Complexity:** Medium

- Azure CLI integration (similar to SecureSecretsManager)
- Scope validation (subscription, resource group, resource)
- Built-in vs custom role handling

**Estimated Lines:** 400-500

**Priority:** HIGH - Critical for Phase 4 hardening

---

### 6. **CertificateAuthBridge.psm1** ⚠️ (Not Started)

**Status:** Referenced but not in repository

**Purpose:** Certificate-based Microsoft Graph API authentication

**Required Functions:**

```powershell
# Certificate management
function New-GraphCertificate {
    param([string]$SubjectName, [int]$ValidityMonths = 12)
}

function Import-GraphCertificate {
    param([string]$CertificatePath, [securestring]$Password)
}

function Register-GraphCertificate {
    param([string]$AppId, [string]$CertificatePath)
}

# Authentication
function Get-GraphTokenWithCertificate {
    param([string]$TenantId, [string]$ClientId, [string]$CertificateThumbprint)
}

function Test-GraphConnection {
    param([string]$Token)
}

# Helper functions
function Export-CertificateForUpload {
    param([string]$CertificatePath, [string]$OutputPath)
}
```

**Integration Points:**

- IdentityAgent (AgentBridge.psm1)
- Week1_Automation.ps1 (Task ID: ID-002, ID-003)
- Email delivery via Get-CodexEmailBody.psm1

**Implementation Complexity:** HIGH

- X.509 certificate generation
- Azure AD app registration integration
- Token acquisition with certificate auth
- Microsoft Graph API client library

**Estimated Lines:** 500-600

**Priority:** HIGH - Enables secure Graph API operations

---

### 7. **HealthCheckAPI.ps1** ⚠️ (Not Started)

**Status:** Referenced but not in repository

**Purpose:** Azure Container App health endpoint for orchestrator monitoring

**Required Functions:**

```powershell
# Health check server
function Start-HealthCheckAPI {
    param([int]$Port = 8080, [string]$BindAddress = "0.0.0.0")
}

function Stop-HealthCheckAPI {
}

# Health checks
function Test-SystemHealth {
    # Returns: CPU, memory, disk, network
}

function Test-DependencyHealth {
    # Returns: Azure CLI, Key Vault, Graph API connectivity
}

function Test-ModuleHealth {
    # Returns: Loaded modules, function availability
}

# Endpoints
# GET /health - Basic liveness probe
# GET /health/ready - Readiness probe (dependencies)
# GET /health/metrics - Prometheus-style metrics
```

**Integration Points:**

- Azure Container Apps (Phase 3 deployment)
- Kubernetes health probes
- Application Insights monitoring

**Implementation Complexity:** MEDIUM

- HTTP server using .NET HttpListener
- JSON response formatting
- Async request handling

**Estimated Lines:** 300-400

**Priority:** MEDIUM - Required for containerized deployment

---

## 📊 Module Implementation Status Summary

| Module | Status | Lines | Priority | Complexity | Dependencies |
|--------|--------|-------|----------|------------|--------------|
| AgentBridge | ✅ Stubs | 447 | HIGH | HIGH | Graph API, Semantic Kernel |
| SecureSecretsManager | ✅ Complete | 608 | HIGH | MEDIUM | Azure CLI, Key Vault |
| CircuitBreaker | ✅ Complete | 530 | HIGH | MEDIUM | None |
| CodexRenderer | ✅ Complete | 650+ | HIGH | MEDIUM | None |
| RBACManager | ⚠️ Pending | 0 | HIGH | MEDIUM | Azure CLI |
| CertificateAuthBridge | ⚠️ Pending | 0 | HIGH | HIGH | Azure AD, Graph API |
| HealthCheckAPI | ⚠️ Pending | 0 | MEDIUM | MEDIUM | .NET HttpListener |

**Completion Rate:** 4/7 modules (57%)

**Total Lines Implemented:** 2,235 lines

**Estimated Remaining:** 1,200-1,500 lines

---

## 🎯 Recommended Implementation Order

### Phase 1: Critical Security Infrastructure

1. **RBACManager.psm1** (Week 1 blocker)
   - Required for Phase4-Admin role creation
   - Blocks Week1_Automation.ps1 Tasks RBAC-001 through RBAC-004
   - Implementation time: 4-6 hours

2. **CertificateAuthBridge.psm1** (Graph API auth)
   - Required for email delivery and identity operations
   - Blocks IdentityAgent full implementation
   - Implementation time: 6-8 hours

### Phase 2: Observability & Monitoring

3. **HealthCheckAPI.ps1** (Container readiness)
   - Required for Azure Container Apps deployment
   - Nice-to-have for Phase 4, critical for Phase 5
   - Implementation time: 3-4 hours

### Phase 3: API Integration

4. **AgentBridge.psm1 API Integration**
   - Replace stub responses with real Graph API calls
   - Integrate Semantic Kernel for context/memory
   - Implementation time: 8-10 hours

---

## 🔨 Implementation Templates

### RBACManager.psm1 Skeleton

```powershell
# RBACManager.psm1 - Azure RBAC automation

$script:RBACContext = @{
    SessionID = (New-Guid).ToString()
    RoleCache = @{}
}

function New-RBACRole {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$RoleName,
        
        [string]$Description,
        
        [array]$Permissions,
        
        [string]$Scope
    )
    
    # Check if role exists
    $existingRole = az role definition list --name $RoleName --query "[0]" | ConvertFrom-Json
    
    if ($existingRole) {
        Write-Warning "Role $RoleName already exists"
        return @{ Status = "Exists"; RoleId = $existingRole.id }
    }
    
    # Create custom role definition
    $roleDefinition = @{
        Name = $RoleName
        Description = $Description
        Actions = $Permissions
        AssignableScopes = @($Scope)
    } | ConvertTo-Json -Depth 10
    
    # Create role
    $result = az role definition create --role-definition $roleDefinition | ConvertFrom-Json
    
    return @{
        Status = "Success"
        RoleId = $result.id
        RoleName = $result.roleName
    }
}

function Grant-RBACRole {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$PrincipalId,
        
        [Parameter(Mandatory=$true)]
        [string]$RoleName,
        
        [string]$Scope
    )
    
    # Create role assignment
    az role assignment create `
        --assignee $PrincipalId `
        --role $RoleName `
        --scope $Scope `
        --output none
    
    return @{ Status = "Success"; Principal = $PrincipalId; Role = $RoleName }
}

Export-ModuleMember -Function @('New-RBACRole', 'Grant-RBACRole')
```

### CertificateAuthBridge.psm1 Skeleton

```powershell
# CertificateAuthBridge.psm1 - Certificate-based Graph API auth

function New-GraphCertificate {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$SubjectName,
        
        [int]$ValidityMonths = 12
    )
    
    # Generate self-signed certificate
    $cert = New-SelfSignedCertificate `
        -Subject "CN=$SubjectName" `
        -CertStoreLocation "Cert:\CurrentUser\My" `
        -KeyExportPolicy Exportable `
        -KeySpec Signature `
        -NotAfter (Get-Date).AddMonths($ValidityMonths)
    
    return @{
        Status = "Success"
        Thumbprint = $cert.Thumbprint
        Subject = $cert.Subject
        ExpiresOn = $cert.NotAfter
    }
}

function Get-GraphTokenWithCertificate {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$TenantId,
        
        [Parameter(Mandatory=$true)]
        [string]$ClientId,
        
        [Parameter(Mandatory=$true)]
        [string]$CertificateThumbprint
    )
    
    # Load certificate
    $cert = Get-Item "Cert:\CurrentUser\My\$CertificateThumbprint"
    
    # Acquire token using MSAL.PS or direct REST call
    $token = # ... token acquisition logic
    
    return $token
}

Export-ModuleMember -Function @('New-GraphCertificate', 'Get-GraphTokenWithCertificate')
```

---

## 🚀 Quick Start: Next Module Implementation

### To implement RBACManager.psm1

```powershell
# 1. Create module file
New-Item -ItemType File -Path ".\IntelIntent_Seeding\RBACManager.psm1"

# 2. Copy skeleton from above

# 3. Test with sample role
Import-Module .\IntelIntent_Seeding\RBACManager.psm1 -Force

New-RBACRole -RoleName "Phase4-Admin" -Description "Phase 4 administrator" `
    -Permissions @("Microsoft.KeyVault/vaults/read", "Microsoft.Resources/deployments/*") `
    -Scope "/subscriptions/$subscriptionId"

# 4. Integrate with Week1_Automation.ps1
```

---

## 📚 Additional Resources

**Azure RBAC Documentation:**

- <https://docs.microsoft.com/en-us/azure/role-based-access-control/>

**Certificate Authentication:**

- <https://docs.microsoft.com/en-us/graph/auth-v2-service>

**Health Check Best Practices:**

- <https://docs.microsoft.com/en-us/azure/container-apps/health-probes>

---

## ✅ Validation Checklist

### RBACManager.psm1

- [ ] Create custom role definition
- [ ] Grant role to principal (user/service principal/managed identity)
- [ ] Revoke role assignment
- [ ] List role assignments by scope
- [ ] Test access permissions
- [ ] Handle built-in vs custom roles
- [ ] Error handling for invalid scopes
- [ ] Integration tests with Week1_Automation.ps1

### CertificateAuthBridge.psm1

- [ ] Generate self-signed certificate
- [ ] Import existing certificate
- [ ] Register certificate with Azure AD app
- [ ] Acquire Graph API token with certificate
- [ ] Test Graph API connection
- [ ] Export certificate for upload (.cer format)
- [ ] Handle certificate expiration
- [ ] Integration tests with IdentityAgent

### HealthCheckAPI.ps1

- [ ] Start HTTP server on configurable port
- [ ] `/health` endpoint (liveness)
- [ ] `/health/ready` endpoint (readiness with dependency checks)
- [ ] `/health/metrics` endpoint (Prometheus format)
- [ ] JSON response formatting
- [ ] Graceful shutdown
- [ ] Error handling for port conflicts
- [ ] Integration with Application Insights

---

**Next Immediate Action:** Implement RBACManager.psm1 to unblock Week1_Automation.ps1 RBAC tasks.

**Estimated Completion:** 15-20 hours for all 3 remaining modules + integration testing.

---

*Roadmap updated: 2025-11-29*  
*Phase 4 Completion: 57% → Target: 100% by Week 1 end*
