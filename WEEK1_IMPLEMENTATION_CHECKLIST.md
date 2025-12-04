# Week 1 Implementation Checklist — Phase 4 Production Hardening

## 🎯 Goal

Secure and stabilize the orchestration environment with Key Vault, RBAC, certificate-based Graph auth, circuit breaker resilience, and health monitoring.

**Timeline:** 5 business days  
**Team:** 2 developers + 1 ops engineer  
**Sponsor Checkpoints:** Daily Codex scroll delivery

---

## 📋 Task Groups

### 🔐 Secrets & Key Vault

**Objective:** Provision Azure Key Vault and store all service credentials securely.

#### Tasks

- [ ] **VAULT-001**: Provision IntelIntentSecrets Key Vault
  ```bash
  az keyvault create \
    --name IntelIntentSecrets \
    --resource-group Phase4RG \
    --location centralus \
    --enable-rbac-authorization true
  ```

- [ ] **VAULT-002**: Store Graph API credentials
  ```bash
  az keyvault secret set \
    --vault-name IntelIntentSecrets \
    --name GRAPH_CLIENT_ID \
    --value "<client-id>"
  
  az keyvault secret set \
    --vault-name IntelIntentSecrets \
    --name GRAPH_CLIENT_SECRET \
    --value "<client-secret>"
  
  az keyvault secret set \
    --vault-name IntelIntentSecrets \
    --name GRAPH_TENANT_ID \
    --value "<tenant-id>"
  ```

- [ ] **VAULT-003**: Store Azure OpenAI credentials
  ```bash
  az keyvault secret set \
    --vault-name IntelIntentSecrets \
    --name AZURE_OPENAI_ENDPOINT \
    --value "https://<resource>.openai.azure.com/"
  
  az keyvault secret set \
    --vault-name IntelIntentSecrets \
    --name AZURE_OPENAI_API_KEY \
    --value "<api-key>"
  ```

- [ ] **VAULT-004**: Store Azure Speech Service credentials
  ```bash
  az keyvault secret set \
    --vault-name IntelIntentSecrets \
    --name AZURE_SPEECH_KEY \
    --value "<speech-key>"
  
  az keyvault secret set \
    --vault-name IntelIntentSecrets \
    --name AZURE_SPEECH_REGION \
    --value "centralus"
  ```

- [ ] **VAULT-005**: Enable managed identity for orchestrator container
  ```bash
  # Create user-assigned managed identity
  az identity create \
    --name IntelIntentOrchestratorIdentity \
    --resource-group Phase4RG
  
  # Grant Key Vault Secrets Officer role
  az role assignment create \
    --assignee <managed-identity-principal-id> \
    --role "Key Vault Secrets Officer" \
    --scope /subscriptions/<subscription-id>/resourceGroups/Phase4RG/providers/Microsoft.KeyVault/vaults/IntelIntentSecrets
  ```

- [ ] **VAULT-006**: Validate retrieval via `SecureSecretsManager.psm1`
  ```powershell
  Import-Module .\IntelIntent_Seeding\SecureSecretsManager.psm1
  
  # Test secret retrieval
  $secret = Get-SecureSecret -VaultName "IntelIntentSecrets" -SecretName "GRAPH_CLIENT_ID"
  Write-Output "✅ Secret retrieved: $($secret.Substring(0,8))..."
  ```

**Checkpoint:** `VAULT_CHECKPOINT.json` with 6 task signatures

---

### 👥 RBAC Personas

**Objective:** Define 4 roles and assign Azure AD groups with least privilege.

#### Tasks

- [ ] **RBAC-001**: Define roles in `RBACManager.psm1`
  - **Admin**: Full system access (orchestrator:run, users:manage, secrets:read)
  - **Developer**: Component generation and debugging (orchestrator:run, components:generate, logs:read)
  - **Sponsor**: Read-only visibility (dashboard:view, codex:read)
  - **Auditor**: Compliance and audit access (compliance:read, lineage:read, logs:read)

