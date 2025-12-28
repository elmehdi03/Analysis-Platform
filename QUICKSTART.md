# 🚀 DÉMARRAGE RAPIDE - Streaming Analytics Platform

## ⚡ En 3 étapes

### 1️⃣ Vérifier les prérequis

Ouvrez PowerShell et exécutez :

```powershell
java -version    # Doit afficher Java 11+
mvn -version     # Doit afficher Maven 3.6+
docker --version # Doit afficher Docker
```

**Si quelque chose manque :**
- Java : https://adoptium.net/
- Maven : https://maven.apache.org/download.cgi
- Docker : https://www.docker.com/products/docker-desktop

### 2️⃣ Démarrer le projet

**Double-cliquez sur** `start.bat` **OU** ouvrez PowerShell et exécutez :

```powershell
.\start.ps1
```

Le script va :
- ✅ Compiler le projet
- ✅ Démarrer MongoDB
- ✅ Démarrer Tomcat avec l'API et le Dashboard

### 3️⃣ Accéder aux services

Après 30 secondes, ouvrez votre navigateur :

- **📊 Dashboard** : http://localhost:8080/analytics-dashboard/
- **🔌 API** : http://localhost:8080/analytics-api/api/v1/analytics/health
- **🍃 Mongo Express** : http://localhost:8081

---

## 🆘 Problèmes fréquents

### ❌ "Docker n'est pas en cours d'exécution"
➡️ **Solution** : Lancez Docker Desktop et attendez qu'il soit prêt

### ❌ "Port 8080 déjà utilisé"
➡️ **Solution** : Arrêtez l'autre application ou exécutez :
```powershell
docker-compose down
```

### ❌ "Compilation échouée"
➡️ **Solution** : Vérifiez que Java 11+ est installé :
```powershell
java -version
```

### ❌ Les services ne répondent pas
➡️ **Solution** : Attendez encore 10-20 secondes, ou redémarrez :
```powershell
docker-compose restart
```

---

## 📋 Commandes utiles

```powershell
# Voir les logs en temps réel
docker-compose logs -f

# Arrêter tous les services
docker-compose down

# Redémarrer un service
docker-compose restart tomcat

# Nettoyer complètement et redémarrer
docker-compose down -v
.\start.ps1
```

---

## 📚 Plus d'informations

Consultez le **[README.md](README.md)** pour la documentation complète.

---

**🎉 C'est tout ! Vous êtes prêt à développer !**

