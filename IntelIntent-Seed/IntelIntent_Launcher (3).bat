@echo off
setlocal

:: Define the folder and script path
set "IntelIntentFolder=C:\IntelIntent"
set "BootstrapScript=%IntelIntentFolder%\IntelIntent_Bootstrap.ps1"

:: Open the IntelIntent folder
start "" "%IntelIntentFolder%"

:: Check if the PowerShell script exists
if exist "%BootstrapScript%" (
    echo Running IntelIntent Bootstrap Script...
    powershell.exe -ExecutionPolicy Bypass -File "%BootstrapScript%"
) else (
    echo ERROR: IntelIntent_Bootstrap.ps1 not found in %IntelIntentFolder%
    pause
)

endlocal
