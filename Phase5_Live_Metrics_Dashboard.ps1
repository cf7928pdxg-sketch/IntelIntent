<#
.SYNOPSIS
    Phase 5 Modality Agent - Live Metrics Dashboard (Terminal & Power BI)

.DESCRIPTION
    Real-time sponsor-facing dashboard displaying modality stream metrics, checkpoint progress,
    agent routing accuracy, and ROI transparency. Includes threshold alerts, ceremonial narration,
    and Power BI streaming dataset integration.

.PARAMETER RefreshInterval
    Dashboard refresh rate in seconds. Default: 2

.PARAMETER AlertThreshold
    Confidence threshold triggering alerts (0-1 scale). Default: 0.85

.PARAMETER LatencyThreshold
    Latency threshold in milliseconds triggering alerts. Default: 200

.PARAMETER PowerBIEnabled
    Enable Power BI streaming dataset push. Default: $false (terminal-only)

.PARAMETER PowerBIEndpoint
    Power BI REST API endpoint for streaming dataset. Optional.

.EXAMPLE
    .\Phase5_Live_Metrics_Dashboard.ps1 -RefreshInterval 3

.EXAMPLE
    .\Phase5_Live_Metrics_Dashboard.ps1 -PowerBIEnabled -PowerBIEndpoint "https://api.powerbi.com/..."

.NOTES
    Created: December 1, 2025
    Phase: 5 (Modality Agent)
    Purpose: Sponsor demonstration transparency
#>

param(
    [int]$RefreshInterval = 2,
    [double]$AlertThreshold = 0.85,
    [int]$LatencyThreshold = 200,
    [switch]$PowerBIEnabled,
    [string]$PowerBIEndpoint = ""
)

# Module-level state
$script:DashboardState = @{
    SessionID = (New-Guid).ToString()
    StartTime = Get-Date
    VoiceMetrics = @{ Confidence = 0.0; Latency = 0; Count = 0; Status = "Idle" }
    ScreenMetrics = @{ Confidence = 0.0; Latency = 0; Count = 0; Status = "Idle" }
    WebcamMetrics = @{ Confidence = 0.0; Latency = 0; Count = 0; Status = "Idle" }
    FileMetrics = @{ Throughput = 0; QueueDepth = 0; Count = 0; Status = "Idle" }
    Checkpoints = @{ Total = 0; Success = 0; Failed = 0 }
    AgentRouting = @{ Total = 0; Accurate = 0; Errors = 0 }
    Alerts = @()
}

#region Helper Functions

function Update-VoiceMetrics {
    param([double]$Confidence, [int]$LatencyMs)
    $script:DashboardState.VoiceMetrics.Confidence = $Confidence
    $script:DashboardState.VoiceMetrics.Latency = $LatencyMs
    $script:DashboardState.VoiceMetrics.Count++
    $script:DashboardState.VoiceMetrics.Status = "Active"

    if ($Confidence -lt $AlertThreshold) {
        Add-Alert -Type "Voice" -Message "Confidence below threshold: $Confidence"
    }
    if ($LatencyMs -gt $LatencyThreshold) {
        Add-Alert -Type "Voice" -Message "Latency above threshold: ${LatencyMs}ms"
    }
}

function Update-ScreenMetrics {
    param([double]$Confidence, [int]$LatencyMs)
    $script:DashboardState.ScreenMetrics.Confidence = $Confidence
    $script:DashboardState.ScreenMetrics.Latency = $LatencyMs
    $script:DashboardState.ScreenMetrics.Count++
    $script:DashboardState.ScreenMetrics.Status = "Active"

    if ($Confidence -lt $AlertThreshold) {
        Add-Alert -Type "Screen" -Message "Confidence below threshold: $Confidence"
    }
    if ($LatencyMs -gt $LatencyThreshold) {
        Add-Alert -Type "Screen" -Message "Latency above threshold: ${LatencyMs}ms"
    }
}

