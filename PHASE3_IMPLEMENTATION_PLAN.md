# Phase 3: Agent Implementation & Semantic Kernel Integration

## 🎯 Overview

**Phase 3** transforms stub agent functions into fully functional AI-powered agents using Microsoft Semantic Kernel, Graph API, and Azure Cognitive Services. This phase bridges the gap between orchestration scaffolding and production-ready intelligent automation.

**Status:** 🔄 **Planning** (Architecture defined, implementation pending)

---

## 📋 Phase 3 Objectives

### Primary Goals
1. **Semantic Kernel Integration**: Implement memory, planning, and skill execution
2. **Microsoft Graph API**: Connect IdentityAgent and FinanceAgent to real data
3. **Azure Cognitive Services**: Enable ModalityAgent multi-modal input processing
4. **Dynamic Queue Management**: Implement predictive component scheduling
5. **Agent Delegation**: Enable agents to spawn sub-agents for complex workflows
6. **Context Persistence**: Semantic memory across sessions and components

### Success Criteria
- ✅ Agents return real data (not stub responses)
- ✅ Semantic Kernel orchestrates multi-step workflows
- ✅ Graph API authenticated and functional
- ✅ Multi-modal inputs (voice, screen) processed successfully
- ✅ Agent memory persists across sessions
- ✅ Dynamic queue adjusts based on runtime conditions

---

## 🧠 Semantic Kernel Architecture

### What is Semantic Kernel?

**Microsoft Semantic Kernel** is an open-source SDK that orchestrates AI models, plugins (skills), and memory for intelligent application workflows.

**Key Components:**
- **Kernel**: Central orchestrator managing plugins, memory, and AI services
- **Plugins (Skills)**: Encapsulated functions that agents can invoke
- **Memory**: Semantic search over facts, context, and conversation history
- **Planners**: Generate multi-step plans to achieve complex goals
- **Connectors**: Integrate with OpenAI, Azure OpenAI, Hugging Face, etc.

**Official Docs:** https://learn.microsoft.com/en-us/semantic-kernel/overview/

---

## 🏗️ Phase 3 Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                   Semantic Kernel Core                      │
│  • Kernel: AI orchestration engine                          │
│  • Memory: Semantic search + fact storage                   │
│  • Planner: Multi-step workflow generation                  │
│  • Plugins: Skill registration and invocation               │
└────────────────────┬────────────────────────────────────────┘
                     │
        ┌────────────┴────────────┐
        │                         │
        ▼                         ▼
┌──────────────────┐    ┌──────────────────────┐
│  AI Connectors   │    │  Integration Layer   │
│  • Azure OpenAI  │    │  • Microsoft Graph   │
│  • GPT-4         │    │  • Azure Functions   │
│  • Embeddings    │    │  • Cognitive Services│
└────────┬─────────┘    └──────────┬───────────┘
         │                         │
         └────────────┬────────────┘
                      │
                      ▼
         ┌────────────────────────────┐
         │   AgentBridge.psm1         │
         │   (Enhanced with SK)       │
         │  • OrchestratorAgent       │
         │  • FinanceAgent            │
         │  • BoopasAgent             │
         │  • IdentityAgent           │
         │  • DeploymentAgent         │
         │  • ModalityAgent           │
         └────────────┬───────────────┘
                      │
                      ▼
         ┌────────────────────────────┐
         │   Orchestrator.ps1         │
         │   (Enhanced with Planning) │
         │  • Dynamic Queue Manager   │
         │  • Agent Delegation        │
         │  • Context Persistence     │
         │  • Predictive Scheduling   │
         └────────────┬───────────────┘
                      │
                      ▼
         ┌────────────────────────────┐
         │   Generated Components     │
         │   (SK-powered execution)   │
         │  • Component Skills        │
         │  • Semantic Checkpoints    │
         │  • Memory Integration      │
         └────────────────────────────┘
```

---

## 🔌 Semantic Kernel Integration Details

### 1. Kernel Initialization

**Location:** New file `IntelIntent_Seeding/SemanticKernelBridge.psm1`

**Purpose:** Initialize Semantic Kernel with Azure OpenAI, memory, and plugins.

**Implementation:**

```csharp
// C# example (PowerShell wrapper will invoke this via .NET)
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.Connectors.OpenAI;
using Microsoft.SemanticKernel.Memory;

public class IntelIntentKernel
{
    private Kernel _kernel;
    private ISemanticTextMemory _memory;
    
    public async Task InitializeAsync(string azureEndpoint, string apiKey)
    {
        // Build kernel with Azure OpenAI
        var builder = Kernel.CreateBuilder();
        builder.AddAzureOpenAIChatCompletion(
            deploymentName: "gpt-4",
            endpoint: azureEndpoint,
            apiKey: apiKey
        );
        
        // Add memory with embeddings
        builder.AddAzureOpenAITextEmbeddingGeneration(
            deploymentName: "text-embedding-ada-002",
            endpoint: azureEndpoint,
            apiKey: apiKey
        );
        
        _kernel = builder.Build();
        
        // Initialize memory store
        var memoryBuilder = new MemoryBuilder();
        memoryBuilder.WithAzureOpenAITextEmbeddingGeneration(
            deploymentName: "text-embedding-ada-002",
            endpoint: azureEndpoint,
            apiKey: apiKey
        );
        memoryBuilder.WithMemoryStore(new VolatileMemoryStore());
        _memory = memoryBuilder.Build();
    }
    
    public async Task<string> InvokeAgentAsync(string agentName, string intent, Dictionary<string, string> context)
    {
        // Load agent plugin
        var plugin = _kernel.ImportPluginFromType<AgentPlugin>();
        
        // Create function arguments
        var arguments = new KernelArguments();
        arguments["agent"] = agentName;
        arguments["intent"] = intent;
        foreach (var kvp in context)
        {
            arguments[kvp.Key] = kvp.Value;
        }
        
        // Invoke with planner for multi-step workflows
        var planner = new FunctionCallingStepwisePlanner();
        var result = await planner.ExecuteAsync(_kernel, intent, arguments);
        
        return result.FinalAnswer;
    }
    
    public async Task SaveMemoryAsync(string collection, string key, string text, Dictionary<string, string> metadata)
    {
        await _memory.SaveInformationAsync(
            collection: collection,
            text: text,
            id: key,
            description: metadata.GetValueOrDefault("description", ""),
            additionalMetadata: string.Join(";", metadata.Select(m => $"{m.Key}={m.Value}"))
        );
    }
    
    public async Task<IEnumerable<MemoryQueryResult>> SearchMemoryAsync(string collection, string query, int limit = 5)
    {
        return await _memory.SearchAsync(collection, query, limit: limit);
    }
}
```

**PowerShell Wrapper:**

```powershell
# SemanticKernelBridge.psm1

Add-Type -Path "Microsoft.SemanticKernel.dll"
Add-Type -Path "IntelIntentKernel.dll"

$script:KernelInstance = $null

function Initialize-SemanticKernel {
    param(
        [Parameter(Mandatory=$true)]
        [string]$AzureEndpoint,
        
        [Parameter(Mandatory=$true)]
        [string]$ApiKey
    )
    
    try {
        $script:KernelInstance = [IntelIntentKernel]::new()
        $script:KernelInstance.InitializeAsync($AzureEndpoint, $ApiKey).Wait()
        Write-Output "✅ Semantic Kernel initialized"
        return $true
    }
    catch {
        Write-Error "❌ Failed to initialize Semantic Kernel: $_"
        return $false
    }
}

function Invoke-SemanticAgent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$AgentName,
        
        [Parameter(Mandatory=$true)]
        [string]$Intent,
        
        [hashtable]$Context = @{}
    )
    
    if (-not $script:KernelInstance) {
        throw "Semantic Kernel not initialized. Call Initialize-SemanticKernel first."
    }
    
    $contextDict = New-Object 'System.Collections.Generic.Dictionary[string,string]'
    foreach ($key in $Context.Keys) {
        $contextDict.Add($key, $Context[$key].ToString())
    }
    
    $result = $script:KernelInstance.InvokeAgentAsync($AgentName, $Intent, $contextDict).Result
    return $result
}

