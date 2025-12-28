# 🎬 Streaming Analytics Platform

Plateforme d'analyse Big Data pour streaming vidéo basée sur Jakarta EE avec traitement en temps réel et visualisation de données.

## 📋 Table des matières

- [Architecture](#architecture)
- [Prérequis](#prérequis)
- [Démarrage rapide](#démarrage-rapide)
- [Structure du projet](#structure-du-projet)
- [API Endpoints](#api-endpoints)
- [Développement](#développement)
- [Configuration](#configuration)
- [Dépannage](#dépannage)

## 🏗️ Architecture

- **Backend**: Jakarta EE 10 (JAX-RS, CDI) avec Jersey
- **Base de données**: MongoDB pour le stockage des événements et analytics
- **Frontend**: Dashboard JSP avec style rétro
- **Build**: Maven multi-module
- **Déploiement**: Docker Compose (Tomcat 10, MongoDB 7, Mongo Express)

## 📦 Modules

```
streaming-analytics-parent/
├── analytics-api/         # API REST pour l'ingestion et les requêtes
├── analytics-dashboard/   # Interface web de visualisation
└── data-generator/        # Générateur de données de test
```

## ⚙️ Prérequis

Avant de commencer, assurez-vous d'avoir installé :

- ✅ **Java 11+** (JDK 11 ou supérieur)
- ✅ **Maven 3.6+** (pour la compilation)
- ✅ **Docker Desktop** (avec Docker Compose)
- ✅ **Git** (optionnel)

### Vérification des prérequis

```powershell
# Vérifier Java
java -version

# Vérifier Maven
mvn -version

# Vérifier Docker
docker --version
docker-compose --version
```

## 🚀 Démarrage rapide

### Option 1 : Script automatique (recommandé)

```powershell
# Ouvrir PowerShell dans le dossier du projet
.\start.ps1
```

Le script va automatiquement :
1. Vérifier que Docker est lancé
2. Nettoyer les anciens conteneurs
3. Compiler le projet
4. Démarrer tous les services
5. Afficher les URLs d'accès

### Option 2 : Démarrage manuel

```powershell
# 1. Compiler le projet
mvn clean package -DskipTests

# 2. Démarrer les services Docker
docker-compose up -d

# 3. Attendre 30 secondes que les services démarrent

# 4. Vérifier que tout fonctionne
docker-compose ps
```

## 🌐 Accès aux services

Une fois démarré, vous pouvez accéder à :

| Service | URL | Description |
|---------|-----|-------------|
| 📊 **Dashboard** | http://localhost:8080/analytics-dashboard/ | Interface de visualisation |
| 🔌 **API** | http://localhost:8080/analytics-api/api/v1/analytics/health | API REST |
| 🍃 **Mongo Express** | http://localhost:8081 | Interface d'admin MongoDB |
| 🗄️ **MongoDB** | mongodb://admin:admin123@localhost:27017 | Base de données |

## 🔌 API Endpoints

### Health Check
```
GET /api/v1/analytics/health
```

### Événements
```
POST /api/v1/analytics/events          # Insérer un événement
POST /api/v1/analytics/events/batch    # Insérer plusieurs événements
```

### Analytics
```
GET /api/v1/analytics/videos/top?limit=10                    # Top vidéos
GET /api/v1/analytics/videos/{videoId}/stats                 # Stats d'une vidéo
GET /api/v1/analytics/users/{userId}/recommendations?limit=5 # Recommandations
```

### Exemple d'appel API

```powershell
# Health check
curl http://localhost:8080/analytics-api/api/v1/analytics/health

# Top 10 vidéos
curl http://localhost:8080/analytics-api/api/v1/analytics/videos/top?limit=10
```

## 💻 Développement

### Compiler le projet
```powershell
mvn clean package
```

### Compiler un module spécifique
```powershell
mvn clean package -pl analytics-api
mvn clean package -pl analytics-dashboard
```

### Lancer les tests
```powershell
mvn test
```

### Redéployer après modification
```powershell
# 1. Recompiler
mvn clean package -DskipTests

# 2. Redémarrer Tomcat
docker-compose restart tomcat
```

### Voir les logs
```powershell
# Tous les services
docker-compose logs -f

# Un service spécifique
docker-compose logs -f tomcat
docker-compose logs -f mongodb
```

## 🔧 Configuration

### Variables d'environnement (docker-compose.yml)

```yaml
MONGODB_HOST=mongodb
MONGODB_PORT=27017
MONGODB_DATABASE=streaming_analytics
MONGODB_USERNAME=admin
MONGODB_PASSWORD=admin123
```

### Ports utilisés

- **8080** : Tomcat (API + Dashboard)
- **8081** : Mongo Express
- **27017** : MongoDB

## 🆘 Dépannage

### Docker n'est pas lancé
```
❌ ERREUR: Docker n'est pas en cours d'exécution!
```
**Solution** : Démarrez Docker Desktop

### Port déjà utilisé
```
Error: Port 8080 is already in use
```
**Solution** : Arrêtez l'autre application ou modifiez le port dans docker-compose.yml

### Erreur de compilation Maven
```
[ERROR] Failed to execute goal...
```
**Solution** : Vérifiez que Java 11+ est installé et configuré

### Les services ne démarrent pas
```powershell
# Voir les logs détaillés
docker-compose logs

# Redémarrer proprement
docker-compose down -v
docker-compose up -d
```

### Nettoyer complètement le projet
```powershell
# Arrêter et supprimer tous les conteneurs et volumes
docker-compose down -v

# Nettoyer Maven
mvn clean

# Redémarrer
.\start.ps1
```

## 📚 Ressources

- Documentation Jakarta EE : https://jakarta.ee/
- MongoDB Documentation : https://docs.mongodb.com/
- Docker Documentation : https://docs.docker.com/

## 📝 Licence

Ce projet est un projet éducatif dans le cadre d'un TP Big Data.

---

**Besoin d'aide ?** Consultez la section [Dépannage](#dépannage) ou vérifiez les logs avec `docker-compose logs -f`
