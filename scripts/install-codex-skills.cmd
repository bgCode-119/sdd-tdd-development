@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
powershell -ExecutionPolicy Bypass -File "%SCRIPT_DIR%install-codex-skills.ps1" %*

endlocal