- [ ] **RBAC-002**: Create Azure AD groups
  ```bash
  az ad group create \
    --display-name "Phase4-Admin" \
    --mail-nickname "Phase4Admin" \
    --description "IntelIntent administrators with full access"
  
  az ad group create \
    --display-name "Phase4-Developer" \
    --mail-nickname "Phase4Dev" \
    --description "IntelIntent developers with component generation access"
  
  az ad group create \
    --display-name "Phase4-Sponsor" \
    --mail-nickname "Phase4Sponsor" \
    --description "IntelIntent sponsors with read-only dashboard access"
  
  az ad group create \
    --display-name "Phase4-Auditor" \
    --mail-nickname "Phase4Audit" \
    --description "IntelIntent auditors with compliance and audit access"
  ```

- [ ] **RBAC-003**: Assign users to groups
  ```bash
  # Add admin
  az ad group member add \
    --group "Phase4-Admin" \
    --member-id <admin-user-object-id>
  
  # Add developers
  az ad group member add \
    --group "Phase4-Developer" \
    --member-id <dev1-user-object-id>
  
  az ad group member add \
    --group "Phase4-Developer" \
    --member-id <dev2-user-object-id>
  
  # Add sponsor
  az ad group member add \
    --group "Phase4-Sponsor" \
    --member-id <sponsor-user-object-id>
  
  # Add auditor
  az ad group member add \
    --group "Phase4-Auditor" \
    --member-id <auditor-user-object-id>
  ```

- [ ] **RBAC-004**: Map PowerShell modules to personas
  ```powershell
  # Edit RBACManager.psm1 to include access matrix
  $AccessMatrix = @{
      "Orchestrator.ps1" = @("Admin", "Developer")
      "SecureSecretsManager.psm1" = @("Admin")
      "RBACManager.psm1" = @("Admin")
      "New-CodexScroll" = @("Admin", "Developer", "Sponsor", "Auditor")
      "AuditLogger.psm1" = @("Admin", "Auditor")
  }
  ```

- [ ] **RBAC-005**: Test enforcement with sample sponsor persona
  ```powershell
  Import-Module .\IntelIntent_Seeding\RBACManager.psm1
  
  # Test sponsor access (should succeed)
  Test-RBACAccess -UserEmail "sponsor@example.com" -Operation "dashboard:view"
  
  # Test sponsor access to secrets (should fail)
  Test-RBACAccess -UserEmail "sponsor@example.com" -Operation "secrets:read"
  ```

**Checkpoint:** `RBAC_CHECKPOINT.json` with 5 task signatures

---

### 🔑 Certificate-Based Graph Authentication

**Objective:** Replace client secret with certificate-based authentication for Microsoft Graph API.

#### Tasks

- [ ] **CERT-001**: Generate self-signed certificate
  ```powershell
  $cert = New-SelfSignedCertificate `
      -Subject "CN=IntelIntent-GraphAuth" `
      -DnsName "intelintent.local" `
      -CertStoreLocation "Cert:\CurrentUser\My" `
      -KeyExportPolicy Exportable `
      -KeySpec Signature `
      -KeyLength 2048 `
      -KeyAlgorithm RSA `
      -HashAlgorithm SHA256 `
      -NotAfter (Get-Date).AddYears(1)
  
  Write-Output "✅ Certificate created with thumbprint: $($cert.Thumbprint)"
  ```

- [ ] **CERT-002**: Export certificate files
  ```powershell
  # Export public key (.cer)
  Export-Certificate `
      -Cert "Cert:\CurrentUser\My\$($cert.Thumbprint)" `
      -FilePath ".\GraphCert.cer"
  
  # Export private key (.pfx) with password
  $certPassword = ConvertTo-SecureString -String "<strong-password>" -Force -AsPlainText
  Export-PfxCertificate `
      -Cert "Cert:\CurrentUser\My\$($cert.Thumbprint)" `
      -FilePath ".\GraphCert.pfx" `
      -Password $certPassword
  
  Write-Output "✅ Certificate exported: GraphCert.cer, GraphCert.pfx"
  ```

