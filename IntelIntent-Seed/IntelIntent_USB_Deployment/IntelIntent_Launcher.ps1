
Start-Process "$PSScriptRoot\IntelIntent_Visual_Dashboard.html"  # Launch visual dashboard

function Show-Menu {
    Clear-Host
    Write-Host "IntelIntent Mutation Launcher" -ForegroundColor Cyan
    Write-Host "================================="
    Write-Host "1. Run Identity Modules"
    Write-Host "2. Run Environment Setup"
    Write-Host "3. Run Tooling Setup"
    Write-Host "4. Run Services"
    Write-Host "5. Run Enhancements"
    Write-Host "6. Run Security Validation"
    Write-Host "7. Run Remote Updates"
    Write-Host "8. Run Autopilot Provisioning"
    Write-Host "9. Run CI/CD Workflows"
    Write-Host "0. Exit"
}

do {
    Show-Menu
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        "1" { Write-Host "Running Identity Modules..." }
        "2" { Write-Host "Running Environment Setup..." }
        "3" { Write-Host "Running Tooling Setup..." }
        "4" { Write-Host "Running Services..." }
        "5" { Write-Host "Running Enhancements..." }
        "6" { Write-Host "Running Security Validation..." }
        "7" { Write-Host "Running Remote Updates..." }
        "8" { Write-Host "Running Autopilot Provisioning..." }
        "9" { Write-Host "Running CI/CD Workflows..." }
        "0" { Write-Host "Exiting..." }
        default { Write-Host "Invalid choice. Try again." }
    }
} while ($choice -ne "0")
