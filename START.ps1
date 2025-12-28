#!/usr/bin/env pwsh
# Script de démarrage pour la plateforme Streaming Analytics
# Auteur: Plateforme Analytics
# Date: 2025-12-28

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Streaming Analytics Platform - START" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Étape 1: Vérifier Docker
Write-Host "[1/6] Verification de Docker..." -ForegroundColor Yellow
$dockerRunning = docker info 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERREUR: Docker n'est pas en cours d'execution!" -ForegroundColor Red
    Write-Host "Veuillez demarrer Docker Desktop et reessayer." -ForegroundColor Red
    exit 1
}
Write-Host "Docker est en cours d'execution" -ForegroundColor Green
Write-Host ""

# Étape 2: Vérifier et libérer les ports
Write-Host "[2/6] Verification des ports..." -ForegroundColor Yellow
$ports = @(27017, 8080, 8081)
foreach ($port in $ports) {
    $connection = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
    if ($connection) {
        Write-Host "Port $port occupe, liberation..." -ForegroundColor Yellow
        # Arrêter docker-compose au cas où
        docker-compose down -v 2>&1 | Out-Null
        Start-Sleep -Seconds 2
        # Vérifier à nouveau
        $connection = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
        if ($connection) {
            $processId = $connection.OwningProcess
            Write-Host "Arret du processus PID: $processId" -ForegroundColor Yellow
            Stop-Process -Id $processId -Force -ErrorAction SilentlyContinue
            Start-Sleep -Seconds 1
        }
    }
}
Write-Host "Ports disponibles" -ForegroundColor Green
Write-Host ""

# Étape 3: Nettoyer les anciens conteneurs
Write-Host "[3/6] Nettoyage des anciens conteneurs..." -ForegroundColor Yellow
docker-compose down -v 2>&1 | Out-Null
Write-Host "Nettoyage termine" -ForegroundColor Green
Write-Host ""

# Étape 4: Compiler le projet
Write-Host "[4/6] Compilation du projet Maven..." -ForegroundColor Yellow
$compileOutput = mvn clean package -DskipTests 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERREUR: La compilation a echoue!" -ForegroundColor Red
    Write-Host $compileOutput
    exit 1
}
Write-Host "Compilation reussie" -ForegroundColor Green
Write-Host ""

# Étape 5: Démarrer les services Docker
Write-Host "[5/6] Demarrage des services Docker..." -ForegroundColor Yellow
docker-compose up -d
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERREUR: Le demarrage des services a echoue!" -ForegroundColor Red
    exit 1
}
Write-Host "Services demarres" -ForegroundColor Green
Write-Host ""

# Étape 6: Attendre que les services soient prêts
Write-Host "[6/6] Attente du demarrage complet (30 secondes)..." -ForegroundColor Yellow
for ($i = 30; $i -gt 0; $i--) {
    Write-Host -NoNewline "`rTemps restant: $i secondes... "
    Start-Sleep -Seconds 1
}
Write-Host "`rServices prets!                    " -ForegroundColor Green
Write-Host ""

# Afficher les URLs
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SERVICES DISPONIBLES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Dashboard:        http://localhost:8080/analytics-dashboard/" -ForegroundColor Green
Write-Host "API:              http://localhost:8080/analytics-api/api/v1/analytics/health" -ForegroundColor Green
Write-Host "Mongo Express:    http://localhost:8081" -ForegroundColor Green
Write-Host "MongoDB:          mongodb://admin:admin123@localhost:27017" -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  COMMANDES UTILES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Voir les logs:       docker-compose logs -f" -ForegroundColor Yellow
Write-Host "Arreter les services: docker-compose down" -ForegroundColor Yellow
Write-Host "Redemarrer:          docker-compose restart" -ForegroundColor Yellow
Write-Host ""
Write-Host "Bon developpement!" -ForegroundColor Cyan

