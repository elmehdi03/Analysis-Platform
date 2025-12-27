# ========================================
# FORCER LE REDÉPLOIEMENT - Solution Radicale
# ========================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  REDÉPLOIEMENT FORCÉ DU DASHBOARD" -ForegroundColor Yellow
Write-Host "  Version 2.0 - Design Unifié" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$warSource = "analytics-dashboard\target\analytics-dashboard-1.0-SNAPSHOT.war"
$warFullPath = Join-Path $PSScriptRoot $warSource

if (-not (Test-Path $warFullPath)) {
    Write-Host "✗ Fichier WAR introuvable!" -ForegroundColor Red
    Write-Host "Compilation en cours..." -ForegroundColor Yellow
    mvn clean package -DskipTests
}

Write-Host "Fichier WAR prêt: analytics-dashboard-1.0-SNAPSHOT.war" -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  INSTRUCTIONS DE REDÉPLOIEMENT" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "ÉTAPE 1: ARRÊTER COMPLÈTEMENT LE SERVEUR" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "Si vous utilisez Docker:" -ForegroundColor White
Write-Host "  docker-compose down" -ForegroundColor Cyan
Write-Host ""
Write-Host "Si vous utilisez Tomcat:" -ForegroundColor White
Write-Host "  - Fermez Tomcat complètement" -ForegroundColor Cyan
Write-Host "  - Vérifiez qu'aucun processus Java ne tourne" -ForegroundColor Cyan
Write-Host ""

Write-Host "ÉTAPE 2: NETTOYER LE CACHE TOMCAT" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "Supprimez ces dossiers dans votre Tomcat:" -ForegroundColor White
Write-Host "  1. webapps\analytics-dashboard-1.0-SNAPSHOT.war" -ForegroundColor Cyan
Write-Host "  2. webapps\analytics-dashboard-1.0-SNAPSHOT\" -ForegroundColor Cyan
Write-Host "  3. work\Catalina\localhost\analytics-dashboard-1.0-SNAPSHOT\" -ForegroundColor Cyan
Write-Host "  4. temp\ (tout le contenu)" -ForegroundColor Cyan
Write-Host ""

Write-Host "ÉTAPE 3: COPIER LE NOUVEAU WAR" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "De: $warFullPath" -ForegroundColor Cyan
Write-Host "Vers: [TOMCAT]\webapps\" -ForegroundColor Cyan
Write-Host ""

$copyNow = Read-Host "Voulez-vous que je copie le WAR vers Tomcat maintenant? Entrez le chemin webapps (ou N pour passer)"

if ($copyNow -ne "N" -and $copyNow -ne "n" -and $copyNow -ne "") {
    if (Test-Path $copyNow) {
        # Nettoyer l'ancien
        $oldWar = Join-Path $copyNow "analytics-dashboard-1.0-SNAPSHOT.war"
        $oldDir = Join-Path $copyNow "analytics-dashboard-1.0-SNAPSHOT"

        if (Test-Path $oldWar) {
            Write-Host "Suppression de l'ancien WAR..." -ForegroundColor Yellow
            Remove-Item $oldWar -Force
        }

        if (Test-Path $oldDir) {
            Write-Host "Suppression de l'ancien dossier..." -ForegroundColor Yellow
            Remove-Item $oldDir -Recurse -Force
        }

        # Copier le nouveau
        Write-Host "Copie du nouveau WAR..." -ForegroundColor Yellow
        Copy-Item $warFullPath $copyNow -Force
        Write-Host "✓ WAR copié avec succès!" -ForegroundColor Green
    } else {
        Write-Host "✗ Chemin invalide!" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "ÉTAPE 4: REDÉMARRER LE SERVEUR" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "Redémarrez votre serveur Tomcat/Docker" -ForegroundColor White
Write-Host ""

Write-Host "ÉTAPE 5: VIDER LE CACHE DU NAVIGATEUR" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "MÉTHODE RADICALE (la plus efficace):" -ForegroundColor White
Write-Host ""
Write-Host "1. Fermez TOUS les navigateurs (Chrome, Firefox, Edge...)" -ForegroundColor Cyan
Write-Host "2. Supprimez le cache manuellement:" -ForegroundColor Cyan
Write-Host ""
Write-Host "   Chrome/Edge:" -ForegroundColor White
Write-Host "   C:\Users\$env:USERNAME\AppData\Local\Google\Chrome\User Data\Default\Cache" -ForegroundColor Gray
Write-Host "   C:\Users\$env:USERNAME\AppData\Local\Microsoft\Edge\User Data\Default\Cache" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Ou utilisez CCleaner / BleachBit pour tout nettoyer" -ForegroundColor Cyan
Write-Host ""
Write-Host "4. Rouvrez le navigateur en MODE INCOGNITO" -ForegroundColor Cyan -BackgroundColor Red
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "  VÉRIFICATION" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Quand vous ouvrirez:" -ForegroundColor White
Write-Host "http://localhost:8080/analytics-dashboard/dashboard" -ForegroundColor Cyan
Write-Host ""
Write-Host "Vous DEVEZ voir:" -ForegroundColor White
Write-Host "  ✓ Titre: '📊 STREAMING ANALYTICS 📊'" -ForegroundColor Green
Write-Host "  ✓ Sous-titre: 'Real-Time Streaming Insights & Performance Metrics'" -ForegroundColor Green
Write-Host "  ✓ Texte: '🎨 NOUVEAU DESIGN UNIFIÉ 🎨'" -ForegroundColor Green
Write-Host "  ✓ Fond: Violet dégradé (pas noir!)" -ForegroundColor Green
Write-Host "  ✓ Boutons: Violet/Rose (pas cyan!)" -ForegroundColor Green
Write-Host ""
Write-Host "Si vous voyez encore l'ancien design:" -ForegroundColor Yellow
Write-Host "  → Le serveur n'a pas pris le nouveau WAR" -ForegroundColor Red
Write-Host "  → OU le cache du navigateur n'est pas vidé" -ForegroundColor Red
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ASTUCE PRO" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pour être SÛR que c'est le nouveau code:" -ForegroundColor White
Write-Host "1. Regardez l'onglet du navigateur" -ForegroundColor Cyan
Write-Host "   Il doit afficher: 'Streaming Analytics Dashboard - NOUVEAU DESIGN v2.0'" -ForegroundColor Green
Write-Host ""
Write-Host "2. Faites un clic droit sur la page → 'Afficher le code source'" -ForegroundColor Cyan
Write-Host "   Cherchez: 'NOUVEAU DESIGN UNIFIÉ'" -ForegroundColor Green
Write-Host "   Si vous le trouvez → Le serveur utilise le nouveau code ✓" -ForegroundColor Green
Write-Host "   Si vous ne le trouvez pas → Le serveur utilise l'ancien code ✗" -ForegroundColor Red
Write-Host ""

Write-Host "Appuyez sur une touche pour quitter..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