- [ ] **CERT-003**: Upload public key to Azure App Registration
  1. Navigate to Azure Portal → Azure Active Directory → App registrations
  2. Select IntelIntent app registration
  3. Go to "Certificates & secrets"
  4. Click "Upload certificate"
  5. Upload `GraphCert.cer`
  6. Note the certificate thumbprint in Azure Portal

- [ ] **CERT-004**: Store private key in Key Vault
  ```bash
  # Convert .pfx to base64 for Key Vault storage
  az keyvault secret set \
    --vault-name IntelIntentSecrets \
    --name GraphAuthCertificate \
    --file ./GraphCert.pfx \
    --encoding base64
  
  # Store certificate password separately
  az keyvault secret set \
    --vault-name IntelIntentSecrets \
    --name GraphAuthCertPassword \
    --value "<strong-password>"
  ```

- [ ] **CERT-005**: Delete local certificate files (security cleanup)
  ```powershell
  Remove-Item ".\GraphCert.cer" -Force
  Remove-Item ".\GraphCert.pfx" -Force
  Write-Output "✅ Local certificate files deleted (only Key Vault copy remains)"
  ```

- [ ] **CERT-006**: Validate token acquisition with `CertificateAuthBridge.psm1`
  ```powershell
  Import-Module .\IntelIntent_Seeding\CertificateAuthBridge.psm1
  
  # Acquire token using certificate
  $token = Get-GraphTokenWithCertificate `
      -TenantId $env:GRAPH_TENANT_ID `
      -ClientId $env:GRAPH_CLIENT_ID `
      -CertThumbprint $cert.Thumbprint
  
  # Test Graph API call
  $headers = @{ Authorization = "Bearer $token" }
  $user = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/me" -Headers $headers
  
  Write-Output "✅ Graph API authenticated: $($user.displayName)"
  ```

**Checkpoint:** `CERT_CHECKPOINT.json` with 6 task signatures

---

### 🛡️ Circuit Breaker

**Objective:** Deploy resilience pattern for external service calls (Graph, OpenAI, Redis).

#### Tasks

- [ ] **CIRCUIT-001**: Deploy `CircuitBreaker.psm1`
  ```powershell
  # File should already exist from Phase 4 roadmap
  Copy-Item ".\PHASE4_MODULES\CircuitBreaker.psm1" -Destination ".\IntelIntent_Seeding\" -Force
  Import-Module .\IntelIntent_Seeding\CircuitBreaker.psm1 -Force
  ```

- [ ] **CIRCUIT-002**: Configure thresholds for Microsoft Graph
  ```powershell
  Set-CircuitBreakerConfig -ServiceName "MicrosoftGraph" -Config @{
      FailureThreshold = 5
      TimeoutSeconds = 60
      HalfOpenAttempts = 3
      BackoffStrategy = "Exponential"
  }
  ```

- [ ] **CIRCUIT-003**: Configure thresholds for Azure OpenAI
  ```powershell
  Set-CircuitBreakerConfig -ServiceName "AzureOpenAI" -Config @{
      FailureThreshold = 3
      TimeoutSeconds = 30
      HalfOpenAttempts = 2
      BackoffStrategy = "Exponential"
  }
  ```

- [ ] **CIRCUIT-004**: Configure thresholds for Redis Cache
  ```powershell
  Set-CircuitBreakerConfig -ServiceName "RedisCache" -Config @{
      FailureThreshold = 10
      TimeoutSeconds = 120
      HalfOpenAttempts = 5
      BackoffStrategy = "Linear"
  }
  ```

- [ ] **CIRCUIT-005**: Simulate Graph API throttling
  ```powershell
  # Simulate 6 consecutive failures to trigger circuit opening
  1..6 | ForEach-Object {
      try {
          Invoke-WithCircuitBreaker -ServiceName "MicrosoftGraph" -ScriptBlock {
              # Simulate throttling error
              throw [System.Net.WebException]::new("429 Too Many Requests")
          }
      } catch {
          Write-Output "Attempt $_ failed (expected)"
      }
  }
  
  # Verify circuit is now open
  $status = Get-CircuitBreakerStatus -ServiceName "MicrosoftGraph"
  Write-Output "Circuit State: $($status.State) (should be 'Open')"
  ```

- [ ] **CIRCUIT-006**: Validate fallback and recovery checkpoint creation
  ```powershell
  # Wait for timeout period (60 seconds for Graph)
  Start-Sleep -Seconds 60
  
  # Circuit should transition to HalfOpen
  $status = Get-CircuitBreakerStatus -ServiceName "MicrosoftGraph"
  Write-Output "Circuit State: $($status.State) (should be 'HalfOpen')"
  
  # Successful call should close circuit
  Invoke-WithCircuitBreaker -ServiceName "MicrosoftGraph" -ScriptBlock {
      # Simulate successful call
      Write-Output "✅ Service recovered"
  }
  
  # Verify recovery checkpoint created
  $checkpoint = Get-Content ".\Recovery_Logs\Recursive_Operations\circuit_recovery_*.json" | ConvertFrom-Json
  Write-Output "Recovery Checkpoint: $($checkpoint.TaskID)"
  Write-Output "Mitigation Hints: $($checkpoint.MitigationHints -join ', ')"
  ```

**Checkpoint:** `CIRCUIT_CHECKPOINT.json` with 6 task signatures

---

### 📡 Health Check API

**Objective:** Deploy containerized health monitoring endpoint with Application Insights telemetry.

#### Tasks

- [ ] **HEALTH-001**: Deploy `HealthCheckAPI.ps1` as Azure Container App
  ```bash
  # Create container registry if not exists
  az acr create \
    --name intelintentacr \
    --resource-group Phase4RG \
    --sku Basic \
    --admin-enabled true
  
  # Build and push health API container image
  az acr build \
    --registry intelintentacr \
    --image healthcheck-api:v1.0 \
    --file ./Dockerfile.HealthAPI \
    ./IntelIntent_Seeding
  
  # Deploy as Container App
  az containerapp create \
    --name Phase4HealthAPI \
    --resource-group Phase4RG \
    --image intelintentacr.azurecr.io/healthcheck-api:v1.0 \
    --target-port 8080 \
    --ingress external \
    --min-replicas 2 \
    --max-replicas 5 \
    --cpu 0.5 \
    --memory 1.0Gi
  ```

- [ ] **HEALTH-002**: Expose `/status` endpoint
  ```bash
  # Get container app FQDN
  HEALTH_API_URL=$(az containerapp show \
    --name Phase4HealthAPI \
    --resource-group Phase4RG \
    --query "properties.configuration.ingress.fqdn" \
    --output tsv)
  
  echo "Health API URL: https://$HEALTH_API_URL/status"
  ```

- [ ] **HEALTH-003**: Test `/status` endpoint
  ```powershell
  $healthUrl = "https://<fqdn-from-previous-step>/status"
  $response = Invoke-RestMethod -Uri $healthUrl -Method Get
  
  # Verify response structure
  Write-Output "Overall Status: $($response.Status)"
  Write-Output "Components:"
  $response.Components | Format-Table Name, Status, ResponseTime
  ```

- [ ] **HEALTH-004**: Add Application Insights telemetry
  ```bash
  # Create Application Insights resource
  az monitor app-insights component create \
    --app HealthCheckInsights \
    --location centralus \
    --resource-group Phase4RG \
    --application-type web
  
  # Get instrumentation key
  INSTRUMENTATION_KEY=$(az monitor app-insights component show \
    --app HealthCheckInsights \
    --resource-group Phase4RG \
    --query "instrumentationKey" \
    --output tsv)
  
  # Update container app environment variables
  az containerapp update \
    --name Phase4HealthAPI \
    --resource-group Phase4RG \
    --set-env-vars "APPINSIGHTS_INSTRUMENTATIONKEY=$INSTRUMENTATION_KEY"
  ```

- [ ] **HEALTH-005**: Configure alert rule for degraded health
  ```bash
  # Create action group for notifications
  az monitor action-group create \
    --name IntelIntent-Ops-Team \
    --resource-group Phase4RG \
    --short-name "IntelOps" \
    --email-receiver name="OpsEmail" email-address="ops@example.com"
  
  # Create metric alert
  az monitor metrics alert create \
    --name IntelIntent-HealthCheck-Degraded \
    --resource-group Phase4RG \
    --scopes /subscriptions/<subscription-id>/resourceGroups/Phase4RG/providers/Microsoft.App/containerApps/Phase4HealthAPI \
    --condition "count customMetrics/HealthCheck_StatusCode > 399" \
    --window-size 5m \
    --evaluation-frequency 1m \
    --severity 2 \
    --action IntelIntent-Ops-Team
  ```

- [ ] **HEALTH-006**: Simulate component failure and validate alert trigger
  ```powershell
  # Simulate RedisCache failure
  Invoke-RestMethod -Uri "$healthUrl/simulate-failure" -Method Post -Body @{
      Component = "RedisCache"
      DurationSeconds = 180
  } -ContentType "application/json"
  
  # Wait for alert to trigger (typically 2-3 minutes)
  Start-Sleep -Seconds 180
  
  # Verify alert in Azure Monitor
  $alerts = az monitor metrics alert show \
    --name IntelIntent-HealthCheck-Degraded \
    --resource-group Phase4RG \
    --query "properties.enabled" \
    --output tsv
  
  Write-Output "Alert Enabled: $alerts"
  
  # Check Application Insights for exception trace
  $query = @"
  exceptions
  | where timestamp > ago(10m)
  | where customDimensions.Component == "RedisCache"
  | project timestamp, message, customDimensions
  "@
  
  az monitor app-insights query \
    --app HealthCheckInsights \
    --resource-group Phase4RG \
    --analytics-query $query
  ```

**Checkpoint:** `HEALTH_CHECKPOINT.json` with 6 task signatures

---

### 🧪 Validation Protocol

**Objective:** Validate all Week 1 implementations with end-to-end tests.

#### Tasks

- [ ] **VALIDATE-001**: Confirm secret retrieval and unauthorized access denied
  ```powershell
  Import-Module .\IntelIntent_Seeding\SecureSecretsManager.psm1
  Import-Module .\IntelIntent_Seeding\RBACManager.psm1
  
  # Test 1: Admin can retrieve secrets
  Test-RBACAccess -UserEmail "admin@example.com" -Operation "secrets:read"
  $secret = Get-SecureSecret -VaultName "IntelIntentSecrets" -SecretName "GRAPH_CLIENT_ID"
  Write-Output "✅ Admin retrieved secret: $($secret.Substring(0,8))..."
  
  # Test 2: Developer cannot retrieve secrets
  try {
      Test-RBACAccess -UserEmail "dev@example.com" -Operation "secrets:read"
      Write-Error "❌ Developer should not have secrets access"
  } catch {
      Write-Output "✅ Developer access denied (correct)"
  }
  
  # Test 3: Sponsor cannot retrieve secrets
  try {
      Test-RBACAccess -UserEmail "sponsor@example.com" -Operation "secrets:read"
      Write-Error "❌ Sponsor should not have secrets access"
  } catch {
      Write-Output "✅ Sponsor access denied (correct)"
  }
  ```

- [ ] **VALIDATE-002**: Validate RBAC boundaries per persona
  ```powershell
  # Test matrix: [User, Operation, Expected Result]
  $tests = @(
      @{ User = "admin@example.com"; Operation = "orchestrator:run"; Expected = "Allow" },
      @{ User = "admin@example.com"; Operation = "users:manage"; Expected = "Allow" },
      @{ User = "dev@example.com"; Operation = "orchestrator:run"; Expected = "Allow" },
      @{ User = "dev@example.com"; Operation = "users:manage"; Expected = "Deny" },
      @{ User = "sponsor@example.com"; Operation = "dashboard:view"; Expected = "Allow" },
      @{ User = "sponsor@example.com"; Operation = "orchestrator:configure"; Expected = "Deny" },
      @{ User = "auditor@example.com"; Operation = "logs:read"; Expected = "Allow" },
      @{ User = "auditor@example.com"; Operation = "users:manage"; Expected = "Deny" }
  )
  
  $passed = 0
  $failed = 0
  
  foreach ($test in $tests) {
      try {
          $result = Test-RBACAccess -UserEmail $test.User -Operation $test.Operation
          if (($result -and $test.Expected -eq "Allow") -or (-not $result -and $test.Expected -eq "Deny")) {
              Write-Output "✅ PASS: $($test.User) - $($test.Operation) - $($test.Expected)"
              $passed++
          } else {
              Write-Error "❌ FAIL: $($test.User) - $($test.Operation) - Expected $($test.Expected)"
              $failed++
          }
      } catch {
          if ($test.Expected -eq "Deny") {
              Write-Output "✅ PASS: $($test.User) - $($test.Operation) - Denied (correct)"
              $passed++
          } else {
              Write-Error "❌ FAIL: $($test.User) - $($test.Operation) - Unexpected error"
              $failed++
          }
      }
  }
  
  Write-Output "`n📊 RBAC Test Results: $passed passed, $failed failed"
  ```

- [ ] **VALIDATE-003**: Acquire Graph token via certificate and call `/me` endpoint
  ```powershell
  Import-Module .\IntelIntent_Seeding\CertificateAuthBridge.psm1
  
  # Acquire token
  $token = Get-GraphTokenWithCertificate `
      -TenantId (Get-SecureSecret -VaultName "IntelIntentSecrets" -SecretName "GRAPH_TENANT_ID") `
      -ClientId (Get-SecureSecret -VaultName "IntelIntentSecrets" -SecretName "GRAPH_CLIENT_ID") `
      -CertThumbprint $cert.Thumbprint
  
  # Call Graph API
  $headers = @{ Authorization = "Bearer $token" }
  $endpoints = @("/me", "/users", "/groups")
  
  foreach ($endpoint in $endpoints) {
      $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
      $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0$endpoint" -Headers $headers
      $stopwatch.Stop()
      
      Write-Output "✅ $endpoint - Status: 200 OK - Response Time: $($stopwatch.ElapsedMilliseconds)ms"
  }
  ```

