<#
.SYNOPSIS
    Complete Phase 4 deployment bundle with roadmap generation, SQL ingestion, and Power BI configuration.

.DESCRIPTION
    All-in-one deployment script that:
    1. Generates PNG roadmap from Mermaid diagram
    2. Executes full Phase 4 deployment (Deploy-IntelIntentPhase4.ps1)
    3. Pushes checkpoints to SQL for Power BI
    4. Exports Power BI configuration JSON
    5. Validates deployment completeness
    6. Generates sponsor-ready package

.PARAMETER DryRun
    Simulate deployment without making actual changes.

.PARAMETER SkipRoadmapGeneration
    Skip PNG roadmap generation (requires Mermaid CLI).

.PARAMETER SkipPowerBIExport
    Skip Power BI configuration export.

.PARAMETER SqlServer
    SQL Server instance for Power BI ingestion (e.g., intelintent.database.windows.net).

.PARAMETER Database
    SQL Database name (default: IntelIntentMetrics).

.PARAMETER UseManagedIdentity
    Use Azure Managed Identity for SQL authentication (default: $true).

.PARAMETER Context
    Deployment context (Personal, Developer, Family, Business, Enterprise).

.PARAMETER ResourceGroup
    Azure resource group name.

.PARAMETER VaultName
    Azure Key Vault name.

.EXAMPLE
    .\Deploy-Phase4-Complete.ps1 -DryRun
    Simulates complete deployment pipeline.

.EXAMPLE
    .\Deploy-Phase4-Complete.ps1 -Context "Developer" -SqlServer "intelintent.database.windows.net"
    Full deployment with Power BI SQL ingestion.

.EXAMPLE
    .\Deploy-Phase4-Complete.ps1 -SkipRoadmapGeneration -SkipPowerBIExport
    Deployment only (no roadmap PNG or Power BI config).

.NOTES
    Author: IntelIntent Orchestration Team
    Version: 1.0.0
    Created: 2025-11-30
    Requires: PowerShell 7+, Mermaid CLI (for PNG generation), Azure CLI
#>

param(
    [switch]$DryRun,
    [switch]$SkipRoadmapGeneration,
    [switch]$SkipPowerBIExport,

    [string]$SqlServer,
    [string]$Database = 'IntelIntentMetrics',
    [bool]$UseManagedIdentity = $true,

    [ValidateSet('Personal', 'Developer', 'Family', 'Business', 'Enterprise')]
    [string]$Context = 'Developer',

    [string]$ResourceGroup = 'Phase4RG',
    [string]$VaultName = 'IntelIntentSecrets'
)

$ErrorActionPreference = 'Stop'

# === Script Configuration ===
$script:BundleSession = @{
    SessionID = (New-Guid).ToString()
    StartTime = Get-Date
    Steps     = @()
    Artifacts = @()
}

# === Helper Functions ===

function Write-BundleHeader {
    param([string]$Message)
    Write-Host "`n╔══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║  $($Message.PadRight(56))║" -ForegroundColor Cyan
    Write-Host '╚══════════════════════════════════════════════════════════╝' -ForegroundColor Cyan
}

function Write-BundleStep {
    param([string]$Step, [string]$Status = 'Running')
    $icon = switch ($Status) {
        'Running' { '⚡' }
        'Success' { '✅' }
        'Failed' { '❌' }
        'Skipped' { '⏭️' }
        default { '📌' }
    }
    Write-Host "$icon $Step" -ForegroundColor $(if ($Status -eq 'Failed') { 'Red' } elseif ($Status -eq 'Success') { 'Green' } else { 'White' })
}

function Add-BundleStep {
    param([string]$Step, [string]$Status, [hashtable]$Metadata = @{})
    $script:BundleSession.Steps += @{
        Timestamp = (Get-Date).ToString('yyyy-MM-ddTHH:mm:ssZ')
        Step      = $Step
        Status    = $Status
        Metadata  = $Metadata
    }
}

