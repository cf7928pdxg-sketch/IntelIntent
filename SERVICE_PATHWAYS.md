# IntelIntent Service Communication Pathways
**High-Frequency Interaction Patterns & Service Contracts**

**Generated:** 2025-11-27  
**Focus:** 80/20 Rule - Most Frequent Service Interactions  
**Purpose:** Ensure independent service operation with clear boundaries

---

## I. Hot Path Analysis (Most Frequent Interactions)

### **Primary Execution Path (95% of Traffic)**

```
Developer CLI Trigger
        ↓
Week1_Automation.ps1 (Orchestrator)
        ↓
    ┌───────────────────────────────────┐
    │   Sequential Service Calls        │
    │   (26 checkpoint events)          │
    └───────────────────────────────────┘
        ↓
    ┌───┴────┬────┬────┬────┬────┐
    ↓        ↓    ↓    ↓    ↓    ↓
 Secrets  RBAC  Cert  CB  Health  Validate
  (4x)    (5x)  (4x) (4x)  (5x)   (4x)
    │        │    │    │    │      │
    └────────┴────┴────┴────┴──────┘
                  ↓
         Checkpoint Array (26 events)
                  ↓
         ┌────────┴────────┐
         ↓                 ↓
    CodexRenderer    IntegrityValidator
         │                 │
         ↓                 ↓
    .md + .html      IntegrityReport.json
         │                 │
         └────────┬────────┘
                  ↓
         IdentityAgent (EmailService)
                  ↓
         Graph API /me/sendMail
                  ↓
            Sponsor Inbox
```

**Frequency:** 1x per Week1 execution (developer-initiated)  
**Total Service Calls:** 26 (Azure services) + 2 (rendering) + 1 (validation) + 1 (email) = **30 calls**  
**Execution Time:** ~8 minutes (5-7min Azure + 1min rendering/email)

---

## II. Service Communication Contracts (Top 5 Hot Paths)

### **Hot Path #1: Orchestrator → Azure Services** (26 calls per execution)

**Pattern:** Synchronous Request/Response with Circuit Breaker

```
┌────────────────────────────────────────────────────────────┐
│ Week1_Automation.ps1 (Orchestrator)                        │
└─────────────────┬──────────────────────────────────────────┘
                  │
                  ↓
    ┌─────────────────────────────────┐
    │  Invoke-TaskWithCheckpoint      │
    │  ├─ Start timer                 │
    │  ├─ Call Azure CLI via CB       │
    │  ├─ Capture output/errors       │
    │  ├─ Stop timer                  │
    │  └─ Log checkpoint               │
    └─────────────────┬───────────────┘
                      │
                      ↓
    ┌─────────────────────────────────┐
    │  Invoke-WithCircuitBreaker      │
    │  ├─ Check circuit state         │
    │  ├─ Execute command             │
    │  ├─ Handle failures             │
    │  └─ Update circuit state        │
    └─────────────────┬───────────────┘
                      │
                      ↓
            ┌─────────┴─────────┐
            ↓                   ↓
       [SUCCESS]            [FAILURE]
            │                   │
            ↓                   ↓
    Add-Checkpoint          Add-Checkpoint
    (Status=Success)        (Status=Failed)
            │                   │
            └─────────┬─────────┘
                      ↓
              Continue to Next Task
```

**Contract Definition:**

```powershell
# Service Interface: Azure CLI Wrapper
function Invoke-AzureCommand {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Command,           # Azure CLI command (e.g., "az keyvault create")
        
        [Parameter(Mandatory)]
        [string]$TaskID,            # Checkpoint identifier (e.g., "KV-001")
        
        [hashtable]$Inputs = @{},   # Command inputs (for audit)
        
        [int]$MaxRetries = 3,       # Circuit breaker retry limit
        
        [int]$TimeoutSeconds = 60   # Command timeout
    )
    
    # Start checkpoint timer
    $startTime = Get-Date
    
    # Execute command with circuit breaker
    try {
        $result = Invoke-WithCircuitBreaker -Command {
            Invoke-Expression $Command
        } -MaxRetries $MaxRetries -TimeoutSeconds $TimeoutSeconds
        
        # Calculate duration
        $duration = (Get-Date) - $startTime
        
        # Log success checkpoint
        Add-Checkpoint -TaskID $TaskID `
                       -Status "Success" `
                       -Duration $duration.TotalSeconds `
                       -Inputs $Inputs `
                       -Outputs @{ Result = $result }
        
        return $result
    }
    catch {
        # Calculate duration
        $duration = (Get-Date) - $startTime
        
        # Log failure checkpoint
        Add-Checkpoint -TaskID $TaskID `
                       -Status "Failed" `
                       -Duration $duration.TotalSeconds `
                       -Inputs $Inputs `
                       -Outputs @{ Error = $_.Exception.Message }
        
        # Re-throw (or continue based on non-blocking flag)
        throw
    }
}
```

