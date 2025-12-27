# Script de démarrage simple pour Streaming Analytics
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DEMARRAGE STREAMING ANALYTICS" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier Docker
Write-Host "Verification de Docker..." -ForegroundColor Yellow
try {
    $dockerTest = docker ps 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERREUR: Docker n'est pas en cours d'execution!" -ForegroundColor Red
        Write-Host ""
        Write-Host "SOLUTION:" -ForegroundColor Yellow
        Write-Host "1. Demarrez Docker Desktop" -ForegroundColor White
        Write-Host "2. Attendez que Docker soit pret" -ForegroundColor White
        Write-Host "3. Relancez ce script" -ForegroundColor White
        Write-Host ""
        Read-Host "Appuyez sur Entree pour quitter"
        exit 1
    }
    Write-Host "Docker OK!" -ForegroundColor Green
} catch {
    Write-Host "ERREUR: Docker n'est pas installe ou pas demarre!" -ForegroundColor Red
    Read-Host "Appuyez sur Entree pour quitter"
    exit 1
}

Write-Host ""

# Arrêter les conteneurs existants
Write-Host "Arret des conteneurs existants..." -ForegroundColor Yellow
docker-compose down | Out-Null

Write-Host ""

# Démarrer les conteneurs
Write-Host "Demarrage des conteneurs..." -ForegroundColor Yellow
docker-compose up -d --build

Write-Host ""
Write-Host "Attente du demarrage complet (30 secondes)..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  APPLICATION DEMARREE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "URLS disponibles:" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Accueil:" -ForegroundColor White
Write-Host "  http://localhost:8080/analytics-dashboard/" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Dashboard:" -ForegroundColor White
Write-Host "  http://localhost:8080/analytics-dashboard/dashboard" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Statistics:" -ForegroundColor White
Write-Host "  http://localhost:8080/analytics-dashboard/stats" -ForegroundColor Yellow
Write-Host ""
Write-Host "  API Health:" -ForegroundColor White
Write-Host "  http://localhost:8080/analytics-api/api/v1/analytics/health" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Mongo Express:" -ForegroundColor White
Write-Host "  http://localhost:8081" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Vérifier l'état des conteneurs
Write-Host "Etat des conteneurs:" -ForegroundColor Cyan
docker ps --format "table {{.Names}}\t{{.Status}}"

Write-Host ""
Write-Host "REMARQUE: Si vous ne voyez pas les changements CSS:" -ForegroundColor Yellow
Write-Host "  - Appuyez sur Ctrl+F5 dans votre navigateur" -ForegroundColor White
Write-Host "  - Ou videz le cache du navigateur" -ForegroundColor White
Write-Host ""

