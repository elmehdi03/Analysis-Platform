# 🚀 Guide de Démarrage - Streaming Analytics Dashboard

## ✅ Statut : Le projet est maintenant en cours d'exécution !

### 📍 URLs d'accès

- **Dashboard Principal** : http://localhost:8080/analytics-dashboard/
- **API REST** : http://localhost:8080/analytics-api/api/v1/analytics/health
- **Mongo Express** (Interface MongoDB) : http://localhost:8081

---

## 🎨 Modifier le CSS

Le CSS est actuellement intégré dans les fichiers JSP. Voici les fichiers à modifier :

### 1. **Page d'Accueil** (`index.jsp`)
📂 Chemin : `analytics-dashboard/src/main/webapp/index.jsp`

Le CSS se trouve dans les balises `<style>` (lignes 7 à 221). C'est ici que vous pouvez :
- Changer les couleurs du thème (ex: `#a855f7`, `#ec4899`)
- Modifier les dégradés de fond
- Ajuster les tailles de police
- Personnaliser les effets de survol

### 2. **Page Dashboard** (`dashboard.jsp`)
📂 Chemin : `analytics-dashboard/src/main/webapp/WEB-INF/views/dashboard.jsp`

Le CSS se trouve dans les balises `<style>` (lignes 6 à 220+). C'est ici que vous pouvez :
- Modifier l'apparence des cartes de statistiques
- Personnaliser les tableaux de données
- Changer les animations

---

## 🔄 Workflow de développement

Après avoir modifié le CSS, suivez ces étapes :

### Méthode 1 : Recompiler et redéployer (Recommandé)
```powershell
# 1. Recompiler le projet
mvn clean package

# 2. Redémarrer Tomcat pour charger les changements
docker-compose restart streaming-tomcat

# 3. Attendre ~10 secondes, puis actualiser le navigateur
# Le navigateur devrait être à : http://localhost:8080/analytics-dashboard/
```

### Méthode 2 : Développement rapide (sans Docker)
Si vous voulez voir les changements plus rapidement :
```powershell
# 1. Modifier le fichier JSP
# 2. Recompiler juste le module dashboard
mvn clean package -pl analytics-dashboard

# 3. Redémarrer Tomcat
docker-compose restart streaming-tomcat
```

---

## 📂 Structure des fichiers CSS/JSP

```
analytics-dashboard/src/main/webapp/
├── index.jsp                      ← Page d'accueil (CSS ligne 7-221)
└── WEB-INF/
    └── views/
        └── dashboard.jsp          ← Dashboard principal (CSS ligne 6-220+)
```

---

## 🎨 Exemples de modifications CSS courantes

### Changer la couleur principale (violet → bleu)
Recherchez et remplacez dans les fichiers JSP :
```css
/* Ancien (violet) */
#a855f7

/* Nouveau (bleu) */
#3b82f6
```

### Changer la couleur secondaire (rose → cyan)
```css
/* Ancien (rose) */
#ec4899

/* Nouveau (cyan) */
#06b6d4
```

### Modifier le fond dégradé
Dans `body` :
```css
body {
    /* Ancien */
    background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
    
    /* Nouveau (exemple bleu foncé) */
    background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 50%, #1e40af 100%);
}
```

### Ajuster la taille des boutons
```css
.modern-button {
    padding: 18px 45px;  /* Modifier pour agrandir/réduire */
    font-size: 1.1em;    /* Modifier la taille du texte */
}
```

---

## 🛠️ Commandes utiles

### Vérifier l'état des conteneurs
```powershell
docker-compose ps
docker logs streaming-tomcat
```

### Arrêter le projet
```powershell
docker-compose down
```

### Redémarrer le projet
```powershell
docker-compose up -d
```

### Voir les logs en temps réel
```powershell
docker logs -f streaming-tomcat
```

### Nettoyer et tout reconstruire
```powershell
mvn clean package
docker-compose down
docker-compose up -d
```

---

## 🎯 Conseils pour modifier le CSS

1. **Utilisez un éditeur avec coloration syntaxique** (VS Code, IntelliJ IDEA)
2. **Testez les changements progressivement** - modifiez une chose à la fois
3. **Gardez une sauvegarde** de l'original avant de grandes modifications
4. **Utilisez les outils de développement du navigateur** (F12) pour tester des modifications avant de les appliquer
5. **Les couleurs utilisent le format hexadécimal** (#RRGGBB)

---

## 🌈 Palette de couleurs actuelle

| Élément | Couleur | Utilisation |
|---------|---------|-------------|
| Violet principal | `#a855f7` | Titres, bordures, effets |
| Rose | `#ec4899` | Accents, dégradés |
| Cyan | `#06b6d4` | Accents complémentaires |
| Bleu foncé | `#0f0c29` | Fond de base |
| Violet foncé | `#302b63` | Fond dégradé |

---

## 📞 En cas de problème

### Le site ne charge pas
```powershell
# Vérifier que Tomcat fonctionne
docker logs streaming-tomcat

# Redémarrer si nécessaire
docker-compose restart streaming-tomcat
```

### Les modifications CSS ne s'appliquent pas
1. Assurez-vous d'avoir recompilé : `mvn clean package`
2. Redémarrez Tomcat : `docker-compose restart streaming-tomcat`
3. Videz le cache du navigateur (Ctrl + Shift + Delete)
4. Actualisez la page (Ctrl + F5)

### Port 8080 déjà utilisé
```powershell
# Trouver et arrêter le processus
netstat -ano | findstr :8080
# Ou changer le port dans docker-compose.yml
```

---

## ✨ Bon développement !

N'hésitez pas à expérimenter avec les couleurs, les tailles, les animations et les effets.
Le CSS est moderne et utilise des dégradés, des ombres et des transitions fluides.

**Astuce Pro** : Utilisez les DevTools du navigateur (F12) pour tester des modifications CSS en temps réel avant de les appliquer au code source !

