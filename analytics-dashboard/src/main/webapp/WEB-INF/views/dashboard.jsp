<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Streaming Analytics Dashboard</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --accent-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --dark-bg: #0a0e27;
            --card-bg: rgba(255, 255, 255, 0.03);
            --card-border: rgba(255, 255, 255, 0.1);
            --text-primary: #ffffff;
            --text-secondary: #a0aec0;
            --shadow-color: rgba(0, 0, 0, 0.5);
        }

        body {
            font-family: 'Poppins', 'Inter', 'Segoe UI', system-ui, sans-serif;
            background: var(--dark-bg);
            color: var(--text-primary);
            min-height: 100vh;
            padding: 20px;
            position: relative;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        /* Animated Background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:
                radial-gradient(circle at 30% 50%, rgba(102, 126, 234, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 70% 80%, rgba(245, 87, 108, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 50% 20%, rgba(79, 172, 254, 0.1) 0%, transparent 40%);
            animation: gradientShift 15s ease infinite;
            pointer-events: none;
            z-index: 0;
        }

        @keyframes gradientShift {
            0%, 100% { opacity: 1; transform: scale(1) rotate(0deg); }
            50% { opacity: 0.8; transform: scale(1.1) rotate(5deg); }
        }

        /* Floating Particles */
        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image:
                radial-gradient(circle, rgba(255, 255, 255, 0.05) 1px, transparent 1px);
            background-size: 50px 50px;
            animation: float 30s linear infinite;
            pointer-events: none;
            z-index: 0;
        }

        @keyframes float {
            0% { transform: translateY(0) translateX(0); }
            100% { transform: translateY(-100px) translateX(50px); }
        }

        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            background: var(--card-bg);
            border-radius: 30px;
            box-shadow:
                0 30px 90px var(--shadow-color),
                0 0 0 1px var(--card-border),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            overflow: hidden;
            backdrop-filter: blur(40px) saturate(180%);
            border: 1px solid var(--card-border);
            position: relative;
            z-index: 1;
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .dashboard-header {
            background: var(--primary-gradient);
            color: white;
            padding: 60px 50px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .dashboard-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.15) 0%, transparent 70%);
            animation: pulse 10s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(10%, 10%) scale(1.1); }
        }

        .dashboard-header h1 {
            font-size: 3.5em;
            font-weight: 900;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
            letter-spacing: -2px;
            text-shadow: 0 5px 30px rgba(0, 0, 0, 0.3);
        }

        .dashboard-header p {
            font-size: 1.3em;
            opacity: 0.95;
            position: relative;
            z-index: 1;
            font-weight: 300;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            padding: 50px;
        }

        .stat-card {
            background: var(--card-bg);
            border-radius: 25px;
            padding: 40px 30px;
            text-align: center;
            box-shadow:
                0 15px 50px rgba(0, 0, 0, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            border: 1px solid var(--card-border);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(20px);
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
            background: var(--primary-gradient);
            opacity: 0;
            transition: opacity 0.5s ease;
            z-index: 0;
        }

        .stat-card:hover::before {
            opacity: 0.15;
        }

        .stat-card:hover {
            transform: translateY(-15px) scale(1.03);
            box-shadow:
                0 30px 70px rgba(102, 126, 234, 0.4),
                0 0 80px rgba(102, 126, 234, 0.2),
                inset 0 1px 0 rgba(255, 255, 255, 0.2);
            border-color: rgba(102, 126, 234, 0.5);
        }

        .stat-card > * {
            position: relative;
            z-index: 1;
        }

        .stat-number {
            font-size: 3.8em;
            font-weight: 900;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 15px;
            animation: countPulse 2s ease-in-out infinite;
        }

        @keyframes countPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .stat-label {
            font-size: 1.1em;
            color: var(--text-secondary);
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .content-section {
            padding: 50px;
        }

        .section-title {
            font-size: 2.5em;
            background: linear-gradient(135deg, #ffffff 0%, #667eea 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 40px;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .data-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 20px;
            border-radius: 20px;
            overflow: hidden;
            box-shadow:
                0 15px 50px rgba(0, 0, 0, 0.3),
                0 0 0 1px var(--card-border);
            background: var(--card-bg);
            backdrop-filter: blur(20px);
        }

        .data-table th,
        .data-table td {
            padding: 20px 30px;
            text-align: left;
        }

        .data-table th {
            background: var(--primary-gradient);
            color: white;
            font-weight: 700;
            font-size: 0.95em;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .data-table th:first-child {
            border-top-left-radius: 20px;
        }

        .data-table th:last-child {
            border-top-right-radius: 20px;
        }

        .data-table tbody tr {
            border-bottom: 1px solid var(--card-border);
            transition: all 0.3s ease;
        }

        .data-table tbody tr:last-child {
            border-bottom: none;
        }

        .data-table tbody tr:nth-child(even) {
            background-color: rgba(102, 126, 234, 0.05);
        }

        .data-table tbody tr:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: scale(1.01);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.2);
        }

        .data-table td {
            color: var(--text-primary);
            font-weight: 400;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            margin: 20px 0 20px 30px;
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 600;
            padding: 14px 30px;
            border-radius: 50px;
            border: 2px solid var(--card-border);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            position: relative;
            z-index: 10;
        }

        .back-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            opacity: 0;
            transition: opacity 0.4s ease;
            border-radius: 50px;
            z-index: -1;
        }

        .back-link:hover::before {
            opacity: 1;
        }

        .back-link:hover {
            color: white;
            transform: translateX(-10px) scale(1.05);
            box-shadow:
                0 15px 40px rgba(102, 126, 234, 0.5),
                0 0 30px rgba(102, 126, 234, 0.3);
            border-color: transparent;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
                padding: 30px 20px;
            }

            .content-section {
                padding: 30px 20px;
            }

            .dashboard-header {
                padding: 40px 20px;
            }

            .dashboard-header h1 {
                font-size: 2.5em;
                letter-spacing: -1px;
            }

            .dashboard-header p {
                font-size: 1.1em;
            }

            .section-title {
                font-size: 2em;
            }

            .data-table th,
            .data-table td {
                padding: 15px 20px;
                font-size: 0.9em;
            }
        }

        @media (max-width: 480px) {
            .dashboard-header h1 {
                font-size: 2em;
            }

            .stat-number {
                font-size: 3em;
            }
        }
    </style>
</head>
<body>
    <a href="/analytics-dashboard/" class="back-link">⚡ HOME</a>

    <div class="dashboard-container">
        <div class="dashboard-header">
            <h1>⚡ ANALYTICS DASHBOARD ⚡</h1>
            <p>REAL-TIME STREAMING INSIGHTS & PERFORMANCE METRICS</p>
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
            <h2 class="section-title">Top Performing Videos</h2>
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
    </div>
</body>
</html>