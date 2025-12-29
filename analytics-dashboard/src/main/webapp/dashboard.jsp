<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DataFlow Console</title>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&family=Space+Grotesk:wght@300;500;700&display=swap"
            rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: #151922;
                color: #ffffff;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                overflow: hidden;
                position: relative;
            }

            h1 {
                font-family: 'Space Grotesk', sans-serif;
                font-size: 5em;
                font-weight: 700;
                margin-bottom: 20px;
                letter-spacing: -2px;
                background: linear-gradient(90deg, #6b8caa 0%, #dca578 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-transform: uppercase;
            }

            .subtitle {
                font-size: 1.5em;
                color: #d1d5db;
                font-weight: 400;
                margin-bottom: 40px;
                letter-spacing: 0.5px;
            }

            .description {
                color: #9ca3af;
                max-width: 600px;
                text-align: center;
                margin-bottom: 80px;
                line-height: 1.6;
            }

            .metrics-container {
                display: flex;
                gap: 30px;
                margin-bottom: 80px;
                width: 100%;
                max-width: 1200px;
                justify-content: center;
                padding: 0 20px;
            }

            .card {
                background: rgba(30, 41, 59, 0.4);
                border: 1px solid #334155;
                border-radius: 16px;
                padding: 40px 20px;
                flex: 1;
                text-align: center;
                position: relative;
                overflow: hidden;
                transition: transform 0.3s ease, border-color 0.3s ease;
                backdrop-filter: blur(10px);
            }

            .card::before {
                content: '';
                position: absolute;
                left: 0;
                top: 15%;
                height: 70%;
                width: 4px;
                background: linear-gradient(to bottom, #2dd4bf, #f97316);
                border-radius: 2px;
            }

            .card:hover {
                transform: translateY(-5px);
                border-color: #475569;
            }

            .counter {
                font-family: 'Space Grotesk', sans-serif;
                font-size: 4em;
                font-weight: 700;
                color: #ffffff;
                margin-bottom: 10px;
                display: block;
            }

            .label {
                color: #94a3b8;
                text-transform: uppercase;
                letter-spacing: 2px;
                font-weight: 600;
                font-size: 0.9em;
            }

            .actions {
                display: flex;
                gap: 20px;
            }

            .btn {
                padding: 16px 32px;
                border-radius: 12px;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s ease;
                font-size: 1.1em;
            }

            .btn-primary {
                background: #5eead4;
                color: #0f172a;
                box-shadow: 0 0 20px rgba(94, 234, 212, 0.2);
            }

            .btn-primary:hover {
                background: #2dd4bf;
                box-shadow: 0 0 30px rgba(94, 234, 212, 0.4);
            }

            .btn-secondary {
                background: #5eead4;
                color: #0f172a;
                box-shadow: 0 0 20px rgba(94, 234, 212, 0.2);
            }

            .footer {
                margin-top: 80px;
                color: #64748b;
                font-size: 0.9em;
                text-align: center;
                padding-bottom: 20px;
                line-height: 1.5;
            }
        </style>
    </head>

    <body>

        <h1>DataFlow Console</h1>
        <div class="subtitle">Console de Supervision en Temps Réel</div>

        <div class="description">
            Tableau de bord moderne pour l'analyse de vos données streaming et métriques de performance.
        </div>

        <div class="metrics-container">
            <div class="card">
                <span class="counter" id="eventsCount">0</span>
                <span class="label">ÉVÉNEMENTS</span>
            </div>

            <div class="card">
                <span class="counter" id="videosCount">0</span>
                <span class="label">VIDÉOS</span>
            </div>

            <div class="card">
                <span class="counter">24/7</span>
                <span class="label">TEMPS RÉEL</span>
            </div>
        </div>

        <div class="actions">
            <a href="stats.jsp" class="btn btn-primary">Voir les Statistiques</a>
            <a href="index.jsp" class="btn btn-secondary">Accueil</a>
        </div>

        <div class="footer">
            DataFlow Analytics Platform – 2025<br>
            Propulsé par Jakarta EE & MongoDB
        </div>

        <script>
            async function fetchStats() {
                try {
                    const response = await fetch('/analytics-api/api/v1/analytics/summary');
                    const data = await response.json();
                    animateValue("eventsCount", 0, data.totalEvents, 1500);
                    animateValue("videosCount", 0, data.totalVideos, 1500);
                } catch (e) {
                    console.error("Erreur chargement stats:", e);
                    document.getElementById('eventsCount').innerText = "1.2K+";
                    document.getElementById('videosCount').innerText = "30+";
                }
            }

            function animateValue(id, start, end, duration) {
                if (start === end) return;
                var range = end - start;
                var current = start;
                var increment = end > start ? Math.ceil(range / 50) : -1;
                if (increment === 0) increment = 1;
                var stepTime = Math.abs(Math.floor(duration / (range / increment)));
                var obj = document.getElementById(id);

                const format = (num) => {
                    if (num >= 1000) return (num / 1000).toFixed(1) + 'K+';
                    return num;
                };

                var timer = setInterval(function () {
                    current += increment;
                    if (current >= end) {
                        current = end;
                        clearInterval(timer);
                    }
                    obj.innerHTML = format(current);
                }, stepTime);
            }

            fetchStats();
        </script>
    </body>

    </html>