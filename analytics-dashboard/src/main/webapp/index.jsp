<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DataFlow Analytics - Intelligence Platform</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            @import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap');

            :root {
                --primary-cyan: #06b6d4;
                --primary-orange: #f97316;
                --accent-teal: #14b8a6;
                --accent-amber: #fbbf24;
                --bg-dark: #0f172a;
                --bg-slate: #1e293b;
                --bg-card: #334155;
                --text-white: #f8fafc;
                --text-gray: #cbd5e1;
                --text-muted: #94a3b8;
                --border-color: #475569;
            }

            body {
                font-family: 'Space Grotesk', 'Inter', sans-serif;
                background: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-slate) 100%);
                color: var(--text-white);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
                position: relative;
                overflow-x: hidden;
            }

            body::before {
                content: '';
                position: fixed;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background:
                    radial-gradient(circle at 30% 40%, rgba(6, 182, 212, 0.08) 0%, transparent 50%),
                    radial-gradient(circle at 70% 60%, rgba(249, 115, 22, 0.08) 0%, transparent 50%);
                animation: rotate 20s linear infinite;
                pointer-events: none;
                z-index: 0;
            }

            @keyframes rotate {
                0% {
                    transform: rotate(0deg);
                }

                100% {
                    transform: rotate(360deg);
                }
            }

            .container {
                max-width: 1200px;
                width: 100%;
                background: rgba(30, 41, 59, 0.6);
                border-radius: 24px;
                padding: 80px 60px;
                border: 1px solid var(--border-color);
                position: relative;
                z-index: 1;
                backdrop-filter: blur(20px);
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
            }

            .header {
                text-align: center;
                margin-bottom: 60px;
            }

            h1 {
                font-size: 4.5em;
                font-weight: 700;
                margin-bottom: 16px;
                background: linear-gradient(90deg, var(--primary-cyan) 0%, var(--primary-orange) 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                letter-spacing: -2px;
                line-height: 1.1;
            }

            .tagline {
                color: var(--text-gray);
                font-size: 1.3em;
                font-weight: 400;
                margin-bottom: 24px;
                font-family: 'Inter', sans-serif;
            }

            .description {
                color: var(--text-muted);
                font-size: 1.05em;
                line-height: 1.7;
                max-width: 700px;
                margin: 0 auto;
                font-family: 'Inter', sans-serif;
            }

            .metrics-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 24px;
                margin: 50px 0;
            }

            .metric-card {
                background: linear-gradient(135deg, rgba(51, 65, 85, 0.8) 0%, rgba(30, 41, 59, 0.8) 100%);
                border-radius: 16px;
                padding: 32px;
                border: 1px solid var(--border-color);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .metric-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 4px;
                height: 100%;
                background: linear-gradient(180deg, var(--primary-cyan), var(--primary-orange));
                transition: width 0.3s ease;
            }

            .metric-card:hover::before {
                width: 100%;
                opacity: 0.1;
            }

            .metric-card:hover {
                transform: translateY(-8px);
                border-color: var(--primary-cyan);
                box-shadow: 0 20px 40px rgba(6, 182, 212, 0.2);
            }

            .metric-icon {
                font-size: 3em;
                margin-bottom: 20px;
                display: block;
                position: relative;
                z-index: 1;
            }

            .metric-title {
                color: var(--text-white);
                font-size: 1.4em;
                font-weight: 600;
                margin-bottom: 12px;
                position: relative;
                z-index: 1;
            }

            .metric-description {
                color: var(--text-muted);
                font-size: 0.95em;
                line-height: 1.6;
                position: relative;
                z-index: 1;
                font-family: 'Inter', sans-serif;
            }

            .cta-section {
                text-align: center;
                margin: 60px 0 40px 0;
            }

            .primary-btn {
                display: inline-block;
                background: linear-gradient(90deg, var(--primary-cyan) 0%, var(--accent-teal) 100%);
                color: var(--bg-dark);
                padding: 18px 48px;
                text-decoration: none;
                border-radius: 12px;
                font-size: 1.1em;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                box-shadow: 0 8px 24px rgba(6, 182, 212, 0.3);
                border: none;
                cursor: pointer;
                position: relative;
                overflow: hidden;
            }

            .primary-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                transition: left 0.5s;
            }

            .primary-btn:hover::before {
                left: 100%;
            }

            .primary-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 32px rgba(6, 182, 212, 0.4);
            }

            .primary-btn:active {
                transform: translateY(0);
            }

            .footer {
                margin-top: 60px;
                padding-top: 32px;
                border-top: 1px solid var(--border-color);
                text-align: center;
            }

            .footer-text {
                color: var(--text-muted);
                font-size: 0.9em;
                margin-bottom: 20px;
                font-family: 'Inter', sans-serif;
            }

            .tech-badges {
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
                gap: 12px;
            }

            .badge {
                background: rgba(6, 182, 212, 0.1);
                color: var(--primary-cyan);
                padding: 8px 20px;
                border-radius: 20px;
                font-size: 0.85em;
                font-weight: 500;
                border: 1px solid rgba(6, 182, 212, 0.3);
                transition: all 0.3s ease;
                font-family: 'Inter', sans-serif;
            }

            .badge:hover {
                background: rgba(6, 182, 212, 0.2);
                border-color: var(--primary-cyan);
                transform: scale(1.05);
            }

            @media (max-width: 768px) {
                .container {
                    padding: 50px 30px;
                }

                h1 {
                    font-size: 3em;
                }

                .tagline {
                    font-size: 1.1em;
                }

                .metrics-grid {
                    grid-template-columns: 1fr;
                }
            }

            @media (max-width: 480px) {
                h1 {
                    font-size: 2.2em;
                }

                .container {
                    padding: 40px 20px;
                }
            }
        </style>
    </head>

    <body>
        <div class="container">
            <div class="header">
                <h1>DataFlow Analytics</h1>
                <p class="tagline">Intelligence Plateforme en Temps Réel</p>
                <p class="description">
                    Transformez vos données en insights actionnables. Analysez, visualisez et optimisez
                    vos contenus streaming avec notre solution d'intelligence artificielle avancée.
                </p>
            </div>

            <div class="metrics-grid">
                <div class="metric-card">
                    <span class="metric-icon">⚡</span>
                    <div class="metric-title">Analyse Instantanée</div>
                    <span class="metric-icon">⚡</span>
                    <div class="metric-description">
                        Visualisez vos métriques en temps réel avec des tableaux de bord interactifs
                        et des rapports automatisés.
                    </div>
                </div>

                <div class="metric-card">
                    <span class="metric-icon">🎯</span>
                    <div class="metric-title">Recommandations IA</div>
                    <span class="metric-icon">🎯</span>
                    <div class="metric-description">
                        Moteur d'apprentissage automatique pour des suggestions personnalisées
                        basées sur le comportement utilisateur.
                    </div>
                </div>

                <div class="metric-card">
                    <span class="metric-icon">📊</span>
                    <div class="metric-title">Métriques Avancées</div>
                    <span class="metric-icon">📊</span>
                    <div class="metric-description">
                        KPIs détaillés, tendances prédictives et analyses démographiques
                        pour piloter vos décisions stratégiques.
                    </div>
                </div>
            </div>

            <div class="cta-section">
                <a href="dashboard" class="primary-btn">Accéder à la Console</a>
                <a href="recommendations.jsp" class="primary-btn"
                    style="margin-left: 16px; background: linear-gradient(90deg, #f97316 0%, #fbbf24 100%); box-shadow: 0 8px 24px rgba(249, 115, 22, 0.3);">🎯
                    Recommandations IA</a>
            </div>

            <div class="footer">
                <p class="footer-text">DataFlow Analytics Platform © 2025</p>
                <div class="tech-badges">
                    <span class="badge">Jakarta EE</span>
                    <span class="badge">MongoDB Atlas</span>
                    <span class="badge">Docker</span>
                    <span class="badge">Machine Learning</span>
                </div>
            </div>
        </div>
    </body>

    </html>