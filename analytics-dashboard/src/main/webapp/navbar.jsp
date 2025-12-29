<%-- Navbar Component --%>
    <style>
        /* Global Navigation Styles */
        .navbar {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(30, 41, 59, 0.7);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 100px;
            padding: 8px 16px;
            display: flex;
            gap: 8px;
            z-index: 1000;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .nav-link {
            color: #94a3b8;
            text-decoration: none;
            font-size: 0.9em;
            font-weight: 500;
            padding: 8px 20px;
            border-radius: 100px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: #ffffff;
            background: rgba(255, 255, 255, 0.05);
        }

        .nav-link.active {
            color: #ffffff;
            background: linear-gradient(90deg, #06b6d4 0%, #14b8a6 100%);
            box-shadow: 0 4px 12px rgba(6, 182, 212, 0.3);
        }
    </style>

    <nav class="navbar">
        <a href="index.jsp" class="nav-link ${pageName == 'home' ? 'active' : ''}">Accueil</a>
        <a href="dashboard.jsp" class="nav-link ${pageName == 'dashboard' ? 'active' : ''}">Console</a>
        <a href="stats.jsp" class="nav-link ${pageName == 'stats' ? 'active' : ''}">Statistiques</a>
        <a href="recommendations.jsp" class="nav-link ${pageName == 'recommendations' ? 'active' : ''}">Recommandations
            IA</a>
    </nav>