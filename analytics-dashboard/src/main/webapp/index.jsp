<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Streaming Analytics Dashboard - Accueil</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap');

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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
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
                radial-gradient(circle at 20% 50%, rgba(102, 126, 234, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(245, 87, 108, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 40% 20%, rgba(79, 172, 254, 0.1) 0%, transparent 40%);
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

        .modern-container {
            max-width: 1100px;
            width: 100%;
            background: var(--card-bg);
            border-radius: 30px;
            padding: 60px;
            box-shadow:
                0 30px 90px var(--shadow-color),
                0 0 0 1px var(--card-border),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            text-align: center;
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

        /* Glow Effect */
        .modern-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: var(--primary-gradient);
            border-radius: 30px;
            z-index: -1;
            opacity: 0;
            transition: opacity 0.4s ease;
            filter: blur(20px);
        }

        .modern-container:hover::before {
            opacity: 0.3;
        }

        h1 {
            font-size: 4em;
            font-weight: 900;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f5576c 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -2px;
            animation: titleGlow 3s ease-in-out infinite;
            text-shadow: 0 0 40px rgba(102, 126, 234, 0.3);
            position: relative;
        }

        @keyframes titleGlow {
            0%, 100% {
                filter: brightness(1);
                transform: scale(1);
            }
            50% {
                filter: brightness(1.2);
                transform: scale(1.01);
            }
        }

        .subtitle {
            color: var(--text-secondary);
            font-size: 1.4em;
            font-weight: 400;
            margin-bottom: 50px;
            letter-spacing: 0.5px;
            opacity: 0.9;
        }

        .welcome-text {
            font-size: 1.1em;
            color: var(--text-secondary);
            line-height: 1.8;
            margin: 20px auto;
            max-width: 800px;
            font-weight: 300;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin: 50px 0;
        }

        .feature-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 40px 30px;
            box-shadow:
                0 10px 40px rgba(0, 0, 0, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            border: 1px solid var(--card-border);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(20px);
            position: relative;
            overflow: hidden;
        }

        /* Card Gradient Overlay */
        .feature-card::before {
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

        .feature-card:hover::before {
            opacity: 0.1;
        }

        .feature-card:hover {
            transform: translateY(-15px) scale(1.03);
            box-shadow:
                0 25px 60px rgba(102, 126, 234, 0.4),
                0 0 80px rgba(102, 126, 234, 0.2),
                inset 0 1px 0 rgba(255, 255, 255, 0.2);
            border-color: rgba(102, 126, 234, 0.5);
        }

        .feature-card > * {
            position: relative;
            z-index: 1;
        }

        .feature-icon {
            font-size: 3em;
            margin-bottom: 20px;
            display: block;
            filter: drop-shadow(0 0 20px rgba(102, 126, 234, 0.5));
            animation: iconFloat 3s ease-in-out infinite;
        }

        @keyframes iconFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .feature-card:nth-child(1) .feature-icon { animation-delay: 0s; }
        .feature-card:nth-child(2) .feature-icon { animation-delay: 0.3s; }
        .feature-card:nth-child(3) .feature-icon { animation-delay: 0.6s; }

        .feature-title {
            color: var(--text-primary);
            font-size: 1.3em;
            font-weight: 700;
            margin-bottom: 15px;
            letter-spacing: 0.5px;
        }

        .feature-description {
            color: var(--text-secondary);
            font-size: 0.95em;
            line-height: 1.6;
            font-weight: 300;
        }

        .modern-button {
            display: inline-block;
            background: var(--primary-gradient);
            color: white;
            padding: 20px 50px;
            text-decoration: none;
            border-radius: 50px;
            font-size: 1.1em;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow:
                0 15px 40px rgba(102, 126, 234, 0.4),
                0 5px 15px rgba(0, 0, 0, 0.3);
            margin-top: 40px;
            border: none;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        /* Button Shine Effect */
        .modern-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.6s;
        }

        .modern-button:hover::before {
            left: 100%;
        }

        .modern-button::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--secondary-gradient);
            opacity: 0;
            transition: opacity 0.4s ease;
            z-index: -1;
        }

        .modern-button:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow:
                0 20px 50px rgba(102, 126, 234, 0.6),
                0 10px 25px rgba(245, 87, 108, 0.3),
                0 0 60px rgba(102, 126, 234, 0.4);
        }

        .modern-button:hover::after {
            opacity: 1;
        }

        .modern-button:active {
            transform: translateY(-2px) scale(1.02);
        }

        .modern-footer {
            margin-top: 60px;
            padding-top: 40px;
            border-top: 1px solid var(--card-border);
            color: var(--text-secondary);
            font-size: 0.9em;
        }

        .tech-stack {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 25px;
        }

        .tech-item {
            background: var(--card-bg);
            padding: 10px 22px;
            border-radius: 25px;
            font-size: 0.85em;
            color: var(--text-primary);
            border: 1px solid var(--card-border);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
            font-weight: 500;
            position: relative;
            overflow: hidden;
        }

        .tech-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--accent-gradient);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .tech-item:hover::before {
            opacity: 0.2;
        }

        .tech-item:hover {
            border-color: rgba(79, 172, 254, 0.5);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 10px 25px rgba(79, 172, 254, 0.3);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .modern-container {
                padding: 40px 25px;
                border-radius: 25px;
            }

            h1 {
                font-size: 2.8em;
                letter-spacing: -1px;
            }

            .subtitle {
                font-size: 1.1em;
            }

            .feature-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .modern-button {
                padding: 16px 40px;
                font-size: 1em;
            }
        }

        @media (max-width: 480px) {
            h1 {
                font-size: 2.2em;
            }

            .modern-container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="modern-container">
        <h1 data-text="STREAMING ANALYTICS">Streaming Analytics</h1>
        <p class="subtitle">⚡ FUTURISTIC BIG DATA ANALYTICS PLATFORM ⚡</p>

        <p class="welcome-text">Welcome to the next generation of streaming analytics. Monitor real-time performance, analyze user behavior, and unlock powerful insights from your video content with cutting-edge technology.</p>

        <div class="feature-grid">
            <div class="feature-card">
                <span class="feature-icon">📊</span>
                <div class="feature-title">REAL-TIME ANALYTICS</div>
                <div class="feature-description">Monitor live streaming metrics, user engagement, and content performance with instant updates powered by advanced algorithms.</div>
            </div>

            <div class="feature-card">
                <span class="feature-icon">🎯</span>
                <div class="feature-title">SMART AI ENGINE</div>
                <div class="feature-description">AI-powered content suggestions based on deep learning, user preferences and sophisticated viewing pattern analysis.</div>
            </div>

            <div class="feature-card">
                <span class="feature-icon">📈</span>
                <div class="feature-title">PERFORMANCE INSIGHTS</div>
                <div class="feature-description">Comprehensive analytics on video popularity, user demographics, engagement metrics and predictive trends.</div>
            </div>
        </div>

        <div>
            <a href="dashboard" class="modern-button">⚡ ENTER DASHBOARD ⚡</a>
        </div>

        <div class="modern-footer">
            <p>Advanced Streaming Analytics Platform - 2025</p>
            <div class="tech-stack">
                <span class="tech-item">Jakarta EE</span>
                <span class="tech-item">MongoDB</span>
                <span class="tech-item">Docker</span>
                <span class="tech-item">Big Data</span>
            </div>
        </div>
    </div>
</body>
</html>