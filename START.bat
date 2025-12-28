@echo off
REM Script de démarrage pour la plateforme Streaming Analytics
REM Date: 2025-12-28

echo ========================================
echo   Streaming Analytics Platform - START
echo ========================================
echo.

REM Étape 1: Vérifier Docker
echo [1/5] Vérification de Docker...
docker info >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERREUR: Docker n'est pas en cours d'execution!
    echo Veuillez demarrer Docker Desktop et reessayer.
    pause
    exit /b 1
)
echo OK - Docker est en cours d'execution
echo.

REM Étape 2: Vérifier et libérer les ports
echo [2/6] Verification des ports...
for %%p in (27017 8080 8081) do (
    netstat -ano | findstr :%%p | findstr LISTENING >nul 2>&1
    if not errorlevel 1 (
        echo Port %%p occupe, liberation...
        docker-compose down -v >nul 2>&1
        timeout /t 2 /nobreak >nul
    )
)
echo OK - Ports disponibles
echo.

REM Étape 3: Nettoyer les anciens conteneurs
echo [3/6] Nettoyage des anciens conteneurs...
docker-compose down -v >nul 2>&1
echo OK - Nettoyage termine
echo.

REM Étape 4: Compiler le projet
echo [4/6] Compilation du projet Maven...
call mvn clean package -DskipTests
if %ERRORLEVEL% NEQ 0 (
    echo ERREUR: La compilation a echoue!
    pause
    exit /b 1
)
echo OK - Compilation reussie
echo.

REM Étape 5: Démarrer les services Docker
echo [5/6] Demarrage des services Docker...
docker-compose up -d
if %ERRORLEVEL% NEQ 0 (
    echo ERREUR: Le demarrage des services a echoue!
    pause
    exit /b 1
)
echo OK - Services demarres
echo.

REM Étape 6: Attendre que les services soient prêts
echo [6/6] Attente du demarrage complet (30 secondes)...
timeout /t 30 /nobreak >nul
echo OK - Services prets!
echo.

REM Afficher les URLs
echo ========================================
echo   SERVICES DISPONIBLES
echo ========================================
echo.
echo Dashboard:        http://localhost:8080/analytics-dashboard/
echo API:              http://localhost:8080/analytics-api/api/v1/analytics/health
echo Mongo Express:    http://localhost:8081
echo MongoDB:          mongodb://admin:admin123@localhost:27017
echo.
echo ========================================
echo   COMMANDES UTILES
echo ========================================
echo.
echo Voir les logs:        docker-compose logs -f
echo Arreter les services: docker-compose down
echo Redemarrer:           docker-compose restart
echo.
echo Bon developpement!
echo.
pause