**Communication Properties:**
- **Protocol:** PowerShell function call → Azure CLI subprocess → HTTPS REST API
- **Authentication:** Service principal (OAuth token in environment)
- **Retry Logic:** Circuit breaker (3 attempts, exponential backoff)
- **Timeout:** 60 seconds per command (configurable)
- **Error Handling:** Capture stderr, log to checkpoint, continue execution
- **Idempotency:** Most Azure CLI commands are idempotent (safe to retry)

**Example Call:**
```powershell
Invoke-AzureCommand -Command "az keyvault create --name IntelIntentSecrets --resource-group Phase4RG" `
                    -TaskID "KV-001" `
                    -Inputs @{ VaultName = "IntelIntentSecrets"; ResourceGroup = "Phase4RG" }
```

---

### **Hot Path #2: Orchestrator → Checkpoint Array** (26 events per execution)

**Pattern:** In-Memory Event Collection (No Network I/O)

```
┌────────────────────────────────────────────────────────────┐
│ Week1_Automation.ps1 (Orchestrator)                        │
│ $script:Checkpoints = @()  # In-memory array               │
└─────────────────┬──────────────────────────────────────────┘
                  │
                  ↓
    ┌─────────────────────────────────┐
    │  Add-Checkpoint                 │
    │  ├─ Create checkpoint hashtable │
    │  ├─ Add metadata (timestamp)    │
    │  ├─ Append to array             │
    │  └─ Return checkpoint object    │
    └─────────────────┬───────────────┘
                      │
                      ↓
         $script:Checkpoints += @{
             TaskID = "KV-001"
             Status = "Success"
             Timestamp = "2025-11-27T14:30:00Z"
             Duration = 12.3
             Inputs = @{ ... }
             Outputs = @{ ... }
             Artifacts = @("IntelIntentSecrets")
             Signature = "[Pending SHA256]"
             ParentTaskID = $null
             SessionID = $SessionID
         }
                      │
                      ↓
    After all 26 tasks complete
                      │
                      ↓
    Export-CheckpointsToJson
         ├─ $script:Checkpoints | ConvertTo-Json -Depth 10
         └─ Set-Content "Week1_Checkpoints.json"
```

**Contract Definition:**

```powershell
# Service Interface: Checkpoint Logger
function Add-Checkpoint {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$TaskID,
        
        [Parameter(Mandatory)]
        [ValidateSet("Success", "Failed", "Skipped")]
        [string]$Status,
        
        [hashtable]$Inputs = @{},
        [hashtable]$Outputs = @{},
        [string[]]$Artifacts = @(),
        [string]$Signature = "[Pending SHA256]",
        [int]$DurationSeconds = 0,
        [string]$ParentTaskID = $null
    )
    
    $checkpoint = @{
        TaskID = $TaskID
        Timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
        Status = $Status
        Duration = $DurationSeconds
        Inputs = $Inputs
        Outputs = $Outputs
        Artifacts = $Artifacts
        Signature = $Signature
        ParentTaskID = $ParentTaskID
        SessionID = $script:SessionID
    }
    
    # Append to in-memory array (thread-safe in single-threaded PowerShell)
    $script:Checkpoints += $checkpoint
    
    # Return checkpoint for immediate inspection
    return $checkpoint
}

# Export function (called once at end)
function Export-CheckpointsToJson {
    param(
        [Parameter(Mandatory)]
        [string]$OutputPath
    )
    
    $output = @{
        SessionID = $script:SessionID
        StartTime = $script:StartTime
        EndTime = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
        Checkpoints = $script:Checkpoints
    }
    
    $output | ConvertTo-Json -Depth 10 | Set-Content $OutputPath -Encoding UTF8
}
```

