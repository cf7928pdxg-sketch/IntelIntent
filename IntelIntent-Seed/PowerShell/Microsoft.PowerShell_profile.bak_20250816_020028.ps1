# PowerShell Profile for CoE Development
# Save this file to: $PROFILE (Use $PROFILE in PowerShell to see the location)

# Set PSGallery as trusted repository if not already trusted
if ((Get-PSRepository -Name "PSGallery").InstallationPolicy -ne "Trusted") {
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    Write-Host "Set PSGallery as a trusted repository" -ForegroundColor Green
}

# Import modules needed for development
$modulesToLoad = @(
    "PSScriptAnalyzer"
)

foreach ($module in $modulesToLoad) {
    if (-not (Get-Module -Name $module -ListAvailable)) {
        Write-Host "Installing module: $module" -ForegroundColor Yellow
        Install-Module -Name $module -Scope CurrentUser -Force
    }
    
    try {
        Import-Module -Name $module -ErrorAction Stop
        Write-Host "Module loaded: $module" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to import module: $module - $_" -ForegroundColor Red
    }
}

# Create aliases for common development tasks
Set-Alias -Name sca -Value Invoke-ScriptAnalyzer

# Function to analyze code against PSScriptAnalyzer rules
function Invoke-CodeQuality {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    
    $analysisFolderPath = "coe\analysis\PSScriptAnalyzerSettings.psd1"
    $settings = Join-Path -Path (Get-Location) -ChildPath $analysisFolderPath
    
    if (-not (Test-Path $settings)) {
        Write-Warning "PSScriptAnalyzerSettings.psd1 not found at $settings"
        Write-Host "Using default settings"
        Invoke-ScriptAnalyzer -Path $Path -Recurse
    }
    else {
        Invoke-ScriptAnalyzer -Path $Path -Settings $settings -Recurse
    }
}
Set-Alias -Name quality -Value Invoke-CodeQuality

# Function to quickly navigate to CoE directories
function Set-CoELocation {
    param (
        [ValidateSet("Root", "Core", "Analysis", "Metrics")]
        [string]$Location = "Root"
    )
    
    $rootPath = "c:\Users\Nic\OneDrive\unified-coe"
    
    switch ($Location) {
        "Root" { Set-Location -Path $rootPath }
        "Core" { Set-Location -Path "$rootPath\coe" }
        "Analysis" { Set-Location -Path "$rootPath\coe\analysis" }
        "Metrics" { Set-Location -Path "$rootPath\coe\metrics" }
    }
    
    Write-Host "Changed location to: $((Get-Location).Path)" -ForegroundColor Cyan
}
Set-Alias -Name coe -Value Set-CoELocation

# Display CoE development environment info
function Show-CoEEnvironment {
    Write-Host "=== Partner Center CoE Development Environment ===" -ForegroundColor Cyan
    
    # Check PowerShell version
    $psVersion = $PSVersionTable.PSVersion
    Write-Host "PowerShell Version: $($psVersion.Major).$($psVersion.Minor).$($psVersion.Patch)" `
        -ForegroundColor Yellow
    
    # Check required modules
    $requiredModules = @(
        "PSScriptAnalyzer",
        "Az.Accounts",
        "Az.Resources",
        "PartnerCenter"
    )
    
    Write-Host "Required Modules:" -ForegroundColor Yellow
    foreach ($module in $requiredModules) {
        $m = Get-Module -Name $module -ListAvailable | 
            Sort-Object Version -Descending | 
            Select-Object -First 1
        if ($m) {
            Write-Host "  [✓] $module v$($m.Version)" -ForegroundColor Green
        }
        else {
            Write-Host "  [✗] $module (Not Installed)" -ForegroundColor Red
        }
    }
    
    Write-Host "`nCommands:" -ForegroundColor Yellow
    Write-Host "  quality <path>  - Run PSScriptAnalyzer on specified path" -ForegroundColor Gray
    Write-Host "  coe <location>  - Navigate to CoE directories (Root, Core, Analysis, Metrics)" `
        -ForegroundColor Gray
    Write-Host "  help-coe        - Show this help message" -ForegroundColor Gray
    
    Write-Host "`nRepository Location: $(Join-Path $rootPath)" -ForegroundColor Cyan
}
Set-Alias -Name help-coe -Value Show-CoEEnvironment

# Show environment info when profile loads
Show-CoEEnvironment
