# ========================================
# DIAGNOSTIC - Quelle version est active?
# ========================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DIAGNOSTIC DU DASHBOARD" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Vérification en cours..." -ForegroundColor Yellow
Write-Host ""

# Test 1: Vérifier si le WAR a été modifié récemment
$warPath = "analytics-dashboard\target\analytics-dashboard-1.0-SNAPSHOT.war"
if (Test-Path $warPath) {
    $warFile = Get-Item $warPath
    $modifiedDate = $warFile.LastWriteTime
    $minutesAgo = ((Get-Date) - $modifiedDate).TotalMinutes

    Write-Host "✓ Fichier WAR trouvé" -ForegroundColor Green
    Write-Host "  Dernière modification: $modifiedDate" -ForegroundColor Cyan
    Write-Host "  Il y a $([math]::Round($minutesAgo, 1)) minutes" -ForegroundColor Cyan

    if ($minutesAgo -lt 10) {
        Write-Host "  ✓ Le WAR est RÉCENT (nouvelle compilation)" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Le WAR est ANCIEN (recompilez avec mvn clean package)" -ForegroundColor Yellow
    }
} else {
    Write-Host "✗ Fichier WAR introuvable! Compilez le projet." -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  TEST DE CONNEXION" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$url = "http://localhost:8080/analytics-dashboard/dashboard"
Write-Host "Test de connexion à: $url" -ForegroundColor White
Write-Host ""

try {
    $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 5
    $content = $response.Content

    Write-Host "✓ Serveur accessible!" -ForegroundColor Green
    Write-Host ""

    # Vérifier la version
    if ($content -match "NOUVEAU DESIGN v2.0") {
        Write-Host "✅ LE NOUVEAU CODE EST ACTIF!" -ForegroundColor Green -BackgroundColor Black
        Write-Host ""
        Write-Host "Le serveur utilise bien la nouvelle version!" -ForegroundColor Green
        Write-Host "Si vous ne voyez pas le nouveau design, c'est le CACHE du navigateur." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "SOLUTION:" -ForegroundColor Cyan
        Write-Host "1. Fermez COMPLÈTEMENT tous les navigateurs" -ForegroundColor White
        Write-Host "2. Rouvrez en MODE INCOGNITO" -ForegroundColor White
        Write-Host "3. Allez sur: $url" -ForegroundColor White
        Write-Host ""
    } elseif ($content -match "FUTURISTIC BIG DATA") {
        Write-Host "❌ L'ANCIEN CODE EST ENCORE ACTIF!" -ForegroundColor Red -BackgroundColor Black
        Write-Host ""
        Write-Host "Le serveur utilise TOUJOURS l'ancienne version!" -ForegroundColor Red
        Write-Host ""
        Write-Host "SOLUTION:" -ForegroundColor Cyan
        Write-Host "1. ARRÊTEZ complètement le serveur (Tomcat/Docker)" -ForegroundColor White
        Write-Host "2. Supprimez le dossier webapps\analytics-dashboard-1.0-SNAPSHOT\" -ForegroundColor White
        Write-Host "3. Supprimez le fichier webapps\analytics-dashboard-1.0-SNAPSHOT.war" -ForegroundColor White
        Write-Host "4. Copiez le nouveau WAR depuis: analytics-dashboard\target\" -ForegroundColor White
        Write-Host "5. Redémarrez le serveur" -ForegroundColor White
        Write-Host ""
    } else {
        Write-Host "⚠ Version inconnue" -ForegroundColor Yellow
        Write-Host "Le serveur répond mais je ne reconnais pas la version." -ForegroundColor Yellow
    }

    # Vérifier le style
    if ($content -match "--primary-purple: #a855f7") {
        Write-Host "✓ Style unifié détecté (purple/pink/cyan)" -ForegroundColor Green
    } elseif ($content -match "--neon-cyan") {
        Write-Host "✗ Ancien style détecté (cyber/neon cyan/magenta)" -ForegroundColor Red
    }

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  DÉTAILS TECHNIQUES" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""

    # Extraire le titre
    if ($content -match "<title>(.*?)</title>") {
        $title = $matches[1]
        Write-Host "Titre de la page: $title" -ForegroundColor Cyan
    }

    # Extraire le h1
    if ($content -match "<h1>(.*?)</h1>") {
        $h1 = $matches[1]
        Write-Host "Titre H1: $h1" -ForegroundColor Cyan
    }

    Write-Host ""

} catch {
    Write-Host "✗ Impossible de se connecter au serveur!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Erreur: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "VÉRIFIEZ:" -ForegroundColor Yellow
    Write-Host "1. Le serveur est-il démarré?" -ForegroundColor White
    Write-Host "2. L'URL est-elle correcte? $url" -ForegroundColor White
    Write-Host "3. Le port 8080 est-il accessible?" -ForegroundColor White
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  RÉSUMÉ" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pour vérifier manuellement:" -ForegroundColor White
Write-Host "1. Ouvrez: $url" -ForegroundColor Cyan
Write-Host "2. Regardez l'onglet du navigateur" -ForegroundColor Cyan
Write-Host "   → Doit contenir: 'NOUVEAU DESIGN v2.0'" -ForegroundColor Green
Write-Host "3. Sur la page, cherchez le texte:" -ForegroundColor Cyan
Write-Host "   → '🎨 NOUVEAU DESIGN UNIFIÉ 🎨'" -ForegroundColor Green
Write-Host ""

Write-Host "Appuyez sur une touche pour quitter..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

