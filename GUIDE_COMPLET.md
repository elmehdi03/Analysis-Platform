# 🎯 GUIDE PAS À PAS - DÉMARRAGE DU PROJET

## ✅ ÉTAPE 1 : Vérifications préalables

### Docker Desktop doit être démarré
- ✅ Lancez Docker Desktop
- ✅ Attendez que l'icône soit verte (Docker est prêt)

---

## 🚀 ÉTAPE 2 : Démarrage automatique

### Option A : Double-clic (PLUS SIMPLE)
1. Localisez le fichier **`start.bat`** à la racine du projet
2. **Double-cliquez** dessus
3. Une fenêtre s'ouvre et exécute tout automatiquement
4. Attendez environ **2-3 minutes** (compilation + démarrage)

### Option B : PowerShell
```powershell
# Ouvrez PowerShell dans le dossier du projet
powershell -ExecutionPolicy Bypass -File start.ps1
```

---

## 📊 ÉTAPE 3 : Ce qui se passe automatiquement

Le script fait **6 étapes automatiques** :

```
[1/6] Vérification de Docker...                 ✅
[2/6] Vérification des ports...                 ✅ Libère 27017, 8080, 8081
[3/6] Nettoyage des anciens conteneurs...       ✅
[4/6] Compilation du projet Maven...            ✅ ~2 minutes
[5/6] Démarrage des services Docker...          ✅
[6/6] Attente du démarrage complet (30s)...     ✅
```

---

## 🌐 ÉTAPE 4 : Vérifier que tout fonctionne

### Ouvrez ces URLs dans votre navigateur :

#### 1️⃣ Test de l'API (doit retourner du JSON)
```
http://localhost:8080/analytics-api/api/v1/analytics/health
```
✅ **Résultat attendu :** `{"status":"UP"}` ou similaire

#### 2️⃣ Dashboard de l'application
```
http://localhost:8080/analytics-dashboard/
```
✅ **Résultat attendu :** Page d'accueil du dashboard

#### 3️⃣ Interface MongoDB (Mongo Express)
```
http://localhost:8081
```
✅ **Résultat attendu :** Interface web pour voir les données MongoDB

---

## 🔍 ÉTAPE 5 : Vérifier les services Docker

```bash
# Voir l'état des conteneurs
docker-compose ps
```

✅ **Vous devriez voir :**
- `streaming-mongodb` → Up (healthy)
- `streaming-tomcat` → Up (healthy)
- `streaming-mongo-express` → Up

```bash
# Voir les logs en temps réel
docker-compose logs -f
```

---

## 🛠️ ÉTAPE 6 : Développement

### Modifier le code Java

1. **Éditez** vos fichiers Java dans `analytics-api/src/` ou `analytics-dashboard/src/`
2. **Recompilez** :
   ```bash
   mvn clean package -DskipTests
   ```
3. **Redémarrez** Tomcat :
   ```bash
   docker-compose restart tomcat
   ```

### Générer des données de test

```bash
# Le générateur de données est dans data-generator/
java -jar data-generator/target/data-generator-1.0-SNAPSHOT.jar
```

---

## 🆘 RÉSOLUTION DE PROBLÈMES

### ❌ Erreur : "Port already allocated"
**Solution :** Le script gère ça automatiquement maintenant !

Si ça persiste :
```bash
docker-compose down -v
docker stop $(docker ps -aq)  # Arrête TOUS les conteneurs
.\start.bat  # Relancez
```

### ❌ Erreur : "Docker n'est pas en cours d'exécution"
1. Démarrez Docker Desktop
2. Attendez l'icône verte (Docker prêt)
3. Relancez le script

### ❌ Page blanche ou erreur 404
1. Attendez 1-2 minutes de plus (Tomcat peut être lent)
2. Vérifiez les logs :
   ```bash
   docker-compose logs -f tomcat
   ```
3. Vérifiez que la compilation a réussi :
   ```bash
   ls analytics-api/target/*.war
   ls analytics-dashboard/target/*.war
   ```

### ❌ Erreur de compilation Maven
```bash
# Nettoyez complètement
mvn clean

# Vérifiez Java
java -version  # Doit être Java 11 ou 17

# Recompilez
mvn package -DskipTests
```

### ❌ Service ne démarre pas
```bash
# Voir les logs détaillés d'un service
docker-compose logs -f tomcat
docker-compose logs -f mongodb
docker-compose logs -f mongo-express

# Redémarrer un service spécifique
docker-compose restart tomcat

# Reconstruire et redémarrer
docker-compose up -d --build
```

---

## 📋 COMMANDES UTILES

### Gestion des services
```bash
# Voir l'état
docker-compose ps

# Voir les logs
docker-compose logs -f

# Logs d'un service spécifique
docker-compose logs -f tomcat

# Arrêter tout
docker-compose down

# Arrêter et supprimer les données
docker-compose down -v

# Redémarrer tout
docker-compose restart

# Redémarrer un service
docker-compose restart tomcat
```

### Développement
```bash
# Recompiler
mvn clean package -DskipTests

# Recompiler un module spécifique
cd analytics-api
mvn package -DskipTests

# Reconstruire l'image Docker
docker-compose build

# Reconstruire et redémarrer
docker-compose up -d --build
```

### Debugging
```bash
# Entrer dans un conteneur
docker exec -it streaming-tomcat bash
docker exec -it streaming-mongodb mongosh

# Voir les processus
docker-compose top

# Voir l'utilisation des ressources
docker stats

# Nettoyer complètement Docker
docker system prune -a
```

---

## 📦 STRUCTURE DU PROJET

```
Aanlysis-Platform/
├── analytics-api/              # API REST
│   ├── src/main/java/          # Code Java
│   └── target/                 # WAR compilé
├── analytics-dashboard/        # Interface utilisateur
│   ├── src/main/webapp/        # JSP, HTML, CSS
│   └── target/                 # WAR compilé
├── data-generator/             # Générateur de données
├── mongo-init/                 # Scripts init MongoDB
├── start.bat                   # ⭐ Script de démarrage
├── start.ps1                   # ⭐ Script PowerShell
└── docker-compose.yml          # Configuration Docker
```

---

## ✅ CHECKLIST DE DÉMARRAGE

- [ ] Docker Desktop est démarré (icône verte)
- [ ] Double-clic sur `start.bat` OU `powershell -ExecutionPolicy Bypass -File start.ps1`
- [ ] Attendre 2-3 minutes (compilation + démarrage)
- [ ] Vérifier http://localhost:8080/analytics-api/api/v1/analytics/health
- [ ] Ouvrir http://localhost:8080/analytics-dashboard/
- [ ] Explorer http://localhost:8081 (Mongo Express)
- [ ] Vérifier les logs : `docker-compose logs -f`

---

## 🎯 PROCHAINES ÉTAPES

1. **Tester l'API** avec Postman ou curl
2. **Développer** votre code Java
3. **Générer des données** de test
4. **Consulter** la documentation dans `README.md`

---

## 📚 DOCUMENTATION

- **Ce fichier** : Guide pas à pas complet
- **LIRE_EN_PREMIER.txt** : Résumé ultra-rapide
- **RESUME_ACTIONS.md** : Ce qui a été nettoyé et corrigé
- **README.md** : Documentation complète du projet
- **QUICKSTART.md** : Guide de démarrage rapide
- **STRUCTURE.md** : Architecture détaillée

---

## ✨ TOUT EST PRÊT !

**Votre projet est nettoyé, corrigé et prêt à fonctionner.**

👉 **Lancez simplement `start.bat` et commencez à développer !**

🎉 **Bon développement !**

