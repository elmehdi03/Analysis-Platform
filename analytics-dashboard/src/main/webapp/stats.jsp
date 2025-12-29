<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Statistiques - DataFlow Analytics</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap');

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            :root {
                --primary-cyan: #06b6d4;
                --primary-orange: #f97316;
                --accent-teal: #14b8a6;
                --bg-dark: #0f172a;
                --bg-slate: #1e293b;
                --text-white: #f8fafc;
                --text-muted: #94a3b8;
                --border-color: #475569;
            }

            body {
                font-family: 'Space Grotesk', 'Inter', sans-serif;
                background: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-slate) 100%);
                color: var(--text-white);
                min-height: 100vh;
                padding: 20px;
                padding-top: 100px;
                /* Space for navbar */
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: rgba(30, 41, 59, 0.6);
                border-radius: 24px;
                padding: 40px;
                border: 1px solid var(--border-color);
                backdrop-filter: blur(20px);
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
            }

            h1 {
                font-size: 3em;
                margin-bottom: 40px;
                background: linear-gradient(90deg, var(--primary-cyan) 0%, var(--primary-orange) 100%);
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
                text-align: center;
            }

            .charts-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
                gap: 40px;
                margin-bottom: 40px;
            }

            .chart-card {
                background: rgba(15, 23, 42, 0.6);
                border-radius: 16px;
                padding: 24px;
                border: 1px solid var(--border-color);
            }

            .chart-title {
                font-size: 1.2em;
                margin-bottom: 20px;
                color: var(--primary-cyan);
                text-align: center;
            }
        </style>
    </head>

    <body>
        <% request.setAttribute("pageName", "stats" ); %>
            <%@ include file="navbar.jsp" %>

                <div class="container">
                    <h1>Tableau de Bord Statistiques</h1>

                    <div class="charts-grid">
                        <div class="chart-card">
                            <div class="chart-title">Top 10 Vidéos (Vues)</div>
                            <canvas id="topVideosChart"></canvas>
                        </div>

                        <div class="chart-card">
                            <div class="chart-title">Répartition par Catégorie</div>
                            <canvas id="categoriesChart"></canvas>
                        </div>
                    </div>

                    <div class="chart-card" style="margin-top: 40px;">
                        <div class="chart-title">Performance Mensuelle - Vues & Engagement</div>
                        <div style="height: 400px; position: relative;">
                            <canvas id="performanceChart"></canvas>
                        </div>
                    </div>
                </div>

                <script>
                    Chart.defaults.color = '#94a3b8';
                    Chart.defaults.borderColor = '#334155';

                    async function loadData() {
                        try {
                            const topRes = await fetch('/analytics-api/api/v1/analytics/videos/top?limit=10');
                            const topVideos = await topRes.json();
                            const catRes = await fetch('/analytics-api/api/v1/analytics/categories/stats');
                            const catStats = await catRes.json();
                            renderCharts(topVideos, catStats);
                            renderPerformanceChart();
                        } catch (error) { console.error("Erreur de chargement:", error); }
                    }

                    function renderCharts(topVideos, catStats) {
                        new Chart(document.getElementById('topVideosChart'), {
                            type: 'bar',
                            data: {
                                labels: topVideos.map(v => v.videoId),
                                datasets: [{
                                    label: 'Vues',
                                    data: topVideos.map(v => v.totalViews),
                                    backgroundColor: 'rgba(6, 182, 212, 0.7)',
                                    borderColor: '#06b6d4',
                                    borderWidth: 1,
                                    borderRadius: 4
                                }]
                            },
                            options: {
                                indexAxis: 'y',
                                responsive: true,
                                plugins: { legend: { display: false } },
                                scales: { x: { beginAtZero: true } }
                            }
                        });

                        const labels = Object.keys(catStats);
                        const data = Object.values(catStats);
                        const colors = ['#06b6d4', '#f97316', '#14b8a6', '#fbbf24', '#8b5cf6', '#ec4899'];

                        new Chart(document.getElementById('categoriesChart'), {
                            type: 'doughnut',
                            data: {
                                labels: labels,
                                datasets: [{
                                    data: data,
                                    backgroundColor: colors.slice(0, labels.length),
                                    borderColor: '#1e293b',
                                    borderWidth: 2
                                }]
                            },
                            options: { responsive: true, plugins: { legend: { position: 'right' } } }
                        });
                    }

                    async function renderPerformanceChart() {
                        try {
                            const res = await fetch('/analytics-api/api/v1/analytics/performance/monthly');
                            const stats = await res.json();
                            const ctx = document.getElementById('performanceChart').getContext('2d');
                            const months = stats.map(s => s.month);
                            const viewsData = stats.map(s => s.totalViews);
                            const visitorsData = stats.map(s => s.uniqueVisitors);
                            const retentionData = stats.map(s => s.retentionRate);
                            const engagementData = stats.map(s => s.engagementRate);

                            new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: months,
                                    datasets: [
                                        { label: 'Vues Totales', data: viewsData, backgroundColor: '#06b6d4', order: 2, yAxisID: 'y' },
                                        { label: 'Visiteurs Uniques', data: visitorsData, backgroundColor: '#f97316', order: 3, yAxisID: 'y' },
                                        { label: 'Rétention (%)', data: retentionData, type: 'line', borderColor: '#10b981', backgroundColor: '#10b981', borderWidth: 2, pointRadius: 4, tension: 0.3, order: 0, yAxisID: 'y1' },
                                        { label: 'Engagement (%)', data: engagementData, type: 'line', borderColor: '#fbbf24', backgroundColor: '#fbbf24', borderWidth: 2, pointRadius: 4, tension: 0.3, order: 1, yAxisID: 'y1' }
                                    ]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    interaction: { mode: 'index', intersect: false },
                                    plugins: { legend: { position: 'top', labels: { usePointStyle: true, color: '#94a3b8' } } },
                                    scales: {
                                        x: { grid: { display: false }, ticks: { color: '#94a3b8' } },
                                        y: { type: 'linear', display: true, position: 'left', title: { display: true, text: 'Volume' }, grid: { color: '#334155', borderDash: [5, 5] }, ticks: { color: '#94a3b8' } },
                                        y1: { type: 'linear', display: true, position: 'right', title: { display: true, text: 'Pourcentage (%)' }, grid: { drawOnChartArea: false }, ticks: { color: '#94a3b8' }, min: 0, max: 100 }
                                    }
                                }
                            });
                        } catch (error) { console.error("Erreur chargement performance:", error); }
                    }
                    loadData();
                </script>
    </body>

    </html>