**Communication Properties:**
- **Protocol:** In-memory array append (no I/O)
- **Persistence:** Single file write at end (`Week1_Checkpoints.json`)
- **Concurrency:** Single-threaded (no locking required)
- **Performance:** O(1) append, negligible overhead (<1ms per checkpoint)
- **Memory:** ~2KB per checkpoint × 26 = ~52KB total

---

### **Hot Path #3: CodexRenderer → Checkpoint Array** (2 calls per execution)

**Pattern:** File Read → Transform → File Write

```
┌────────────────────────────────────────────────────────────┐
│ Week1_Automation.ps1 (Orchestrator)                        │
└─────────────────┬──────────────────────────────────────────┘
                  │
                  ↓
         Export-CheckpointsToJson
                  │
                  ↓
         Week1_Checkpoints.json (52KB)
                  │
                  ├───────────────────────┐
                  │                       │
                  ↓                       ↓
    ┌─────────────────────┐   ┌─────────────────────┐
    │ ConvertTo-          │   │ ConvertTo-          │
    │ MarkdownScroll      │   │ HtmlScroll          │
    │ ├─ Read JSON        │   │ ├─ Read JSON        │
    │ ├─ Parse checkpoints│   │ ├─ Parse checkpoints│
    │ ├─ Generate MD      │   │ ├─ Generate HTML    │
    │ └─ Write file       │   │ └─ Write file       │
    └─────────┬───────────┘   └─────────┬───────────┘
              │                         │
              ↓                         ↓
    Week1_Codex_Scroll.md     Week1_Codex_Scroll.html
         (~15KB)                     (~45KB)
```

**Contract Definition:**

