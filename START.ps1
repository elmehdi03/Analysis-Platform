# ========================================
# Script de Démarrage Rapide
# Streaming Analytics Dashboard
# ========================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DÉMARRAGE DU PROJET" -ForegroundColor Yellow
Write-Host "  Streaming Analytics Dashboard" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier si Docker est en cours d'exécution
Write-Host "Vérification de Docker..." -ForegroundColor Yellow

$dockerRunning = $false
try {
    $dockerTest = docker ps 2>&1
    if ($LASTEXITCODE -eq 0) {
        $dockerRunning = $true
        Write-Host "✓ Docker est en cours d'exécution" -ForegroundColor Green
    }
} catch {
    $dockerRunning = $false
}

if (-not $dockerRunning) {
    Write-Host "✗ Docker n'est pas en cours d'exécution!" -ForegroundColor Red
    Write-Host ""
    Write-Host "SOLUTION :" -ForegroundColor Yellow
    Write-Host "1. Ouvrez Docker Desktop" -ForegroundColor White
    Write-Host "2. Attendez que Docker soit complètement démarré" -ForegroundColor White
    Write-Host "3. Réexécutez ce script" -ForegroundColor White
    Write-Host ""
    Write-Host "Appuyez sur une touche pour quitter..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host ""

# Arrêter les conteneurs existants
Write-Host "Arrêt des conteneurs existants..." -ForegroundColor Yellow
docker-compose down 2>&1 | Out-Null

Write-Host ""

# Recompiler le projet si nécessaire
Write-Host "Voulez-vous recompiler le projet ? (O/N)" -ForegroundColor Cyan
$compile = Read-Host

if ($compile -eq "O" -or $compile -eq "o") {
    Write-Host ""
    Write-Host "Compilation du projet..." -ForegroundColor Yellow

    # Compiler analytics-dashboard
    Write-Host "  → Compilation analytics-dashboard..." -ForegroundColor White
    Set-Location "analytics-dashboard"
    mvn clean package -q
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ analytics-dashboard compilé avec succès" -ForegroundColor Green
    } else {
        Write-Host "  ✗ Erreur de compilation analytics-dashboard" -ForegroundColor Red
    }
    Set-Location ..

    Write-Host ""
}

# Démarrer les conteneurs
Write-Host "Démarrage des conteneurs Docker..." -ForegroundColor Yellow
Write-Host ""

docker-compose up -d

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ Conteneurs démarrés avec succès!" -ForegroundColor Green
    Write-Host ""

    # Attendre que Tomcat soit prêt
    Write-Host "Attente du démarrage de Tomcat..." -ForegroundColor Yellow
    Write-Host "(Cela peut prendre 30-60 secondes)" -ForegroundColor Gray
    Write-Host ""

    $countdown = 40
    for ($i = $countdown; $i -gt 0; $i--) {
        Write-Host "`rTemps restant : $i secondes..." -NoNewline -ForegroundColor Cyan
        Start-Sleep -Seconds 1
    }

    Write-Host "`n"

    # Vérifier l'état des conteneurs
    Write-Host "État des conteneurs :" -ForegroundColor Yellow
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  ✓ PROJET DÉMARRÉ AVEC SUCCÈS!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "URLs disponibles :" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  🏠 Page d'accueil :" -ForegroundColor White
    Write-Host "     http://localhost:8080/analytics-dashboard/" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  📊 Dashboard :" -ForegroundColor White
    Write-Host "     http://localhost:8080/analytics-dashboard/dashboard" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  🗄️  MongoDB Express :" -ForegroundColor White
    Write-Host "     http://localhost:8081/" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""

    # Demander si on veut ouvrir le navigateur
    Write-Host "Voulez-vous ouvrir l'application dans le navigateur ? (O/N)" -ForegroundColor Yellow
    $openBrowser = Read-Host

    if ($openBrowser -eq "O" -or $openBrowser -eq "o") {
        Write-Host ""
        Write-Host "Ouverture du navigateur..." -ForegroundColor Green
        Start-Process "http://localhost:8080/analytics-dashboard/"
    }

    Write-Host ""
    Write-Host "Pour voir les logs en temps réel :" -ForegroundColor Gray
    Write-Host "  docker logs -f streaming-tomcat" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "Pour arrêter les services :" -ForegroundColor Gray
    Write-Host "  docker-compose down" -ForegroundColor DarkGray
    Write-Host ""

} else {
    Write-Host ""
    Write-Host "✗ Erreur lors du démarrage des conteneurs" -ForegroundColor Red
    Write-Host ""
    Write-Host "Vérifiez que Docker Desktop est bien démarré." -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "Appuyez sur une touche pour quitter..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