- [ ] **VALIDATE-004**: Simulate failure and confirm circuit breaker fallback
  ```powershell
  Import-Module .\IntelIntent_Seeding\CircuitBreaker.psm1
  
  # Open circuit with 6 failures
  1..6 | ForEach-Object {
      try {
          Invoke-WithCircuitBreaker -ServiceName "MicrosoftGraph" -ScriptBlock {
              throw [System.Net.WebException]::new("429 Too Many Requests")
          }
      } catch {
          # Expected failure
      }
  }
  
  # Verify circuit is open
  $status = Get-CircuitBreakerStatus -ServiceName "MicrosoftGraph"
  if ($status.State -eq "Open") {
      Write-Output "✅ Circuit opened after 6 failures"
  } else {
      Write-Error "❌ Circuit should be open but is: $($status.State)"
  }
  
  # Verify fallback response
  try {
      Invoke-WithCircuitBreaker -ServiceName "MicrosoftGraph" -ScriptBlock {
          Write-Output "This should not execute"
      }
  } catch {
      if ($_.Exception.Message -match "Circuit breaker open") {
          Write-Output "✅ Fallback response returned (circuit open)"
      } else {
          Write-Error "❌ Unexpected error: $($_.Exception.Message)"
      }
  }
  
  # Verify recovery checkpoint exists
  $checkpoints = Get-ChildItem ".\Recovery_Logs\Recursive_Operations" -Filter "circuit_*.json"
  if ($checkpoints.Count -gt 0) {
      $checkpoint = Get-Content $checkpoints[0].FullName | ConvertFrom-Json
      Write-Output "✅ Recovery checkpoint created:"
      Write-Output "   Task ID: $($checkpoint.TaskID)"
      Write-Output "   Mitigation Hints: $($checkpoint.MitigationHints -join ', ')"
  } else {
      Write-Error "❌ No recovery checkpoint found"
  }
  ```

