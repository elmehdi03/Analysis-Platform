# 🚀 GUIDE DE DÉMARRAGE - Streaming Analytics

## ⚠️ PROBLÈME IDENTIFIÉ

Les containers Docker ne sont **pas en cours d'exécution**. C'est pourquoi vous ne voyez pas les changements sur le dashboard.

---

## ✅ SOLUTION - Étapes à Suivre

### 📋 Étape 1: Démarrer Docker Desktop

1. **Ouvrez Docker Desktop** sur votre PC
2. Attendez que Docker soit complètement démarré (icône Docker en bas à droite devient verte)
3. Vérifiez que Docker fonctionne en ouvrant PowerShell et tapant:
   ```powershell
   docker ps
   ```
   Vous devriez voir une liste (même vide) sans erreur.

---

### 📋 Étape 2: Démarrer l'Application

Une fois Docker démarré, choisissez **UNE** des options suivantes:

#### **Option A: Avec le Script Simple (RECOMMANDÉ)**

Ouvrez PowerShell et exécutez:

```powershell
cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"
.\START_SIMPLE.ps1
```

Le script va:
- ✅ Vérifier que Docker fonctionne
- ✅ Arrêter les anciens containers
- ✅ Reconstruire et démarrer les nouveaux containers
- ✅ Attendre que tout soit prêt
- ✅ Afficher les URLs à utiliser

---

#### **Option B: Manuellement (Si le script ne fonctionne pas)**

Ouvrez PowerShell et exécutez ces commandes **une par une**:

```powershell
# 1. Aller dans le dossier du projet
cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"

# 2. Arrêter les containers existants
docker-compose down

# 3. Démarrer les nouveaux containers
docker-compose up -d --build

# 4. Attendre 30 secondes que tout démarre
Start-Sleep -Seconds 30

# 5. Vérifier que les containers fonctionnent
docker ps
```

Vous devriez voir 3 containers:
- `streaming-tomcat` (port 8080)
- `streaming-mongodb` (port 27017)
- `streaming-mongo-express` (port 8081)

---

### 📋 Étape 3: Tester l'Application

Une fois les containers démarrés, ouvrez votre navigateur et testez:

1. **Page d'accueil**:
   ```
   http://localhost:8080/analytics-dashboard/
   ```

2. **Dashboard** (avec le nouveau design):
   ```
   http://localhost:8080/analytics-dashboard/dashboard
   ```

3. **Statistics**:
   ```
   http://localhost:8080/analytics-dashboard/stats
   ```

4. **API Health Check**:
   ```
   http://localhost:8080/analytics-api/api/v1/analytics/health
   ```

---

### 📋 Étape 4: Vider le Cache du Navigateur

Si vous ne voyez toujours pas les changements:

#### **Méthode 1: Hard Refresh**
- **Windows**: `Ctrl + F5`
- **Mac**: `Cmd + Shift + R`

#### **Méthode 2: Vider le Cache Complètement**

