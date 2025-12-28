# 🚀 Guide de Démarrage Rapide

## ✅ Fichiers Nettoyés

Les fichiers suivants ont été supprimés :
- ❌ `check.bat` et `check.ps1` (redondants)
- ❌ `COMMENCER_ICI.md`, `INDEX.md`, `LISEZ_MOI.txt` (documentation en double)
- ❌ Dossier `assets/` (fichiers d'exemple)
- ❌ Dossiers `target/` (seront recréés lors de la compilation)

## 📋 Structure Simplifiée

```
Aanlysis-Platform/
├── analytics-api/          # API REST
├── analytics-dashboard/    # Interface utilisateur
├── data-generator/         # Générateur de données
├── mongo-init/            # Scripts d'initialisation MongoDB
├── start.ps1              # ⭐ Script de démarrage PowerShell
├── start.bat              # ⭐ Script de démarrage Batch
├── docker-compose.yml     # Configuration Docker
└── pom.xml               # Configuration Maven
```

## 🎯 Démarrage en 1 Clic

### Option 1 : Double-clic (RECOMMANDÉ)
```
Double-cliquez sur : start.bat
```

### Option 2 : PowerShell
```powershell
.\start.ps1
```

## 📝 Ce que fait le script automatiquement

1. ✅ Vérifie que Docker est démarré
2. ✅ **Libère automatiquement les ports 27017, 8080, 8081**
3. ✅ Nettoie les anciens conteneurs
4. ✅ Compile le projet Maven
5. ✅ Démarre tous les services Docker
6. ✅ Attend que tout soit prêt

## 🌐 Services Disponibles

Après le démarrage (attendez 30 secondes) :

| Service | URL | Identifiants |
|---------|-----|--------------|
| **Dashboard** | http://localhost:8080/analytics-dashboard/ | - |
| **API** | http://localhost:8080/analytics-api/api/v1/analytics/health | - |
| **Mongo Express** | http://localhost:8081 | - |
| **MongoDB** | mongodb://localhost:27017 | admin / admin123 |

## 🛠️ Commandes Utiles

```bash
# Voir les logs en temps réel
docker-compose logs -f

# Voir les logs d'un service spécifique
docker-compose logs -f tomcat
docker-compose logs -f mongodb

# Arrêter tous les services
docker-compose down

# Arrêter et supprimer les données
docker-compose down -v

# Redémarrer un service
docker-compose restart tomcat

# Vérifier l'état des services
docker-compose ps
```

## 🔧 Résolution des Problèmes

### Erreur : Port déjà utilisé
✅ **Résolu automatiquement** - Le script libère maintenant les ports automatiquement !

Si le problème persiste :
```powershell
# Arrêter tous les conteneurs
docker-compose down -v

# Redémarrer le script
.\start.ps1
```

### Erreur : Docker n'est pas démarré
1. Démarrez Docker Desktop
2. Attendez que Docker soit complètement lancé (icône verte)
3. Relancez le script

### Erreur de compilation Maven
```bash
# Nettoyer complètement
mvn clean

# Recompiler
mvn package -DskipTests
```

## 📦 Prochaines Étapes

1. **Tester l'API** : Ouvrez http://localhost:8080/analytics-api/api/v1/analytics/health
2. **Accéder au Dashboard** : http://localhost:8080/analytics-dashboard/
3. **Explorer MongoDB** : http://localhost:8081
4. **Générer des données** : Utilisez le module `data-generator`

## 💡 Conseils

- ⚡ Utilisez `start.ps1` pour un démarrage rapide
- 📊 Consultez Mongo Express pour voir les données
- 🔄 Les modifications de code nécessitent une recompilation (`mvn package`)
- 🐛 Vérifiez les logs avec `docker-compose logs -f`

---

**Bon développement !** 🎉

