# 🎨 Exemples de Modifications CSS

Ce document contient des exemples concrets de modifications CSS que vous pouvez appliquer au dashboard.

---

## 🌈 Changement de Palette de Couleurs

### Thème 1 : Bleu Océan
```css
/* Remplacer dans body */
background: linear-gradient(135deg, #0a1929 0%, #1e3a5f 50%, #2563eb 100%);

/* Remplacer dans h1 */
background: linear-gradient(135deg, #3b82f6 0%, #06b6d4 50%, #10b981 100%);

/* Remplacer les bordures */
border: 1px solid rgba(59, 130, 246, 0.2);
```

### Thème 2 : Coucher de Soleil
```css
/* Remplacer dans body */
background: linear-gradient(135deg, #451a03 0%, #7c2d12 50%, #ea580c 100%);

/* Remplacer dans h1 */
background: linear-gradient(135deg, #fb923c 0%, #f97316 50%, #facc15 100%);

/* Remplacer les bordures */
border: 1px solid rgba(251, 146, 60, 0.2);
```

### Thème 3 : Forêt Mystique
```css
/* Remplacer dans body */
background: linear-gradient(135deg, #022c22 0%, #064e3b 50%, #047857 100%);

/* Remplacer dans h1 */
background: linear-gradient(135deg, #10b981 0%, #34d399 50%, #6ee7b7 100%);

/* Remplacer les bordures */
border: 1px solid rgba(16, 185, 129, 0.2);
```

### Thème 4 : Monochrome Élégant
```css
/* Remplacer dans body */
background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);

/* Remplacer dans h1 */
background: linear-gradient(135deg, #94a3b8 0%, #cbd5e1 50%, #e2e8f0 100%);

/* Remplacer les bordures */
border: 1px solid rgba(148, 163, 184, 0.2);
```

---

## 💫 Animations et Effets

### Animation de pulsation pour les cartes
```css
@keyframes pulse-card {
    0%, 100% {
        box-shadow: 0 8px 32px rgba(168, 85, 247, 0.2);
    }
    50% {
        box-shadow: 0 8px 32px rgba(168, 85, 247, 0.5);
    }
}

.feature-card {
    animation: pulse-card 3s ease-in-out infinite;
}
```

### Effet de particules en arrière-plan
```css
body::after {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    background-image: 
        radial-gradient(circle, rgba(255, 255, 255, 0.1) 1px, transparent 1px);
    background-size: 50px 50px;
    opacity: 0.3;
    animation: float 20s linear infinite;
}

@keyframes float {
    0% {
        transform: translateY(0);
    }
    100% {
        transform: translateY(-50px);
    }
}
```

### Effet de brillance sur les boutons
```css
.modern-button {
    position: relative;
    overflow: hidden;
}

.modern-button::after {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(
        45deg,
        transparent,
        rgba(255, 255, 255, 0.1),
        transparent
    );
    transform: rotate(45deg);
    animation: shine 3s ease-in-out infinite;
}

@keyframes shine {
    0% {
        transform: translateX(-100%) rotate(45deg);
    }
    100% {
        transform: translateX(100%) rotate(45deg);
    }
}
```

---

## 📐 Modifications de Layout

### Cards plus larges
```css
.feature-card {
    padding: 40px;  /* Augmenter de 30px à 40px */
    min-height: 250px;  /* Ajouter une hauteur minimum */
}
```

### Grille en 2 colonnes sur desktop
```css
.feature-grid {
    grid-template-columns: repeat(2, 1fr);  /* Force 2 colonnes */
    gap: 40px;  /* Augmenter l'espace entre les cartes */
}
```

### Container pleine largeur
```css
.modern-container {
    max-width: 1400px;  /* Augmenter de 900px à 1400px */
}
```

---

## 🔤 Modifications de Typographie

### Police Google Fonts (Poppins)
Ajouter dans le `<head>` :
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700;800&display=swap" rel="stylesheet">
```

Puis dans le CSS :
```css
body {
    font-family: 'Poppins', 'Segoe UI', system-ui, sans-serif;
}
```

### Titres plus grands
```css
h1 {
    font-size: 4em;  /* Augmenter de 3.5em à 4em */
}

