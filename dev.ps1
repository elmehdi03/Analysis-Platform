# ========================================
# Script de Développement Rapide
# Streaming Analytics Dashboard
# ========================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Streaming Analytics Dashboard" -ForegroundColor Yellow
Write-Host "  Script de Développement Rapide" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Menu principal
function Show-Menu {
    Write-Host "Que voulez-vous faire ?" -ForegroundColor Green
    Write-Host ""
    Write-Host "[1] Recompiler et redéployer le projet complet" -ForegroundColor White
    Write-Host "[2] Recompiler uniquement le dashboard" -ForegroundColor White
    Write-Host "[3] Redémarrer Tomcat (sans recompiler)" -ForegroundColor White
    Write-Host "[4] Ouvrir le dashboard dans le navigateur" -ForegroundColor White
    Write-Host "[5] Voir les logs de Tomcat" -ForegroundColor White
    Write-Host "[6] Arrêter tous les services" -ForegroundColor White
    Write-Host "[7] Redémarrer tous les services" -ForegroundColor White
    Write-Host "[8] Nettoyer et tout reconstruire" -ForegroundColor White
    Write-Host "[Q] Quitter" -ForegroundColor Red
    Write-Host ""
}

# Fonction pour recompiler tout
function Build-All {
    Write-Host "🔨 Compilation du projet complet..." -ForegroundColor Yellow
    mvn clean package
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Compilation réussie!" -ForegroundColor Green
        return $true
    } else {
        Write-Host "❌ Erreur lors de la compilation!" -ForegroundColor Red
        return $false
    }
}

# Fonction pour recompiler uniquement le dashboard
function Build-Dashboard {
    Write-Host "🔨 Compilation du dashboard uniquement..." -ForegroundColor Yellow
    mvn clean package -pl analytics-dashboard
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Compilation réussie!" -ForegroundColor Green
        return $true
    } else {
        Write-Host "❌ Erreur lors de la compilation!" -ForegroundColor Red
        return $false
    }
}

# Fonction pour redémarrer Tomcat
function Restart-Tomcat {
    Write-Host "🔄 Redémarrage de Tomcat..." -ForegroundColor Yellow
    docker-compose restart streaming-tomcat
    Write-Host "⏳ Attente du démarrage de Tomcat (15 secondes)..." -ForegroundColor Cyan
    Start-Sleep -Seconds 15
    Write-Host "✅ Tomcat redémarré!" -ForegroundColor Green
}

# Fonction pour ouvrir le navigateur
function Open-Dashboard {
    Write-Host "🌐 Ouverture du dashboard dans le navigateur..." -ForegroundColor Yellow
    Start-Process "http://localhost:8080/analytics-dashboard/"
    Write-Host "✅ Dashboard ouvert!" -ForegroundColor Green
}

# Fonction pour voir les logs
function Show-Logs {
    Write-Host "📋 Logs de Tomcat (Ctrl+C pour quitter):" -ForegroundColor Yellow
    docker logs -f streaming-tomcat
}

# Fonction pour arrêter les services
function Stop-Services {
    Write-Host "🛑 Arrêt de tous les services..." -ForegroundColor Yellow
    docker-compose down
    Write-Host "✅ Services arrêtés!" -ForegroundColor Green
}

# Fonction pour démarrer les services
function Start-Services {
    Write-Host "▶️  Démarrage de tous les services..." -ForegroundColor Yellow
    docker-compose up -d
    Write-Host "⏳ Attente du démarrage (20 secondes)..." -ForegroundColor Cyan
    Start-Sleep -Seconds 20
    Write-Host "✅ Services démarrés!" -ForegroundColor Green
}

# Fonction pour nettoyer et reconstruire
function Clean-Rebuild {
    Write-Host "🧹 Nettoyage et reconstruction complète..." -ForegroundColor Yellow
    Write-Host "1/4 - Arrêt des services..." -ForegroundColor Cyan
    docker-compose down
    Write-Host "2/4 - Nettoyage Maven..." -ForegroundColor Cyan
    mvn clean
    Write-Host "3/4 - Recompilation..." -ForegroundColor Cyan
    mvn package
    if ($LASTEXITCODE -eq 0) {
        Write-Host "4/4 - Redémarrage des services..." -ForegroundColor Cyan
        docker-compose up -d
        Write-Host "⏳ Attente du démarrage (20 secondes)..." -ForegroundColor Cyan
        Start-Sleep -Seconds 20
        Write-Host "✅ Reconstruction complète terminée!" -ForegroundColor Green
    } else {
        Write-Host "❌ Erreur lors de la compilation!" -ForegroundColor Red
    }
}

# Boucle principale
do {
    Show-Menu
    $choice = Read-Host "Votre choix"
    Write-Host ""

    switch ($choice) {
        '1' {
            if (Build-All) {
                Restart-Tomcat
                Write-Host ""
                Write-Host "🎉 Dashboard disponible à : http://localhost:8080/analytics-dashboard/" -ForegroundColor Green
            }
        }
        '2' {
            if (Build-Dashboard) {
                Restart-Tomcat
                Write-Host ""
                Write-Host "🎉 Dashboard disponible à : http://localhost:8080/analytics-dashboard/" -ForegroundColor Green
            }
        }
        '3' {
            Restart-Tomcat
            Write-Host ""
            Write-Host "🎉 Dashboard disponible à : http://localhost:8080/analytics-dashboard/" -ForegroundColor Green
        }
        '4' {
            Open-Dashboard
        }
        '5' {
            Show-Logs
        }
        '6' {
            Stop-Services
        }
        '7' {
            Start-Services
            Write-Host ""
            Write-Host "🎉 Dashboard disponible à : http://localhost:8080/analytics-dashboard/" -ForegroundColor Green
        }
        '8' {
            Clean-Rebuild
            Write-Host ""
            Write-Host "🎉 Dashboard disponible à : http://localhost:8080/analytics-dashboard/" -ForegroundColor Green
        }
        'q' {
            Write-Host "👋 Au revoir!" -ForegroundColor Yellow
            break
        }
        'Q' {
            Write-Host "👋 Au revoir!" -ForegroundColor Yellow
            break
        }
        default {
            Write-Host "❌ Choix invalide!" -ForegroundColor Red
        }
    }

    if ($choice -ne 'q' -and $choice -ne 'Q') {
        Write-Host ""
        Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Cyan
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        Clear-Host
    }
} while ($choice -ne 'q' -and $choice -ne 'Q')