function Update-WebcamMetrics {
    param([double]$Confidence, [int]$LatencyMs)
    $script:DashboardState.WebcamMetrics.Confidence = $Confidence
    $script:DashboardState.WebcamMetrics.Latency = $LatencyMs
    $script:DashboardState.WebcamMetrics.Count++
    $script:DashboardState.WebcamMetrics.Status = "Active"

    if ($Confidence -lt $AlertThreshold) {
        Add-Alert -Type "Webcam" -Message "Confidence below threshold: $Confidence"
    }
    if ($LatencyMs -gt $LatencyThreshold) {
        Add-Alert -Type "Webcam" -Message "Latency above threshold: ${LatencyMs}ms"
    }
}

function Update-FileMetrics {
    param([int]$ThroughputRowsPerSec, [int]$QueueDepth)
    $script:DashboardState.FileMetrics.Throughput = $ThroughputRowsPerSec
    $script:DashboardState.FileMetrics.QueueDepth = $QueueDepth
    $script:DashboardState.FileMetrics.Count++
    $script:DashboardState.FileMetrics.Status = "Active"
}

function Update-CheckpointMetrics {
    param([string]$Status)
    $script:DashboardState.Checkpoints.Total++
    if ($Status -eq "Success") {
        $script:DashboardState.Checkpoints.Success++
    } else {
        $script:DashboardState.Checkpoints.Failed++
    }
}

function Update-RoutingMetrics {
    param([bool]$IsAccurate)
    $script:DashboardState.AgentRouting.Total++
    if ($IsAccurate) {
        $script:DashboardState.AgentRouting.Accurate++
    } else {
        $script:DashboardState.AgentRouting.Errors++
    }
}

function Add-Alert {
    param([string]$Type, [string]$Message)
    $alert = @{
        Timestamp = (Get-Date).ToString('HH:mm:ss')
        Type = $Type
        Message = $Message
    }
    $script:DashboardState.Alerts += $alert

    # Keep only last 5 alerts
    if ($script:DashboardState.Alerts.Count -gt 5) {
        $script:DashboardState.Alerts = $script:DashboardState.Alerts[-5..-1]
    }
}

function Get-StatusIcon {
    param([string]$Status, [double]$Confidence, [int]$Latency)

    if ($Status -eq "Idle") { return "⚪" }
    if ($Confidence -lt $AlertThreshold -or $Latency -gt $LatencyThreshold) { return "🟡" }
    return "✅"
}

function Get-ColorForValue {
    param([double]$Value, [double]$Threshold, [bool]$IsLatency = $false)

    if ($IsLatency) {
        if ($Value -gt $Threshold) { return "Red" }
        if ($Value -gt ($Threshold * 0.8)) { return "Yellow" }
        return "Green"
    } else {
        if ($Value -lt $Threshold) { return "Red" }
        if ($Value -lt ($Threshold + 0.05)) { return "Yellow" }
        return "Green"
    }
}

