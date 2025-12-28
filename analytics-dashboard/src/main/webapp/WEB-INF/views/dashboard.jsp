<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>DataFlow Analytics - Console</title>
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
            --accent-amber: #fbbf24;
            --bg-dark: #0f172a;
            --bg-slate: #1e293b;
            --bg-card: #334155;
            --text-white: #f8fafc;
            --text-gray: #cbd5e1;
            --text-muted: #94a3b8;
            --border-color: #475569;
            --success: #10b981;
            --warning: #f59e0b;
            --error: #ef4444;
        }

        body {
            font-family: 'Space Grotesk', 'Inter', sans-serif;
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-slate) 100%);
            color: var(--text-white);
            min-height: 100vh;
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
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .dashboard-header {
            background: rgba(30, 41, 59, 0.6);
            border-radius: 16px;
            padding: 32px 40px;
            margin-bottom: 32px;
            border: 1px solid var(--border-color);
            backdrop-filter: blur(20px);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .header-title {
            flex: 1;
        }

        h1 {
            font-size: 2.5em;
            font-weight: 700;
            background: linear-gradient(90deg, var(--primary-cyan) 0%, var(--primary-orange) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 8px;
        }

        .header-subtitle {
            color: var(--text-muted);
            font-size: 1em;
            font-family: 'Inter', sans-serif;
        }

        .header-actions {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .action-btn {
            padding: 10px 20px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            background: rgba(51, 65, 85, 0.6);
            color: var(--text-white);
            font-size: 0.9em;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .action-btn:hover {
            background: rgba(6, 182, 212, 0.2);
            border-color: var(--primary-cyan);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 32px;
        }

        .stat-card {
            background: rgba(30, 41, 59, 0.6);
            border-radius: 12px;
            padding: 28px;
            border: 1px solid var(--border-color);
            backdrop-filter: blur(20px);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(180deg, var(--primary-cyan), var(--primary-orange));
            transition: width 0.3s ease;
        }

        .stat-card:hover::before {
            width: 100%;
            opacity: 0.1;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            border-color: var(--primary-cyan);
            box-shadow: 0 12px 32px rgba(6, 182, 212, 0.2);
        }

        .stat-icon {
            font-size: 2em;
            margin-bottom: 12px;
            display: block;
            position: relative;
            z-index: 1;
        }

        .stat-label {
            color: var(--text-muted);
            font-size: 0.9em;
            margin-bottom: 8px;
            font-weight: 500;
            position: relative;
            z-index: 1;
            font-family: 'Inter', sans-serif;
        }

        .stat-number {
            font-size: 2.8em;
            font-weight: 700;
            color: var(--text-white);
            position: relative;
            z-index: 1;
        }

        .stat-trend {
            color: var(--success);
            font-size: 0.85em;
            margin-top: 8px;
            font-weight: 500;
            position: relative;
            z-index: 1;
            font-family: 'Inter', sans-serif;
        }

        .stat-trend.down {
            color: var(--error);
        }

        .content-section {
            background: rgba(30, 41, 59, 0.6);
            border-radius: 16px;
            padding: 32px;
            margin-bottom: 24px;
            border: 1px solid var(--border-color);
            backdrop-filter: blur(20px);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 16px;
        }

        .section-title {
            font-size: 1.6em;
            font-weight: 600;
            color: var(--text-white);
        }

        .section-controls {
            display: flex;
            gap: 8px;
        }

        .control-btn {
            padding: 8px 16px;
            border-radius: 6px;
            border: 1px solid var(--border-color);
            background: rgba(51, 65, 85, 0.4);
            color: var(--text-gray);
            font-size: 0.85em;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .control-btn:hover {
            background: rgba(6, 182, 212, 0.2);
            border-color: var(--primary-cyan);
            color: var(--text-white);
        }

        .control-btn.active {
            background: var(--primary-cyan);
            border-color: var(--primary-cyan);
            color: var(--bg-dark);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-family: 'Inter', sans-serif;
        }

        .data-table thead {
            background: rgba(51, 65, 85, 0.4);
            border-bottom: 2px solid var(--border-color);
        }

        .data-table th {
            text-align: left;
            padding: 16px;
            color: var(--text-gray);
            font-weight: 600;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .data-table td {
            padding: 16px;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-white);
        }

        .data-table tbody tr {
            transition: all 0.2s ease;
        }

        .data-table tbody tr:hover {
            background: rgba(6, 182, 212, 0.05);
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.8em;
            font-weight: 600;
            display: inline-block;
        }

        .status-badge.success {
            background: rgba(16, 185, 129, 0.2);
            color: var(--success);
            border: 1px solid var(--success);
        }

        .status-badge.warning {
            background: rgba(245, 158, 11, 0.2);
            color: var(--warning);
            border: 1px solid var(--warning);
        }

        .status-badge.error {
            background: rgba(239, 68, 68, 0.2);
            color: var(--error);
            border: 1px solid var(--error);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
        }

        .empty-state-icon {
            font-size: 4em;
            margin-bottom: 16px;
            opacity: 0.3;
        }

        .empty-state-text {
            font-size: 1.1em;
            margin-bottom: 8px;
        }

        .empty-state-subtext {
            font-size: 0.9em;
            color: var(--text-muted);
        }

        @media (max-width: 768px) {
            .dashboard-header {
                padding: 24px 28px;
            }

            h1 {
                font-size: 2em;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .content-section {
                padding: 24px;
            }

            .data-table {
                font-size: 0.9em;
            }

            .data-table th,
            .data-table td {
                padding: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="dashboard-header">
            <div class="header-title">
                <h1>DataFlow Console</h1>
                <p class="header-subtitle">Supervision en Temps Réel</p>
            </div>
            <div class="header-actions">
                <a href="<c:url value='/'/>" class="action-btn">Retour</a>
                <button class="action-btn" onclick="location.reload()">Actualiser</button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <span class="stat-icon">🎬</span>
                <div class="stat-label">Total Vidéos</div>
                <div class="stat-number">${totalVideos}</div>
                <div class="stat-trend">+12% ce mois</div>
            </div>
            <div class="stat-card">
                <span class="stat-icon">👥</span>
                <div class="stat-label">Utilisateurs Actifs</div>
                <div class="stat-number">${totalUsers}</div>
                <div class="stat-trend">+8% ce mois</div>
            </div>
            <div class="stat-card">
                <span class="stat-icon">👁️</span>
                <div class="stat-label">Vues Totales</div>
                <div class="stat-number">${totalViews}</div>
                <div class="stat-trend">+24% ce mois</div>
            </div>
            <div class="stat-card">
                <span class="stat-icon">⚡</span>
                <div class="stat-label">Taux d'Engagement</div>
                <div class="stat-number">87%</div>
                <div class="stat-trend">+5% ce mois</div>
            </div>
        </div>

        <div class="content-section">
            <div class="section-header">
                <h2 class="section-title">Contenus Populaires</h2>
                <div class="section-controls">
                    <button class="control-btn active">Aujourd'hui</button>
                    <button class="control-btn">Semaine</button>
                    <button class="control-btn">Mois</button>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty topVideos}">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID Vidéo</th>
                                <th>Titre</th>
                                <th>Vues</th>
                                <th>Engagement</th>
                                <th>Statut</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${topVideos}" var="video">
                                <tr>
                                    <td>${video.id}</td>
                                    <td>${video.title}</td>
                                    <td>${video.views}</td>
                                    <td>${video.engagement}%</td>
                                    <td>
                                        <span class="status-badge success">En ligne</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">📊</div>
                        <div class="empty-state-text">Aucune donnée disponible</div>
                        <div class="empty-state-subtext">Les métriques s'afficheront une fois que les données seront collectées</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="content-section">
            <div class="section-header">
                <h2 class="section-title">Activité Récente</h2>
            </div>

            <c:choose>
                <c:when test="${not empty recentActivity}">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Utilisateur</th>
                                <th>Action</th>
                                <th>Contenu</th>
                                <th>Timestamp</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${recentActivity}" var="activity">
                                <tr>
                                    <td>${activity.userId}</td>
                                    <td>${activity.action}</td>
                                    <td>${activity.videoTitle}</td>
                                    <td>${activity.timestamp}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">⏱️</div>
                        <div class="empty-state-text">Aucune activité récente</div>
                        <div class="empty-state-subtext">L'activité des utilisateurs apparaîtra ici</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
