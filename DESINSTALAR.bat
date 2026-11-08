@echo off
chcp 65001 >nul
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0DESINSTALAR.ps1"
echo.
pause