function Save-SemanticMemory {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Collection,
        
        [Parameter(Mandatory=$true)]
        [string]$Key,
        
        [Parameter(Mandatory=$true)]
        [string]$Text,
        
        [hashtable]$Metadata = @{}
    )
    
    $metadataDict = New-Object 'System.Collections.Generic.Dictionary[string,string]'
    foreach ($k in $Metadata.Keys) {
        $metadataDict.Add($k, $Metadata[$k].ToString())
    }
    
    $script:KernelInstance.SaveMemoryAsync($Collection, $Key, $Text, $metadataDict).Wait()
    Write-Output "💾 Memory saved: $Collection/$Key"
}

function Search-SemanticMemory {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Collection,
        
        [Parameter(Mandatory=$true)]
        [string]$Query,
        
        [int]$Limit = 5
    )
    
    $results = $script:KernelInstance.SearchMemoryAsync($Collection, $Query, $Limit).Result
    return $results
}

Export-ModuleMember -Function @(
    'Initialize-SemanticKernel',
    'Invoke-SemanticAgent',
    'Save-SemanticMemory',
    'Search-SemanticMemory'
)
```

---

### 2. Agent Plugin Architecture

**Plugins** encapsulate agent capabilities as reusable skills that Semantic Kernel can orchestrate.

**Example: FinanceAgent Plugin**

```csharp
using Microsoft.SemanticKernel;
using System.ComponentModel;

public class FinanceAgentPlugin
{
    private readonly IGraphServiceClient _graphClient;
    
    public FinanceAgentPlugin(IGraphServiceClient graphClient)
    {
        _graphClient = graphClient;
    }
    
    [KernelFunction, Description("Get user's investment portfolio holdings")]
    public async Task<string> GetPortfolioHoldingsAsync(
        [Description("User ID")] string userId)
    {
        // Query Microsoft Graph or custom API
        var holdings = await FetchPortfolioDataAsync(userId);
        return JsonSerializer.Serialize(holdings);
    }
    
    [KernelFunction, Description("Generate investment dashboard for user")]
    public async Task<string> GenerateDashboardAsync(
        [Description("User ID")] string userId,
        [Description("Dashboard type")] string dashboardType)
    {
        var data = await FetchFinancialDataAsync(userId);
        var dashboard = BuildDashboard(data, dashboardType);
        return dashboard.ToJson();
    }
    
    [KernelFunction, Description("Set market event trigger for alerts")]
    public async Task<string> SetMarketTriggerAsync(
        [Description("Stock symbol")] string symbol,
        [Description("Trigger condition")] string condition,
        [Description("Threshold value")] decimal threshold)
    {
        var trigger = new MarketTrigger
        {
            Symbol = symbol,
            Condition = condition,
            Threshold = threshold,
            CreatedAt = DateTime.UtcNow
        };
        
        await SaveTriggerAsync(trigger);
        return $"Market trigger set: {symbol} {condition} {threshold}";
    }
}
```

**PowerShell Integration:**

```powershell
# Enhanced FinanceAgent with Semantic Kernel
function Invoke-FinanceAgent {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("Dashboard", "Portfolio", "MarketEvent", "Optimization")]
        [string]$Operation,
        
        [hashtable]$Data = @{}
    )
    
    Write-Output "💰 FinanceAgent: Processing $Operation operation"
    
    # Use Semantic Kernel for intelligent execution
    $intent = "Execute finance operation: $Operation with data: $($Data | ConvertTo-Json -Compress)"
    
    try {
        $result = Invoke-SemanticAgent -AgentName "FinanceAgent" -Intent $intent -Context $Data
        
        # Save to semantic memory for future reference
        Save-SemanticMemory -Collection "FinanceOperations" `
                            -Key "$(Get-Date -Format 'yyyyMMddHHmmss')_$Operation" `
                            -Text $result `
                            -Metadata @{
                                Operation = $Operation
                                UserID = $Data.UserID
                                Timestamp = Get-Date -Format "o"
                            }
        
        return @{
            Status = "Success"
            Agent = "Finance"
            Operation = $Operation
            Result = $result
            Message = "Operation completed successfully"
        }
    }
    catch {
        Write-Error "❌ FinanceAgent error: $_"
        return @{
            Status = "Error"
            Agent = "Finance"
            Operation = $Operation
            Error = $_.Exception.Message
        }
    }
}
```

---

### 3. Memory Integration

**Semantic Memory** enables agents to remember facts, context, and history across sessions.

**Use Cases:**
- **Component History**: Remember which components were generated and when
- **Agent Interactions**: Track previous agent calls and outcomes
- **User Context**: Store user preferences, settings, and workflows
- **Dependency Tracking**: Semantic search for related components

**Implementation:**

```powershell
# Save component generation to memory
function Save-ComponentMemory {
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$Component
    )
    
    $text = @"
Component ID: $($Component.ID)
Title: $($Component.Title)
Category: $($Component.Category)
Priority: $($Component.Priority)
Status: $($Component.Status)
Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
"@
    
    Save-SemanticMemory -Collection "Components" `
                        -Key $Component.ID `
                        -Text $text `
                        -Metadata @{
                            Category = $Component.Category
                            Priority = $Component.Priority
                            Status = $Component.Status
                        }
}

# Search for related components
function Find-RelatedComponents {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Query,
        
        [int]$Limit = 5
    )
    
    $results = Search-SemanticMemory -Collection "Components" -Query $Query -Limit $Limit
    
    return $results | ForEach-Object {
        @{
            ComponentID = $_.Metadata.Id
            Relevance = $_.Relevance
            Text = $_.Text
        }
    }
}
```

---

### 4. Planner Integration

**Planners** generate multi-step execution plans to achieve complex goals.

**Types:**
- **Sequential Planner**: Linear step-by-step execution
- **Function Calling Planner**: Adaptive function selection
- **Stepwise Planner**: Interactive, iterative planning

**Example: Dynamic Component Generation Plan**

```csharp
public async Task<Plan> GenerateComponentPlanAsync(string manifestPath)
{
    var planner = new FunctionCallingStepwisePlanner();
    
    var goal = $"Generate all components from manifest at {manifestPath} with dependency-aware ordering";
    
    var plan = await planner.CreatePlanAsync(_kernel, goal);
    
    // Plan might include steps like:
    // 1. Load manifest from file
    // 2. Parse JSON and validate structure
    // 3. Build dependency graph
    // 4. Sort by priority
    // 5. For each component:
    //    a. Check dependencies
    //    b. Generate component file
    //    c. Create checkpoint
    //    d. Validate execution
    
    return plan;
}
```

**PowerShell Integration:**

```powershell
function Invoke-SemanticPlan {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Goal,
        
        [hashtable]$Context = @{}
    )
    
    Write-Output "🧠 Generating execution plan for: $Goal"
    
    $result = Invoke-SemanticAgent -AgentName "Planner" -Intent $Goal -Context $Context
    
    # Parse plan steps
    $plan = $result | ConvertFrom-Json
    
    Write-Output "📋 Plan generated with $($plan.Steps.Count) steps:"
    foreach ($step in $plan.Steps) {
        Write-Output "  $($step.StepNumber). $($step.Description)"
    }
    
    return $plan
}
```

---

## 🔗 Microsoft Graph API Integration

### Purpose
Connect IdentityAgent and FinanceAgent to real Microsoft 365 data:
- **Users**: Entra ID profiles, groups, authentication
- **Mail**: Email orchestration, inbox rules, calendar
- **Calendar**: Meeting scheduling, event triggers
- **OneDrive**: File access for ModalityAgent
- **Teams**: Collaboration workflows

### Authentication

**Azure App Registration:**
1. Register app in Azure Portal
2. Configure API permissions (User.Read, Mail.Send, Calendars.ReadWrite, etc.)
3. Create client secret
4. Note Application (client) ID and Tenant ID

**PowerShell Authentication:**

```powershell
# GraphAuthBridge.psm1