function Render-Dashboard {
    Clear-Host

    $elapsed = ((Get-Date) - $script:DashboardState.StartTime).ToString("hh\:mm\:ss")

    # Header
    Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║          MODALITY AGENT - LIVE METRICS DASHBOARD (Phase 5)                  ║" -ForegroundColor Cyan
    Write-Host "║          Session: $($script:DashboardState.SessionID.Substring(0,8))...    Elapsed: $elapsed                     ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    # Voice Stream
    $voiceIcon = Get-StatusIcon -Status $script:DashboardState.VoiceMetrics.Status `
                                -Confidence $script:DashboardState.VoiceMetrics.Confidence `
                                -Latency $script:DashboardState.VoiceMetrics.Latency
    $voiceConfColor = Get-ColorForValue -Value $script:DashboardState.VoiceMetrics.Confidence -Threshold $AlertThreshold
    $voiceLatColor = Get-ColorForValue -Value $script:DashboardState.VoiceMetrics.Latency -Threshold $LatencyThreshold -IsLatency $true

    Write-Host "🎤 VOICE STREAM" -ForegroundColor Yellow
    Write-Host "   Status: " -NoNewline
    Write-Host "$voiceIcon $($script:DashboardState.VoiceMetrics.Status)" -ForegroundColor White
    Write-Host "   Confidence: " -NoNewline
    Write-Host "$("{0:P0}" -f $script:DashboardState.VoiceMetrics.Confidence)" -ForegroundColor $voiceConfColor -NoNewline
    Write-Host "   │   Latency: " -NoNewline
    Write-Host "$($script:DashboardState.VoiceMetrics.Latency)ms" -ForegroundColor $voiceLatColor -NoNewline
    Write-Host "   │   Operations: $($script:DashboardState.VoiceMetrics.Count)" -ForegroundColor Gray
    Write-Host ""

    # Screen Stream
    $screenIcon = Get-StatusIcon -Status $script:DashboardState.ScreenMetrics.Status `
                                 -Confidence $script:DashboardState.ScreenMetrics.Confidence `
                                 -Latency $script:DashboardState.ScreenMetrics.Latency
    $screenConfColor = Get-ColorForValue -Value $script:DashboardState.ScreenMetrics.Confidence -Threshold $AlertThreshold
    $screenLatColor = Get-ColorForValue -Value $script:DashboardState.ScreenMetrics.Latency -Threshold $LatencyThreshold -IsLatency $true

    Write-Host "🖥️  SCREEN STREAM" -ForegroundColor Yellow
    Write-Host "   Status: " -NoNewline
    Write-Host "$screenIcon $($script:DashboardState.ScreenMetrics.Status)" -ForegroundColor White
    Write-Host "   Confidence: " -NoNewline
    Write-Host "$("{0:P0}" -f $script:DashboardState.ScreenMetrics.Confidence)" -ForegroundColor $screenConfColor -NoNewline
    Write-Host "   │   Latency: " -NoNewline
    Write-Host "$($script:DashboardState.ScreenMetrics.Latency)ms" -ForegroundColor $screenLatColor -NoNewline
    Write-Host "   │   Operations: $($script:DashboardState.ScreenMetrics.Count)" -ForegroundColor Gray
    Write-Host ""

    # Webcam Stream
    $webcamIcon = Get-StatusIcon -Status $script:DashboardState.WebcamMetrics.Status `
                                 -Confidence $script:DashboardState.WebcamMetrics.Confidence `
                                 -Latency $script:DashboardState.WebcamMetrics.Latency
    $webcamConfColor = Get-ColorForValue -Value $script:DashboardState.WebcamMetrics.Confidence -Threshold $AlertThreshold
    $webcamLatColor = Get-ColorForValue -Value $script:DashboardState.WebcamMetrics.Latency -Threshold $LatencyThreshold -IsLatency $true

    Write-Host "📹 WEBCAM STREAM" -ForegroundColor Yellow
    Write-Host "   Status: " -NoNewline
    Write-Host "$webcamIcon $($script:DashboardState.WebcamMetrics.Status)" -ForegroundColor White
    Write-Host "   Confidence: " -NoNewline
    Write-Host "$("{0:P0}" -f $script:DashboardState.WebcamMetrics.Confidence)" -ForegroundColor $webcamConfColor -NoNewline
    Write-Host "   │   Latency: " -NoNewline
    Write-Host "$($script:DashboardState.WebcamMetrics.Latency)ms" -ForegroundColor $webcamLatColor -NoNewline
    Write-Host "   │   Operations: $($script:DashboardState.WebcamMetrics.Count)" -ForegroundColor Gray
    Write-Host ""

    # File Stream
    $fileIcon = if ($script:DashboardState.FileMetrics.Status -eq "Idle") { "⚪" } else { "✅" }

    Write-Host "📄 FILE STREAM" -ForegroundColor Yellow
    Write-Host "   Status: " -NoNewline
    Write-Host "$fileIcon $($script:DashboardState.FileMetrics.Status)" -ForegroundColor White
    Write-Host "   Throughput: " -NoNewline
    Write-Host "$($script:DashboardState.FileMetrics.Throughput) rows/s" -ForegroundColor Cyan -NoNewline
    Write-Host "   │   Queue: " -NoNewline
    Write-Host "$($script:DashboardState.FileMetrics.QueueDepth)" -ForegroundColor $(if ($script:DashboardState.FileMetrics.QueueDepth -gt 0) { "Yellow" } else { "Green" }) -NoNewline
    Write-Host "   │   Operations: $($script:DashboardState.FileMetrics.Count)" -ForegroundColor Gray
    Write-Host ""

    Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host ""

    # Checkpoint Metrics
    $checkpointSuccessRate = if ($script:DashboardState.Checkpoints.Total -gt 0) {
        $script:DashboardState.Checkpoints.Success / $script:DashboardState.Checkpoints.Total
    } else { 0 }
    $checkpointColor = Get-ColorForValue -Value $checkpointSuccessRate -Threshold 0.95

    Write-Host "📝 CHECKPOINT LINEAGE" -ForegroundColor Yellow
    Write-Host "   Total: $($script:DashboardState.Checkpoints.Total)   │   " -NoNewline -ForegroundColor White
    Write-Host "Success: $($script:DashboardState.Checkpoints.Success)" -NoNewline -ForegroundColor Green
    Write-Host "   │   Failed: $($script:DashboardState.Checkpoints.Failed)   │   " -NoNewline -ForegroundColor $(if ($script:DashboardState.Checkpoints.Failed -gt 0) { "Red" } else { "Green" })
    Write-Host "Rate: " -NoNewline -ForegroundColor White
    Write-Host "$("{0:P0}" -f $checkpointSuccessRate)" -ForegroundColor $checkpointColor
    Write-Host ""

    # Agent Routing Metrics
    $routingAccuracy = if ($script:DashboardState.AgentRouting.Total -gt 0) {
        $script:DashboardState.AgentRouting.Accurate / $script:DashboardState.AgentRouting.Total
    } else { 0 }
    $routingColor = Get-ColorForValue -Value $routingAccuracy -Threshold 0.90

    Write-Host "🎯 AGENT ROUTING" -ForegroundColor Yellow
    Write-Host "   Total: $($script:DashboardState.AgentRouting.Total)   │   " -NoNewline -ForegroundColor White
    Write-Host "Accurate: $($script:DashboardState.AgentRouting.Accurate)" -NoNewline -ForegroundColor Green
    Write-Host "   │   Errors: $($script:DashboardState.AgentRouting.Errors)   │   " -NoNewline -ForegroundColor $(if ($script:DashboardState.AgentRouting.Errors -gt 0) { "Red" } else { "Green" })
    Write-Host "Accuracy: " -NoNewline -ForegroundColor White
    Write-Host "$("{0:P0}" -f $routingAccuracy)" -ForegroundColor $routingColor
    Write-Host ""

    # Alerts Section
    if ($script:DashboardState.Alerts.Count -gt 0) {
        Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor DarkGray
        Write-Host ""
        Write-Host "⚠️  ALERTS (Last 5)" -ForegroundColor Red
        $script:DashboardState.Alerts | ForEach-Object {
            Write-Host "   [$($_.Timestamp)] $($_.Type): $($_.Message)" -ForegroundColor Yellow
        }
        Write-Host ""
    }

    # ROI Summary
    Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "💰 ROI TRANSPARENCY" -ForegroundColor Yellow

    # Calculate time savings (demo elapsed vs manual equivalent)
    $manualTimeMinutes = 120  # 2 hours for manual equivalent
    $elapsedSeconds = ((Get-Date) - $script:DashboardState.StartTime).TotalSeconds
    $elapsedMinutes = [math]::Round($elapsedSeconds / 60, 1)
    $timeSavings = if ($elapsedMinutes -gt 0) {
        [math]::Round((($manualTimeMinutes - $elapsedMinutes) / $manualTimeMinutes) * 100, 1)
    } else { 0 }

    Write-Host "   Time Savings: " -NoNewline -ForegroundColor White
    Write-Host "$timeSavings% " -NoNewline -ForegroundColor Green
    Write-Host "($elapsedMinutes min vs $manualTimeMinutes min manual)" -ForegroundColor Gray

    # Accuracy improvement
    $avgConfidence = if ($script:DashboardState.VoiceMetrics.Count -gt 0) {
        ($script:DashboardState.VoiceMetrics.Confidence +
         $script:DashboardState.ScreenMetrics.Confidence +
         $script:DashboardState.WebcamMetrics.Confidence) / 3
    } else { 0 }

    Write-Host "   Avg Confidence: " -NoNewline -ForegroundColor White
    Write-Host "$("{0:P0}" -f $avgConfidence) " -NoNewline -ForegroundColor $(Get-ColorForValue -Value $avgConfidence -Threshold $AlertThreshold)
    Write-Host "(vs 70% manual baseline)" -ForegroundColor Gray

    # Operations per minute
    $opsPerMin = if ($elapsedMinutes -gt 0) {
        [math]::Round(($script:DashboardState.VoiceMetrics.Count +
                       $script:DashboardState.ScreenMetrics.Count +
                       $script:DashboardState.WebcamMetrics.Count +
                       $script:DashboardState.FileMetrics.Count) / $elapsedMinutes, 1)
    } else { 0 }

    Write-Host "   Throughput: " -NoNewline -ForegroundColor White
    Write-Host "$opsPerMin ops/min " -NoNewline -ForegroundColor Cyan
    Write-Host "(multi-stream parallelism)" -ForegroundColor Gray
    Write-Host ""

    # Footer
    Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "  Dashboard refreshing every $RefreshInterval seconds  •  Press Ctrl+C to exit" -ForegroundColor DarkGray
    Write-Host "  Thresholds: Confidence <$("{0:P0}" -f $AlertThreshold), Latency >${LatencyThreshold}ms" -ForegroundColor DarkGray
}