.subtitle {
    font-size: 1.5em;  /* Augmenter de 1.3em à 1.5em */
}
```

### Texte avec ombre
```css
h1 {
    text-shadow: 0 0 30px rgba(168, 85, 247, 0.5);
}
```

---

## 🎭 Effets de Hover Avancés

### Rotation 3D au survol
```css
.feature-card {
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    transform-style: preserve-3d;
}

.feature-card:hover {
    transform: translateY(-8px) rotateX(5deg) rotateY(5deg);
}
```

### Effet de lumière néon
```css
.modern-button:hover {
    box-shadow: 0 0 20px rgba(168, 85, 247, 0.6),
                0 0 40px rgba(168, 85, 247, 0.4),
                0 0 60px rgba(168, 85, 247, 0.2);
}
```

### Bordure animée
```css
.feature-card {
    position: relative;
    overflow: hidden;
}

.feature-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 2px;
    background: linear-gradient(90deg, transparent, #a855f7, transparent);
    animation: border-slide 2s linear infinite;
}

@keyframes border-slide {
    0% {
        left: -100%;
    }
    100% {
        left: 100%;
    }
}
```

---

## 🌟 Mode Sombre/Clair (Bonus)

### Ajouter un toggle pour basculer entre les thèmes
```css
/* Variables pour le mode clair */
body.light-mode {
    background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 50%, #cbd5e1 100%);
    color: #1e293b;
}

body.light-mode .modern-container {
    background: rgba(255, 255, 255, 0.9);
    border: 1px solid rgba(148, 163, 184, 0.3);
}

body.light-mode h1 {
    background: linear-gradient(135deg, #7c3aed 0%, #db2777 50%, #0891b2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}
```

---

## 📱 Responsive Design

### Améliorer l'affichage mobile
```css
@media (max-width: 480px) {
    h1 {
        font-size: 2em;
    }
    
    .modern-container {
        padding: 20px 15px;
        border-radius: 16px;
    }
    
    .modern-button {
        padding: 14px 30px;
        font-size: 0.9em;
    }
    
    .feature-card {
        padding: 20px;
    }
}
```

---

## 🎯 Astuces Pro

### 1. Utiliser CSS Variables pour faciliter les modifications
```css
:root {
    --primary-color: #a855f7;
    --secondary-color: #ec4899;
    --bg-gradient-start: #0f0c29;
    --bg-gradient-mid: #302b63;
    --bg-gradient-end: #24243e;
}

/* Puis utiliser dans le code */
body {
    background: linear-gradient(135deg, 
        var(--bg-gradient-start) 0%, 
        var(--bg-gradient-mid) 50%, 
        var(--bg-gradient-end) 100%
    );
}
```

### 2. Smooth Scrolling
```css
html {
    scroll-behavior: smooth;
}
```

### 3. Anti-aliasing pour un texte plus net
```css
body {
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}
```

### 4. Transitions globales douces
```css
* {
    transition: background-color 0.3s ease, 
                color 0.3s ease, 
                border-color 0.3s ease;
}
```

---

## 🔧 Comment appliquer ces modifications

1. **Ouvrir le fichier JSP** :
   - Pour la page d'accueil : `analytics-dashboard/src/main/webapp/index.jsp`
   - Pour le dashboard : `analytics-dashboard/src/main/webapp/WEB-INF/views/dashboard.jsp`

2. **Trouver la section `<style>`** (généralement entre les lignes 7 et 220)

3. **Copier-coller les modifications** dans les classes correspondantes

4. **Sauvegarder le fichier**

5. **Recompiler et redéployer** :
   ```powershell
   mvn clean package
   docker-compose restart streaming-tomcat
   ```

6. **Actualiser le navigateur** (Ctrl + F5 pour vider le cache)

---

## 📚 Ressources Utiles

- **Palettes de couleurs** : https://coolors.co/
- **Dégradés CSS** : https://cssgradient.io/
- **Animations CSS** : https://animate.style/
- **Google Fonts** : https://fonts.google.com/
- **CSS Tricks** : https://css-tricks.com/

---

Bon design ! 🎨✨