```powershell
# Service Interface: Codex Renderer
function New-CodexScroll {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet("Markdown", "HTML")]
        [string]$Format,
        
        [Parameter(Mandatory)]
        [string]$CheckpointFile,    # Input: Week1_Checkpoints.json
        
        [Parameter(Mandatory)]
        [string]$OutputPath,        # Output: Week1_Codex_Scroll.md or .html
        
        [string]$PowerBIDashboardUrl = ""  # Optional: embed dashboard link
    )
    
    # Read and parse checkpoint JSON
    if (-not (Test-Path $CheckpointFile)) {
        throw "Checkpoint file not found: $CheckpointFile"
    }
    
    $checkpointData = Get-Content $CheckpointFile -Raw | ConvertFrom-Json
    
    # Validate schema
    if (-not $checkpointData.SessionID) {
        throw "Invalid checkpoint file: Missing SessionID"
    }
    
    # Generate scroll based on format
    switch ($Format) {
        "Markdown" {
            $scroll = ConvertTo-MarkdownScroll -CheckpointData $checkpointData `
                                                -PowerBIDashboardUrl $PowerBIDashboardUrl
        }
        "HTML" {
            $scroll = ConvertTo-HtmlScroll -CheckpointData $checkpointData `
                                           -PowerBIDashboardUrl $PowerBIDashboardUrl
        }
    }
    
    # Write to file
    $scroll | Set-Content $OutputPath -Encoding UTF8
    
    return @{
        Format = $Format
        FilePath = $OutputPath
        FileSize = (Get-Item $OutputPath).Length
        CheckpointCount = $checkpointData.Checkpoints.Count
    }
}
```

**Communication Properties:**
- **Protocol:** File I/O (read JSON, write Markdown/HTML)
- **Input Schema:** Week1_Checkpoints.json (validated structure)
- **Output Format:** UTF-8 encoded text files
- **Performance:** <1 second per scroll (pure string concatenation)
- **Dependencies:** None (no external API calls)
- **Idempotency:** Overwrite output file (safe to re-run)

**Example Call:**
```powershell
# Generate Markdown scroll
New-CodexScroll -Format Markdown `
                -CheckpointFile "Week1_Checkpoints.json" `
                -OutputPath ".\Sponsors\Week1_Codex_Scroll.md" `
                -PowerBIDashboardUrl "https://app.powerbi.com/..."

# Generate HTML scroll
New-CodexScroll -Format HTML `
                -CheckpointFile "Week1_Checkpoints.json" `
                -OutputPath ".\Sponsors\Week1_Codex_Scroll.html" `
                -PowerBIDashboardUrl "https://app.powerbi.com/..."
```

---

### **Hot Path #4: IdentityAgent → Graph API** (1 call per execution)

**Pattern:** Certificate-Based Authentication → REST API Call

```
┌────────────────────────────────────────────────────────────┐
│ Week1_Automation.ps1 (Orchestrator)                        │
└─────────────────┬──────────────────────────────────────────┘
                  │
                  ↓
    ┌─────────────────────────────────┐
    │ Import-Module Get-CodexEmailBody│
    └─────────────────┬───────────────┘
                      │
                      ↓
    ┌─────────────────────────────────┐
    │ Get-CodexEmailBody              │
    │ ├─ Read Week1_Codex_Scroll.html│
    │ ├─ Read IntegrityReport.json   │
    │ ├─ Wrap into Graph API payload │
    │ └─ Return JSON object           │
    └─────────────────┬───────────────┘
                      │
                      ↓
              $emailPayload = @{
                  message = @{
                      subject = "Phase 4 Week 1 Complete"
                      body = @{
                          contentType = "HTML"
                          content = $htmlScroll
                      }
                      toRecipients = @(
                          @{ emailAddress = @{ address = "sponsor@intelintent.com" } }
                      )
                      attachments = @(
                          @{
                              "@odata.type" = "#microsoft.graph.fileAttachment"
                              name = "Week1_Codex_Scroll.md"
                              contentBytes = [Convert]::ToBase64String([IO.File]::ReadAllBytes($mdPath))
                          }
                      )
                  }
              }
                      │
                      ↓
    ┌─────────────────────────────────┐
    │ Send-CodexEmail                 │
    │ ├─ Get-GraphToken (cert auth)  │
    │ ├─ POST /me/sendMail            │
    │ ├─ Handle 429 throttling        │
    │ └─ Return MessageID             │
    └─────────────────┬───────────────┘
                      │
                      ↓
    ┌─────────────────────────────────┐
    │ Graph API /me/sendMail          │
    │ └─ 202 Accepted (async send)    │
    └─────────────────┬───────────────┘
                      │
                      ↓
            Sponsor Email Inbox
```

**Contract Definition:**

```powershell
# Service Interface: Email Delivery
function Send-CodexEmail {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [hashtable]$Payload,        # Graph API message payload
        
        [Parameter(Mandatory)]
        [string]$AccessToken,       # OAuth bearer token
        
        [int]$MaxRetries = 3        # Retry on 429 throttling
    )
    
    $uri = "https://graph.microsoft.com/v1.0/me/sendMail"
    $headers = @{
        "Authorization" = "Bearer $AccessToken"
        "Content-Type" = "application/json"
    }
    
    $body = $Payload | ConvertTo-Json -Depth 10
    
    $retryCount = 0
    $backoffSeconds = 2
    
    while ($retryCount -lt $MaxRetries) {
        try {
            $response = Invoke-RestMethod -Uri $uri `
                                         -Method Post `
                                         -Headers $headers `
                                         -Body $body `
                                         -TimeoutSec 30
            
            return @{
                Status = "Success"
                StatusCode = 202
                MessageID = $response.id
            }
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.Value__
            
            if ($statusCode -eq 429) {
                # Throttling - retry with exponential backoff
                $retryAfter = $_.Exception.Response.Headers["Retry-After"]
                if ($retryAfter) {
                    $backoffSeconds = [int]$retryAfter + 1
                }
                
                Write-Warning "Graph API throttling (429). Retrying in $backoffSeconds seconds..."
                Start-Sleep -Seconds $backoffSeconds
                
                $retryCount++
                $backoffSeconds *= 2  # Exponential backoff
            }
            else {
                # Non-retriable error
                throw "Graph API error: $($_.Exception.Message)"
            }
        }
    }
    
    throw "Max retries exceeded ($MaxRetries) for Graph API call"
}

# Authentication function
function Get-GraphToken {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$CertificateThumbprint,
        
        [Parameter(Mandatory)]
        [string]$TenantId,
        
        [Parameter(Mandatory)]
        [string]$ClientId
    )
    
    # Retrieve certificate from Key Vault (cached in memory)
    $cert = Get-AzKeyVaultCertificate -VaultName "IntelIntentSecrets" `
                                      -Name "GraphCert"
    
    # Acquire token via Azure AD (certificate assertion)
    $token = Get-MsalToken -ClientId $ClientId `
                           -TenantId $TenantId `
                           -ClientCertificate $cert `
                           -Scopes "https://graph.microsoft.com/.default"
    
    return $token.AccessToken
}
```

**Communication Properties:**
- **Protocol:** HTTPS REST API (POST)
- **Authentication:** OAuth 2.0 certificate assertion (no client secret)
- **Endpoint:** `https://graph.microsoft.com/v1.0/me/sendMail`
- **Retry Logic:** Exponential backoff (2s, 4s, 8s) on 429 throttling
- **Timeout:** 30 seconds per request
- **Response:** 202 Accepted (async email delivery)
- **Idempotency:** Graph API deduplicates messages (safe to retry)

**Example Call:**
```powershell
# Get access token
$token = Get-GraphToken -CertificateThumbprint "ABC123..." `
                        -TenantId "..." `
                        -ClientId "..."

# Prepare payload
$payload = Get-CodexEmailBody -ScrollPath ".\Sponsors\Week1_Codex_Scroll.html" `
                              -Recipients @("sponsor@intelintent.com") `
                              -Subject "Phase 4 Week 1 Complete"

# Send email
$result = Send-CodexEmail -Payload $payload -AccessToken $token
# Output: @{ Status = "Success"; StatusCode = 202; MessageID = "AAMkAGI2T..." }
```

---

### **Hot Path #5: CI/CD Pipeline → Orchestrator** (1 call per commit)

**Pattern:** GitHub Actions Event → PowerShell Script Execution

```
┌────────────────────────────────────────────────────────────┐
│ GitHub Actions Workflow (.github/workflows/*)              │
└─────────────────┬──────────────────────────────────────────┘
                  │
                  ↓
          on: push (main branch)
                  │
                  ↓
    ┌─────────────────────────────────┐
    │ Job: week1-execution            │
    │ runs-on: windows-latest         │
    └─────────────────┬───────────────┘
                      │
                      ↓
    ┌─────────────────────────────────┐
    │ Step: Checkout repository       │
    │ uses: actions/checkout@v4       │
    └─────────────────┬───────────────┘
                      │
                      ↓
    ┌─────────────────────────────────┐
    │ Step: Azure Login               │
    │ uses: azure/login@v1            │
    │ with: creds=${{ secrets.* }}    │
    └─────────────────┬───────────────┘
                      │
                      ↓
    ┌─────────────────────────────────┐
    │ Step: Run Week1_Automation.ps1  │
    │ run: .\Week1_Automation.ps1     │
    └─────────────────┬───────────────┘
                      │
                      ↓
         Week1_Automation.ps1 executes
         (Hot Paths #1-4 triggered)
                      │
                      ↓
    ┌─────────────────────────────────┐
    │ Step: Upload Artifacts          │
    │ uses: actions/upload-artifact@v4│
    │ ├─ Week1_Checkpoints.json       │
    │ ├─ Week1_Codex_Scroll.md        │
    │ └─ Week1_Codex_Scroll.html      │
    └─────────────────┬───────────────┘
                      │
                      ↓
    ┌─────────────────────────────────┐
    │ Step: Test Integrity            │
    │ run: Test-CodexIntegrity        │
    └─────────────────┬───────────────┘
                      │
                      ↓
    ┌─────────────────────────────────┐
    │ Step: Send Email                │
    │ run: Send-CodexScrollEmail      │
    └─────────────────────────────────┘
```

**Contract Definition:**

```yaml
# Service Interface: GitHub Actions Workflow
name: Phase 4 Codex Scroll Delivery

on:
  push:
    branches: [main]
    paths:
      - 'Week1_Automation.ps1'
      - 'IntelIntent_Seeding/*.psm1'

jobs:
  week1-execution:
    runs-on: windows-latest
    
    steps:
      # Service Call #1: Azure Authentication
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      # Service Call #2: Execute Orchestrator (Hot Paths #1-4)
      - name: Run Week1_Automation.ps1
        run: |
          .\Week1_Automation.ps1 `
            -ResourceGroup "Phase4RG" `
            -Location "centralus" `
            -VaultName "IntelIntentSecrets"
        shell: pwsh
      
      # Service Call #3: Upload Artifacts
      - name: Upload Checkpoints
        uses: actions/upload-artifact@v4
        with:
          name: week1-checkpoints
          path: Week1_Checkpoints.json
      
      # Service Call #4: Validate Integrity
      - name: Test Integrity
        run: |
          Import-Module .\IntelIntent_Seeding\Test-CodexIntegrity.psm1
          $result = Test-CodexIntegrity -CheckpointFile Week1_Checkpoints.json
          if ($result.IntegrityScore -lt 100) {
            throw "Integrity validation failed: Score = $($result.IntegrityScore)"
          }
        shell: pwsh
      
      # Service Call #5: Send Email (Hot Path #4)
      - name: Send Email to Sponsors
        run: |
          Import-Module .\IntelIntent_Seeding\Get-CodexEmailBody.psm1
          $token = az account get-access-token --resource https://graph.microsoft.com --query accessToken -o tsv
          $payload = Get-CodexEmailBody -ScrollPath ".\Sponsors\Week1_Codex_Scroll.html" `
                                        -Recipients @("${{ secrets.SPONSOR_EMAIL }}")
          Send-CodexEmail -Payload $payload -AccessToken $token
        shell: pwsh
```

**Communication Properties:**
- **Protocol:** GitHub Actions webhook → HTTPS POST → Runner VM
- **Authentication:** GitHub token + Azure service principal
- **Trigger Frequency:** Every commit to main branch (or manual dispatch)
- **Execution Environment:** windows-latest VM (PowerShell 7.3)
- **Artifacts:** Uploaded to GitHub Actions storage (90-day retention)
- **Failure Handling:** Pipeline stops on error (non-zero exit code)

---

## III. Dependency Graph (Service Interaction Frequency)

```
┌─────────────────────────────────────────────────────────────┐
│             SERVICE INTERACTION FREQUENCY MAP               │
└─────────────────────────────────────────────────────────────┘

Week1_Automation.ps1 (Orchestrator)
  │
  ├─► Azure Services (26 calls) ◄────── HOT PATH #1 (95% traffic)
  │     ├─ SecureSecretsManager (4 calls)
  │     ├─ RBACManager (5 calls)
  │     ├─ CertificateAuthBridge (4 calls)
  │     ├─ CircuitBreaker (4 calls)
  │     ├─ HealthCheckAPI (5 calls)
  │     └─ Validation (4 calls)
  │
  ├─► Checkpoint Array (26 writes) ◄─── HOT PATH #2 (in-memory)
  │     └─ Add-Checkpoint (O(1) append)
  │
  ├─► CodexRenderer (2 calls) ◄────────── HOT PATH #3 (file I/O)
  │     ├─ ConvertTo-MarkdownScroll (1 call)
  │     └─ ConvertTo-HtmlScroll (1 call)
  │
  ├─► Test-CodexIntegrity (1 call) ◄──── MEDIUM PATH (validation)
  │     └─ Export-IntegrityReport
  │
  └─► IdentityAgent (1 call) ◄──────────── HOT PATH #4 (Graph API)
        └─ Send-CodexEmail
              └─► Graph API /me/sendMail ◄── EXTERNAL (429 throttling)

CI/CD Pipeline (GitHub Actions)
  │
  └─► Week1_Automation.ps1 (1 call per commit) ◄── HOT PATH #5
        └─► Triggers Hot Paths #1-4
```

---

## IV. Performance Characteristics

### **Hot Path Performance Metrics**

| Hot Path | Frequency | Latency (p50) | Latency (p99) | Throughput | Bottleneck |
|----------|-----------|---------------|---------------|------------|------------|
| #1: Orchestrator → Azure | 26/execution | 10s | 30s | 2.6 req/min | Azure API rate limits |
| #2: Checkpoint Logging | 26/execution | <1ms | 2ms | Infinite (in-memory) | Memory (52KB) |
| #3: CodexRenderer | 2/execution | 500ms | 1s | 2 scrolls/sec | File I/O |
| #4: Graph API Email | 1/execution | 2s | 5s | 1 email/min | Graph API throttling (429) |
| #5: CI/CD Pipeline | 1/commit | 8min | 12min | 1 execution/commit | Azure provisioning time |

**Total Execution Time:** ~8 minutes (dominated by Hot Path #1 Azure provisioning)

---

## V. Error Handling & Retry Strategies

### **Service-Level Retry Policies**

| Service | Retry Strategy | Max Retries | Backoff | Timeout | Fallback |
|---------|---------------|-------------|---------|---------|----------|
| **Azure Services** | Circuit Breaker | 3 | Exponential (1s, 2s, 4s) | 60s | Log failure + continue |
| **Checkpoint Logging** | N/A (in-memory) | N/A | N/A | N/A | N/A (atomic) |
| **CodexRenderer** | None (idempotent) | 0 | N/A | N/A | Overwrite file |
| **Graph API Email** | Exponential Backoff | 3 | 2s, 4s, 8s | 30s | Throw error (manual retry) |
| **CI/CD Pipeline** | GitHub Actions retry | 0 | N/A | N/A | Manual re-run |

---

## VI. Service Independence Verification

### **✅ Independent Service Criteria**

**Criterion 1: No Shared State (Except Checkpoint Array)**
- ✅ Azure services: Stateless (idempotent commands)
- ✅ CodexRenderer: Reads from file, writes to file (no shared memory)
- ✅ IdentityAgent: Reads from file, calls external API (no shared memory)
- ⚠️ Checkpoint Array: Shared in-memory state (acceptable for orchestrator pattern)

**Criterion 2: Clear Service Boundaries**
- ✅ Each service has well-defined input/output contract
- ✅ No direct function calls between services (orchestrator mediates)
- ✅ Services can be replaced with mocks for testing

**Criterion 3: Failure Isolation**
- ✅ Azure service failure → Log failure checkpoint → Continue to next task
- ✅ CodexRenderer failure → Throw error → Pipeline fails (expected behavior)
- ✅ Graph API failure → Retry with backoff → Throw after max retries
- ✅ CI/CD pipeline failure → Stop execution → Manual re-run (safe)

**Criterion 4: Independent Deployment**
- ✅ Azure services: Deployed via ARM/Bicep template (independent of orchestrator)
- ✅ CodexRenderer: PowerShell module (can be updated independently)
- ✅ IdentityAgent: PowerShell module (can be updated independently)
- ✅ CI/CD pipeline: GitHub Actions workflow (can be updated independently)

---

## VII. Next Steps: Implementation Priority

Based on this pathway analysis, here's the **optimal implementation order**:

### **Phase 1: Foundation (No External Dependencies)**
1. ✅ `Add-Checkpoint` function (in-memory logging)
2. ✅ `Export-CheckpointsToJson` function (file write)
3. ✅ `CodexRenderer.psm1` (Markdown + HTML generation)

**Why First:** No Azure dependencies, immediate visual output, testable with mock data

### **Phase 2: Azure Integration (Critical Path)**
4. ✅ `CircuitBreaker.psm1` (retry logic for Azure commands)
5. ✅ `SecureSecretsManager.psm1` (Key Vault operations)
6. ✅ `RBACManager.psm1` (Azure AD group operations)
7. ✅ `CertificateAuthBridge.psm1` (Graph API authentication)
8. ✅ `HealthCheckAPI.ps1` (Container App deployment)

**Why Second:** Blocks all Azure services, requires service principal setup

### **Phase 3: Validation & Delivery (Quality Gates)**
9. ✅ `Test-CodexIntegrity.psm1` (checkpoint validation)
10. ✅ `IdentityAgent` email functions (Graph API integration)

**Why Third:** Depends on CodexRenderer output, requires certificate authentication

### **Phase 4: Orchestration (Glue Layer)**
11. ✅ `Week1_Automation.ps1` main logic (tie all services together)
12. ✅ CI/CD pipeline integration (GitHub Actions)

**Why Last:** Depends on all other services being implemented

---

## VIII. Decision Point

**Recommended Next Action: Implement CodexRenderer.psm1 (Hot Path #3)**

**Rationale:**
- ✅ **Zero external dependencies** (pure PowerShell string manipulation)
- ✅ **Immediate visual output** (generates beautiful HTML scrolls)
- ✅ **Unblocks email delivery** (Hot Path #4 needs HTML scroll)
- ✅ **Testable with sample data** (create mock `Week1_Checkpoints.json`)
- ✅ **Core value proposition** (cryptographic lineage visualization)

**Shall I implement `CodexRenderer.psm1` now?** 🎯

Or would you prefer to:
- **A.** Start with CircuitBreaker.psm1 (retry logic for all Azure calls)
- **B.** Create sample Week1_Checkpoints.json (test data for CodexRenderer)
- **C.** Build Sprint 1 tracking board (organize all 8 modules)

Your call! 🚀