function Push-ToPowerBI {
    param([hashtable]$Metrics)

    if (-not $PowerBIEnabled -or [string]::IsNullOrEmpty($PowerBIEndpoint)) {
        return
    }

    try {
        $payload = @{
            SessionID = $script:DashboardState.SessionID
            Timestamp = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
            VoiceConfidence = $Metrics.VoiceMetrics.Confidence
            VoiceLatency = $Metrics.VoiceMetrics.Latency
            ScreenConfidence = $Metrics.ScreenMetrics.Confidence
            ScreenLatency = $Metrics.ScreenMetrics.Latency
            WebcamConfidence = $Metrics.WebcamMetrics.Confidence
            WebcamLatency = $Metrics.WebcamMetrics.Latency
            FileThroughput = $Metrics.FileMetrics.Throughput
            CheckpointTotal = $Metrics.Checkpoints.Total
            CheckpointSuccess = $Metrics.Checkpoints.Success
            RoutingAccuracy = if ($Metrics.AgentRouting.Total -gt 0) {
                $Metrics.AgentRouting.Accurate / $Metrics.AgentRouting.Total
            } else { 0 }
        }

        $json = $payload | ConvertTo-Json
        Invoke-RestMethod -Uri $PowerBIEndpoint -Method Post -Body $json -ContentType "application/json" -ErrorAction Stop
    } catch {
        # Silent failure - don't interrupt dashboard
        # Could log to file if needed
    }
}

