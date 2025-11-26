
Write-Host "IntelIntent Mutation Launcher"
Write-Host "==================================="
Write-Host "Select a module to run:"
Write-Host "1. Identity Modules"
Write-Host "2. Environment Setup"
Write-Host "3. Tooling"
Write-Host "4. Services"
Write-Host "5. Enhancements"
Write-Host "6. Security Validation"
Write-Host "7. Remote Updates"
Write-Host "8. Autopilot Provisioning"
Write-Host "9. CI/CD Workflows"
Write-Host "0. Run All"
$choice = Read-Host "Enter your choice"

switch ($choice) {
    "1" { & .\Identity_Modules\Identity_Modules_component.ps1 }
    "2" { & .\Environment_Setup\Environment_Setup_component.ps1 }
    "3" { & .\Tooling\Tooling_component.ps1 }
    "4" { & .\Services\Services_component.ps1 }
    "5" { & .\Enhancements\Enhancements_component.ps1 }
    "6" { & .\Security_Validation\Security_Validation_component.ps1 }
    "7" { & .\Remote_Updates\Remote_Updates_component.ps1 }
    "8" { & .\Autopilot_Provisioning\Autopilot_Provisioning_component.ps1 }
    "9" { & .\CI_CD_Workflows\CI_CD_Workflows_component.ps1 }
    "0" {
        & .\Identity_Modules\Identity_Modules_component.ps1
        & .\Environment_Setup\Environment_Setup_component.ps1
        & .\Tooling\Tooling_component.ps1
        & .\Services\Services_component.ps1
        & .\Enhancements\Enhancements_component.ps1
        & .\Security_Validation\Security_Validation_component.ps1
        & .\Remote_Updates\Remote_Updates_component.ps1
        & .\Autopilot_Provisioning\Autopilot_Provisioning_component.ps1
        & .\CI_CD_Workflows\CI_CD_Workflows_component.ps1
    }
    default { Write-Host "Invalid choice." }
}
