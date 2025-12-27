<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Streaming Analytics Dashboard</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            /* Couleurs principales - Thème unifié */
            --primary-purple: #a855f7;
            --primary-pink: #ec4899;
            --primary-cyan: #06b6d4;

            /* Couleurs de fond */
            --bg-dark-1: #0f0c29;
            --bg-dark-2: #302b63;
            --bg-dark-3: #24243e;

            /* Couleurs de carte */
            --card-bg: rgba(30, 27, 75, 0.85);
            --card-border: rgba(168, 85, 247, 0.2);

            /* Couleurs de texte */
            --text-primary: #e8eaf6;
            --text-secondary: #c4b5fd;
            --text-muted: #b8b8b8;

            /* Espacements */
            --spacing-sm: 12px;
            --spacing-md: 20px;
            --spacing-lg: 40px;
        }

        body {
            font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, var(--bg-dark-1) 0%, var(--bg-dark-2) 50%, var(--bg-dark-3) 100%);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        /* Background Effect - Style unifié */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 20% 80%, rgba(168, 85, 247, 0.15) 0%, transparent 50%),
                        radial-gradient(circle at 80% 20%, rgba(59, 130, 246, 0.15) 0%, transparent 50%);
            pointer-events: none;
        }

        .dashboard-container {
            max-width: 1200px;
            width: 100%;
            background: var(--card-bg);
            border-radius: 24px;
            padding: 50px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3),
                        0 0 80px rgba(168, 85, 247, 0.1),
                        inset 0 1px 0 rgba(255, 255, 255, 0.1);
            text-align: center;
            backdrop-filter: blur(30px);
            border: 1px solid var(--card-border);
            position: relative;
            z-index: 1;
        }

        /* Glow Effect - Style unifié */
        .dashboard-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--primary-pink) 100%);
            border-radius: 24px;
            z-index: -1;
            opacity: 0;
            transition: opacity 0.4s ease;
            filter: blur(20px);
        }

        .dashboard-container:hover::before {
            opacity: 0.3;
        }


        .dashboard-header {
            margin-bottom: 50px;
        }

        .dashboard-header h1 {
            font-size: 3.5em;
            font-weight: 800;
            margin-bottom: 20px;
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--primary-pink) 50%, var(--primary-cyan) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -1px;
        }

        .dashboard-header p {
            color: var(--text-secondary);
            font-size: 1.3em;
            font-weight: 400;
            letter-spacing: 0.5px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin: 40px 0;
        }

        .stat-card {
            background: linear-gradient(135deg, rgba(88, 28, 135, 0.3) 0%, rgba(49, 46, 129, 0.3) 100%);
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            border: 1px solid var(--card-border);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--primary-pink) 100%);
            opacity: 0;
            transition: opacity 0.5s ease;
            z-index: 0;
        }

        .stat-card:hover::before {
            opacity: 0.1;
        }

        .stat-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 20px 40px rgba(168, 85, 247, 0.3),
                        0 0 60px rgba(236, 72, 153, 0.2);
            border-color: rgba(168, 85, 247, 0.5);
            background: linear-gradient(135deg, rgba(88, 28, 135, 0.5) 0%, rgba(49, 46, 129, 0.5) 100%);
        }

        .stat-card > * {
            position: relative;
            z-index: 1;
        }

        .stat-number {
            font-size: 3.5em;
            font-weight: 900;
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--primary-pink) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 12px;
            position: relative;
            z-index: 1;
        }

        .stat-label {
            font-size: 1em;
            color: var(--text-secondary);
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            position: relative;
            z-index: 1;
        }

        .content-section {
            margin-top: 50px;
            text-align: left;
        }

        .section-title {
            font-size: 2em;
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--primary-pink) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 30px;
            font-weight: 800;
            letter-spacing: -1px;
            text-align: center;
        }

        .data-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 20px;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.3),
                        0 0 0 1px var(--card-border);
            background: rgba(30, 27, 75, 0.5);
            backdrop-filter: blur(20px);
        }

        .data-table th,
        .data-table td {
            padding: 20px 30px;
            text-align: left;
        }

        .data-table th {
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--primary-pink) 100%);
            color: white;
            font-weight: 700;
            font-size: 0.95em;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .data-table th:first-child {
            border-top-left-radius: 16px;
        }

        .data-table th:last-child {
            border-top-right-radius: 16px;
        }

        .data-table tbody tr {
            border-bottom: 1px solid var(--card-border);
            transition: all 0.3s ease;
        }

        .data-table tbody tr:last-child {
            border-bottom: none;
        }

        .data-table tbody tr:nth-child(even) {
            background-color: rgba(168, 85, 247, 0.05);
        }

        .data-table tbody tr:hover {
            background: rgba(168, 85, 247, 0.15);
            transform: scale(1.01);
            box-shadow: 0 5px 20px rgba(168, 85, 247, 0.2);
        }

        .data-table td {
            color: var(--text-primary);
            font-weight: 400;
        }


        /* Navigation Section */
        .navigation-section {
            margin-top: 50px;
            padding-top: 40px;
            border-top: 1px solid var(--card-border);
            text-align: center;
        }

        .nav-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .nav-button {
            display: inline-block;
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--primary-pink) 100%);
            color: white;
            padding: 18px 45px;
            text-decoration: none;
            border-radius: 12px;
            font-size: 1.1em;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 10px 30px rgba(168, 85, 247, 0.4);
            border: none;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .nav-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .nav-button:hover::before {
            left: 100%;
        }

        .nav-button:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 40px rgba(168, 85, 247, 0.5);
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--primary-purple) 100%);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 40px 30px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .content-section {
                margin-top: 40px;
            }

            .navigation-section {
                margin-top: 40px;
                padding-top: 30px;
            }

            .nav-buttons {
                flex-direction: column;
                gap: 15px;
            }

            .nav-button {
                width: 100%;
                padding: 14px 30px;
            }

            .dashboard-header h1 {
                font-size: 2.5em;
                letter-spacing: -1px;
            }

            .dashboard-header p {
                font-size: 1.1em;
            }

            .section-title {
                font-size: 1.8em;
            }

            .data-table th,
            .data-table td {
                padding: 12px 15px;
                font-size: 0.9em;
            }
        }

        @media (max-width: 480px) {
            .dashboard-container {
                padding: 30px 20px;
            }

            .dashboard-header h1 {
                font-size: 2em;
            }

            .stat-number {
                font-size: 2.8em;
            }

            .nav-button {
                font-size: 0.9em;
                padding: 12px 25px;
                letter-spacing: 1px;
            }

            .section-title {
                font-size: 1.5em;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="dashboard-header">
            <h1>📊 ANALYTICS DASHBOARD</h1>
            <p>Real-Time Streaming Insights & Performance Metrics</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">${totalVideos}</div>
                <div class="stat-label">Total Videos</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${totalUsers}</div>
                <div class="stat-label">Active Users</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${totalViews}</div>
                <div class="stat-label">Total Views</div>
            </div>
        </div>

        <div class="content-section">
            <h2 class="section-title">📈 Top Performing Videos</h2>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Video ID</th>
                        <th>Title</th>
                        <th>Views</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="video" items="${topVideos}">
                        <tr>
                            <td>${video.videoId}</td>
                            <td>${video.title}</td>
                            <td>${video.views}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="navigation-section">
            <div class="nav-buttons">
                <a href="/analytics-dashboard/" class="nav-button">🏠 HOME</a>
                <a href="stats" class="nav-button">📊 Statistics</a>
                <a href="/analytics-api/api/v1/analytics/health" class="nav-button" target="_blank">🔍 API Health</a>
            </div>
        </div>
    </div>
</body>
</html>