function Start-DemoSimulation {
    # Simulate demo activity for testing
    Write-Host "`n🎬 Starting demo simulation..." -ForegroundColor Cyan
    Write-Host "   (Simulated metrics will update every $RefreshInterval seconds)`n" -ForegroundColor Gray
    Start-Sleep -Seconds 2

    $iteration = 0
    while ($true) {
        $iteration++

        # Simulate Voice stream
        if ($iteration % 3 -eq 0) {
            $voiceConf = 0.85 + (Get-Random -Minimum 0 -Maximum 13) / 100
            $voiceLat = Get-Random -Minimum 800 -Maximum 1500
            Update-VoiceMetrics -Confidence $voiceConf -LatencyMs $voiceLat
            Update-CheckpointMetrics -Status "Success"
            Update-RoutingMetrics -IsAccurate $true
        }

        # Simulate Screen stream
        if ($iteration % 4 -eq 0) {
            $screenConf = 0.88 + (Get-Random -Minimum 0 -Maximum 10) / 100
            $screenLat = Get-Random -Minimum 600 -Maximum 1200
            Update-ScreenMetrics -Confidence $screenConf -LatencyMs $screenLat
            Update-CheckpointMetrics -Status "Success"
            Update-RoutingMetrics -IsAccurate $true
        }

        # Simulate Webcam stream
        if ($iteration % 2 -eq 0) {
            $webcamConf = 0.84 + (Get-Random -Minimum 0 -Maximum 12) / 100
            $webcamLat = Get-Random -Minimum 10 -Maximum 30
            Update-WebcamMetrics -Confidence $webcamConf -LatencyMs $webcamLat
            Update-CheckpointMetrics -Status "Success"
            Update-RoutingMetrics -IsAccurate $true
        }

        # Simulate File stream
        if ($iteration % 5 -eq 0) {
            $throughput = Get-Random -Minimum 100 -Maximum 200
            $queue = Get-Random -Minimum 0 -Maximum 3
            Update-FileMetrics -ThroughputRowsPerSec $throughput -QueueDepth $queue
            Update-CheckpointMetrics -Status "Success"
            Update-RoutingMetrics -IsAccurate $true
        }

        # Render dashboard
        Render-Dashboard

        # Push to Power BI if enabled
        Push-ToPowerBI -Metrics $script:DashboardState

        # Wait for next refresh
        Start-Sleep -Seconds $RefreshInterval
    }
}

