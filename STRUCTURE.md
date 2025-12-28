# 📁 Structure du Projet - Streaming Analytics Platform

## 🗂️ Vue d'ensemble

```
Aanlysis-Platform/
│
├── 📄 pom.xml                    # POM parent Maven
├── 📄 docker-compose.yml         # Configuration Docker
├── 📄 Dockerfile                 # Image Docker pour Tomcat
│
├── 🚀 start.ps1                  # Script de démarrage PowerShell
├── 🚀 start.bat                  # Script de démarrage Batch
│
├── 📖 README.md                  # Documentation principale
├── 📖 QUICKSTART.md              # Guide de démarrage rapide
├── 📖 STRUCTURE.md               # Ce fichier
│
├── 📦 analytics-api/             # Module API REST
│   ├── pom.xml
│   └── src/
│       └── main/
│           ├── java/
│           │   └── com/streaming/analytics/
│           │       ├── api/         # Endpoints REST
│           │       ├── model/       # Modèles de données
│           │       └── service/     # Services métier
│           └── webapp/
│               └── WEB-INF/
│                   ├── beans.xml    # Configuration CDI
│                   └── web.xml      # Configuration serveur
│
├── 📊 analytics-dashboard/       # Module Dashboard Web
│   ├── pom.xml
│   └── src/
│       └── main/
│           ├── java/
│           │   ├── com/streaming/analytics/
│           │   │   └── servlet/     # Servlets
│           │   └── org/hsc/pj/
│           │       └── filter/      # Filtres HTTP
│           └── webapp/
│               ├── index.jsp        # Page d'accueil
│               ├── css/
│               │   └── style.css    # Styles
│               └── WEB-INF/
│                   ├── beans.xml
│                   ├── web.xml
│                   └── views/       # Vues JSP
│
├── 🔧 data-generator/            # Module générateur de données
│   ├── pom.xml
│   └── src/
│       └── main/
│           └── java/
│               └── com/streaming/datagenerator/
│                   └── DataGenerator.java
│
├── 🗄️ mongo-init/                # Scripts d'initialisation MongoDB
│   └── init.js                   # Création des collections et index
│
└── 📂 assets/                    # Fichiers de référence et exemples
    ├── README.md
    ├── postman-collection.json   # Collection Postman pour tester l'API
    └── ...
```

## 🎯 Modules principaux

### 1. **analytics-api** 📦
**Type:** Application WAR (Web Application Archive)  
**Rôle:** API REST pour l'ingestion et l'analyse de données

**Composants clés:**
- `AnalyticsResource` : Endpoints REST JAX-RS
- `EventService` : Service d'ingestion d'événements
- `AnalyticsService` : Service d'analytics et recommandations
- `Event`, `Video`, `User` : Modèles de données

**Technologies:**
- Jakarta EE 10
- JAX-RS (Jersey)
- CDI (Contexts and Dependency Injection)
- MongoDB Driver

**URL d'accès:** http://localhost:8080/analytics-api/

### 2. **analytics-dashboard** 📊
**Type:** Application WAR  
**Rôle:** Interface web de visualisation

**Composants clés:**
- `DashboardServlet` : Servlet principal
- JSP Views : Vues avec style rétro
- CSS : Styles pour l'interface

**Technologies:**
- Jakarta Servlet
- JSP/JSTL
- CSS

**URL d'accès:** http://localhost:8080/analytics-dashboard/

### 3. **data-generator** 🔧
**Type:** Application JAR exécutable  
**Rôle:** Générer des données de test

**Utilisation:**
```powershell
java -jar data-generator/target/data-generator-1.0-SNAPSHOT.jar
```

## 🐳 Infrastructure Docker

### Services

1. **mongodb** - Base de données
   - Port: 27017
   - User: admin / admin123
   - Database: streaming_analytics

2. **mongo-express** - Interface d'administration MongoDB
   - Port: 8081
   - URL: http://localhost:8081

3. **tomcat** - Serveur d'application
   - Port: 8080
   - Déploie: analytics-api.war + analytics-dashboard.war

## 🔄 Workflow de développement

### 1. Modifier le code
Éditez les fichiers dans `src/main/java/` ou `src/main/webapp/`

### 2. Recompiler
```powershell
mvn clean package -DskipTests
```

### 3. Redéployer
```powershell
docker-compose restart tomcat
```

### 4. Tester
Accédez aux URLs dans votre navigateur

## 📊 Collections MongoDB

Créées automatiquement au démarrage via `mongo-init/init.js`:

- **events** : Événements de visualisation
- **videos** : Métadonnées des vidéos
- **users** : Informations utilisateurs
- **analytics** : Données agrégées

## 🔗 Dépendances Maven

### Parent POM (`pom.xml`)
Définit les versions communes pour tous les modules

### Dépendances principales:
- Jakarta EE 10
- MongoDB Driver 4.11.1
- Jackson 2.16.1 (JSON)
- SLF4J 2.0.9 (Logging)

## 📝 Fichiers de configuration

### `docker-compose.yml`
Configuration des services Docker

### `Dockerfile`
Image Tomcat personnalisée avec les WARs

### `pom.xml` (parent)
Configuration Maven parent

### `WEB-INF/web.xml`
Configuration des applications web

### `WEB-INF/beans.xml`
Activation de CDI

## 🛠️ Commandes utiles

```powershell
# Compiler tout
mvn clean package

# Compiler un module
mvn clean package -pl analytics-api

# Voir l'arbre de dépendances
mvn dependency:tree

# Démarrer Docker
docker-compose up -d

# Voir les logs
docker-compose logs -f tomcat

# Arrêter Docker
docker-compose down

# Nettoyer complètement
docker-compose down -v
mvn clean
```

## 📚 Ressources

- [README.md](README.md) - Documentation complète
- [QUICKSTART.md](QUICKSTART.md) - Démarrage rapide
- [assets/postman-collection.json](assets/postman-collection.json) - Collection API

---

**Maintenu par:** Équipe Streaming Analytics  
**Dernière mise à jour:** 2025-12-28