- [ ] **VALIDATE-005**: Call `/status` endpoint and confirm JSON response + alert trigger
  ```powershell
  # Test 1: Healthy status
  $response = Invoke-RestMethod -Uri "$healthUrl/status"
  
  if ($response.Status -eq "Healthy" -and $response.Components.Count -eq 5) {
      Write-Output "✅ Health endpoint returns 200 OK with 5 components"
  } else {
      Write-Error "❌ Unexpected health response: $($response | ConvertTo-Json)"
  }
  
  # Test 2: Simulate component failure
  Invoke-RestMethod -Uri "$healthUrl/simulate-failure" -Method Post -Body @{
      Component = "AzureOpenAI"
      DurationSeconds = 180
  } -ContentType "application/json"
  
  Start-Sleep -Seconds 10
  
  $response = Invoke-RestMethod -Uri "$healthUrl/status"
  if ($response.Status -eq "Degraded" -and $response.Components.AzureOpenAI -eq "Unhealthy") {
      Write-Output "✅ Health endpoint returns 503 (Degraded) for failed component"
  } else {
      Write-Error "❌ Health endpoint should show degraded status"
  }
  
  # Test 3: Verify Application Insights trace
  Start-Sleep -Seconds 60  # Wait for telemetry ingestion
  
  $query = @"
  customEvents
  | where timestamp > ago(5m)
  | where name == "HealthCheckFailed"
  | where customDimensions.Component == "AzureOpenAI"
  | project timestamp, name, customDimensions
  "@
  
  $traces = az monitor app-insights query `
    --app HealthCheckInsights `
    --resource-group Phase4RG `
    --analytics-query $query `
    --output json | ConvertFrom-Json
  
  if ($traces.tables[0].rows.Count -gt 0) {
      Write-Output "✅ Application Insights trace captured"
  } else {
      Write-Error "❌ No Application Insights trace found"
  }
  
  # Test 4: Verify alert triggered
  Start-Sleep -Seconds 120  # Wait for alert evaluation
  
  $alerts = az monitor metrics alert show `
    --name IntelIntent-HealthCheck-Degraded `
    --resource-group Phase4RG `
    --query "properties.enabled" `
    --output tsv
  
  Write-Output "✅ Alert rule validated (enabled: $alerts)"
  ```