function Connect-IntelIntentGraph {
    param(
        [Parameter(Mandatory=$true)]
        [string]$TenantId,
        
        [Parameter(Mandatory=$true)]
        [string]$ClientId,
        
        [Parameter(Mandatory=$true)]
        [string]$ClientSecret
    )
    
    $body = @{
        grant_type    = "client_credentials"
        client_id     = $ClientId
        client_secret = $ClientSecret
        scope         = "https://graph.microsoft.com/.default"
    }
    
    $tokenResponse = Invoke-RestMethod -Method Post -Uri "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token" -Body $body
    
    $script:GraphToken = $tokenResponse.access_token
    Write-Output "✅ Connected to Microsoft Graph"
    
    return $script:GraphToken
}

function Invoke-GraphRequest {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Uri,
        
        [string]$Method = "GET",
        
        [hashtable]$Body = $null
    )
    
    if (-not $script:GraphToken) {
        throw "Not authenticated. Call Connect-IntelIntentGraph first."
    }
    
    $headers = @{
        Authorization = "Bearer $script:GraphToken"
        "Content-Type" = "application/json"
    }
    
    $params = @{
        Method = $Method
        Uri = $Uri
        Headers = $headers
    }
    
    if ($Body) {
        $params.Body = ($Body | ConvertTo-Json -Depth 10)
    }
    
    try {
        $response = Invoke-RestMethod @params
        return $response
    }
    catch {
        Write-Error "❌ Graph API error: $_"
        throw
    }
}

Export-ModuleMember -Function @(
    'Connect-IntelIntentGraph',
    'Invoke-GraphRequest'
)
```

### IdentityAgent Enhancement

```powershell
function Invoke-IdentityAgent {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("EmailOrchestration", "AccessControl", "MFA", "Governance")]
        [string]$Operation,
        
        [Parameter(Mandatory=$true)]
        [string]$UserEmail,
        
        [hashtable]$Data = @{}
    )
    
    Write-Output "🔐 IdentityAgent: $Operation for $UserEmail"
    
    switch ($Operation) {
        "EmailOrchestration" {
            # Send email via Graph API
            $mailBody = @{
                message = @{
                    subject = $Data.Subject
                    body = @{
                        contentType = "HTML"
                        content = $Data.Body
                    }
                    toRecipients = @(
                        @{
                            emailAddress = @{
                                address = $UserEmail
                            }
                        }
                    )
                }
                saveToSentItems = "true"
            }
            
            $result = Invoke-GraphRequest -Uri "https://graph.microsoft.com/v1.0/me/sendMail" `
                                          -Method POST `
                                          -Body $mailBody
            
            return @{
                Status = "Success"
                Agent = "Identity"
                Operation = $Operation
                Message = "Email sent to $UserEmail"
            }
        }
        
        "AccessControl" {
            # Query Entra ID for user permissions
            $user = Invoke-GraphRequest -Uri "https://graph.microsoft.com/v1.0/users/$UserEmail"
            $groups = Invoke-GraphRequest -Uri "https://graph.microsoft.com/v1.0/users/$($user.id)/memberOf"
            
            return @{
                Status = "Success"
                Agent = "Identity"
                Operation = $Operation
                User = $user
                Groups = $groups.value
            }
        }
        
        # Additional operations...
    }
}
```

---

## 🎙️ Azure Cognitive Services Integration

### Purpose
Enable ModalityAgent to process multi-modal inputs:
- **Speech-to-Text**: Voice command transcription
- **Text-to-Speech**: Audible agent responses
- **Computer Vision**: Screen capture analysis, OCR
- **Form Recognizer**: Document processing

### Speech Service Integration

```powershell
# CognitiveServicesBridge.psm1

function Invoke-SpeechToText {
    param(
        [Parameter(Mandatory=$true)]
        [string]$AudioFilePath,
        
        [string]$Language = "en-US"
    )
    
    $subscriptionKey = $env:AZURE_SPEECH_KEY
    $region = $env:AZURE_SPEECH_REGION
    
    $headers = @{
        "Ocp-Apim-Subscription-Key" = $subscriptionKey
        "Content-Type" = "audio/wav"
    }
    
    $audioBytes = [System.IO.File]::ReadAllBytes($AudioFilePath)
    
    $uri = "https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?language=$Language"
    
    $response = Invoke-RestMethod -Method Post -Uri $uri -Headers $headers -Body $audioBytes
    
    return $response.DisplayText
}

function Invoke-TextToSpeech {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Text,
        
        [string]$Voice = "en-US-JennyNeural",
        
        [string]$OutputPath = ".\output.wav"
    )
    
    $subscriptionKey = $env:AZURE_SPEECH_KEY
    $region = $env:AZURE_SPEECH_REGION
    
    $ssml = @"
<speak version='1.0' xml:lang='en-US'>
    <voice name='$Voice'>
        $Text
    </voice>
</speak>
"@
    
    $headers = @{
        "Ocp-Apim-Subscription-Key" = $subscriptionKey
        "Content-Type" = "application/ssml+xml"
        "X-Microsoft-OutputFormat" = "audio-16khz-32kbitrate-mono-mp3"
    }
    
    $uri = "https://$region.tts.speech.microsoft.com/cognitiveservices/v1"
    
    $audioBytes = Invoke-RestMethod -Method Post -Uri $uri -Headers $headers -Body $ssml
    [System.IO.File]::WriteAllBytes($OutputPath, $audioBytes)
    
    Write-Output "🔊 Speech generated: $OutputPath"
}
```

### ModalityAgent Enhancement

```powershell
function Invoke-ModalityAgent {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("Voice", "Audio", "Screen", "Webcam", "File")]
        [string]$InputType,
        
        [Parameter(Mandatory=$true)]
        [object]$InputData,
        
        [hashtable]$Options = @{}
    )
    
    Write-Output "🎙️ ModalityAgent: Processing $InputType input"
    
    switch ($InputType) {
        "Voice" {
            # Transcribe voice input
            $transcription = Invoke-SpeechToText -AudioFilePath $InputData -Language "en-US"
            
            # Process transcription with Semantic Kernel
            $intent = Invoke-SemanticAgent -AgentName "OrchestratorAgent" `
                                           -Intent $transcription `
                                           -Context @{InputType = "Voice"}
            
            # Generate voice response
            $responsePath = ".\Temp\response_$(Get-Date -Format 'yyyyMMddHHmmss').wav"
            Invoke-TextToSpeech -Text $intent.Response -OutputPath $responsePath
            
            return @{
                Status = "Success"
                Agent = "Modality"
                InputType = $InputType
                Transcription = $transcription
                Intent = $intent
                ResponseAudio = $responsePath
            }
        }
        
        "Screen" {
            # Capture screen and analyze with Computer Vision
            $screenshotPath = Capture-Screen
            $analysis = Invoke-ComputerVision -ImagePath $screenshotPath
            
            return @{
                Status = "Success"
                Agent = "Modality"
                InputType = $InputType
                ScreenshotPath = $screenshotPath
                Analysis = $analysis
            }
        }
        
        # Additional modalities...
    }
}
```

---

## 🔄 Dynamic Queue Management

### Purpose
Adjust component execution order at runtime based on:
- Agent feedback and failures
- Dependency resolution
- Resource availability
- Priority changes

### Implementation

```powershell
# Enhanced Orchestrator.ps1 with dynamic queue

