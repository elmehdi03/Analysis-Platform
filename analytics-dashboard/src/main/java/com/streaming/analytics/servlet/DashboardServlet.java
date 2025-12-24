package com.streaming.analytics.servlet;

import java.io.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "dashboardServlet", value = "/dashboard")
public class DashboardServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "STREAMING ANALYTICS";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html lang='fr'>");
        out.println("<head>");
        out.println("    <meta charset='UTF-8'>");
        out.println("    <meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("    <title>⚡ Streaming Analytics Dashboard ⚡</title>");
        out.println("    <link href='https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Rajdhani:wght@400;600;700&display=swap' rel='stylesheet'>");
        out.println("    <style>");

        // CSS Variables
        out.println("        :root {");
        out.println("            --neon-cyan: #00f5ff;");
        out.println("            --neon-magenta: #ff0080;");
        out.println("            --neon-purple: #7928ca;");
        out.println("            --dark-bg: #050505;");
        out.println("            --shadow-cyan: rgba(0, 245, 255, 0.5);");
        out.println("            --shadow-magenta: rgba(255, 0, 128, 0.5);");
        out.println("        }");

        // Reset
        out.println("        * { margin: 0; padding: 0; box-sizing: border-box; }");

        // Body
        out.println("        body {");
        out.println("            font-family: 'Rajdhani', 'Orbitron', sans-serif;");
        out.println("            background: var(--dark-bg);");
        out.println("            color: white;");
        out.println("            min-height: 100vh;");
        out.println("            padding: 20px;");
        out.println("            position: relative;");
        out.println("        }");

        // Grid Background
        out.println("        body::before {");
        out.println("            content: '';");
        out.println("            position: fixed;");
        out.println("            top: 0; left: 0;");
        out.println("            width: 100%; height: 100%;");
        out.println("            background: ");
        out.println("                linear-gradient(90deg, rgba(0, 245, 255, 0.03) 1px, transparent 1px),");
        out.println("                linear-gradient(0deg, rgba(0, 245, 255, 0.03) 1px, transparent 1px),");
        out.println("                radial-gradient(circle at 30% 50%, rgba(0, 245, 255, 0.15), transparent 50%),");
        out.println("                radial-gradient(circle at 70% 80%, rgba(255, 0, 128, 0.15), transparent 50%);");
        out.println("            background-size: 50px 50px, 50px 50px, 100% 100%, 100% 100%;");
        out.println("            animation: gridPulse 8s ease infinite;");
        out.println("            pointer-events: none;");
        out.println("        }");

        // Animations
        out.println("        @keyframes gridPulse {");
        out.println("            0%, 100% { opacity: 0.3; }");
        out.println("            50% { opacity: 0.5; }");
        out.println("        }");

        out.println("        @keyframes borderRotate {");
        out.println("            0% { background-position: 0% 50%; }");
        out.println("            50% { background-position: 100% 50%; }");
        out.println("            100% { background-position: 0% 50%; }");
        out.println("        }");

        out.println("        @keyframes neonPulse {");
        out.println("            0%, 100% { filter: drop-shadow(0 0 20px var(--neon-cyan)); }");
        out.println("            50% { filter: drop-shadow(0 0 40px var(--neon-cyan)); }");
        out.println("        }");

        // Container
        out.println("        .cyber-container {");
        out.println("            max-width: 1200px;");
        out.println("            margin: 0 auto;");
        out.println("            background: rgba(10, 10, 10, 0.8);");
        out.println("            border-radius: 20px;");
        out.println("            padding: 60px;");
        out.println("            box-shadow: 0 0 60px var(--shadow-cyan), 0 0 100px var(--shadow-magenta);");
        out.println("            backdrop-filter: blur(40px);");
        out.println("            border: 2px solid transparent;");
        out.println("            position: relative;");
        out.println("            text-align: center;");
        out.println("        }");

        // Animated Border
        out.println("        .cyber-container::before {");
        out.println("            content: '';");
        out.println("            position: absolute;");
        out.println("            top: 0; left: 0; right: 0; bottom: 0;");
        out.println("            border-radius: 20px;");
        out.println("            padding: 2px;");
        out.println("            background: linear-gradient(45deg, var(--neon-cyan), var(--neon-magenta), var(--neon-purple), var(--neon-cyan));");
        out.println("            background-size: 300% 300%;");
        out.println("            -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);");
        out.println("            mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);");
        out.println("            -webkit-mask-composite: xor;");
        out.println("            mask-composite: exclude;");
        out.println("            animation: borderRotate 4s linear infinite;");
        out.println("            z-index: -1;");
        out.println("        }");

        // Title
        out.println("        h1 {");
        out.println("            font-family: 'Orbitron', sans-serif;");
        out.println("            font-size: 4em;");
        out.println("            font-weight: 900;");
        out.println("            margin-bottom: 20px;");
        out.println("            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-magenta), var(--neon-purple));");
        out.println("            -webkit-background-clip: text;");
        out.println("            -webkit-text-fill-color: transparent;");
        out.println("            letter-spacing: 5px;");
        out.println("            text-transform: uppercase;");
        out.println("            animation: neonPulse 2s ease-in-out infinite;");
        out.println("        }");

        // Subtitle
        out.println("        .subtitle {");
        out.println("            font-size: 1.4em;");
        out.println("            color: #b0b0b0;");
        out.println("            margin-bottom: 40px;");
        out.println("            letter-spacing: 3px;");
        out.println("        }");

        // Welcome Text
        out.println("        .welcome-text {");
        out.println("            font-size: 1.2em;");
        out.println("            color: #b0b0b0;");
        out.println("            margin: 20px auto;");
        out.println("            max-width: 800px;");
        out.println("            line-height: 1.7;");
        out.println("        }");

        // Stats Grid
        out.println("        .stats-grid {");
        out.println("            display: grid;");
        out.println("            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));");
        out.println("            gap: 30px;");
        out.println("            margin: 50px 0;");
        out.println("        }");

        // Stat Card
        out.println("        .stat-card {");
        out.println("            background: rgba(10, 10, 10, 0.6);");
        out.println("            border-radius: 15px;");
        out.println("            padding: 40px 30px;");
        out.println("            box-shadow: 0 0 30px rgba(0, 245, 255, 0.2);");
        out.println("            border: 1px solid rgba(0, 245, 255, 0.3);");
        out.println("            transition: all 0.5s;");
        out.println("            backdrop-filter: blur(20px);");
        out.println("        }");

        out.println("        .stat-card:hover {");
        out.println("            transform: translateY(-15px) scale(1.05);");
        out.println("            box-shadow: 0 0 60px var(--shadow-cyan), 0 0 100px var(--shadow-magenta);");
        out.println("            border-color: var(--neon-cyan);");
        out.println("        }");

        // Stat Number
        out.println("        .stat-number {");
        out.println("            font-family: 'Orbitron', sans-serif;");
        out.println("            font-size: 4em;");
        out.println("            font-weight: 900;");
        out.println("            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-magenta));");
        out.println("            -webkit-background-clip: text;");
        out.println("            -webkit-text-fill-color: transparent;");
        out.println("            margin-bottom: 15px;");
        out.println("        }");

        // Stat Label
        out.println("        .stat-label {");
        out.println("            font-family: 'Rajdhani', sans-serif;");
        out.println("            font-size: 1.2em;");
        out.println("            color: #b0b0b0;");
        out.println("            font-weight: 700;");
        out.println("            letter-spacing: 3px;");
        out.println("            text-transform: uppercase;");
        out.println("        }");

        // Cyber Button
        out.println("        .cyber-button {");
        out.println("            font-family: 'Orbitron', sans-serif;");
        out.println("            display: inline-block;");
        out.println("            background: transparent;");
        out.println("            color: var(--neon-cyan);");
        out.println("            padding: 22px 60px;");
        out.println("            text-decoration: none;");
        out.println("            font-size: 1.2em;");
        out.println("            font-weight: 700;");
        out.println("            text-transform: uppercase;");
        out.println("            letter-spacing: 4px;");
        out.println("            transition: all 0.4s;");
        out.println("            box-shadow: 0 0 20px var(--shadow-cyan);");
        out.println("            margin: 20px 10px;");
        out.println("            border: 2px solid var(--neon-cyan);");
        out.println("            cursor: pointer;");
        out.println("            position: relative;");
        out.println("            overflow: hidden;");
        out.println("            clip-path: polygon(10% 0%, 100% 0%, 90% 100%, 0% 100%);");
        out.println("        }");

        out.println("        .cyber-button:hover {");
        out.println("            color: white;");
        out.println("            transform: translateY(-5px) scale(1.05);");
        out.println("            box-shadow: 0 0 40px var(--shadow-cyan), 0 0 80px var(--shadow-magenta);");
        out.println("            border-color: var(--neon-magenta);");
        out.println("            text-shadow: 0 0 10px var(--neon-cyan);");
        out.println("            background: rgba(0, 245, 255, 0.1);");
        out.println("        }");

        // Footer
        out.println("        .cyber-footer {");
        out.println("            margin-top: 60px;");
        out.println("            padding-top: 40px;");
        out.println("            border-top: 1px solid rgba(0, 245, 255, 0.2);");
        out.println("            color: #b0b0b0;");
        out.println("            font-size: 0.9em;");
        out.println("        }");

        // Responsive
        out.println("        @media (max-width: 768px) {");
        out.println("            .cyber-container { padding: 30px 20px; }");
        out.println("            h1 { font-size: 2.5em; }");
        out.println("            .stats-grid { grid-template-columns: 1fr; }");
        out.println("            .cyber-button { padding: 16px 40px; font-size: 1em; }");
        out.println("        }");

        out.println("    </style>");
        out.println("</head>");
        out.println("<body>");
        out.println("    <div class='cyber-container'>");
        out.println("        <h1>⚡ " + message + " ⚡</h1>");
        out.println("        <p class='subtitle'>FUTURISTIC BIG DATA ANALYTICS PLATFORM</p>");
        out.println("        <p class='welcome-text'>Welcome to the next generation of streaming analytics. Monitor real-time performance and unlock powerful insights with cutting-edge technology.</p>");
        out.println("        ");
        out.println("        <div class='stats-grid'>");
        out.println("            <div class='stat-card'>");
        out.println("                <div class='stat-number'>100K+</div>");
        out.println("                <div class='stat-label'>EVENTS</div>");
        out.println("            </div>");
        out.println("            <div class='stat-card'>");
        out.println("                <div class='stat-number'>10K+</div>");
        out.println("                <div class='stat-label'>VIDEOS</div>");
        out.println("            </div>");
        out.println("            <div class='stat-card'>");
        out.println("                <div class='stat-number'>24/7</div>");
        out.println("                <div class='stat-label'>REAL-TIME</div>");
        out.println("            </div>");
        out.println("        </div>");
        out.println("        ");
        out.println("        <div style='margin: 40px 0;'>");
        out.println("            <a href='stats' class='cyber-button'>⚡ VIEW STATISTICS ⚡</a>");
        out.println("            <a href='/analytics-dashboard/' class='cyber-button'>⚡ HOME ⚡</a>");
        out.println("        </div>");
        out.println("        ");
        out.println("        <div class='cyber-footer'>");
        out.println("            <p>⚡ ADVANCED STREAMING ANALYTICS PLATFORM - 2025 ⚡</p>");
        out.println("            <p>Powered by Jakarta EE & MongoDB</p>");
        out.println("        </div>");
        out.println("    </div>");
        out.println("</body>");
        out.println("</html>");
    }

    public void destroy() {
    }
}