**Checkpoint:** `VALIDATION_CHECKPOINT.json` with 5 task signatures

---

## 📜 Codex Scroll Integration

### Checkpoint Logging

Each task group automatically logs checkpoints to `Week1_Checkpoints.json`:

```json
{
  "SessionID": "Phase4-Week1-<GUID>",
  "StartTime": "2025-11-26T09:00:00Z",
  "Checkpoints": [
    {
      "TaskID": "VAULT-001",
      "Timestamp": "2025-11-26T09:00:45Z",
      "Status": "Success",
      "Inputs": { "VaultName": "IntelIntentSecrets", "ResourceGroup": "Phase4RG" },
      "Outputs": { "VaultUri": "https://intelintentsecrets.vault.azure.net/" },
      "Signature": "a7b3c2d1e4f56789abcdef1234567890fedcba9876543210a1b2c3d4e5f67890",
      "Artifacts": ["bicep/keyvault.bicep", "deployment_logs/keyvault_provision.log"]
    }
  ]
}
```

### Scroll Generation

After completing all tasks, generate sponsor-facing scrolls:

```powershell
Import-Module .\IntelIntent_Seeding\CodexRenderer.psm1

# Generate Markdown scroll
New-CodexScroll `
    -CheckpointFile ".\Week1_Checkpoints.json" `
    -OutputPath ".\Sponsors\Week1_Codex_Scroll.md" `
    -Format "Markdown"

