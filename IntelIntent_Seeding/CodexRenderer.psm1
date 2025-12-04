<#
.SYNOPSIS
    Renders checkpoint JSON to Markdown and HTML Codex scrolls with Fluent 2 design.

.DESCRIPTION
    Transforms Week1_Checkpoints.json into sponsor-facing documentation:
    - Markdown (.md) - Archive-friendly, git-friendly, audit trail
    - HTML (.html) - Fluent 2 design, email embeds, interactive visualization

    Supports:
    - Cryptographic lineage visualization (SHA256 signature chains)
    - Task dependency graphs
    - Agent delegation tracking
    - Success/failure metrics
    - Timeline views

.NOTES
    Module:         CodexRenderer.psm1
    Author:         IntelIntent Orchestration Team
    Created:        2025-11-29
    Phase:          Phase 4 - Production Hardening
    Output:         Sponsors/Week1_Codex_Scroll.md, Sponsors/Week1_Codex_Scroll.html

.EXAMPLE
    Import-Module .\IntelIntent_Seeding\CodexRenderer.psm1

    $checkpoints = Get-Content .\Week1_Checkpoints.json | ConvertFrom-Json
    Render-CodexScroll -Checkpoints $checkpoints.Checkpoints -OutputPath ".\Sponsors"
#>

# === Module State ===
$script:RenderContext = @{
    SessionID      = (New-Guid).ToString()
    RenderCount    = 0
    LastRenderTime = $null
}

# === Fluent 2 Design Tokens ===
$script:Fluent2Theme = @{
    Colors     = @{
        Primary       = '#0078D4'
        Success       = '#107C10'
        Warning       = '#FFC107'
        Error         = '#D13438'
        Background    = '#F3F2F1'
        Surface       = '#FFFFFF'
        Text          = '#323130'
        TextSecondary = '#605E5C'
        Border        = '#EDEBE9'
    }
    Typography = @{
        FontFamily = "'Segoe UI', -apple-system, BlinkMacSystemFont, 'Helvetica Neue', sans-serif"
        H1Size     = '32px'
        H2Size     = '24px'
        H3Size     = '20px'
        BodySize   = '14px'
    }
}

# === Core Functions ===

function Render-CodexScroll {
    <#
    .SYNOPSIS
        Generates Markdown and HTML Codex scrolls from checkpoint data.

    .DESCRIPTION
        Main entry point for rendering checkpoint JSON into sponsor documentation.
        Creates both archive-friendly Markdown and interactive HTML with Fluent 2 design.

    .PARAMETER Checkpoints
        Array of checkpoint objects from Week1_Checkpoints.json.

    .PARAMETER OutputPath
        Directory to write output files (default: .\Sponsors).

    .PARAMETER ScrollName
        Base filename for outputs (default: Week1_Codex_Scroll).

    .PARAMETER IncludeMetrics
        Include aggregated metrics summary (default: $true).

    .PARAMETER IncludeDependencyGraph
        Generate Mermaid dependency graph (default: $true).

    .EXAMPLE
        $data = Get-Content .\Week1_Checkpoints.json | ConvertFrom-Json
        Render-CodexScroll -Checkpoints $data.Checkpoints -OutputPath ".\Sponsors"

    .EXAMPLE
        Render-CodexScroll -Checkpoints $checkpoints -ScrollName "Phase4_Week1" -IncludeMetrics $true
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [array]$Checkpoints,

        [string]$OutputPath = '.\Sponsors',

        [string]$ScrollName = 'Week1_Codex_Scroll',

        [bool]$IncludeMetrics = $true,

        [bool]$IncludeDependencyGraph = $true
    )

    try {
        Write-Host "📜 Rendering Codex Scroll: $ScrollName" -ForegroundColor Cyan

        # Ensure output directory exists
        if (-not (Test-Path $OutputPath)) {
            New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
        }

        # Generate Markdown
        $mdPath = Join-Path $OutputPath "$ScrollName.md"
        $markdown = New-MarkdownScroll -Checkpoints $Checkpoints -IncludeMetrics:$IncludeMetrics -IncludeDependencyGraph:$IncludeDependencyGraph
        Set-Content -Path $mdPath -Value $markdown -Encoding UTF8
        Write-Host "  ✅ Markdown scroll: $mdPath" -ForegroundColor Green

        # Generate HTML
        $htmlPath = Join-Path $OutputPath "$ScrollName.html"
        $html = New-HtmlScroll -Checkpoints $Checkpoints -IncludeMetrics:$IncludeMetrics
        Set-Content -Path $htmlPath -Value $html -Encoding UTF8
        Write-Host "  ✅ HTML scroll: $htmlPath" -ForegroundColor Green

        # Update module state
        $script:RenderContext.RenderCount++
        $script:RenderContext.LastRenderTime = Get-Date

        return @{
            Status          = 'Success'
            MarkdownPath    = $mdPath
            HtmlPath        = $htmlPath
            CheckpointCount = $Checkpoints.Count
        }
    } catch {
        Write-Error "❌ Failed to render Codex scroll: $_"
        return @{
            Status = 'Failed'
            Error  = $_.Exception.Message
        }
    }
}

