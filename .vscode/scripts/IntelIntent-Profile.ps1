<#
.SYNOPSIS
    IntelIntent Development PowerShell Profile Snippet

.DESCRIPTION
    Add this to your PowerShell profile ($PROFILE) for IntelIntent-specific shortcuts
    and environment setup when working in the IntelIntent workspace.

.NOTES
    To use: Copy contents to $PROFILE or dot-source this file:
    . .\.vscode\scripts\IntelIntent-Profile.ps1
#>

# ============================================================
# Environment Variables
# ============================================================
$env:INTELINTENT_HOME = $PWD.Path
$env:INTELINTENT_SEED_PATH = Join-Path $env:INTELINTENT_HOME "IntelIntent-Seed"
$env:INTELINTENT_SEEDING_PATH = Join-Path $env:INTELINTENT_HOME "IntelIntent_Seeding"

# ============================================================
# Aliases
# ============================================================
Set-Alias -Name week1 -Value "$env:INTELINTENT_HOME\Week1_Automation.ps1"
Set-Alias -Name orchestrate -Value "$env:INTELINTENT_SEEDING_PATH\Orchestrator.ps1"
Set-Alias -Name launch -Value "$env:INTELINTENT_HOME\IntelIntent_Launcher.ps1"

# ============================================================
# Helper Functions
# ============================================================

function Start-IntelIntentDryRun {
    <#
    .SYNOPSIS
        Quick alias for Week1 automation in DryRun mode
    #>
    & "$env:INTELINTENT_HOME\Week1_Automation.ps1" -DryRun -SkipEmail
}
Set-Alias -Name iidry -Value Start-IntelIntentDryRun

function Get-IntelIntentCheckpoints {
    <#
    .SYNOPSIS
        Display checkpoints in formatted table
    #>
    $checkpointPath = Join-Path $env:INTELINTENT_HOME "Week1_Checkpoints.json"
    if (Test-Path $checkpointPath) {
        $data = Get-Content $checkpointPath | ConvertFrom-Json
        Write-Host "`nSession: $($data.SessionID)" -ForegroundColor Cyan
        $data.Checkpoints | Format-Table TaskID, Status, Duration, @{Label = "Time"; Expression = { $_.Timestamp } }
    }
    else {
        Write-Host "No checkpoints found. Run 'iidry' to generate." -ForegroundColor Yellow
    }
}
Set-Alias -Name iicp -Value Get-IntelIntentCheckpoints

function Test-IntelIntentModules {
    <#
    .SYNOPSIS
        Check module implementation status
    #>
    & "$env:INTELINTENT_HOME\.vscode\scripts\Check-MissingModules.ps1"
}
Set-Alias -Name iimod -Value Test-IntelIntentModules

function Test-IntelIntentAzure {
    <#
    .SYNOPSIS
        Validate Azure CLI authentication
    #>
    Write-Host "🔍 Checking Azure connection..." -ForegroundColor Cyan
    $account = az account show 2>$null | ConvertFrom-Json

    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Connected to Azure" -ForegroundColor Green
        Write-Host "   Subscription: $($account.name)" -ForegroundColor Gray
        Write-Host "   Tenant: $($account.tenantId)" -ForegroundColor Gray
    }
    else {
        Write-Host "❌ Not logged in to Azure. Run 'az login'" -ForegroundColor Red
    }
}
Set-Alias -Name iiaz -Value Test-IntelIntentAzure

function New-IntelIntentModule {
    <#
    .SYNOPSIS
        Scaffold a new PowerShell module with IntelIntent conventions
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$ModuleName
    )

    $modulePath = Join-Path $env:INTELINTENT_SEEDING_PATH "$ModuleName.psm1"

    if (Test-Path $modulePath) {
        Write-Host "❌ Module already exists: $modulePath" -ForegroundColor Red
        return
    }

    $template = @"
# $ModuleName.psm1
# Purpose: [Brief description]

<#
.SYNOPSIS
    [Module purpose]

.DESCRIPTION
    [Detailed description]

.NOTES
    Author: IntelIntent Orchestration System
    Date: $(Get-Date -Format 'yyyy-MM-dd')
#>

# === Module State ===
`$script:ModuleState = @{
    SessionID = (New-Guid).ToString()
}

# === Core Functions ===

function Get-ModuleState {
    <#
    .SYNOPSIS
        Returns current module state
    #>
    return `$script:ModuleState
}

# Export module members
Export-ModuleMember -Function @(
    'Get-ModuleState'
)
"@

    Set-Content -Path $modulePath -Value $template
    Write-Host "✅ Created module: $modulePath" -ForegroundColor Green
    code $modulePath
}
Set-Alias -Name iimod-new -Value New-IntelIntentModule

# ============================================================
# Startup Banner
# ============================================================
function Show-IntelIntentBanner {
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  IntelIntent Development Environment" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Quick Commands:" -ForegroundColor Yellow
    Write-Host "  iidry         - Run Week1 automation (DryRun mode)" -ForegroundColor Gray
    Write-Host "  iicp          - View checkpoints" -ForegroundColor Gray
    Write-Host "  iimod         - Check module status" -ForegroundColor Gray
    Write-Host "  iiaz          - Validate Azure connection" -ForegroundColor Gray
    Write-Host "  iimod-new     - Create new module" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Core Scripts:" -ForegroundColor Yellow
    Write-Host "  week1         - Week1_Automation.ps1" -ForegroundColor Gray
    Write-Host "  orchestrate   - Orchestrator.ps1" -ForegroundColor Gray
    Write-Host "  launch        - IntelIntent_Launcher.ps1" -ForegroundColor Gray
    Write-Host ""
}

# Show banner on profile load (comment out if too verbose)
# Show-IntelIntentBanner