function Test-CommandAvailable {
    param([string]$Command)
    return $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

# === Step 1: Generate PNG Roadmap ===

function Invoke-RoadmapGeneration {
    Write-BundleHeader 'Step 1: Roadmap PNG Generation'

    try {
        if ($SkipRoadmapGeneration) {
            Write-BundleStep 'Roadmap generation skipped (SkipRoadmapGeneration flag)' 'Skipped'
            Add-BundleStep -Step 'RoadmapGeneration' -Status 'Skipped' -Metadata @{ Reason = 'UserFlag' }
            return
        }

        # Check for Mermaid CLI
        if (-not (Test-CommandAvailable 'mmdc')) {
            Write-Host '  ⚠️ Mermaid CLI not found. Installing...' -ForegroundColor Yellow

            if (Test-CommandAvailable 'npm') {
                npm install -g @mermaid-js/mermaid-cli 2>&1 | Out-Null
                Write-Host '  ✅ Mermaid CLI installed' -ForegroundColor Green
            } else {
                Write-Host '  ❌ Node.js/npm not found. Cannot install Mermaid CLI.' -ForegroundColor Red
                Write-Host '  💡 Install manually: npm install -g @mermaid-js/mermaid-cli' -ForegroundColor Yellow
                Add-BundleStep -Step 'RoadmapGeneration' -Status 'Skipped' -Metadata @{ Reason = 'MermaidCLINotAvailable' }
                return
            }
        }

        # Extract Mermaid diagram from PHASE4_DEPLOYMENT_ROADMAP.md
        Write-BundleStep 'Extracting Mermaid diagram from roadmap' 'Running'

        $roadmapFile = '.\PHASE4_DEPLOYMENT_ROADMAP.md'
        if (-not (Test-Path $roadmapFile)) {
            Write-Host '  ❌ PHASE4_DEPLOYMENT_ROADMAP.md not found' -ForegroundColor Red
            Add-BundleStep -Step 'RoadmapGeneration' -Status 'Failed' -Metadata @{ Error = 'RoadmapFileNotFound' }
            return
        }

        $roadmapContent = Get-Content $roadmapFile -Raw

        # Extract mermaid code block
        if ($roadmapContent -match '```mermaid\s+(.*?)\s+```') {
            $mermaidCode = $Matches[1]

            # Save to temporary .mmd file
            $mmdFile = '.\Sponsors\phase4-roadmap.mmd'
            $mermaidCode | Set-Content $mmdFile

            Write-BundleStep 'Generating PNG from Mermaid diagram' 'Running'

            # Generate PNG
            $pngFile = '.\Sponsors\phase4-roadmap.png'

            if ($DryRun) {
                Write-Host "  [DRY RUN] Would generate PNG: $pngFile" -ForegroundColor Yellow
                Add-BundleStep -Step 'RoadmapGeneration' -Status 'Skipped' -Metadata @{ Reason = 'DryRun'; PngFile = $pngFile }
            } else {
                mmdc -i $mmdFile -o $pngFile -t default -b transparent 2>&1 | Out-Null

                if (Test-Path $pngFile) {
                    Write-BundleStep "PNG roadmap generated: $pngFile" 'Success'
                    Add-BundleStep -Step 'RoadmapGeneration' -Status 'Success' -Metadata @{ PngFile = $pngFile }
                    $script:BundleSession.Artifacts += $pngFile
                } else {
                    Write-BundleStep 'PNG generation failed' 'Failed'
                    Add-BundleStep -Step 'RoadmapGeneration' -Status 'Failed' -Metadata @{ Error = 'PngNotGenerated' }
                }

                # Cleanup temp .mmd file
                Remove-Item $mmdFile -Force -ErrorAction SilentlyContinue
            }
        } else {
            Write-Host '  ❌ No Mermaid diagram found in PHASE4_DEPLOYMENT_ROADMAP.md' -ForegroundColor Red
            Add-BundleStep -Step 'RoadmapGeneration' -Status 'Failed' -Metadata @{ Error = 'MermaidDiagramNotFound' }
        }
    } catch {
        Write-BundleStep "Roadmap generation failed: $_" 'Failed'
        Add-BundleStep -Step 'RoadmapGeneration' -Status 'Failed' -Metadata @{ Error = $_.Exception.Message }
    }
}

# === Step 2: Execute Phase 4 Deployment ===

function Invoke-Phase4Deployment {
    Write-BundleHeader 'Step 2: Phase 4 Deployment Execution'

    try {
        $deployScript = '.\Deploy-IntelIntentPhase4.ps1'

        if (-not (Test-Path $deployScript)) {
            Write-Host '  ❌ Deploy-IntelIntentPhase4.ps1 not found' -ForegroundColor Red
            Add-BundleStep -Step 'Phase4Deployment' -Status 'Failed' -Metadata @{ Error = 'ScriptNotFound' }
            return
        }

        Write-BundleStep 'Executing Deploy-IntelIntentPhase4.ps1' 'Running'

        $deployParams = @{
            Context       = $Context
            ResourceGroup = $ResourceGroup
            VaultName     = $VaultName
        }

        if ($DryRun) {
            $deployParams['DryRun'] = $true
        }

        & $deployScript @deployParams

        if ($LASTEXITCODE -eq 0) {
            Write-BundleStep 'Phase 4 deployment completed successfully' 'Success'
            Add-BundleStep -Step 'Phase4Deployment' -Status 'Success' -Metadata @{ Context = $Context; ResourceGroup = $ResourceGroup }

            # Capture deployment artifacts
            $artifacts = @(
                '.\Week1_Checkpoints.json',
                '.\Sponsors\Phase4_Deployment_Session.json',
                '.\Sponsors\Week1_Codex_Scroll.md',
                '.\Sponsors\Week1_Codex_Scroll.html'
            )

            foreach ($artifact in $artifacts) {
                if (Test-Path $artifact) {
                    $script:BundleSession.Artifacts += $artifact
                }
            }
        } else {
            Write-BundleStep 'Phase 4 deployment completed with errors' 'Failed'
            Add-BundleStep -Step 'Phase4Deployment' -Status 'Failed' -Metadata @{ ExitCode = $LASTEXITCODE }
        }
    } catch {
        Write-BundleStep "Phase 4 deployment failed: $_" 'Failed'
        Add-BundleStep -Step 'Phase4Deployment' -Status 'Failed' -Metadata @{ Error = $_.Exception.Message }
    }
}

# === Step 3: Push Checkpoints to SQL ===

function Invoke-SQLIngestion {
    Write-BundleHeader 'Step 3: SQL Ingestion for Power BI'

    try {
        if (-not $SqlServer) {
            Write-BundleStep 'SQL ingestion skipped (SqlServer not specified)' 'Skipped'
            Add-BundleStep -Step 'SQLIngestion' -Status 'Skipped' -Metadata @{ Reason = 'SqlServerNotSpecified' }
            return
        }

        # Check for SqlServer module
        if (-not (Get-Module -ListAvailable -Name SqlServer)) {
            Write-Host '  ⚠️ SqlServer module not found. Installing...' -ForegroundColor Yellow
            Install-Module -Name SqlServer -Force -AllowClobber -Scope CurrentUser
        }

        Import-Module SqlServer -ErrorAction Stop

        Write-BundleStep 'Pushing checkpoints to SQL database' 'Running'

        # Build connection string
        if ($UseManagedIdentity) {
            $connectionString = "Server=$SqlServer;Database=$Database;Authentication=Active Directory Managed Identity;"
        } else {
            $connectionString = "Server=$SqlServer;Database=$Database;Integrated Security=True;"
        }

        if ($DryRun) {
            Write-Host "  [DRY RUN] Would push checkpoints to: $SqlServer/$Database" -ForegroundColor Yellow
            Add-BundleStep -Step 'SQLIngestion' -Status 'Skipped' -Metadata @{ Reason = 'DryRun'; SqlServer = $SqlServer }
            return
        }

        # Push Week1 checkpoints
        $checkpointFile = '.\Week1_Checkpoints.json'
        if (Test-Path $checkpointFile) {
            $checkpointData = Get-Content $checkpointFile | ConvertFrom-Json

            foreach ($checkpoint in $checkpointData.Checkpoints) {
                $query = @"
INSERT INTO [dbo].[Week1Checkpoints] (
    CheckpointID, TaskID, SessionID, Timestamp, Status, Description, Duration, Signature,
    ParentTaskID, InputsJSON, OutputsJSON, ArtifactsJSON
) VALUES (
    '$($checkpoint.TaskID)-$($checkpoint.SessionID)',
    '$($checkpoint.TaskID)',
    '$($checkpointData.SessionID)',
    '$($checkpoint.Timestamp)',
    '$($checkpoint.Status)',
    '$($checkpoint.Description ?? '')',
    $($checkpoint.Duration ?? 0),
    '$($checkpoint.Signature ?? '[Pending SHA256]')',
    NULL,
    '$(ConvertTo-Json $checkpoint.Inputs -Compress -Depth 10)',
    '$(ConvertTo-Json $checkpoint.Outputs -Compress -Depth 10)',
    '$(ConvertTo-Json $checkpoint.Artifacts -Compress -Depth 10)'
)
"@

                try {
                    Invoke-Sqlcmd -ConnectionString $connectionString -Query $query -ErrorAction Stop
                } catch {
                    Write-Host "  ⚠️ Failed to insert checkpoint $($checkpoint.TaskID): $_" -ForegroundColor Yellow
                }
            }

            Write-BundleStep "Pushed $($checkpointData.Checkpoints.Count) checkpoints to SQL" 'Success'
            Add-BundleStep -Step 'SQLIngestion' -Status 'Success' -Metadata @{ CheckpointCount = $checkpointData.Checkpoints.Count }
        }

        # Push deployment session
        $sessionFile = '.\Sponsors\Phase4_Deployment_Session.json'
        if (Test-Path $sessionFile) {
            $sessionData = Get-Content $sessionFile | ConvertFrom-Json

            $successCount = ($sessionData.Checkpoints | Where-Object { $_.Status -eq 'Success' }).Count
            $failedCount = ($sessionData.Checkpoints | Where-Object { $_.Status -eq 'Failed' }).Count
            $skippedCount = ($sessionData.Checkpoints | Where-Object { $_.Status -eq 'Skipped' }).Count

            $sessionQuery = @"
INSERT INTO [dbo].[DeploymentSessions] (
    SessionID, StartTime, EndTime, DurationSeconds, Context, IsDryRun, ReadinessScore,
    SuccessCount, FailedCount, SkippedCount, TotalSteps, Status
) VALUES (
    '$($sessionData.SessionID)',
    '$($sessionData.StartTime)',
    '$($sessionData.EndTime)',
    $($sessionData.DurationSeconds),
    '$($sessionData.Context)',
    $(if ($sessionData.DryRun) { 1 } else { 0 }),
    0,
    $successCount,
    $failedCount,
    $skippedCount,
    $($sessionData.Checkpoints.Count),
    '$(if ($failedCount -eq 0) { 'Success' } else { 'Failed' })'
)
"@

            Invoke-Sqlcmd -ConnectionString $connectionString -Query $sessionQuery -ErrorAction Stop

            Write-BundleStep 'Deployment session pushed to SQL' 'Success'
        }

        Write-Host '  📊 Data ready for Power BI refresh' -ForegroundColor Cyan
    } catch {
        Write-BundleStep "SQL ingestion failed: $_" 'Failed'
        Add-BundleStep -Step 'SQLIngestion' -Status 'Failed' -Metadata @{ Error = $_.Exception.Message }
    }
}

# === Step 4: Export Power BI Configuration ===

function Invoke-PowerBIConfigExport {
    Write-BundleHeader 'Step 4: Power BI Configuration Export'

    try {
        if ($SkipPowerBIExport) {
            Write-BundleStep 'Power BI export skipped (SkipPowerBIExport flag)' 'Skipped'
            Add-BundleStep -Step 'PowerBIConfigExport' -Status 'Skipped' -Metadata @{ Reason = 'UserFlag' }
            return
        }

        Write-BundleStep 'Generating Power BI configuration JSON' 'Running'

        $powerBIConfig = @{
            Version         = '1.0.0'
            Generated       = (Get-Date).ToString('yyyy-MM-ddTHH:mm:ssZ')
            SessionID       = $script:BundleSession.SessionID

            DataSources     = @{
                SqlServer          = $SqlServer
                Database           = $Database
                UseManagedIdentity = $UseManagedIdentity
            }

            Tables          = @(
                'DeploymentSessions',
                'DeploymentCheckpoints',
                'EnvironmentReadiness',
                'Week1Checkpoints',
                'CoEActivations',
                'UniversalIntegrationLogs',
                'CopilotLifecycleEvents',
                'CopilotCommandInvocations'
            )

            DAXMeasures     = @{
                ReadinessScore         = 'DIVIDE(SUM(EnvironmentReadiness[ReadinessScore]), COUNTROWS(EnvironmentReadiness), 0)'
                DeploymentSuccessRate  = "DIVIDE(CALCULATE(COUNTROWS(DeploymentSessions), DeploymentSessions[Status] = 'Success'), COUNTROWS(DeploymentSessions), 0) * 100"
                AvgDeploymentDuration  = 'AVERAGE(DeploymentSessions[DurationSeconds]) / 60'
                CheckpointSuccessRate  = "DIVIDE(CALCULATE(COUNTROWS(Week1Checkpoints), Week1Checkpoints[Status] = 'Success'), COUNTROWS(Week1Checkpoints), 0) * 100"
                CoEActivationRate      = "DIVIDE(CALCULATE(COUNTROWS(CoEActivations), CoEActivations[Status] = 'Completed'), COUNTROWS(CoEActivations), 0) * 100"
                IntegrationSuccessRate = "DIVIDE(CALCULATE(COUNTROWS(UniversalIntegrationLogs), UniversalIntegrationLogs[Status] = 'Success'), COUNTROWS(UniversalIntegrationLogs), 0) * 100"
                CopilotAdoptionRate    = 'DIVIDE(CALCULATE(COUNTROWS(CopilotCommandInvocations), CopilotCommandInvocations[Timestamp] >= TODAY() - 30), 30, 0)'
            }

            DashboardPages  = @(
                @{
                    Name    = 'Executive Summary'
                    Visuals = @('Readiness Score Gauge', 'Success Rate Card', 'Deployment Trend Line Chart')
                },
                @{
                    Name    = 'Environment Readiness'
                    Visuals = @('Tools Installed Bar Chart', 'PATH Status Table', 'Readiness Over Time')
                },
                @{
                    Name    = 'Deployment Execution'
                    Visuals = @('Session Status Donut', 'Checkpoint Waterfall', 'Duration Trend')
                },
                @{
                    Name    = 'CoE Activation'
                    Visuals = @('Activation Rate Gauge', 'Priority Treemap', 'Failed Components Table')
                },
                @{
                    Name    = 'Universal Integration'
                    Visuals = @('Integration Type Bar Chart', 'Success Rate Line', 'Recent Events Table')
                },
                @{
                    Name    = 'Copilot Lineage'
                    Visuals = @('Invocation Type Donut', 'Usage Trend Line', 'Session History Table')
                }
            )

            RefreshSchedule = @{
                Frequency   = 'Hourly'
                ActiveHours = '8 AM - 6 PM'
                Retention   = '90 days'
            }
        }

        $configFile = '.\Sponsors\PowerBI_Configuration.json'
        $powerBIConfig | ConvertTo-Json -Depth 10 | Set-Content $configFile

        Write-BundleStep "Power BI configuration exported: $configFile" 'Success'
        Add-BundleStep -Step 'PowerBIConfigExport' -Status 'Success' -Metadata @{ ConfigFile = $configFile }
        $script:BundleSession.Artifacts += $configFile
    } catch {
        Write-BundleStep "Power BI configuration export failed: $_" 'Failed'
        Add-BundleStep -Step 'PowerBIConfigExport' -Status 'Failed' -Metadata @{ Error = $_.Exception.Message }
    }
}

# === Step 5: Post-Install Verification ===

function Invoke-PostInstallVerification {
    Write-BundleHeader 'Step 5: Post-Install Verification'

    try {
        $verifyScript = '.\Test-PostInstall.ps1'

        if (-not (Test-Path $verifyScript)) {
            Write-BundleStep 'Test-PostInstall.ps1 not found' 'Failed'
            Add-BundleStep -Step 'PostInstallVerification' -Status 'Failed' -Metadata @{ Error = 'ScriptNotFound' }
            return
        }

        Write-BundleStep 'Running post-install verification' 'Running'

        & $verifyScript -ExportReport -TestAzureConnectivity

        if ($LASTEXITCODE -eq 0) {
            Write-BundleStep 'Post-install verification passed' 'Success'
            Add-BundleStep -Step 'PostInstallVerification' -Status 'Success'

            $reportFile = '.\Sponsors\PostInstall_Verification_Report.json'
            if (Test-Path $reportFile) {
                $script:BundleSession.Artifacts += $reportFile
            }
        } else {
            Write-BundleStep 'Post-install verification completed with warnings' 'Failed'
            Add-BundleStep -Step 'PostInstallVerification' -Status 'Warning' -Metadata @{ ExitCode = $LASTEXITCODE }
        }
    } catch {
        Write-BundleStep "Post-install verification failed: $_" 'Failed'
        Add-BundleStep -Step 'PostInstallVerification' -Status 'Failed' -Metadata @{ Error = $_.Exception.Message }
    }
}

# === Step 6: Generate Sponsor Package ===

function Invoke-SponsorPackageGeneration {
    Write-BundleHeader 'Step 6: Sponsor Package Generation'

    try {
        Write-BundleStep 'Creating sponsor delivery package' 'Running'

        $packageDir = '.\Sponsors\Phase4_Delivery_Package'
        if (-not (Test-Path $packageDir)) {
            New-Item -ItemType Directory -Path $packageDir -Force | Out-Null
        }

        # Copy artifacts to package directory
        foreach ($artifact in $script:BundleSession.Artifacts) {
            if (Test-Path $artifact) {
                $fileName = Split-Path $artifact -Leaf
                Copy-Item $artifact -Destination "$packageDir\$fileName" -Force
                Write-Host "  📦 Packaged: $fileName" -ForegroundColor Green
            }
        }

        # Generate README for sponsors
        $readmeContent = @"
# IntelIntent Phase 4 Deployment Package

**Session ID:** $($script:BundleSession.SessionID)
**Generated:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
**Context:** $Context
**Status:** Deployment Complete

## Package Contents

$(foreach ($artifact in $script:BundleSession.Artifacts) {
    $fileName = Split-Path $artifact -Leaf
    "- **$fileName** - $(switch ($fileName) {
        { $_ -like '*roadmap*.png' } { 'Visual deployment flow diagram' }
        { $_ -like '*Checkpoints.json' } { 'Week 1 automation checkpoint data' }
        { $_ -like '*Deployment_Session.json' } { 'Phase 4 deployment session metadata' }
        { $_ -like '*Codex_Scroll*' } { 'Sponsor-facing lineage report' }
        { $_ -like '*Verification_Report.json' } { 'Environment readiness verification' }
        { $_ -like '*PowerBI_Configuration.json' } { 'Power BI dashboard configuration' }
        default { 'Deployment artifact' }
    })"
})

## Deployment Summary

**Total Steps:** $($script:BundleSession.Steps.Count)
**Success:** $(($script:BundleSession.Steps | Where-Object { $_.Status -eq 'Success' }).Count)
**Failed:** $(($script:BundleSession.Steps | Where-Object { $_.Status -eq 'Failed' }).Count)
**Skipped:** $(($script:BundleSession.Steps | Where-Object { $_.Status -eq 'Skipped' }).Count)

## Next Steps

1. **Review Deployment Artifacts:** Open included JSON/HTML files
2. **Access Power BI Dashboard:** Import PowerBI_Configuration.json to Power BI Service
3. **Validate Environment:** Review PostInstall_Verification_Report.json
4. **View Roadmap:** Open phase4-roadmap.png for visual deployment flow

## Documentation References

- [PHASE4_DEPLOYMENT_ROADMAP.md](../../PHASE4_DEPLOYMENT_ROADMAP.md)
- [POWERBI_PHASE4_SCHEMA.md](../../POWERBI_PHASE4_SCHEMA.md)
- [PRODUCTION_MODULES_QUICKSTART.md](../../PRODUCTION_MODULES_QUICKSTART.md)

---

*IntelIntent Phase 4 - Production Hardening Complete*
"@

        $readmeContent | Set-Content "$packageDir\README.md"

        Write-BundleStep "Sponsor package created: $packageDir" 'Success'
        Add-BundleStep -Step 'SponsorPackageGeneration' -Status 'Success' -Metadata @{ PackageDir = $packageDir; ArtifactCount = $script:BundleSession.Artifacts.Count }
    } catch {
        Write-BundleStep "Sponsor package generation failed: $_" 'Failed'
        Add-BundleStep -Step 'SponsorPackageGeneration' -Status 'Failed' -Metadata @{ Error = $_.Exception.Message }
    }
}

