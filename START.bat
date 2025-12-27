@echo off
chcp 65001 >nul
cls

echo ========================================
echo   DÉMARRAGE STREAMING ANALYTICS
echo ========================================
echo.

REM Vérifier Docker
echo Vérification de Docker...
docker ps >nul 2>&1
if errorlevel 1 (
    echo.
    echo [ERREUR] Docker n'est pas en cours d'exécution!
    echo.
    echo SOLUTION :
    echo 1. Ouvrez Docker Desktop
    echo 2. Attendez que Docker soit complètement démarré
    echo 3. Réexécutez ce script
    echo.
    pause
    exit /b 1
)

echo [OK] Docker est en cours d'exécution
echo.

REM Arrêter les conteneurs existants
echo Arrêt des conteneurs existants...
docker-compose down >nul 2>&1
echo.

REM Démarrer les conteneurs
echo Démarrage des conteneurs...
docker-compose up -d

if errorlevel 1 (
    echo.
    echo [ERREUR] Impossible de démarrer les conteneurs
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] Conteneurs démarrés avec succès!
echo.

REM Attendre que Tomcat soit prêt
echo Attente du démarrage de Tomcat...
echo (Cela peut prendre 30-60 secondes)
echo.

timeout /t 40 /nobreak >nul

echo.
echo ========================================
echo   PROJET DÉMARRÉ AVEC SUCCÈS!
echo ========================================
echo.
echo URLs disponibles :
echo.
echo   🏠 Page d'accueil :
echo      http://localhost:8080/analytics-dashboard/
echo.
echo   📊 Dashboard :
echo      http://localhost:8080/analytics-dashboard/dashboard
echo.
echo   🗄️ MongoDB Express :
echo      http://localhost:8081/
echo.
echo ========================================
echo.

REM Ouvrir le navigateur
echo Ouverture du navigateur...
start http://localhost:8080/analytics-dashboard/

echo.
echo Pour voir les logs : docker logs -f streaming-tomcat
echo Pour arrêter : docker-compose down
echo.
pause