function Build-DynamicQueue {
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$Manifests,
        
        [string]$FilterCategory = ""
    )
    
    Write-Output "🎯 Building dynamic execution queue..."
    
    # Initial queue from manifests
    $queue = Get-ComponentQueue -Manifests $Manifests -FilterCategory $FilterCategory
    
    # Search semantic memory for context
    $memoryResults = Search-SemanticMemory -Collection "Components" -Query "failed components" -Limit 10
    
    # Boost priority of previously failed components
    foreach ($result in $memoryResults) {
        $componentId = $result.Metadata.Id
        $match = $queue | Where-Object { $_.ID -eq $componentId }
        if ($match) {
            $match.Priority -= 5  # Increase priority (lower number)
            Write-Output "  ⚡ Priority boost: $componentId (previous failure)"
        }
    }
    
    # Re-sort by updated priorities
    $queue = $queue | Sort-Object Priority
    
    # Save queue state to memory
    $queueText = "Execution queue generated with $($queue.Count) components. Priorities: $($queue | ForEach-Object { "$($_.ID):$($_.Priority)" } | Join-String -Separator ', ')"
    Save-SemanticMemory -Collection "Orchestration" `
                        -Key "queue_$(Get-Date -Format 'yyyyMMddHHmmss')" `
                        -Text $queueText `
                        -Metadata @{
                            ComponentCount = $queue.Count
                            Timestamp = Get-Date -Format "o"
                        }
    
    Write-Output "  ✅ Dynamic queue built: $($queue.Count) components"
    
    return $queue
}

function Update-QueueAtRuntime {
    param(
        [Parameter(Mandatory=$true)]
        [array]$Queue,
        
        [Parameter(Mandatory=$true)]
        [string]$CompletedComponentID
    )
    
    # Remove completed component
    $Queue = $Queue | Where-Object { $_.ID -ne $CompletedComponentID }
    
    # Check if newly unblocked components can be promoted
    $unblocked = $Queue | Where-Object {
        $dependencies = $_.Dependencies
        $allMet = $true
        foreach ($dep in $dependencies) {
            $depCheckpoint = ".\$($_.Category)\Recursive_Operations\$dep`_checkpoint.txt"
            if (-not (Test-Path $depCheckpoint)) {
                $allMet = $false
                break
            }
        }
        return $allMet
    }
    
    # Promote unblocked components
    foreach ($component in $unblocked) {
        $component.Priority -= 2  # Slight priority boost
        Write-Output "  🔓 Unblocked: $($component.ID)"
    }
    
    # Re-sort
    $Queue = $Queue | Sort-Object Priority
    
    return $Queue
}
```

---

## 🤝 Agent Delegation

### Purpose
Enable agents to spawn sub-agents for complex multi-step workflows.

**Example Workflow:**
1. User: "Generate investment report and email it to stakeholders"
2. OrchestratorAgent: Route to FinanceAgent
3. FinanceAgent: Generate report → Delegate to IdentityAgent to send email
4. IdentityAgent: Send email with report attachment
5. Feedback: Confirm email sent

### Implementation

```powershell
function Invoke-AgentDelegation {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ParentAgent,
        
        [Parameter(Mandatory=$true)]
        [string]$ChildAgent,
        
        [Parameter(Mandatory=$true)]
        [string]$Task,
        
        [hashtable]$Context = @{}
    )
    
    Write-Output "🔀 $ParentAgent delegating to $ChildAgent: $Task"
    
    # Log delegation in semantic memory
    Save-SemanticMemory -Collection "AgentDelegation" `
                        -Key "$(Get-Date -Format 'yyyyMMddHHmmss')_$ParentAgent`_to_$ChildAgent" `
                        -Text "Parent: $ParentAgent | Child: $ChildAgent | Task: $Task" `
                        -Metadata @{
                            ParentAgent = $ParentAgent
                            ChildAgent = $ChildAgent
                            Timestamp = Get-Date -Format "o"
                        }
    
    # Invoke child agent via Semantic Kernel
    $result = Invoke-SemanticAgent -AgentName $ChildAgent -Intent $Task -Context $Context
    
    Write-Output "  ✅ Delegation complete: $ChildAgent → $ParentAgent"
    
    return $result
}
```

---

## 📊 Phase 3 Implementation Roadmap

### Week 1: Semantic Kernel Foundation
- [ ] Install Semantic Kernel NuGet packages
- [ ] Create `SemanticKernelBridge.psm1` with initialization
- [ ] Implement kernel configuration with Azure OpenAI
- [ ] Test basic plugin invocation
- [ ] Implement memory save/search functions

