
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║         IntelIntent - Interactive Module Launcher         ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "Infrastructure Components:" -ForegroundColor Yellow
Write-Host "  1. Identity Modules"
Write-Host "  2. Environment Setup"
Write-Host "  3. Tooling"
Write-Host "  4. Services"
Write-Host "  5. Enhancements"
Write-Host "  6. Security Validation"
Write-Host "  7. Remote Updates"
Write-Host "  8. Autopilot Provisioning"
Write-Host "  9. CI/CD Workflows"
Write-Host ""
Write-Host "Agent Testing (No Azure Dependencies):" -ForegroundColor Green
Write-Host "  10. Test Finance Agent       (Portfolio management)"
Write-Host "  11. Test Boopas Agent        (POS & inventory)"
Write-Host "  12. Test Modality Agent      (Voice, Screen, Webcam, File streams)" -ForegroundColor Green
Write-Host ""
Write-Host "System Operations:" -ForegroundColor Cyan
Write-Host "  0. Run All Infrastructure Components"
Write-Host "  Q. Quit"
Write-Host ""
$choice = Read-Host "Enter your choice"

switch ($choice.ToUpper()) {
    "1" { & .\Identity_Modules\Identity_Modules_component.ps1 }
    "2" { & .\Environment_Setup\Environment_Setup_component.ps1 }
    "3" { & .\Tooling\Tooling_component.ps1 }
    "4" { & .\Services\Services_component.ps1 }
    "5" { & .\Enhancements\Enhancements_component.ps1 }
    "6" { & .\Security_Validation\Security_Validation_component.ps1 }
    "7" { & .\Remote_Updates\Remote_Updates_component.ps1 }
    "8" { & .\Autopilot_Provisioning\Autopilot_Provisioning_component.ps1 }
    "9" { & .\CI_CD_Workflows\CI_CD_Workflows_component.ps1 }
    "10" {
        Write-Host "`n🚀 Launching Finance Agent Test Suite...`n" -ForegroundColor Green
        & .\Test-FinanceAgent.ps1
    }
    "11" {
        Write-Host "`n🏪 Launching Boopas Agent Test Suite...`n" -ForegroundColor Green
        & .\Test-BoopasAgent.ps1
    }
    "12" {
        Write-Host "`n🔮 Launching Modality Agent...`n" -ForegroundColor Cyan
        Import-Module .\IntelIntent_Seeding\ModalityDataHelper.psm1 -Force

        Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
        Write-Host "🎯 MODALITY AGENT - MULTI-MODAL INPUT ORCHESTRATION 🎯" -ForegroundColor Green
        Write-Host "═══════════════════════════════════════════════════════`n" -ForegroundColor Cyan

        Write-Host "Select Input Channel:" -ForegroundColor Yellow
        Write-Host "  1. Voice Stream      (Speech-to-text, intent extraction)"
        Write-Host "  2. Screen Stream     (Screen capture, OCR text extraction)"
        Write-Host "  3. Webcam Stream     (Frame capture, gesture detection)"
        Write-Host "  4. File Stream       (CSV/PDF parsing, bulk import)"
        Write-Host "  5. Context Status    (View session state)"
        Write-Host "  Q. Back to Main Menu`n"

        $modalityChoice = Read-Host "Enter choice"

        switch ($modalityChoice.ToUpper()) {
            "1" {
                Write-Host "`n🎤 VOICE STREAM DEMO`n" -ForegroundColor Green

                $result = Invoke-ModalityAgent -InputChannel "Voice" -InputData @{
                    AudioFile = "sample_voice_query.wav"
                    SubscriptionKey = "demo-key"
                    Region = "centralus"
                }

                Write-Host "Status: $($result.Status)" -ForegroundColor $(if ($result.Status -eq "Success") { "Green" } else { "Red" })
                Write-Host "Input Type: $($result.InputType)"
                Write-Host "Transcript: $($result.Transcript)" -ForegroundColor Cyan
                Write-Host "Intent: $($result.Intent)" -ForegroundColor Yellow
                Write-Host "Agent Route: $($result.AgentRoute)" -ForegroundColor Magenta
                Write-Host "Confidence: $($result.Confidence)"
            }
            "2" {
                Write-Host "`n📺 SCREEN STREAM DEMO`n" -ForegroundColor Green

                $result = Invoke-ModalityAgent -InputChannel "Screen" -InputData @{
                    WindowTitle = "Microsoft Excel"
                    SubscriptionKey = "demo-key"
                    Region = "centralus"
                }

                Write-Host "Status: $($result.Status)" -ForegroundColor $(if ($result.Status -eq "Success") { "Green" } else { "Red" })
                Write-Host "Input Type: $($result.InputType)"
                Write-Host "Window: $($result.WindowTitle)" -ForegroundColor Cyan
                Write-Host "Extracted Text: $($result.ExtractedText)" -ForegroundColor Yellow
                Write-Host "OCR Confidence: $($result.Confidence)"
            }
            "3" {
                Write-Host "`n📷 WEBCAM STREAM DEMO`n" -ForegroundColor Green

                $result = Invoke-ModalityAgent -InputChannel "Webcam" -InputData @{
                    DeviceID = 0
                    Duration = 5
                    FPS = 10
                }

                Write-Host "Status: $($result.Status)" -ForegroundColor $(if ($result.Status -eq "Success") { "Green" } else { "Red" })
                Write-Host "Input Type: $($result.InputType)"
                Write-Host "Frame Count: $($result.FrameCount)" -ForegroundColor Cyan
                Write-Host "Duration: $($result.Duration) seconds"
                Write-Host "Actual FPS: $($result.ActualFPS)"
                Write-Host "Resolution: $($result.Resolution)" -ForegroundColor Yellow
            }
            "4" {
                Write-Host "`n📄 FILE STREAM DEMO`n" -ForegroundColor Green

                Write-Host "Select file type to process:" -ForegroundColor Yellow
                Write-Host "  1. CSV File (Bulk import)"
                Write-Host "  2. PDF File (Text extraction)"

                $fileType = Read-Host "Enter choice"

                if ($fileType -eq "1") {
                    $result = Invoke-ModalityAgent -InputChannel "File" -InputData @{
                        FilePath = "sample_transactions.csv"
                        MaxSizeMB = 50
                    }

                    Write-Host "`nStatus: $($result.Status)" -ForegroundColor $(if ($result.Status -eq "Success") { "Green" } else { "Red" })
                    Write-Host "File: $($result.FileName)" -ForegroundColor Cyan
                    Write-Host "MIME Type: $($result.MimeType)"
                    Write-Host "Size: $($result.FileSizeMB) MB"
                    Write-Host "Parsed Rows: $($result.ParsedRows)" -ForegroundColor Yellow
                    Write-Host "Agent Route: $($result.AgentRoute)" -ForegroundColor Magenta
                } elseif ($fileType -eq "2") {
                    $result = Invoke-ModalityAgent -InputChannel "File" -InputData @{
                        FilePath = "sample_report.pdf"
                        MaxSizeMB = 50
                    }

                    Write-Host "`nStatus: $($result.Status)" -ForegroundColor $(if ($result.Status -eq "Success") { "Green" } else { "Red" })
                    Write-Host "File: $($result.FileName)" -ForegroundColor Cyan
                    Write-Host "MIME Type: $($result.MimeType)"
                    Write-Host "Extraction Method: $($result.ExtractionMethod)" -ForegroundColor Yellow
                    Write-Host "Confidence: $($result.Confidence)"
                    Write-Host "Agent Route: $($result.AgentRoute)" -ForegroundColor Magenta
                }
            }
            "5" {
                Write-Host "`n📊 SESSION CONTEXT`n" -ForegroundColor Green

                $context = Get-ModalityContext

                Write-Host "Session ID: $($context.SessionID)" -ForegroundColor Cyan
                Write-Host "Start Time: $($context.StartTime)"
                Write-Host "Input Channels Used: $($context.InputChannels -join ', ')" -ForegroundColor Yellow
                Write-Host "Total Calls: $($context.CallHistory.Count)"

                if ($context.CallHistory.Count -gt 0) {
                    Write-Host "`nRecent Calls:" -ForegroundColor Magenta
                    $context.CallHistory | Select-Object -Last 5 | ForEach-Object {
                        Write-Host "  - $($_.Timestamp): $($_.InputType) → $($_.AgentRoute)"
                    }
                }
            }
            "Q" {
                Write-Host "`nReturning to main menu...`n" -ForegroundColor Cyan
            }
            default {
                Write-Host "`n❌ Invalid choice.`n" -ForegroundColor Red
            }
        }

        Write-Host "`nPress Enter to continue..." -ForegroundColor Gray
        Read-Host
    }
    "0" {
        Write-Host "`n🔄 Running all infrastructure components...`n" -ForegroundColor Cyan
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
    "Q" {
        Write-Host "`n👋 Exiting IntelIntent Launcher. Goodbye!`n" -ForegroundColor Cyan
        exit
    }
    default {
        Write-Host "`n❌ Invalid choice. Please select 1-12, 0, or Q.`n" -ForegroundColor Red
    }
}
