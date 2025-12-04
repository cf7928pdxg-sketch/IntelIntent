@echo off
set SCRIPT_PATH=C:\IntelIntent\IntelIntent_Bootstrap.ps1
set LOG_PATH=C:\IntelIntent\IntelIntent_Logs/bootstrap_log.txt
set CHECKPOINT_PATH=C:\IntelIntent\IntelIntent_Logs/semantic_checkpoint.txt

:: Create log directory if it doesn't exist
if not exist "C:\IntelIntent\IntelIntent_Logs" (
    mkdir "C:\IntelIntent\IntelIntent_Logs"
)

:: Log start time
echo [%DATE% %TIME%] Starting IntelIntent Bootstrap >> "%LOG_PATH%"

:: Check if script exists
if not exist "%SCRIPT_PATH%" (
    echo ERROR: Bootstrap script not found. >> "%LOG_PATH%"
    exit /b
)

:: Check internet connectivity
ping -n 1 8.8.8.8 >nul
if errorlevel 1 (
    echo ERROR: No internet connectivity. >> "%LOG_PATH%"
    exit /b
)

:: Semantic checkpoint
echo [%DATE% %TIME%] Semantic Checkpoint: >> "%CHECKPOINT_PATH%"
echo Current State: IntelIntent system initialized with backup and propagation modules. >> "%CHECKPOINT_PATH%"
echo Future Goal: IntelIntent system fully recursive, self-healing, and cloud-synced. >> "%CHECKPOINT_PATH%"
echo ⚠️ Misalignment detected. Adjustments may be required. >> "%CHECKPOINT_PATH%"

:: Execute PowerShell script
powershell.exe -ExecutionPolicy Bypass -File "%SCRIPT_PATH%" >> "%LOG_PATH%"

:: Log completion
echo [%DATE% %TIME%] Bootstrap Completed >> "%LOG_PATH%"
pause