function New-MarkdownScroll {
    <#
    .SYNOPSIS
        Generates Markdown Codex scroll from checkpoints.

    .DESCRIPTION
        Creates archive-friendly Markdown with:
        - Executive summary
        - Checkpoint table
        - Metrics aggregation
        - Mermaid dependency graph
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [array]$Checkpoints,

        [bool]$IncludeMetrics = $true,

        [bool]$IncludeDependencyGraph = $true
    )

    $sb = [System.Text.StringBuilder]::new()

    # Header
    [void]$sb.AppendLine('# IntelIntent Phase 4 - Week 1 Codex Scroll')
    [void]$sb.AppendLine('')
    [void]$sb.AppendLine("**Generated:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss UTC')")
    [void]$sb.AppendLine("**Session ID:** $($Checkpoints[0].SessionID)")
    [void]$sb.AppendLine("**Total Checkpoints:** $($Checkpoints.Count)")
    [void]$sb.AppendLine('')
    [void]$sb.AppendLine('---')
    [void]$sb.AppendLine('')

    # Executive Summary
    if ($IncludeMetrics) {
        $metrics = Get-CheckpointMetrics -Checkpoints $Checkpoints
        [void]$sb.AppendLine('## Executive Summary')
        [void]$sb.AppendLine('')
        [void]$sb.AppendLine('| Metric | Value |')
        [void]$sb.AppendLine('|--------|-------|')
        [void]$sb.AppendLine('| **Total Operations** | {0} |' -f $metrics.TotalOperations)
        [void]$sb.AppendLine('| **Successful** | {0} |' -f $metrics.SuccessCount)
        [void]$sb.AppendLine('| **Failed** | {0} |' -f $metrics.FailureCount)
        [void]$sb.AppendLine('| **Skipped** | {0} |' -f $metrics.SkippedCount)
        [void]$sb.AppendLine('| **Success Rate** | {0}% |' -f $metrics.SuccessRate)
        [void]$sb.AppendLine('| **Total Duration** | {0}s |' -f $metrics.TotalDuration)
        [void]$sb.AppendLine('| **Average Duration** | {0}s |' -f $metrics.AvgDuration)
        [void]$sb.AppendLine('')
        [void]$sb.AppendLine('---')
        [void]$sb.AppendLine('')
    }

    # Dependency Graph
    if ($IncludeDependencyGraph) {
        $graph = New-MermaidDependencyGraph -Checkpoints $Checkpoints
        [void]$sb.AppendLine('## Task Dependency Graph')
        [void]$sb.AppendLine('')
        [void]$sb.AppendLine("```mermaid")
        [void]$sb.AppendLine($graph)
        [void]$sb.AppendLine("```")
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("-- - ")
        [void]$sb.AppendLine("")
    }

    # Checkpoint Table
    [void]$sb.AppendLine("## Checkpoint Details")
            [void]$sb.AppendLine('')
            [void]$sb.AppendLine('| Task ID | Timestamp | Status | Duration | Artifacts |')
            [void]$sb.AppendLine('|---------|-----------|--------|----------|-----------|')

            foreach ($cp in $Checkpoints) {
                $status = switch ($cp.Status) {
                    'Success' { '[OK] Success' }
                    'Failed' { '[FAIL] Failed' }
                    'Skipped' { '[SKIP] Skipped' }
                    default { $cp.Status }
                }

                $artifacts = if ($cp.Artifacts.Count -gt 0) {
                    $cp.Artifacts -join ', '
                } else {
                    '-'
                }

                $timestamp = ([DateTime]$cp.Timestamp).ToString('HH:mm:ss')

                $rowLine = '| {0} | {1} | {2} | {3}s | {4} |' -f $cp.TaskID, $timestamp, $status, $cp.Duration, $artifacts
                [void]$sb.AppendLine($rowLine)
            }

            [void]$sb.AppendLine('')
            [void]$sb.AppendLine('---')
            [void]$sb.AppendLine('')

            # Detailed Checkpoint Logs
            [void]$sb.AppendLine('## Detailed Logs')
            [void]$sb.AppendLine('')

            foreach ($cp in $Checkpoints) {
                [void]$sb.AppendLine("### $($cp.TaskID): $($cp.Description)")
                [void]$sb.AppendLine('')
                [void]$sb.AppendLine("**Status:** $($cp.Status)")
                [void]$sb.AppendLine("**Timestamp:** $($cp.Timestamp)")
                [void]$sb.AppendLine("**Duration:** $($cp.Duration) seconds")
                [void]$sb.AppendLine('')

                if ($cp.Inputs -and $cp.Inputs.Count -gt 0) {
                    [void]$sb.AppendLine('**Inputs:**')
                    foreach ($key in $cp.Inputs.Keys) {
                        [void]$sb.AppendLine("- $key : $($cp.Inputs[$key])")
                    }
                    [void]$sb.AppendLine('')
                }

                if ($cp.Outputs -and $cp.Outputs.Count -gt 0) {
                    [void]$sb.AppendLine('**Outputs:**')
                    foreach ($key in $cp.Outputs.Keys) {
                        [void]$sb.AppendLine("- $key : $($cp.Outputs[$key])")
                    }
                    [void]$sb.AppendLine('')
                }

                if ($cp.Artifacts.Count -gt 0) {
                    [void]$sb.AppendLine("**Artifacts:** $($cp.Artifacts -join ', ')")
                    [void]$sb.AppendLine('')
                }

                [void]$sb.AppendLine("**Signature:** ``$($cp.Signature)``")
                [void]$sb.AppendLine('')
                [void]$sb.AppendLine('---')
                [void]$sb.AppendLine('')
            }

            # Footer
            [void]$sb.AppendLine('## Cryptographic Lineage')
            [void]$sb.AppendLine('')
            [void]$sb.AppendLine('This Codex scroll represents an immutable audit trail of Phase 4 Week 1 operations.')
            [void]$sb.AppendLine('Each checkpoint includes a SHA256 signature placeholder for future verification.')
            [void]$sb.AppendLine('')
            [void]$sb.AppendLine("**Session ID:** $($Checkpoints[0].SessionID)")
            [void]$sb.AppendLine("**Rendered:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss UTC')")

            return $sb.ToString()
        }

        function New-HtmlScroll {
            <#
    .SYNOPSIS
        Generates HTML Codex scroll with Fluent 2 design.

    .DESCRIPTION
        Creates interactive HTML with:
        - Fluent 2 UI components
        - Responsive design
        - Interactive charts
        - Collapsible sections
    #>
            [CmdletBinding()]
            param(
                [Parameter(Mandatory = $true)]
                [array]$Checkpoints,

                [bool]$IncludeMetrics = $true
            )

            $metrics = Get-CheckpointMetrics -Checkpoints $Checkpoints

            $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IntelIntent Phase 4 - Week 1 Codex Scroll</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: $($script:Fluent2Theme.Typography.FontFamily);
            background: $($script:Fluent2Theme.Colors.Background);
            color: $($script:Fluent2Theme.Colors.Text);
            line-height: 1.6;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: $($script:Fluent2Theme.Colors.Surface);
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 40px;
        }

        header {
            border-bottom: 2px solid $($script:Fluent2Theme.Colors.Primary);
            padding-bottom: 20px;
            margin-bottom: 30px;
        }

        h1 {
            font-size: $($script:Fluent2Theme.Typography.H1Size);
            color: $($script:Fluent2Theme.Colors.Primary);
            margin-bottom: 10px;
        }

        h2 {
            font-size: $($script:Fluent2Theme.Typography.H2Size);
            color: $($script:Fluent2Theme.Colors.Primary);
            margin-top: 30px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid $($script:Fluent2Theme.Colors.Border);
        }

        h3 {
            font-size: $($script:Fluent2Theme.Typography.H3Size);
            color: $($script:Fluent2Theme.Colors.TextSecondary);
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .meta-info {
            color: $($script:Fluent2Theme.Colors.TextSecondary);
            font-size: $($script:Fluent2Theme.Typography.BodySize);
            margin-bottom: 20px;
        }

        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .metric-card {
            background: $($script:Fluent2Theme.Colors.Background);
            border: 1px solid $($script:Fluent2Theme.Colors.Border);
            border-radius: 6px;
            padding: 20px;
            text-align: center;
        }

        .metric-value {
            font-size: 32px;
            font-weight: bold;
            color: $($script:Fluent2Theme.Colors.Primary);
        }

        .metric-label {
            font-size: 14px;
            color: $($script:Fluent2Theme.Colors.TextSecondary);
            margin-top: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid $($script:Fluent2Theme.Colors.Border);
        }

        th {
            background: $($script:Fluent2Theme.Colors.Background);
            color: $($script:Fluent2Theme.Colors.TextSecondary);
            font-weight: 600;
        }

        tr:hover {
            background: $($script:Fluent2Theme.Colors.Background);
        }

        .status-success {
            color: $($script:Fluent2Theme.Colors.Success);
            font-weight: bold;
        }

        .status-failed {
            color: $($script:Fluent2Theme.Colors.Error);
            font-weight: bold;
        }

        .status-skipped {
            color: $($script:Fluent2Theme.Colors.Warning);
            font-weight: bold;
        }

        .checkpoint-detail {
            background: $($script:Fluent2Theme.Colors.Background);
            border-left: 4px solid $($script:Fluent2Theme.Colors.Primary);
            padding: 20px;
            margin: 20px 0;
            border-radius: 4px;
        }

        .signature {
            font-family: 'Courier New', monospace;
            background: $($script:Fluent2Theme.Colors.Background);
            padding: 10px;
            border-radius: 4px;
            overflow-x: auto;
            font-size: 12px;
        }

        footer {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid $($script:Fluent2Theme.Colors.Border);
            text-align: center;
            color: $($script:Fluent2Theme.Colors.TextSecondary);
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>IntelIntent Phase 4 - Week 1 Codex Scroll</h1>
            <div class="meta-info">
                <p><strong>Generated:</strong> $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss UTC')</p>
                <p><strong>Session ID:</strong> $($Checkpoints[0].SessionID)</p>
                <p><strong>Total Checkpoints:</strong> $($Checkpoints.Count)</p>
            </div>
        </header>

        <section class="metrics">
            <h2>Executive Summary</h2>
            <div class="metrics-grid">
                <div class="metric-card">
                    <div class="metric-value">$($metrics.TotalOperations)</div>
                    <div class="metric-label">Total Operations</div>
                </div>
                <div class="metric-card">
                    <div class="metric-value status-success">$($metrics.SuccessCount)</div>
                    <div class="metric-label">Successful</div>
                </div>
                <div class="metric-card">
                    <div class="metric-value status-failed">$($metrics.FailureCount)</div>
                    <div class="metric-label">Failed</div>
                </div>
                <div class="metric-card">
                    <div class="metric-value status-skipped">$($metrics.SkippedCount)</div>
                    <div class="metric-label">Skipped</div>
                </div>
                <div class="metric-card">
                    <div class="metric-value">$($metrics.SuccessRate)%</div>
                    <div class="metric-label">Success Rate</div>
                </div>
                <div class="metric-card">
                    <div class="metric-value">$($metrics.TotalDuration)s</div>
                    <div class="metric-label">Total Duration</div>
                </div>
            </div>
        </section>

        <section class="checkpoints">
            <h2>Checkpoint Overview</h2>
            <table>
                <thead>
                    <tr>
                        <th>Task ID</th>
                        <th>Timestamp</th>
                        <th>Status</th>
                        <th>Duration</th>
                        <th>Artifacts</th>
                    </tr>
                </thead>
                <tbody>
"@

            foreach ($cp in $Checkpoints) {
                $statusClass = switch ($cp.Status) {
                    'Success' { 'status-success' }
                    'Failed' { 'status-failed' }
                    'Skipped' { 'status-skipped' }
                    default { '' }
                }

                $statusText = switch ($cp.Status) {
                    'Success' { '[OK] Success' }
                    'Failed' { '[FAIL] Failed' }
                    'Skipped' { '[SKIP] Skipped' }
                    default { $cp.Status }
                }

                $artifacts = if ($cp.Artifacts.Count -gt 0) {
                    $cp.Artifacts -join ', '
                } else {
                    '-'
                }

                $timestamp = ([DateTime]$cp.Timestamp).ToString('HH:mm:ss')

                $html += @"
                    <tr>
                        <td><strong>$($cp.TaskID)</strong></td>
                        <td>$timestamp</td>
                        <td class="$statusClass">$statusText</td>
                        <td>$($cp.Duration)s</td>
                        <td>$artifacts</td>
                    </tr>
"@
            }

            $html += @'
                </tbody>
            </table>
        </section>

        <section class="details">
            <h2>Detailed Logs</h2>
'@

            foreach ($cp in $Checkpoints) {
                $html += @"
            <div class="checkpoint-detail">
                <h3>$($cp.TaskID): $($cp.Description)</h3>
                <p><strong>Status:</strong> $($cp.Status)</p>
                <p><strong>Timestamp:</strong> $($cp.Timestamp)</p>
                <p><strong>Duration:</strong> $($cp.Duration) seconds</p>
"@

                if ($cp.Inputs -and $cp.Inputs.Count -gt 0) {
                    $html += '<p><strong>Inputs:</strong></p><ul>'
                    foreach ($key in $cp.Inputs.Keys) {
                        $html += "<li>$key : $($cp.Inputs[$key])</li>"
                    }
                    $html += '</ul>'
                }

                if ($cp.Outputs -and $cp.Outputs.Count -gt 0) {
                    $html += '<p><strong>Outputs:</strong></p><ul>'
                    foreach ($key in $cp.Outputs.Keys) {
                        $html += "<li>$key : $($cp.Outputs[$key])</li>"
                    }
                    $html += '</ul>'
                }

                if ($cp.Artifacts.Count -gt 0) {
                    $html += "<p><strong>Artifacts:</strong> $($cp.Artifacts -join ', ')</p>"
                }

                $html += @"
                <p><strong>Signature:</strong></p>
                <div class="signature">$($cp.Signature)</div>
            </div>
"@
            }

            $html += @"
        </section>

        <footer>
            <h2>Cryptographic Lineage</h2>
            <p>This Codex scroll represents an immutable audit trail of Phase 4 Week 1 operations.</p>
            <p>Each checkpoint includes a SHA256 signature placeholder for future verification.</p>
            <p><strong>Session ID:</strong> $($Checkpoints[0].SessionID)</p>
            <p><strong>Rendered:</strong> $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss UTC')</p>
        </footer>
    </div>
</body>
</html>
"@

            return $html
        }

        function Get-CheckpointMetrics {
            <#
    .SYNOPSIS
        Calculates aggregated metrics from checkpoint data.
    #>
            [CmdletBinding()]
            param(
                [Parameter(Mandatory = $true)]
                [array]$Checkpoints
            )

            $successCount = ($Checkpoints | Where-Object { $_.Status -eq 'Success' }).Count
            $failureCount = ($Checkpoints | Where-Object { $_.Status -eq 'Failed' }).Count
            $skippedCount = ($Checkpoints | Where-Object { $_.Status -eq 'Skipped' }).Count
            $totalDuration = ($Checkpoints | Measure-Object -Property Duration -Sum).Sum
            $avgDuration = if ($Checkpoints.Count -gt 0) {
                [Math]::Round($totalDuration / $Checkpoints.Count, 2)
            } else {
                0
            }

            $successRate = if ($Checkpoints.Count -gt 0) {
                [Math]::Round(($successCount / $Checkpoints.Count) * 100, 2)
            } else {
                0
            }

            return @{
                TotalOperations = $Checkpoints.Count
                SuccessCount    = $successCount
                FailureCount    = $failureCount
                SkippedCount    = $skippedCount
                SuccessRate     = $successRate
                TotalDuration   = $totalDuration
                AvgDuration     = $avgDuration
            }
        }

        function New-MermaidDependencyGraph {
            <#
    .SYNOPSIS
        Generates Mermaid diagram showing checkpoint dependencies.
    #>
            [CmdletBinding()]
            param(
                [Parameter(Mandatory = $true)]
                [array]$Checkpoints
            )

            $sb = [System.Text.StringBuilder]::new()

            [void]$sb.AppendLine('graph TD')

            foreach ($cp in $Checkpoints) {
                $nodeStyle = switch ($cp.Status) {
                    'Success' { ':::success' }
                    'Failed' { ':::failed' }
                    'Skipped' { ':::skipped' }
                    default { '' }
                }

                $nodeLabel = "$($cp.TaskID)[$($cp.TaskID): $($cp.Description)]$nodeStyle"
                [void]$sb.AppendLine("    $nodeLabel")
            }

            # Add sequential dependencies
            for ($i = 0; $i -lt $Checkpoints.Count - 1; $i++) {
                $current = $Checkpoints[$i].TaskID
                $next = $Checkpoints[$i + 1].TaskID
                [void]$sb.AppendLine("    $current --> $next")
            }

            # Style classes
            [void]$sb.AppendLine('')
            [void]$sb.AppendLine('    classDef success fill:#107C10,stroke:#0B5A0B,color:#fff')
            [void]$sb.AppendLine('    classDef failed fill:#D13438,stroke:#A82729,color:#fff')
            [void]$sb.AppendLine('    classDef skipped fill:#FFC107,stroke:#CC9A06,color:#000')

            return $sb.ToString()
        }

        function Test-CodexRenderer {
            <#
    .SYNOPSIS
        Tests CodexRenderer with sample checkpoint data.

    .EXAMPLE
        Test-CodexRenderer
    #>
            [CmdletBinding()]
            param()

            Write-Host '🧪 Testing CodexRenderer with sample data...' -ForegroundColor Cyan

            # Sample checkpoint data
            $sampleCheckpoints = @(
                @{
                    TaskID      = 'KV-001'
                    Timestamp   = (Get-Date).ToString('o')
                    Status      = 'Success'
                    Description = 'Provision Azure Key Vault'
                    Inputs      = @{ VaultName = 'TestVault'; ResourceGroup = 'TestRG' }
                    Outputs     = @{ VaultUri = 'https://testvault.vault.azure.net/' }
                    Artifacts   = @('TestVault')
                    Signature   = '[Pending SHA256]'
                    Duration    = 12
                    SessionID   = (New-Guid).ToString()
                },
                @{
                    TaskID      = 'RBAC-001'
                    Timestamp   = (Get-Date).AddMinutes(1).ToString('o')
                    Status      = 'Success'
                    Description = 'Create Phase4-Admin RBAC role'
                    Inputs      = @{ RoleName = 'Phase4-Admin' }
                    Outputs     = @{ RoleId = 'role-12345' }
                    Artifacts   = @('Phase4-Admin')
                    Signature   = '[Pending SHA256]'
                    Duration    = 8
                    SessionID   = (New-Guid).ToString()
                },
                @{
                    TaskID      = 'GRAPH-001'
                    Timestamp   = (Get-Date).AddMinutes(2).ToString('o')
                    Status      = 'Failed'
                    Description = 'Configure Microsoft Graph API'
                    Inputs      = @{ AppId = 'test-app' }
                    Outputs     = @{ Error = 'Permission denied' }
                    Artifacts   = @()
                    Signature   = '[Pending SHA256]'
                    Duration    = 5
                    SessionID   = (New-Guid).ToString()
                }
            )

            # Render
            $result = Render-CodexScroll -Checkpoints $sampleCheckpoints -OutputPath '.\Test_Output'

            if ($result.Status -eq 'Success') {
                Write-Host '  ✅ Test successful!' -ForegroundColor Green
                Write-Host "  📄 Markdown: $($result.MarkdownPath)" -ForegroundColor Yellow
                Write-Host "  🌐 HTML: $($result.HtmlPath)" -ForegroundColor Yellow
            } else {
                Write-Error "Test failed: $($result.Error)"
            }
        }

        # Export module members
        Export-ModuleMember -Function @(
            'Render-CodexScroll',
            'New-MarkdownScroll',
            'New-HtmlScroll',
            'Get-CheckpointMetrics',
            'New-MermaidDependencyGraph',
            'Test-CodexRenderer'
        )
