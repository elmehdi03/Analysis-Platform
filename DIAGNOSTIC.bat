@echo off
chcp 65001 >nul
color 0E

echo ========================================
echo   DIAGNOSTIC DASHBOARD
echo   Quelle version est active?
echo ========================================
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0DIAGNOSTIC.ps1"

pause