**Google Chrome / Edge:**
1. Appuyez sur `F12` pour ouvrir les DevTools
2. Cliquez droit sur le bouton de rafraîchissement (à côté de la barre d'adresse)
3. Sélectionnez "**Vider le cache et actualiser de force**"

**Firefox:**
1. Appuyez sur `Ctrl + Shift + Delete`
2. Sélectionnez "Cache"
3. Période: "Tout"
4. Cliquez sur "Effacer maintenant"
5. Rafraîchissez la page (`F5`)

#### **Méthode 3: Mode Navigation Privée**

Ouvrez une fenêtre de navigation privée/incognito:
- **Chrome/Edge**: `Ctrl + Shift + N`
- **Firefox**: `Ctrl + Shift + P`

Puis testez les URLs dans cette fenêtre.

---

## 🔍 Vérification que Tout Fonctionne

### **Test 1: Vérifier les Containers**

Dans PowerShell:
```powershell
docker ps
```

Vous devriez voir:
```
CONTAINER ID   IMAGE            STATUS         PORTS                    NAMES
xxxxxxxxxxxx   tomcat:10.1...   Up X minutes   0.0.0.0:8080->8080/tcp   streaming-tomcat
xxxxxxxxxxxx   mongo:7          Up X minutes   0.0.0.0:27017->27017/tcp streaming-mongodb
xxxxxxxxxxxx   mongo-express    Up X minutes   0.0.0.0:8081->8081/tcp   streaming-mongo-express
```

### **Test 2: Vérifier les Logs**

Pour voir les logs du container Tomcat:
```powershell
docker logs streaming-tomcat --tail 50
```

Vous devriez voir:
```
INFO [main] org.apache.catalina.startup.Catalina.start Server startup in [XXXX] milliseconds
```

### **Test 3: Tester l'API**

Ouvrez:
```
http://localhost:8080/analytics-api/api/v1/analytics/health
```

Vous devriez voir une réponse JSON comme:
```json
{
  "status": "UP",
  "timestamp": "2025-12-27T...",
  "message": "Service is running"
}
```

---

## ❌ Problèmes Courants et Solutions

### **Problème 1: "Docker n'est pas reconnu"**

**Solution:**
- Docker Desktop n'est pas installé ou pas dans le PATH
- Installez Docker Desktop: https://www.docker.com/products/docker-desktop/
- Redémarrez votre PC après l'installation

---

### **Problème 2: "Cannot connect to the Docker daemon"**

**Solution:**
- Docker Desktop n'est pas démarré
- Ouvrez Docker Desktop et attendez qu'il soit prêt
- L'icône Docker dans la barre des tâches doit être verte

---

### **Problème 3: Port 8080 déjà utilisé**

**Solution:**
```powershell
# Trouver le processus qui utilise le port 8080
netstat -ano | findstr :8080

# Arrêter le processus (remplacez PID par le numéro trouvé)
taskkill /PID <PID> /F

# Ou arrêter tous les containers Docker
docker stop $(docker ps -aq)
```

---

### **Problème 4: Les changements CSS ne s'affichent pas**

**Solution:**
1. Vérifiez que les containers sont bien redémarrés
2. Attendez 30 secondes après le démarrage
3. Videz complètement le cache du navigateur
4. Testez en mode navigation privée
5. Si rien ne marche, redémarrez les containers:
   ```powershell
   docker-compose restart
   ```

---

## 📦 Fichiers Modifiés (Pour Référence)

Les modifications de design sont dans ces fichiers:

1. **Dashboard JSP**:
   ```
   analytics-dashboard/src/main/webapp/WEB-INF/views/dashboard.jsp
   ```
   - Glow effect ajouté
   - Animations améliorées
   - Navigation ajoutée

2. **Stats Servlet**:
   ```
   analytics-dashboard/src/main/java/com/streaming/analytics/servlet/StatsServlet.java
   ```
   - Design complet redesigné

Les fichiers ont déjà été compilés avec Maven (BUILD SUCCESS).

---

## 🎯 Résumé des Commandes Essentielles

```powershell
# Démarrer l'application
cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"
docker-compose up -d --build

# Arrêter l'application
docker-compose down

# Redémarrer l'application
docker-compose restart

# Voir les containers en cours
docker ps

# Voir les logs
docker-compose logs -f

# Voir les logs d'un container spécifique
docker logs streaming-tomcat -f

# Reconstruire après modifications
mvn clean package -DskipTests
docker-compose up -d --build
```

---

## ✅ Checklist Finale

Avant de tester le dashboard, assurez-vous que:

- [ ] Docker Desktop est ouvert et en cours d'exécution (icône verte)
- [ ] Les containers sont démarrés (`docker ps` montre 3 containers)
- [ ] Vous avez attendu 30 secondes après le démarrage
- [ ] Vous avez vidé le cache du navigateur (Ctrl+F5)
- [ ] L'API répond sur http://localhost:8080/analytics-api/api/v1/analytics/health

---

## 🆘 Besoin d'Aide?

Si vous rencontrez toujours des problèmes:

1. **Copiez les logs:**
   ```powershell
   docker-compose logs > logs.txt
   ```

2. **Vérifiez les ports:**
   ```powershell
   netstat -ano | findstr :8080
   netstat -ano | findstr :27017
   netstat -ano | findstr :8081
   ```

3. **Redémarrez complètement:**
   ```powershell
   docker-compose down
   docker system prune -f
   docker-compose up -d --build
   ```

---

**Une fois Docker démarré et les containers en cours d'exécution, vous verrez le nouveau design du dashboard! 🎉**

