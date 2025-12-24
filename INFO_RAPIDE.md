# 🚀 Streaming Analytics Dashboard - Information Rapide

## ✅ Le projet est maintenant en cours d'exécution !

### 🌐 URLs d'Accès

| Service | URL | Description |
|---------|-----|-------------|
| **Dashboard Principal** | http://localhost:8080/analytics-dashboard/ | Interface utilisateur principale |
| **API REST** | http://localhost:8080/analytics-api/api/v1/analytics/health | API Backend |
| **Mongo Express** | http://localhost:8081 | Interface MongoDB |

---

## 📁 Fichiers CSS à Modifier

### Fichier Principal - Page d'Accueil
```
📂 analytics-dashboard/src/main/webapp/index.jsp
   └─ CSS intégré : lignes 7-221
```

### Fichier Principal - Dashboard
```
📂 analytics-dashboard/src/main/webapp/WEB-INF/views/dashboard.jsp
   └─ CSS intégré : lignes 6-220+
```

### Fichier CSS Externe (Optionnel)
```
📂 analytics-dashboard/src/main/webapp/css/style.css
   └─ CSS séparé avec variables et commentaires
```

---

## ⚡ Workflow Rapide - Modifier le CSS

### Méthode 1 : Script PowerShell (Recommandé)
```powershell
.\dev.ps1
```
Puis choisir l'option **[2] Recompiler uniquement le dashboard**

### Méthode 2 : Commandes Manuelles
```powershell
# 1. Modifier les fichiers JSP/CSS
# 2. Recompiler
mvn clean package -pl analytics-dashboard

# 3. Redémarrer Tomcat
docker-compose restart streaming-tomcat

# 4. Attendre 10-15 secondes
# 5. Actualiser le navigateur (Ctrl + F5)
```

---

## 🎨 Couleurs Actuelles du Thème

| Élément | Couleur | Code Hex |
|---------|---------|----------|
| Violet Principal | 🟣 | `#a855f7` |
| Rose | 🌸 | `#ec4899` |
| Cyan | 🔵 | `#06b6d4` |
| Fond Sombre 1 | ⚫ | `#0f0c29` |
| Fond Sombre 2 | ⚫ | `#302b63` |
| Fond Sombre 3 | ⚫ | `#24243e` |

---

## 🛠️ Commandes Docker Utiles

```powershell
# Démarrer les services
docker-compose up -d

# Arrêter les services
docker-compose down

# Redémarrer Tomcat uniquement
docker-compose restart streaming-tomcat

# Voir les logs de Tomcat
docker logs -f streaming-tomcat

# Voir l'état des conteneurs
docker-compose ps

# Redémarrer tous les services
docker-compose restart
```

---

## 📦 Commandes Maven Utiles

```powershell
# Compiler tout le projet
mvn clean package

# Compiler uniquement le dashboard
mvn clean package -pl analytics-dashboard

# Compiler uniquement l'API
mvn clean package -pl analytics-api

# Nettoyer les fichiers compilés
mvn clean

# Exécuter les tests
mvn test
```

---

## 🔍 Vérifier que Tout Fonctionne

### Test 1 : Conteneurs en cours d'exécution
```powershell
docker ps
```
Vous devriez voir :
- `streaming-tomcat`
- `streaming-mongodb`
- `streaming-mongo-express`

### Test 2 : Dashboard accessible
```powershell
Start-Process "http://localhost:8080/analytics-dashboard/"
```

### Test 3 : API fonctionne
```powershell
Invoke-WebRequest -Uri "http://localhost:8080/analytics-api/api/v1/analytics/health"
```

---

## 📚 Documentation Créée

| Fichier | Description |
|---------|-------------|
| `GUIDE_DEMARRAGE.md` | Guide complet de démarrage |
| `EXEMPLES_CSS.md` | Exemples de modifications CSS |
| `INFO_RAPIDE.md` | Ce fichier - informations rapides |
| `dev.ps1` | Script PowerShell interactif |
| `css/style.css` | Fichier CSS externe (optionnel) |

---

## ⚠️ Résolution de Problèmes

### Le site ne charge pas
```powershell
# Vérifier les logs
docker logs streaming-tomcat

# Redémarrer si nécessaire
docker-compose restart streaming-tomcat
```

### Les modifications CSS ne s'affichent pas
1. Avez-vous recompilé ? → `mvn clean package -pl analytics-dashboard`
2. Avez-vous redémarré Tomcat ? → `docker-compose restart streaming-tomcat`
3. Videz le cache du navigateur → Ctrl + Shift + Delete
4. Actualisez la page → Ctrl + F5

### Port 8080 déjà utilisé
```powershell
# Trouver le processus qui utilise le port
netstat -ano | findstr :8080

# Ou modifier le port dans docker-compose.yml
# Changer "8080:8080" en "8081:8080" par exemple
```

### Docker ne démarre pas
1. Vérifiez que Docker Desktop est lancé
2. Vérifiez les ressources disponibles (RAM, CPU)
3. Redémarrez Docker Desktop

---

## 🎯 Prochaines Étapes

1. ✅ Le projet est démarré
2. 🎨 Modifier le CSS dans les fichiers JSP
3. 🔄 Recompiler avec le script `dev.ps1` ou manuellement
4. 🌐 Tester dans le navigateur
5. 🔁 Répéter jusqu'à satisfaction

---

## 💡 Astuces

- Utilisez les **DevTools du navigateur** (F12) pour tester des modifications CSS en temps réel
- Gardez un **backup** de vos fichiers avant de grandes modifications
- Utilisez le **script dev.ps1** pour automatiser le workflow
- Consultez **EXEMPLES_CSS.md** pour des idées de modifications

---

## 📞 Besoin d'Aide ?

Consultez les fichiers de documentation :
- `GUIDE_DEMARRAGE.md` - Guide détaillé
- `EXEMPLES_CSS.md` - Exemples concrets
- `README.md` - Documentation du projet

---

Bon développement ! 🚀✨

