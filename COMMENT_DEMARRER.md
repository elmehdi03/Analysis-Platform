# 🚀 DÉMARRAGE RAPIDE - Streaming Analytics

## ❌ VOUS AVEZ UNE ERREUR 404 ?

**Le problème :** Les services Docker ne sont pas démarrés.

---

## ✅ SOLUTION EN 3 ÉTAPES

### 1️⃣ Démarrer Docker Desktop

**Ouvrez l'application Docker Desktop sur Windows**

Attendez que l'icône Docker dans la barre des tâches devienne **verte** ✅

---

### 2️⃣ Exécuter le Script de Démarrage

**Clic droit sur `START.ps1` → Exécuter avec PowerShell**

OU ouvrez PowerShell et tapez :

```powershell
cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"
.\START.ps1
```

Le script va :
- ✅ Vérifier que Docker fonctionne
- ✅ Démarrer MongoDB et Tomcat
- ✅ Attendre que tout soit prêt
- ✅ Ouvrir automatiquement le navigateur

---

### 3️⃣ Accéder à l'Application

Une fois le script terminé, ouvrez :

```
http://localhost:8080/analytics-dashboard/
```

**Vous devriez voir :**
- 🎨 Design moderne avec dégradés violets
- ⚡ Animations fluides
- 🏠 Navigation complète

---

## 🔧 ALTERNATIVE : Commandes Manuelles

Si vous préférez les commandes manuelles :

```powershell
# 1. Aller dans le dossier du projet
cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"

# 2. Démarrer tous les services
docker-compose up -d

# 3. Attendre 30-60 secondes

# 4. Ouvrir le navigateur
start http://localhost:8080/analytics-dashboard/
```

---

## 📋 VÉRIFICATION

### Vérifier que Docker fonctionne
```powershell
docker ps
```

**Vous devriez voir :**
```
CONTAINER ID   IMAGE              PORTS                    NAMES
xxxxx          tomcat:10.1-jdk17  0.0.0.0:8080->8080/tcp  streaming-tomcat
xxxxx          mongo:7.0          0.0.0.0:27017->27017/tcp streaming-mongodb
```

### Vérifier les logs de Tomcat
```powershell
docker logs streaming-tomcat --tail 50
```

---

## 🛑 ARRÊTER LES SERVICES

```powershell
cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"
docker-compose down
```

---

## 📚 URLS DISPONIBLES

Une fois démarré :

| Service | URL |
|---------|-----|
| 🏠 **Page d'Accueil** | http://localhost:8080/analytics-dashboard/ |
| 📊 **Dashboard** | http://localhost:8080/analytics-dashboard/dashboard |
| 🗄️ **MongoDB Express** | http://localhost:8081/ |
| 🔌 **API REST** | http://localhost:8080/analytics-api/ |

---

## ⚠️ PROBLÈMES FRÉQUENTS

### Erreur : "Cannot connect to Docker daemon"
**Solution :** Docker Desktop n'est pas démarré. Ouvrez Docker Desktop et attendez.

### Erreur : "Port 8080 already in use"
**Solution :** Un autre service utilise le port 8080.
```powershell
# Trouver et tuer le processus
netstat -ano | findstr :8080
taskkill /PID <ID_DU_PROCESSUS> /F
```

### Erreur 404 persiste
**Solution :** Attendez 60 secondes après le démarrage, puis rafraîchissez (Ctrl+F5).

---

## 🎯 RÉCAPITULATIF ULTRA-RAPIDE

```powershell
# Copier-coller ceci dans PowerShell :

cd "C:\Users\saad0\Downloads\Streaming_Analytics-main\Streaming_Analytics-main"
docker-compose up -d
timeout /t 40
start http://localhost:8080/analytics-dashboard/
```

**C'est tout ! ✅**

---

## 📞 AIDE

Pour plus de détails, consultez :
- `SOLUTION_ERREUR_404.md` - Guide complet de résolution
- `RESUME_COMPLET.md` - Documentation complète du projet
- `DEMARRAGE_RAPIDE.md` - Référence rapide

---

**Date** : 27 Décembre 2025  
**Status** : Guide de Démarrage Rapide