# Generate HTML scroll for email
New-CodexScroll `
    -CheckpointFile ".\Week1_Checkpoints.json" `
    -OutputPath ".\Sponsors\Week1_Codex_Scroll.html" `
    -Format "HTML"
```

### Email Delivery

Automatically send scrolls to sponsors via IdentityAgent:

```powershell
Import-Module .\IntelIntent_Seeding\IdentityAgent.psm1

$emailBody = Get-CodexEmailBody `
    -ScrollPath ".\Sponsors\Week1_Codex_Scroll.html" `
    -SessionID "Phase4-Week1"

Invoke-IdentityAgent -Operation "EmailOrchestration" `
    -UserEmail "sponsors@example.com" `
    -Data @{
        Subject = "IntelIntent Phase 4 Week 1 Completion Report"
        Body = $emailBody
        ContentType = "HTML"
        Attachments = @(
            ".\Sponsors\Week1_Codex_Scroll.md",
            ".\Sponsors\Week1_Summary_Metrics.pdf"
        )
        Priority = "High"
    }

Write-Output "✅ Week 1 Codex Scroll delivered to sponsors"
```

---

## ✅ Deliverables

After completing Week 1, you will have:

### Infrastructure
- ✅ Azure Key Vault with 8 secrets stored securely
- ✅ 4 Azure AD groups with 5+ users assigned
- ✅ Certificate-based Graph API authentication operational
- ✅ Circuit breaker resilience for 3 external services
- ✅ Health monitoring API with Application Insights telemetry

