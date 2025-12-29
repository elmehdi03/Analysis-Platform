<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Recommandations IA - DataFlow Analytics</title>
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
                --bg-dark: #0f172a;
                --bg-slate: #1e293b;
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
                padding-top: 100px;
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
                padding: 60px;
                border: 1px solid var(--border-color);
                position: relative;
                z-index: 1;
                backdrop-filter: blur(20px);
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
            }

            .header {
                text-align: center;
                margin-bottom: 40px;
            }

            h1 {
                font-size: 3.5em;
                font-weight: 700;
                margin-bottom: 16px;
                background: linear-gradient(90deg, var(--primary-cyan) 0%, var(--primary-orange) 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                letter-spacing: -1px;
            }

            .tagline {
                color: var(--text-gray);
                font-size: 1.2em;
                margin-bottom: 30px;
            }

            .search-section {
                display: flex;
                gap: 20px;
                margin-bottom: 50px;
                background: rgba(15, 23, 42, 0.4);
                padding: 30px;
                border-radius: 20px;
                border: 1px solid var(--border-color);
                align-items: flex-end;
                justify-content: center;
                flex-wrap: wrap;
            }

            .input-group {
                flex: 1;
                min-width: 200px;
                max-width: 300px;
            }

            .input-group label {
                display: block;
                color: var(--text-muted);
                font-size: 0.85em;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 10px;
                font-weight: 600;
            }

            .input-group input,
            .input-group select {
                width: 100%;
                padding: 14px 18px;
                background: rgba(30, 41, 59, 0.8);
                border: 1px solid var(--border-color);
                border-radius: 10px;
                color: var(--text-white);
                font-family: 'Inter', sans-serif;
                transition: all 0.3s ease;
            }

            .input-group input:focus,
            .input-group select:focus {
                outline: none;
                border-color: var(--primary-cyan);
                background: rgba(30, 41, 59, 1);
                box-shadow: 0 0 15px rgba(6, 182, 212, 0.2);
            }

            .search-btn {
                background: linear-gradient(90deg, var(--primary-cyan) 0%, var(--accent-teal) 100%);
                color: var(--bg-dark);
                padding: 14px 40px;
                border: none;
                border-radius: 10px;
                font-size: 1.1em;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 8px 20px rgba(6, 182, 212, 0.3);
            }

            .search-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 25px rgba(6, 182, 212, 0.4);
            }

            .recommendations-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
                gap: 24px;
                opacity: 0;
                transform: translateY(20px);
                transition: all 0.5s ease;
            }

            .recommendations-grid.active {
                opacity: 1;
                transform: translateY(0);
            }

            .recommendation-card {
                background: linear-gradient(135deg, rgba(51, 65, 85, 0.8) 0%, rgba(30, 41, 59, 0.8) 100%);
                border-radius: 16px;
                padding: 28px;
                border: 1px solid var(--border-color);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .recommendation-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 4px;
                height: 100%;
                background: linear-gradient(180deg, var(--primary-cyan), var(--primary-orange));
            }

            .recommendation-card:hover {
                transform: translateY(-8px);
                border-color: var(--primary-cyan);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            }

            .card-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 12px;
            }

            .video-title {
                font-size: 1.2em;
                font-weight: 600;
                color: var(--text-white);
                flex: 1;
                padding-right: 10px;
            }

            .score-badge {
                background: rgba(6, 182, 212, 0.1);
                color: var(--primary-cyan);
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 0.85em;
                font-weight: 700;
                border: 1px solid rgba(6, 182, 212, 0.3);
            }

            .category-tag {
                display: inline-block;
                color: var(--primary-orange);
                background: rgba(249, 115, 22, 0.1);
                padding: 4px 12px;
                border-radius: 6px;
                font-size: 0.8em;
                font-weight: 600;
                margin-bottom: 15px;
                text-transform: uppercase;
            }

            .reason {
                color: var(--text-muted);
                font-size: 0.9em;
                line-height: 1.6;
                font-family: 'Inter', sans-serif;
            }

            .loading-state {
                text-align: center;
                padding: 40px;
                display: none;
            }

            .spinner {
                width: 40px;
                height: 40px;
                border: 4px solid rgba(6, 182, 212, 0.1);
                border-top-color: var(--primary-cyan);
                border-radius: 50%;
                animation: spin 1s linear infinite;
                margin: 0 auto 20px;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }
        </style>
    </head>

    <body>
        <% request.setAttribute("pageName", "recommendations" ); %>
            <%@ include file="navbar.jsp" %>

                <div class="container">
                    <div class="header">
                        <h1>🎯 Recommandations IA</h1>
                        <p class="tagline">Intelligence Prédictive pour votre Audience</p>
                    </div>

                    <div class="search-section">
                        <div class="input-group">
                            <label>ID Utilisateur</label>
                            <input type="text" id="userId" value="user_10" placeholder="ex: user_123">
                        </div>
                        <div class="input-group">
                            <label>Nombre de Suggestions</label>
                            <select id="limit">
                                <option value="3">3 vidéos</option>
                                <option value="6">6 vidéos</option>
                                <option value="10" selected>10 vidéos</option>
                            </select>
                        </div>
                        <button class="search-btn" onclick="fetchRecommendations()">Générer les suggestions</button>
                    </div>

                    <div id="loadingState" class="loading-state">
                        <div class="spinner"></div>
                        <p>Analyse de l'historique en cours...</p>
                    </div>

                    <div class="recommendations-grid" id="recommendationsGrid">
                        <!-- Dynamically populated -->
                    </div>
                </div>

                <script>
                    async function fetchRecommendations() {
                        const userId = document.getElementById('userId').value;
                        const limit = document.getElementById('limit').value;
                        const grid = document.getElementById('recommendationsGrid');
                        const loader = document.getElementById('loadingState');

                        grid.classList.remove('active');
                        loader.style.display = 'block';

                        try {
                            const response = await fetch(`/analytics-api/api/v1/analytics/users/` + userId + `/recommendations?limit=` + limit);
                            const data = await response.json();

                            grid.innerHTML = '';
                            data.forEach(rec => {
                                const card = document.createElement('div');
                                card.className = 'recommendation-card';
                                card.innerHTML = `
                        <div class="card-header">
                            <div class="video-title">` + rec.title + `</div>
                            <div class="score-badge">` + Math.round(rec.score * 100) + `% Match</div>
                        </div>
                        <div class="category-tag">` + rec.category + `</div>
                        <div class="reason">` + rec.reason + `</div>
                    `;
                                grid.appendChild(card);
                            });

                            setTimeout(() => {
                                loader.style.display = 'none';
                                grid.classList.add('active');
                            }, 300);

                        } catch (e) {
                            console.error("Erreur:", e);
                            loader.innerHTML = '<p style="color:var(--primary-orange)">Erreur lors de la récupération des données.</p>';
                        }
                    }
                </script>
    </body>

    </html>