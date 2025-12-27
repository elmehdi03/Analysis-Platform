@echo off
chcp 65001 >nul
color 0B

echo ========================================
echo   DEMARRAGE STREAMING ANALYTICS
echo ========================================
echo.

:: Vérifier Docker
echo Verification de Docker...
docker ps >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo.
    echo ERREUR: Docker n'est pas en cours d'execution!
    echo.
    echo SOLUTION:
    echo 1. Demarrez Docker Desktop
    echo 2. Attendez que Docker soit pret
    echo 3. Double-cliquez sur ce fichier a nouveau
    echo.
    pause
    exit /b 1
)

echo Docker OK!
echo.

:: Arrêter les anciens containers
echo Arret des anciens containers...
docker-compose down >nul 2>&1
echo.

:: Démarrer les containers
echo Demarrage des containers...
echo (Cela peut prendre 30-60 secondes)
echo.
docker-compose up -d --build

echo.
echo Attente du demarrage complet...
timeout /t 30 /nobreak >nul

echo.
color 0A
echo ========================================
echo   APPLICATION DEMARREE!
echo ========================================
echo.
echo URLS disponibles:
echo.
echo   Accueil:
echo   http://localhost:8080/analytics-dashboard/
echo.
echo   Dashboard (NOUVEAU DESIGN):
echo   http://localhost:8080/analytics-dashboard/dashboard
echo.
echo   Statistics:
echo   http://localhost:8080/analytics-dashboard/stats
echo.
echo   API Health:
echo   http://localhost:8080/analytics-api/api/v1/analytics/health
echo.
echo ========================================
echo.
echo Etat des containers:
docker ps --format "table {{.Names}}\t{{.Status}}"
echo.
echo ========================================
echo.
echo REMARQUE: Si vous ne voyez pas les changements:
echo   - Appuyez sur Ctrl+F5 dans votre navigateur
echo   - Ou videz le cache du navigateur
echo.
pause

