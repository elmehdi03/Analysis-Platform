# 🚨 ERREUR 404 - SOLUTION

## ❌ PROBLÈME DÉTECTÉ

L'erreur **HTTP Status 404 - Not Found** signifie que :
- Le serveur Tomcat n'est pas en cours d'exécution
- OU l'application n'est pas déployée
- OU Docker n'est pas démarré

---

## ✅ SOLUTION RAPIDE

### Étape 1 : Vérifier Docker Desktop

1. **Ouvrez Docker Desktop** (l'application Docker sur Windows)
2. **Attendez** que Docker soit complètement démarré
3. Vérifiez que l'icône Docker dans la barre des tâches est verte ✅

**Si Docker Desktop n'est pas installé :**
- Téléchargez-le depuis : https://www.docker.com/products/docker-desktop/

---

### Étape 2 : Démarrer les Services

Une fois Docker démarré, ouvrez PowerShell et exécutez :

```powershell
cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"
docker-compose up -d
```

**OU utilisez le script automatique :**

```powershell
cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"
.\dev.ps1
```

Puis choisissez l'option **[1]** pour compiler et démarrer tout.

---

### Étape 3 : Attendre le Déploiement

⏳ **Attendez 30-60 secondes** que Tomcat démarre et déploie l'application.

Vous verrez des messages comme :
```
✓ Container streaming-tomcat Started
✓ Container streaming-mongodb Started
```

---

### Étape 4 : Accéder à l'Application

Une fois les conteneurs démarrés :

```
http://localhost:8080/analytics-dashboard/
```

---

## 🔍 DIAGNOSTIC COMPLET

### Vérifier si Docker est en cours d'exécution

```powershell
docker ps
```

**Résultat attendu :**
```
CONTAINER ID   IMAGE              PORTS                    NAMES
xxxxx          tomcat:10.1-jdk17  0.0.0.0:8080->8080/tcp  streaming-tomcat
xxxxx          mongo:7.0          0.0.0.0:27017->27017/tcp streaming-mongodb
```

**Si vide** : Docker n'est pas démarré ou les conteneurs ne sont pas lancés.

---

### Démarrer Manuellement les Conteneurs

```powershell
# Aller dans le dossier du projet
cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"

# Démarrer tous les services
docker-compose up -d

# Vérifier les logs de Tomcat
docker logs streaming-tomcat --tail 50

# Vérifier que Tomcat est prêt
docker logs streaming-tomcat | Select-String "Server startup"
```

---

### Si Docker-Compose Ne Fonctionne Pas

Essayez avec la nouvelle syntaxe (sans tiret) :

```powershell
docker compose up -d
```

---

## 🛠️ ALTERNATIVE : Sans Docker

Si Docker pose problème, vous pouvez utiliser **Maven avec Tomcat embarqué** :

### Option 1 : Tomcat Maven Plugin

```powershell
cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main\analytics-dashboard"
mvn clean package tomcat7:run
```

### Option 2 : Installer Tomcat Localement

1. Téléchargez Apache Tomcat 10.1 : https://tomcat.apache.org/download-10.cgi
2. Extrayez dans `C:\Program Files\Apache\Tomcat`
3. Copiez les fichiers WAR :
   ```powershell
   copy "analytics-dashboard\target\analytics-dashboard-1.0-SNAPSHOT.war" "C:\Program Files\Apache\Tomcat\webapps\"
   ```
4. Démarrez Tomcat :
   ```powershell
   cd "C:\Program Files\Apache\Tomcat\bin"
   .\startup.bat
   ```

---

## 📋 CHECKLIST DE DÉMARRAGE

Suivez ces étapes dans l'ordre :

- [ ] 1. Docker Desktop est installé
- [ ] 2. Docker Desktop est démarré (icône verte dans la barre des tâches)
- [ ] 3. Ouvrir PowerShell en tant qu'administrateur
- [ ] 4. Naviguer vers le dossier du projet
- [ ] 5. Exécuter `docker-compose up -d`
- [ ] 6. Attendre 30-60 secondes
- [ ] 7. Vérifier avec `docker ps`
- [ ] 8. Ouvrir http://localhost:8080/analytics-dashboard/

---

## 🚀 COMMANDES RAPIDES

### Tout Démarrer
```powershell
cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"
docker-compose up -d
```

### Vérifier l'État
```powershell
docker ps
```

### Voir les Logs
```powershell
docker logs streaming-tomcat --tail 50
```

### Redémarrer Tomcat
```powershell
docker-compose restart tomcat
```

### Tout Arrêter
```powershell
docker-compose down
```

### Tout Reconstruire
```powershell
docker-compose up -d --build
```

---

## ⚠️ ERREURS COURANTES

### Erreur : "Cannot connect to Docker daemon"
**Solution :** Démarrez Docker Desktop et attendez qu'il soit prêt.

### Erreur : "Port 8080 already in use"
**Solution :** Un autre service utilise le port 8080.
```powershell
# Trouver le processus utilisant le port 8080
netstat -ano | findstr :8080

# Tuer le processus (remplacez PID par l'ID du processus)
taskkill /PID <PID> /F
```

### Erreur : "docker-compose: command not found"
**Solution :** Docker Desktop n'est pas installé ou n'est pas dans le PATH.

### Erreur 404 persiste
**Solution :** Le WAR n'est pas déployé correctement.
```powershell
# Recompiler et redéployer
cd analytics-dashboard
mvn clean package
docker-compose restart tomcat

# Attendre 30 secondes et réessayer
```

---

## 📞 AIDE RAPIDE

### Vérifier que tout fonctionne

1. **MongoDB** : http://localhost:8081/ (Mongo Express)
2. **Dashboard** : http://localhost:8080/analytics-dashboard/
3. **API** : http://localhost:8080/analytics-api/

### Logs en Temps Réel

```powershell
# Suivre les logs de Tomcat
docker logs -f streaming-tomcat

# Suivre tous les logs
docker-compose logs -f
```

---

## 🎯 SOLUTION IMMÉDIATE

**Exécutez simplement ces commandes :**

```powershell
# 1. Ouvrir PowerShell
# 2. Copier-coller ceci :

cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"
docker-compose down
docker-compose up -d
timeout /t 30
start http://localhost:8080/analytics-dashboard/
```

**Cela va :**
1. Arrêter tous les conteneurs
2. Les redémarrer
3. Attendre 30 secondes
4. Ouvrir automatiquement le navigateur

---

## ✅ CONFIRMATION DE FONCTIONNEMENT

Quand tout fonctionne, vous devriez voir :

### Dans PowerShell
```
✓ Container streaming-mongodb Started
✓ Container streaming-tomcat Started
```

### Dans le Navigateur
- Page d'accueil moderne avec design violet
- Animations fluides
- Bouton "⚡ ENTER DASHBOARD ⚡"

---

**Une fois les services démarrés, rafraîchissez votre navigateur (Ctrl+F5) pour voir votre magnifique design !**

---

**Date** : 27 Décembre 2025
**Status** : Guide de Résolution 404