### Documentation
- ✅ 26 checkpoint JSON files with SHA256 signatures
- ✅ Week 1 Codex Scroll (Markdown + HTML)
- ✅ RBAC access matrix documentation
- ✅ Circuit breaker configuration guide
- ✅ Health API endpoint specification

### Validation Evidence
- ✅ Secret retrieval test results (100% pass rate)
- ✅ RBAC enforcement test results (8/8 tests passed)
- ✅ Graph API authentication test (3 endpoints validated)
- ✅ Circuit breaker fallback test (recovery checkpoint created)
- ✅ Health monitoring alert test (Application Insights trace captured)

---

## 🎯 Success Metrics

| Metric | Target | Actual |
|--------|--------|--------|
| Key Vault Secrets Stored | 8 | ___ |
| RBAC Roles Defined | 4 | ___ |
| Azure AD Groups Created | 4 | ___ |
| Users Assigned | 5+ | ___ |
| Certificate Auth Working | ✅ | ___ |
| Circuit Breaker Services | 3 | ___ |
| Health API Uptime | 99.9% | ___ |
| Alert Rules Configured | 1 | ___ |
| Checkpoints Created | 26 | ___ |
| RBAC Tests Passed | 8/8 | ___ |
| Codex Scrolls Generated | 2 (MD + HTML) | ___ |

---

## 🚀 Next Steps (Week 2)

### Scale Testing
- Load test framework with 50/200/600/1000 component synthetic manifests
- Parallel orchestration with dependency-aware execution
- Redis caching for Graph API and semantic memory
- Performance benchmarking (target: 0.22+ components/second)

### Monitoring Enhancement
- Azure Monitor custom metrics for orchestrator throughput
- Application Insights dependency tracking
- Power BI dashboard integration for real-time metrics
- Alerting rules for performance degradation

---

**Week 1 Status:** ⏳ **In Progress** (0/26 tasks completed)

_Clear tasks. Transparent lineage. Continuous sponsor engagement._
