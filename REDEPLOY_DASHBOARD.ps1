# ===============================
# REDEPLOY DASHBOARD - SAFE MODE
# ===============================

Clear-Host

Write-Host "===============================" -ForegroundColor Cyan
Write-Host " REDEPLOIEMENT DU DASHBOARD" -ForegroundColor Yellow
Write-Host "===============================" -ForegroundColor Cyan
Write-Host ""

$warSource = "analytics-dashboard\target\analytics-dashboard-1.0-SNAPSHOT.war"
$warFullPath = Join-Path $PSScriptRoot $warSource

Write-Host "Verification du fichier WAR..." -ForegroundColor Yellow
Write-Host ""

if (-not (Test-Path $warFullPath)) {
    Write-Host "Fichier WAR introuvable !" -ForegroundColor Red
    Write-Host "Compile le projet avec :" -ForegroundColor Yellow
    Write-Host "mvn clean install -DskipTests"
    pause
    exit
}

$warFile = Get-Item $warFullPath
Write-Host "WAR trouve :" -ForegroundColor Green
Write-Host $warFullPath
Write-Host "Date : $($warFile.LastWriteTime)"
Write-Host "Taille : $([math]::Round($warFile.Length / 1MB, 2)) MB"
Write-Host ""

Write-Host "1 - Deployer avec Docker"
Write-Host "2 - Copier vers Tomcat"
Write-Host "3 - Instructions manuelles"
Write-Host "4 - Quitter"
Write-Host ""

$choice = Read-Host "Votre choix (1-4)"

if ($choice -eq "1") {

    Write-Host ""
    Write-Host "Deploiement Docker..." -ForegroundColor Yellow
    docker-compose down
    docker-compose up -d --build

    Write-Host ""
    Write-Host "DEPLOIEMENT TERMINE" -ForegroundColor Green
    Write-Host "http://localhost:8080/analytics-dashboard/dashboard"

}
elseif ($choice -eq "2") {

    Write-Host ""
    $tomcatWebapps = Read-Host "Chemin webapps Tomcat"

    if (Test-Path $tomcatWebapps) {
        $dest = Join-Path $tomcatWebapps "analytics-dashboard-1.0-SNAPSHOT.war"
        Copy-Item $warFullPath $dest -Force
        Write-Host "WAR copie avec succes" -ForegroundColor Green
    }
    else {
        Write-Host "Chemin invalide" -ForegroundColor Red
    }

}
elseif ($choice -eq "3") {

    Write-Host ""
    Write-Host "INSTRUCTIONS MANUELLES" -ForegroundColor Yellow
    Write-Host "1. Arreter Tomcat"
    Write-Host "2. Supprimer :"
    Write-Host "   webapps\analytics-dashboard-1.0-SNAPSHOT.war"
    Write-Host "   webapps\analytics-dashboard-1.0-SNAPSHOT\"
    Write-Host "3. Copier le nouveau WAR"
    Write-Host "4. Demarrer Tomcat"
    Write-Host "5. Ouvrir :"
    Write-Host "   http://localhost:8080/analytics-dashboard/dashboard"

}
elseif ($choice -eq "4") {

    Write-Host "Sortie..."
    exit

}
else {
    Write-Host "Choix invalide" -ForegroundColor Red
}

Write-Host ""
pause