### Week 2: Agent Plugin Development
- [ ] Convert FinanceAgent to SK plugin (C#)
- [ ] Convert IdentityAgent to SK plugin (C#)
- [ ] Convert DeploymentAgent to SK plugin (C#)
- [ ] Compile plugins into DLL
- [ ] Test plugin registration in kernel

### Week 3: Microsoft Graph Integration
- [ ] Create Azure App Registration
- [ ] Implement `GraphAuthBridge.psm1`
- [ ] Test authentication flow
- [ ] Enhance IdentityAgent with real Graph calls
- [ ] Test email sending, user queries

### Week 4: Cognitive Services Integration
- [ ] Create `CognitiveServicesBridge.psm1`
- [ ] Implement speech-to-text function
- [ ] Implement text-to-speech function
- [ ] Enhance ModalityAgent with voice processing
- [ ] Test end-to-end voice workflow

### Week 5: Dynamic Queue & Planning
- [ ] Enhance `Orchestrator.ps1` with dynamic queue
- [ ] Implement planner integration
- [ ] Test priority adjustments at runtime
- [ ] Implement agent delegation logic
- [ ] Test multi-agent workflows

### Week 6: Testing & Documentation
- [ ] End-to-end integration testing
- [ ] Performance benchmarking
- [ ] Update `README_PHASE3.md`
- [ ] Create video demos
- [ ] Deploy to production environment

---

## 🧪 Testing Strategy

### Unit Tests
- Semantic Kernel initialization
- Plugin registration and invocation
- Memory save/search operations
- Graph API authentication

### Integration Tests
- Agent-to-agent delegation
- Multi-step planner execution
- Dynamic queue adjustments
- Checkpoint creation with SK context

### End-to-End Tests
- Voice command → transcription → agent routing → execution → voice response
- Manifest loading → planning → component generation → validation
- User email → identity lookup → access control → email response

---

## 📦 Dependencies & Prerequisites

### NuGet Packages
```xml
<PackageReference Include="Microsoft.SemanticKernel" Version="1.0.0" />
<PackageReference Include="Microsoft.SemanticKernel.Connectors.OpenAI" Version="1.0.0" />
<PackageReference Include="Microsoft.SemanticKernel.Plugins.Core" Version="1.0.0-alpha" />
<PackageReference Include="Microsoft.Graph" Version="5.0.0" />
<PackageReference Include="Azure.AI.OpenAI" Version="1.0.0-beta.12" />
```

### Environment Variables
```powershell
$env:AZURE_OPENAI_ENDPOINT = "https://<your-resource>.openai.azure.com/"
$env:AZURE_OPENAI_API_KEY = "<your-api-key>"
$env:AZURE_SPEECH_KEY = "<your-speech-key>"
$env:AZURE_SPEECH_REGION = "<your-region>"
$env:GRAPH_TENANT_ID = "<your-tenant-id>"
$env:GRAPH_CLIENT_ID = "<your-client-id>"
$env:GRAPH_CLIENT_SECRET = "<your-client-secret>"
```

### Azure Resources
- **Azure OpenAI Service**: GPT-4 and text-embedding-ada-002 deployments
- **Azure Cognitive Services**: Speech service for voice processing
- **Azure App Registration**: Microsoft Graph API access
- **Azure Storage**: Optional for persistent memory store

---

## 📚 Additional Resources

### Official Documentation
- [Semantic Kernel Docs](https://learn.microsoft.com/en-us/semantic-kernel/overview/)
- [Microsoft Graph API Reference](https://learn.microsoft.com/en-us/graph/api/overview)
- [Azure OpenAI Service](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/)
- [Azure Speech Service](https://learn.microsoft.com/en-us/azure/cognitive-services/speech-service/)

### Code Samples
- [Semantic Kernel Samples (GitHub)](https://github.com/microsoft/semantic-kernel/tree/main/samples)
- [Graph API Quick Start](https://developer.microsoft.com/en-us/graph/quick-start)
- [Azure OpenAI Examples](https://github.com/Azure-Samples/openai)

---

## 🎯 Success Metrics

**Phase 3 Complete When:**
- ✅ All 6 agents return real data (not stubs)
- ✅ Semantic Kernel orchestrates 3+ step workflows
- ✅ Graph API successfully sends emails and queries users
- ✅ Voice commands transcribed and executed end-to-end
- ✅ Agent memory persists across 10+ sessions
- ✅ Dynamic queue adjusts based on 5+ failure scenarios
- ✅ 90%+ test coverage for SK integrations

---

## 🎨 Composite Mandala Integration

### Mapping Phase 3 to Mandala Layers

**IntelIntent Phase 3** aligns directly with the Composite Mandala overlay architecture:

| Mandala Layer | Phase 3 Component | Purpose |
|---------------|-------------------|---------|
| **Issues** | Recovery Manager | Drift detection, predictive recovery, mitigation templates |
| **Pull Requests** | Delegation Queue | Task merging, agent routing, workstream consolidation |
| **Sponsors** | IdentityAgent + Graph | Stakeholder communications via Teams/Email |
| **ACT (Active Context Tracker)** | Semantic Kernel Skills | Real-time skill activation and context binding |
| **Codex Scroll** | Lineage Renderer | Transform checkpoints into sponsor-facing audit trails |

---

### Codex Scroll Rendering

**Purpose:** Transform JSON checkpoints into human-readable, lineage-preserving scroll fragments for sponsor walkthroughs.

**Implementation:**

```powershell
# CodexRenderer.psm1

function New-CodexFragment {
    <#
    .SYNOPSIS
        Renders a checkpoint as a codex scroll fragment.
    
    .PARAMETER CheckpointPath
        Path to checkpoint JSON file.
    
    .PARAMETER OutputFormat
        Format: "Markdown", "HTML", "JSON"
    
    .EXAMPLE
        New-CodexFragment -CheckpointPath ".\checkpoints\T1.json" -OutputFormat "Markdown"
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$CheckpointPath,
        
        [ValidateSet("Markdown", "HTML", "JSON")]
        [string]$OutputFormat = "Markdown"
    )
    
    $checkpoint = Get-Content $CheckpointPath | ConvertFrom-Json
    
    $fragment = @{
        TaskID = $checkpoint.id
        Timestamp = $checkpoint.at
        Inputs = $checkpoint.in
        Outputs = $checkpoint.out
        Signature = $checkpoint.sig
        Status = if ($checkpoint.out.status -eq "ok") { "✅ Success" } else { "⚠️ Warning" }
    }
    
    switch ($OutputFormat) {
        "Markdown" {
            $markdown = @"
### Task: $($fragment.TaskID)

**Timestamp:** $($fragment.Timestamp)  
**Status:** $($fragment.Status)  
**Signature:** ``$($fragment.Signature)``

#### Inputs
``````json
$($fragment.Inputs | ConvertTo-Json -Depth 5)
``````

#### Outputs
``````json
$($fragment.Outputs | ConvertTo-Json -Depth 5)
``````

---
"@
            return $markdown
        }
        
        "HTML" {
            $html = @"
<div class="codex-fragment" id="$($fragment.TaskID)">
    <h3>Task: $($fragment.TaskID)</h3>
    <p><strong>Timestamp:</strong> $($fragment.Timestamp)</p>
    <p><strong>Status:</strong> $($fragment.Status)</p>
    <p><strong>Signature:</strong> <code>$($fragment.Signature)</code></p>
    <details>
        <summary>Inputs</summary>
        <pre>$($fragment.Inputs | ConvertTo-Json -Depth 5)</pre>
    </details>
    <details>
        <summary>Outputs</summary>
        <pre>$($fragment.Outputs | ConvertTo-Json -Depth 5)</pre>
    </details>
</div>
"@
            return $html
        }
        
        "JSON" {
            return $fragment | ConvertTo-Json -Depth 10
        }
    }
}

function New-CodexScroll {
    <#
    .SYNOPSIS
        Consolidates all checkpoints into a complete codex scroll.
    
    .PARAMETER CheckpointDir
        Directory containing checkpoint JSON files.
    
    .PARAMETER OutputPath
        Path for generated scroll (e.g., "codex_scroll.md").
    
    .PARAMETER Format
        Output format: "Markdown", "HTML"
    
    .EXAMPLE
        New-CodexScroll -CheckpointDir ".\checkpoints" -OutputPath ".\codex_scroll.md" -Format "Markdown"
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$CheckpointDir,
        
        [Parameter(Mandatory=$true)]
        [string]$OutputPath,
        
        [ValidateSet("Markdown", "HTML")]
        [string]$Format = "Markdown"
    )
    
    $checkpoints = Get-ChildItem -Path $CheckpointDir -Filter "*.json" | Sort-Object Name
    
    $header = if ($Format -eq "Markdown") {
        @"
# IntelIntent Codex Scroll
**Generated:** $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")  
**Checkpoints:** $($checkpoints.Count)  
**Session:** $((Get-Content "$CheckpointDir\orchestrator_checkpoint.json" -ErrorAction SilentlyContinue | ConvertFrom-Json).SessionID)

---

"@
    } else {
        @"
<!DOCTYPE html>
<html>
<head>
    <title>IntelIntent Codex Scroll</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 2em; }
        .codex-fragment { border: 1px solid #ddd; padding: 1em; margin: 1em 0; border-radius: 5px; }
        h3 { color: #0078d4; }
        code { background: #f4f4f4; padding: 2px 4px; border-radius: 3px; }
        details { margin: 0.5em 0; }
        pre { background: #f4f4f4; padding: 1em; border-radius: 5px; overflow-x: auto; }
    </style>
</head>
<body>
    <h1>IntelIntent Codex Scroll</h1>
    <p><strong>Generated:</strong> $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")</p>
    <p><strong>Checkpoints:</strong> $($checkpoints.Count)</p>
    <hr>
"@
    }
    
    $fragments = foreach ($cp in $checkpoints) {
        New-CodexFragment -CheckpointPath $cp.FullName -OutputFormat $Format
    }
    
    $footer = if ($Format -eq "HTML") { "</body></html>" } else { "" }
    
    $scroll = $header + ($fragments -join "`n") + $footer
    
    Set-Content -Path $OutputPath -Value $scroll
    Write-Output "📜 Codex scroll generated: $OutputPath"
}

Export-ModuleMember -Function @(
    'New-CodexFragment',
    'New-CodexScroll'
)
```

---

### Sponsor-Facing Workflow

**Use Case:** Executive wants to review orchestration run without reading JSON checkpoints.

**Workflow:**
1. Orchestrator completes Phase 3 execution
2. Checkpoints saved to `checkpoints/` directory
3. Render codex scroll: `New-CodexScroll -CheckpointDir ".\checkpoints" -OutputPath ".\sponsor_report.md" -Format "Markdown"`
4. Share `sponsor_report.md` via Teams/Email using IdentityAgent
5. Sponsors trace lineage: Task → Inputs → Outputs → Signature

**Example Rendered Fragment:**

```markdown
### Task: T1

**Timestamp:** 2025-11-26T14:35:22Z  
**Status:** ✅ Success  
**Signature:** `a7b3c2d1e4f56789abcdef1234567890...`

#### Inputs
```json
{
  "channel": "sponsor-updates",
  "text": "Phase 3 orchestration completed successfully"
}
```

#### Outputs
```json
{
  "status": "ok",
  "messageId": "19:a1b2c3d4e5f6@thread.tacv2",
  "timestamp": "2025-11-26T14:35:25Z"
}
```

---
```

---

## 📋 Quick Start (Phase 3)

### Prerequisites

**Software:**
- PowerShell 7.0+
- .NET 8.0 SDK
- Visual Studio 2022 or VS Code with C# extension

**Azure Resources:**
- Azure OpenAI Service with deployments:
  - `gpt-4` (chat completion)
  - `text-embedding-ada-002` (embeddings)
- Azure Cognitive Services (Speech)
- Azure App Registration with Graph API permissions:
  - `User.Read`
  - `Mail.Send`
  - `ChannelMessage.Send`
  - `Files.ReadWrite.All`

**Environment Variables:**
```powershell
# Azure OpenAI
$env:AZURE_OPENAI_ENDPOINT = "https://<your-resource>.openai.azure.com/"
$env:AZURE_OPENAI_API_KEY = "<your-api-key>"

# Azure Speech
$env:AZURE_SPEECH_KEY = "<your-speech-key>"
$env:AZURE_SPEECH_REGION = "<your-region>"

# Microsoft Graph
$env:GRAPH_TENANT_ID = "<your-tenant-id>"
$env:GRAPH_CLIENT_ID = "<your-client-id>"
$env:GRAPH_CLIENT_SECRET = "<your-client-secret>"
```

---

### Installation

**Step 1: Install Semantic Kernel NuGet Packages**

```bash
# Create C# project for plugins
dotnet new classlib -n IntelIntent.Plugins
cd IntelIntent.Plugins

# Add Semantic Kernel packages
dotnet add package Microsoft.SemanticKernel --version 1.0.0
dotnet add package Microsoft.SemanticKernel.Connectors.OpenAI --version 1.0.0
dotnet add package Microsoft.Graph --version 5.0.0

# Build DLL
dotnet build -c Release
```

**Step 2: Copy DLLs to IntelIntent_Seeding**

```powershell
Copy-Item ".\IntelIntent.Plugins\bin\Release\net8.0\*.dll" -Destination ".\IntelIntent_Seeding\" -Force
```

**Step 3: Create PowerShell Bridge Modules**

```powershell
# Files already created in Phase 3:
# - SemanticKernelBridge.psm1
# - GraphAuthBridge.psm1
# - CognitiveServicesBridge.psm1
# - CodexRenderer.psm1

# Verify files exist
Get-ChildItem -Path ".\IntelIntent_Seeding\" -Filter "*Bridge.psm1"
Get-ChildItem -Path ".\IntelIntent_Seeding\" -Filter "CodexRenderer.psm1"
```

---

### Initialization

**Initialize Semantic Kernel:**

```powershell
# Import Phase 3 modules
Import-Module .\IntelIntent_Seeding\SemanticKernelBridge.psm1 -Force
Import-Module .\IntelIntent_Seeding\GraphAuthBridge.psm1 -Force
Import-Module .\IntelIntent_Seeding\CodexRenderer.psm1 -Force

# Initialize Semantic Kernel with Azure OpenAI
$initResult = Initialize-SemanticKernel -AzureEndpoint $env:AZURE_OPENAI_ENDPOINT `
                                         -ApiKey $env:AZURE_OPENAI_API_KEY

if ($initResult) {
    Write-Output "✅ Semantic Kernel ready"
} else {
    Write-Error "❌ Semantic Kernel initialization failed"
    exit 1
}

# Connect to Microsoft Graph
$graphToken = Connect-IntelIntentGraph -TenantId $env:GRAPH_TENANT_ID `
                                        -ClientId $env:GRAPH_CLIENT_ID `
                                        -ClientSecret $env:GRAPH_CLIENT_SECRET

Write-Output "✅ Microsoft Graph connected"
```

---

### Start Adaptive Orchestration

**Execute Phase 3 Pipeline:**

```powershell
# Run enhanced orchestrator with Semantic Kernel
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode Full -Verbose

# Expected output:
# ═══════════════════════════════════════════════════════════════
#   IntelIntent Orchestrator - Phase 3 (Semantic Kernel Active)
#   Session ID: a7b3c2d1-e4f5-6789-abcd-ef1234567890
#   Mode: Full
# ═══════════════════════════════════════════════════════════════
# 
# 🧠 Generating execution plan with Semantic Kernel...
# 📋 Plan generated with 16 steps
# 
# [1/16] Generating: Environment Variable Configuration
#   🤖 Invoking SemanticAgent: OrchestratorAgent
#   💾 Memory saved: Components/ENV-001
#   ✅ Generated: .\Environment_Setup\ENV-001_component.ps1
# 
# [2/16] Generating: PowerShell Module Path Setup
#   🔓 Unblocked: ENV-002 (dependency ENV-001 satisfied)
#   ...
# 
# ═══════════════════════════════════════════════════════════════
#   Orchestration Complete
#   ✅ Generated: 14 | ⏭️ Skipped: 2 | ❌ Failed: 0
# ═══════════════════════════════════════════════════════════════
```

---

### Generate Codex Scroll

**Render Checkpoint Lineage:**

```powershell
# Generate sponsor-facing codex scroll
New-CodexScroll -CheckpointDir ".\IntelIntent_Seeding\Recursive_Operations" `
                -OutputPath ".\codex_scroll.md" `
                -Format "Markdown"

# Output: 📜 Codex scroll generated: .\codex_scroll.md

# View scroll
Get-Content .\codex_scroll.md | Select-Object -First 30
```

**Share with Sponsors via Teams:**

```powershell
# Send codex scroll to sponsors channel
$scrollContent = Get-Content .\codex_scroll.md -Raw

$result = Invoke-IdentityAgent -Operation "EmailOrchestration" `
                                -UserEmail "sponsors@example.com" `
                                -Data @{
                                    Subject = "IntelIntent Phase 3 Execution Report"
                                    Body = $scrollContent
                                }

Write-Output "✅ Codex scroll delivered to sponsors"
```

---

### Validate Semantic Memory

**Search Component History:**

```powershell
# Find components related to "identity"
$results = Search-SemanticMemory -Collection "Components" -Query "identity authentication" -Limit 5

$results | ForEach-Object {
    Write-Output "Component: $($_.Metadata.Id)"
    Write-Output "Relevance: $($_.Relevance)"
    Write-Output "Text: $($_.Text)"
    Write-Output "---"
}
```

**Expected Output:**
```
Component: ID-001
Relevance: 0.87
Text: Component ID: ID-001
Title: Entra ID Connection Validation
Category: Identity_Modules
Priority: 3
Status: completed
Generated: 2025-11-26 14:35:22
---
Component: ID-002
Relevance: 0.82
Text: Component ID: ID-002
Title: User Email Orchestration Setup
Category: Identity_Modules
...
```

---

### Test Agent Delegation

**Invoke Multi-Agent Workflow:**

```powershell
# Scenario: Generate investment report and email to stakeholders
$delegationResult = Invoke-FinanceAgent -Operation "Dashboard" -Data @{
    UserID = "investor1"
    Action = "GenerateReport"
}

# FinanceAgent completes report generation, then delegates to IdentityAgent
# 💰 FinanceAgent: Processing Dashboard operation
# 🤖 OrchestratorAgent: Semantic planning activated
# 📊 Report generated: investment_report_20251126.pdf
# 🔀 FinanceAgent delegating to IdentityAgent: Send report via email
# 🔐 IdentityAgent: EmailOrchestration for stakeholders@example.com
# ✅ Delegation complete: IdentityAgent → FinanceAgent

$delegationResult | ConvertTo-Json -Depth 5
```

---

### Monitor Dynamic Queue

**View Real-Time Queue State:**

```powershell
# Get current execution queue
$queue = Get-ComponentQueue -Manifests (Get-AllManifests)

# Display queue with priority and dependencies
$queue | Format-Table ID, Title, Priority, @{
    Label = "Dependencies"
    Expression = { $_.Dependencies -join ", " }
}, Status -AutoSize
```

**Expected Output:**
```
ID       Title                           Priority Dependencies   Status
--       -----                           -------- ------------   ------
ENV-001  Environment Variable Config     1                       completed
ENV-002  PowerShell Module Path Setup    2        ENV-001        completed
SEC-001  Security Gate Validation        2        ENV-001        in-progress
ID-001   Entra ID Connection             3        ENV-001, ENV-002 not-started
```

---

## 🎯 Next Steps After Quick Start

1. **Test Voice Workflow**: `Invoke-ModalityAgent -InputType "Voice" -InputData ".\test_audio.wav"`
2. **Extend Skills**: Add custom C# plugin for domain-specific operations
3. **Configure Guardrails**: Tune rate limits and timeouts in manifest
4. **Review Lineage**: Open `codex_scroll.md` and trace signature chain
5. **Deploy to Production**: Configure Azure resources for production environment

---

## ✅ Validation Checklist (Phase 2 → Phase 3 Bridge)

### Checkpoint Lineage Creation

**Objective:** Confirm every orchestration step writes a JSON checkpoint with complete metadata.

**Test:**
```powershell
# Run orchestrator
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode Full

# Verify checkpoint structure
$checkpoint = Get-Content ".\IntelIntent_Seeding\Recursive_Operations\ENV-001_checkpoint.json" | ConvertFrom-Json

# Required fields
@("TaskID", "Timestamp", "Status", "Inputs", "Outputs", "Signature") | ForEach-Object {
    if (-not $checkpoint.$_) {
        Write-Error "❌ Missing field: $_"
    } else {
        Write-Output "✅ Field validated: $_"
    }
}
```

**Expected Output:**
```
✅ Field validated: TaskID
✅ Field validated: Timestamp
✅ Field validated: Status
✅ Field validated: Inputs
✅ Field validated: Outputs
✅ Field validated: Signature
```

**Pass Criteria:**
- All checkpoints contain complete metadata
- Timestamps are ISO 8601 format
- Signatures are SHA256 hashes
- Inputs/Outputs are valid JSON

---

### Recovery Logic on Simulated Failures

**Objective:** Trigger auth and rate limit failures, verify recovery checkpoints with mitigation hints.

**Test:**
```powershell
# Simulate authentication failure
try {
    Connect-IntelIntentGraph -TenantId "invalid-tenant" `
                              -ClientId "invalid-client" `
                              -ClientSecret "invalid-secret"
} catch {
    # Verify recovery checkpoint created
    $recoveryCheckpoint = Get-Content ".\Recovery_Logs\Recursive_Operations\auth_failure_checkpoint.json" | ConvertFrom-Json
    
    if ($recoveryCheckpoint.MitigationHint) {
        Write-Output "✅ Mitigation hint present: $($recoveryCheckpoint.MitigationHint)"
    }
}

# Simulate rate limit scenario
1..10 | ForEach-Object {
    try {
        Invoke-GraphRequest -Endpoint "/me" -Method GET
    } catch {
        if ($_.Exception.Message -match "429") {
            Write-Output "✅ Rate limit detected"
            # Verify backoff checkpoint
            $backoffCheckpoint = Get-Content ".\Recovery_Logs\Recursive_Operations\rate_limit_checkpoint.json" | ConvertFrom-Json
            Write-Output "✅ Backoff strategy: $($backoffCheckpoint.BackoffSeconds)s"
        }
    }
}
```

**Expected Mitigation Hints:**
- **Auth Failure**: "Refresh client secret in Azure Portal; verify API permissions; re-consent"
- **Rate Limit**: "Increase backoff to 60s; batch Graph requests; reduce concurrency"

**Pass Criteria:**
- Recovery checkpoints created automatically
- Mitigation hints are actionable
- Backoff strategies are adaptive
- Escalation paths are documented

---

### Output Artifacts for Traceability

**Objective:** Ensure file paths and Graph IDs are hashed and appear in Codex Scroll fragments.

**Test:**
```powershell
# Generate component with file artifact
$componentData = @{
    ID = "TEST-001"
    Title = "Test Component with Artifact"
    OutputFiles = @(".\test_output.txt")
}

# Simulate component execution
"Test artifact content" | Out-File -FilePath ".\test_output.txt"

# Generate checkpoint with artifact hash
$artifactHash = (Get-FileHash ".\test_output.txt" -Algorithm SHA256).Hash
$checkpoint = @{
    TaskID = "TEST-001"
    Timestamp = (Get-Date -Format "o")
    Status = "Success"
    Artifacts = @(
        @{
            Path = ".\test_output.txt"
            Hash = $artifactHash
            Type = "OutputFile"
        }
    )
}

$checkpoint | ConvertTo-Json -Depth 5 | Out-File ".\test_checkpoint.json"

# Render codex scroll
New-CodexScroll -CheckpointDir "." `
                -OutputPath ".\test_codex.md" `
                -Format "Markdown"

# Verify artifact hash appears in scroll
$scrollContent = Get-Content ".\test_codex.md" -Raw
if ($scrollContent -match $artifactHash) {
    Write-Output "✅ Artifact hash traced in codex scroll"
} else {
    Write-Error "❌ Artifact hash missing from scroll"
}
```

**Pass Criteria:**
- File artifacts hashed with SHA256
- Graph API IDs included in checkpoint metadata
- Codex scroll fragments contain artifact paths
- Signature chains are cryptographically verifiable

---

### Lineage Walkthrough

**Objective:** Sponsors can trace each step, input, output, and hash in codex scroll.

**Test:**
```powershell
# Generate multi-step workflow with delegation
$workflow = @(
    @{ Agent = "FinanceAgent"; Operation = "GenerateReport"; Input = @{ UserID = "investor1" } },
    @{ Agent = "IdentityAgent"; Operation = "EmailOrchestration"; Input = @{ Recipient = "sponsor@example.com" } }
)

# Execute workflow
$workflow | ForEach-Object {
    $result = & "Invoke-$($_.Agent)" -Operation $_.Operation -Data $_.Input
    # Checkpoint created automatically
}

# Render codex scroll
New-CodexScroll -CheckpointDir ".\IntelIntent_Seeding\Recursive_Operations" `
                -OutputPath ".\sponsor_walkthrough.md" `
                -Format "Markdown"

# Verify lineage structure
$scroll = Get-Content ".\sponsor_walkthrough.md" -Raw

# Check for key lineage elements
@("### Task:", "**Signature:**", "#### Inputs", "#### Outputs") | ForEach-Object {
    if ($scroll -match [regex]::Escape($_)) {
        Write-Output "✅ Lineage element present: $_"
    } else {
        Write-Error "❌ Missing lineage element: $_"
    }
}
```

**Pass Criteria:**
- Each task has unique ID and timestamp
- Inputs/Outputs rendered as JSON blocks
- Signatures verifiable with SHA256
- Delegation chains traceable (parent → child tasks)

---

## 🐛 Troubleshooting

### Authentication Failures

**Symptoms:**
- `401 Unauthorized` errors from Microsoft Graph
- `InvalidAuthenticationToken` exceptions
- `AADSTS` error codes in logs

**Common Causes:**
- Invalid client secret (expired or incorrect)
- Missing API permissions in Azure App Registration
- User consent not granted for delegated permissions
- Token not refreshed after permission changes

**Resolution:**
```powershell
# 1. Refresh client secret in Azure Portal
# Navigate to: Azure Portal → App Registrations → [Your App] → Certificates & secrets
# Create new secret, update environment variable:
$env:GRAPH_CLIENT_SECRET = "<new-secret>"

# 2. Verify API permissions
# Azure Portal → App Registrations → [Your App] → API permissions
# Ensure granted:
# - User.Read
# - Mail.Send
# - Calendars.ReadWrite
# - Files.ReadWrite.All
# - offline_access

# 3. Re-consent (if using delegated permissions)
# Visit: https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/authorize?
#        client_id=<client-id>&response_type=code&scope=User.Read%20Mail.Send

# 4. Test authentication
$token = Connect-IntelIntentGraph -TenantId $env:GRAPH_TENANT_ID `
                                   -ClientId $env:GRAPH_CLIENT_ID `
                                   -ClientSecret $env:GRAPH_CLIENT_SECRET

if ($token) {
    Write-Output "✅ Authentication successful"
    Invoke-GraphRequest -Endpoint "/me" -Method GET
}
```

**Prevention:**
- Rotate secrets every 90 days
- Use Azure Key Vault for secret storage
- Enable audit logs for permission changes
- Test authentication in non-production environment first

---

### Rate Limit Errors

**Symptoms:**
- `429 Too Many Requests` HTTP status codes
- `Microsoft.Graph.ServiceException: Retry after X seconds`
- Orchestrator slowing down or timing out

**Common Causes:**
- Burst operations (e.g., 100+ Graph API calls in 10 seconds)
- Insufficient backoff between retries
- Concurrent agent executions exceeding throttle limits
- Resource-intensive operations (e.g., bulk user queries)

**Resolution:**
```powershell
# 1. Increase backoff duration
# Edit GraphAuthBridge.psm1:
$backoffSeconds = 60  # Increase from default 10s

# 2. Batch Graph requests
# Instead of:
1..100 | ForEach-Object { Invoke-GraphRequest -Endpoint "/users/$_" }

# Use batch API:
$batchRequests = 1..100 | ForEach-Object {
    @{
        id = $_
        method = "GET"
        url = "/users/$_"
    }
}

Invoke-GraphRequest -Endpoint '/$batch' -Method POST -Body @{
    requests = $batchRequests
} | ConvertTo-Json -Depth 5

# 3. Lower concurrency
# Edit Orchestrator.ps1:
$maxConcurrentAgents = 3  # Reduce from 10

# 4. Implement exponential backoff
function Invoke-GraphRequestWithRetry {
    param($Endpoint, $Method = "GET", $MaxRetries = 5)
    
    $attempt = 0
    while ($attempt -lt $MaxRetries) {
        try {
            return Invoke-GraphRequest -Endpoint $Endpoint -Method $Method
        } catch {
            if ($_.Exception.Message -match "429") {
                $backoff = [math]::Pow(2, $attempt) * 10  # Exponential: 10s, 20s, 40s, 80s, 160s
                Write-Warning "⚠️ Rate limit hit, backing off ${backoff}s"
                Start-Sleep -Seconds $backoff
                $attempt++
            } else {
                throw
            }
        }
    }
}
```

**Prevention:**
- Monitor Graph API throttle headers (`Retry-After`, `RateLimit-Remaining`)
- Use delta queries for incremental changes
- Cache frequently accessed data
- Schedule batch operations during off-peak hours

---

### Unknown Skills Errors

**Symptoms:**
- `Skill not found: GetUserProfile` errors from Semantic Kernel
- Planner generates steps referencing unimplemented functions
- `FunctionNotFound` exceptions during plan execution

**Common Causes:**
- Planner referenced a skill not registered in kernel
- PowerShell function exists but not exported as SK skill
- Plugin DLL not loaded or outdated
- Skill name mismatch (e.g., `GetUser` vs `GetUserProfile`)

**Resolution:**
```powershell
# 1. List registered skills
$kernel = Get-SemanticKernelInstance
$kernel.Skills.GetFunctionViews() | Select-Object Name, SkillName, Description

# 2. Add missing PowerShell function as skill
function Get-UserProfile {
    param([string]$UserID)
    # Implementation
}

# Export and register
Export-ModuleMember -Function Get-UserProfile

# Register in kernel (SemanticKernelBridge.psm1):
$kernel.ImportSkill(@{
    GetUserProfile = ${function:Get-UserProfile}
}, "IntelIntentSkills")

# 3. Recompile plugin DLL (if C# skill)
cd IntelIntent.Plugins
dotnet build -c Release
Copy-Item ".\bin\Release\net8.0\*.dll" -Destination "..\IntelIntent_Seeding\" -Force

# 4. Re-register plugin
$kernel.ImportPluginFromAssembly(".\IntelIntent_Seeding\IntelIntent.Plugins.dll")

# 5. Verify skill registration
$kernel.Skills.GetFunction("IntelIntentSkills", "GetUserProfile")
```

**Prevention:**
- Maintain skill registry in manifest (`sample_manifest.json`)
- Document skill signatures and parameters
- Run `dotnet build` after every C# plugin change
- Use semantic function naming conventions

---

### Checkpoint Write Errors

**Symptoms:**
- `Access to the path is denied` exceptions
- `DirectoryNotFoundException` when creating checkpoints
- Checkpoints created but contain empty JSON (`{}`)
- Orchestrator completes but no checkpoint files found

**Common Causes:**
- `Recursive_Operations/` directory does not exist
- Insufficient file system permissions
- Checkpoint path contains invalid characters (e.g., `:` in filename on Windows)
- Disk space exhausted

**Resolution:**
```powershell
# 1. Ensure checkpoint directory exists
$checkpointDir = ".\IntelIntent_Seeding\Recursive_Operations"
if (-not (Test-Path $checkpointDir)) {
    New-Item -ItemType Directory -Path $checkpointDir -Force | Out-Null
    Write-Output "✅ Checkpoint directory created"
}

# 2. Verify write permissions
try {
    "test" | Out-File "$checkpointDir\test_checkpoint.txt"
    Remove-Item "$checkpointDir\test_checkpoint.txt"
    Write-Output "✅ Write permissions verified"
} catch {
    Write-Error "❌ Insufficient permissions. Run PowerShell as Administrator."
}

# 3. Sanitize checkpoint filenames
function New-CheckpointPath {
    param([string]$ComponentID)
    
    # Remove invalid characters
    $sanitized = $ComponentID -replace '[<>:"/\\|?*]', '_'
    return "$checkpointDir\${sanitized}_checkpoint.json"
}

# 4. Check disk space
$drive = (Get-Item $checkpointDir).PSDrive
$freeSpace = (Get-PSDrive $drive.Name).Free / 1GB
if ($freeSpace -lt 1) {
    Write-Warning "⚠️ Low disk space: ${freeSpace}GB remaining"
}

# 5. Validate checkpoint content before write
function Save-Checkpoint {
    param($ComponentID, $Data)
    
    try {
        $json = $Data | ConvertTo-Json -Depth 10
        if ($json.Length -lt 10) {
            throw "Checkpoint data is empty or invalid"
        }
        
        $path = New-CheckpointPath -ComponentID $ComponentID
        $json | Out-File -FilePath $path -Encoding UTF8
        Write-Output "✅ Checkpoint saved: $path"
    } catch {
        Write-Error "❌ Checkpoint write failed: $_"
        # Fallback: Write to temp directory
        $fallbackPath = "$env:TEMP\intelintent_checkpoint_${ComponentID}.json"
        $json | Out-File -FilePath $fallbackPath -Encoding UTF8
        Write-Warning "⚠️ Fallback checkpoint: $fallbackPath"
    }
}
```

**Prevention:**
- Create `Recursive_Operations/` directories in phase setup scripts
- Use `Test-Path` before every checkpoint write
- Implement checkpoint write retries with exponential backoff
- Monitor disk space as part of orchestrator health checks

---

## 🎭 Sponsor Workflow (Now Fully Walkable)

### End-to-End Lineage Delivery

**Phase 1: Orchestrator Execution**
```powershell
# Run orchestration
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode Full

# Checkpoints saved to: .\IntelIntent_Seeding\Recursive_Operations\
```

**Phase 2: Codex Scroll Generation**
```powershell
# Render lineage fragments
New-CodexScroll -CheckpointDir ".\IntelIntent_Seeding\Recursive_Operations" `
                -OutputPath ".\sponsor_codex_scroll.md" `
                -Format "Markdown"

# Optional: HTML for rich formatting
New-CodexScroll -CheckpointDir ".\IntelIntent_Seeding\Recursive_Operations" `
                -OutputPath ".\sponsor_codex_scroll.html" `
                -Format "HTML"
```

**Phase 3: Delivery via IdentityAgent**
```powershell
# Send scroll to sponsors channel
$scrollContent = Get-Content ".\sponsor_codex_scroll.html" -Raw

Invoke-IdentityAgent -Operation "EmailOrchestration" `
                      -UserEmail "sponsors@example.com" `
                      -Data @{
                          Subject = "IntelIntent Phase 3 Lineage Scroll - $(Get-Date -Format 'yyyy-MM-dd')"
                          Body = $scrollContent
                          ContentType = "HTML"
                          Attachments = @(".\sponsor_codex_scroll.md")
                      }

Write-Output "✅ Codex scroll delivered to sponsors"
```

**Phase 4: Sponsor Traceability**

Sponsors receive email with:
1. **Lineage Summary**: Total tasks, success rate, duration
2. **Task-by-Task Breakdown**: Each fragment with:
   - Task ID and timestamp
   - Agent responsible
   - Inputs (JSON)
   - Outputs (JSON)
   - SHA256 signature
   - Artifact paths with hashes
3. **Delegation Chains**: Parent → Child task relationships
4. **Recovery Events**: Failures with mitigation hints

**Example Scroll Fragment:**
```markdown
### Task: FIN-001

**Timestamp:** 2025-11-26T14:35:22Z  
**Agent:** FinanceAgent  
**Status:** ✅ Success  
**Signature:** `a7b3c2d1e4f56789abcdef1234567890...`

#### Inputs
```json
{
  "UserID": "investor1",
  "Action": "GenerateReport",
  "Period": "2025-Q4"
}
```

#### Outputs
```json
{
  "ReportPath": "./reports/investment_report_2025Q4.pdf",
  "ReportHash": "b8c4d3e2f1a09876543210fedcba9876...",
  "GeneratedAt": "2025-11-26T14:35:25Z"
}
```

#### Artifacts
- `./reports/investment_report_2025Q4.pdf` (SHA256: `b8c4d3e2...`)

#### Delegation
- Delegated to **IdentityAgent** (ID-003) for email delivery
```

---

**Phase 3 Target Completion:** Q1 2026

_Transforming IntelIntent from orchestration scaffolding into production-ready AI-powered automation with semantic intelligence, predictive recovery, and sponsor-facing transparency through codex lineage rendering._