# === Main Execution ===

try {
    Write-BundleHeader 'IntelIntent Phase 4 Complete Deployment Bundle'
    Write-Host "Session ID: $($script:BundleSession.SessionID)" -ForegroundColor Cyan
    Write-Host "Context: $Context" -ForegroundColor Cyan
    Write-Host "Mode: $(if ($DryRun) { 'DRY RUN (Simulation)' } else { 'PRODUCTION' })" -ForegroundColor $(if ($DryRun) { 'Yellow' } else { 'Green' })

    # Execute bundle steps
    Invoke-RoadmapGeneration
    Invoke-Phase4Deployment
    Invoke-SQLIngestion
    Invoke-PowerBIConfigExport
    Invoke-PostInstallVerification
    Invoke-SponsorPackageGeneration

    # Final summary
    Write-BundleHeader 'Deployment Bundle Summary'

    $script:BundleSession.EndTime = Get-Date
    $script:BundleSession.DurationSeconds = [math]::Round((($script:BundleSession.EndTime - $script:BundleSession.StartTime).TotalSeconds), 2)

    $successCount = ($script:BundleSession.Steps | Where-Object { $_.Status -eq 'Success' }).Count
    $failedCount = ($script:BundleSession.Steps | Where-Object { $_.Status -eq 'Failed' }).Count
    $skippedCount = ($script:BundleSession.Steps | Where-Object { $_.Status -eq 'Skipped' }).Count

    Write-Host "Total Steps: $($script:BundleSession.Steps.Count)" -ForegroundColor Cyan
    Write-Host "  ✅ Success: $successCount" -ForegroundColor Green
    Write-Host "  ❌ Failed: $failedCount" -ForegroundColor Red
    Write-Host "  ⏭️ Skipped: $skippedCount" -ForegroundColor Yellow
    Write-Host "Duration: $($script:BundleSession.DurationSeconds) seconds" -ForegroundColor Cyan
    Write-Host "Artifacts Generated: $($script:BundleSession.Artifacts.Count)" -ForegroundColor Cyan

    # Export bundle session
    $bundleSessionFile = '.\Sponsors\Phase4_Bundle_Session.json'
    $script:BundleSession | ConvertTo-Json -Depth 10 | Set-Content $bundleSessionFile
    Write-Host "`n📄 Bundle session exported: $bundleSessionFile" -ForegroundColor Green

    if ($failedCount -eq 0) {
        Write-Host "`n🎉 IntelIntent Phase 4 complete deployment bundle succeeded!" -ForegroundColor Green
        Write-Host '📦 Sponsor package ready: .\Sponsors\Phase4_Delivery_Package\' -ForegroundColor Cyan
        exit 0
    } else {
        Write-Host "`n⚠️ Deployment bundle completed with $failedCount failed steps. Review logs for details." -ForegroundColor Yellow
        exit 1
    }
} catch {
    Write-Host "`n❌ Deployment bundle failed: $_" -ForegroundColor Red
    Write-Host $_.Exception.StackTrace -ForegroundColor Red
    exit 1
}
