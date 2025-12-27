@echo off
chcp 65001 >nul
color 0C

echo ========================================
echo   FORCER LE REDÉPLOIEMENT
echo   Solution Radicale Anti-Cache
echo ========================================
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0FORCER_REDEPLOY.ps1"

pause

