@echo off
chcp 65001 >nul
color 0B

echo ========================================
echo   REDÉPLOIEMENT DU DASHBOARD
echo   Design Unifié
echo ========================================
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0REDEPLOY_DASHBOARD.ps1"

pause