#endregion

# Main execution
try {
    Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║  PHASE 5 MODALITY AGENT - LIVE METRICS DASHBOARD           ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

    Write-Host "Session ID: $($script:DashboardState.SessionID)" -ForegroundColor Gray
    Write-Host "Started: $($script:DashboardState.StartTime.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Gray

    if ($PowerBIEnabled) {
        if ([string]::IsNullOrEmpty($PowerBIEndpoint)) {
            Write-Host "⚠️  Power BI enabled but endpoint not provided - terminal mode only" -ForegroundColor Yellow
        } else {
            Write-Host "✅ Power BI streaming enabled: $($PowerBIEndpoint.Substring(0, 40))..." -ForegroundColor Green
        }
    } else {
        Write-Host "📊 Terminal dashboard mode (Power BI disabled)" -ForegroundColor Cyan
    }

    # Start simulation
    Start-DemoSimulation

} catch {
    Write-Host "`n❌ Dashboard error: $_" -ForegroundColor Red
    Write-Host "`nStack trace:" -ForegroundColor Gray
    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray
} finally {
    Write-Host "`n🔮 Dashboard session ended." -ForegroundColor Cyan
    Write-Host "   Final metrics exported to: Dashboard_Session_$($script:DashboardState.SessionID).json" -ForegroundColor Gray

    # Export final state
    $exportPath = ".\Dashboard_Session_$($script:DashboardState.SessionID).json"
    $script:DashboardState | ConvertTo-Json -Depth 10 | Out-File -FilePath $exportPath -Encoding UTF8
}
