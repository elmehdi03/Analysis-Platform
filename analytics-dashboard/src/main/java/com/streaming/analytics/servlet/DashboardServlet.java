package com.streaming.analytics.servlet;

import java.io.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "dashboardServlet", value = "/dashboard")
public class DashboardServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "DATAFLOW CONSOLE";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html lang='fr'>");
        out.println("<head>");
        out.println("  <meta charset='UTF-8'>");
        out.println("  <meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("  <meta http-equiv='Cache-Control' content='no-cache, no-store, must-revalidate'>");
        out.println("  <meta http-equiv='Pragma' content='no-cache'>");
        out.println("  <meta http-equiv='Expires' content='0'>");
        out.println("  <title>DataFlow Console</title>");
        out.println("  <link href='https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap' rel='stylesheet'>");

        out.println("<style>");

        /* ===================== */
        /* NOUVEAU THEME CYAN/ORANGE */
        /* ===================== */
        out.println(":root{");
        out.println(" --primary-cyan:#06b6d4;");
        out.println(" --primary-orange:#f97316;");
        out.println(" --accent-teal:#14b8a6;");
        out.println(" --bg-dark:#0f172a;");
        out.println(" --bg-slate:#1e293b;");
        out.println(" --bg-card:#334155;");
        out.println(" --text-white:#f8fafc;");
        out.println(" --text-gray:#cbd5e1;");
        out.println(" --text-muted:#94a3b8;");
        out.println(" --border-color:#475569;");
        out.println("}");

        out.println("*{margin:0;padding:0;box-sizing:border-box;}");

        out.println("body{");
        out.println(" font-family:'Space Grotesk','Inter',sans-serif;");
        out.println(" background:linear-gradient(135deg,var(--bg-dark) 0%,var(--bg-slate) 100%);");
        out.println(" color:var(--text-white);");
        out.println(" min-height:100vh;");
        out.println(" display:flex;");
        out.println(" align-items:center;");
        out.println(" justify-content:center;");
        out.println(" padding:30px;");
        out.println(" position:relative;");
        out.println("}");

        out.println("body::before{");
        out.println(" content:'';");
        out.println(" position:fixed;");
        out.println(" top:-50%;");
        out.println(" left:-50%;");
        out.println(" width:200%;");
        out.println(" height:200%;");
        out.println(" background:radial-gradient(circle at 30% 40%,rgba(6,182,212,0.08) 0%,transparent 50%),radial-gradient(circle at 70% 60%,rgba(249,115,22,0.08) 0%,transparent 50%);");
        out.println(" animation:rotate 20s linear infinite;");
        out.println(" pointer-events:none;");
        out.println(" z-index:0;");
        out.println("}");

        out.println("@keyframes rotate{0%{transform:rotate(0deg);}100%{transform:rotate(360deg);}}");

        out.println(".cyber-container{");
        out.println(" width:100%;");
        out.println(" max-width:1100px;");
        out.println(" background:rgba(30,41,59,0.6);");
        out.println(" border-radius:24px;");
        out.println(" padding:45px;");
        out.println(" border:1px solid var(--border-color);");
        out.println(" backdrop-filter:blur(20px);");
        out.println(" box-shadow:0 20px 60px rgba(0,0,0,0.4);");
        out.println(" text-align:center;");
        out.println(" animation:fadeIn 0.8s ease;");
        out.println(" position:relative;");
        out.println(" z-index:1;");
        out.println("}");

        out.println("@keyframes fadeIn{from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:none;}}");

        out.println("h1{");
        out.println(" font-size:3.5em;");
        out.println(" font-weight:700;");
        out.println(" margin-bottom:15px;");
        out.println(" background:linear-gradient(90deg,var(--primary-cyan) 0%,var(--primary-orange) 100%);");
        out.println(" -webkit-background-clip:text;");
        out.println(" -webkit-text-fill-color:transparent;");
        out.println(" background-clip:text;");
        out.println(" letter-spacing:-2px;");
        out.println("}");

        out.println(".subtitle{");
        out.println(" font-size:1.2em;");
        out.println(" color:var(--text-gray);");
        out.println(" margin-bottom:35px;");
        out.println(" font-family:'Inter',sans-serif;");
        out.println("}");

        out.println(".welcome-text{");
        out.println(" max-width:750px;");
        out.println(" margin:0 auto 40px;");
        out.println(" line-height:1.7;");
        out.println(" color:var(--text-muted);");
        out.println(" font-family:'Inter',sans-serif;");
        out.println("}");

        out.println(".stats-grid{");
        out.println(" display:grid;");
        out.println(" grid-template-columns:repeat(auto-fit,minmax(220px,1fr));");
        out.println(" gap:25px;");
        out.println(" margin:40px 0;");
        out.println("}");

        out.println(".stat-card{");
        out.println(" padding:32px;");
        out.println(" border-radius:12px;");
        out.println(" background:rgba(30,41,59,0.6);");
        out.println(" border:1px solid var(--border-color);");
        out.println(" transition:all 0.3s ease;");
        out.println(" position:relative;");
        out.println(" overflow:hidden;");
        out.println("}");

        out.println(".stat-card::before{");
        out.println(" content:'';");
        out.println(" position:absolute;");
        out.println(" top:0;");
        out.println(" left:0;");
        out.println(" width:4px;");
        out.println(" height:100%;");
        out.println(" background:linear-gradient(180deg,var(--primary-cyan),var(--primary-orange));");
        out.println(" transition:width 0.3s ease;");
        out.println("}");

        out.println(".stat-card:hover::before{");
        out.println(" width:100%;");
        out.println(" opacity:0.1;");
        out.println("}");

        out.println(".stat-card:hover{");
        out.println(" transform:translateY(-8px);");
        out.println(" border-color:var(--primary-cyan);");
        out.println(" box-shadow:0 20px 40px rgba(6,182,212,0.2);");
        out.println("}");

        out.println(".stat-number{");
        out.println(" font-size:3em;");
        out.println(" font-weight:700;");
        out.println(" margin-bottom:8px;");
        out.println(" color:var(--text-white);");
        out.println(" position:relative;");
        out.println(" z-index:1;");
        out.println("}");

        out.println(".stat-label{");
        out.println(" font-size:0.95em;");
        out.println(" letter-spacing:0.5px;");
        out.println(" text-transform:uppercase;");
        out.println(" color:var(--text-muted);");
        out.println(" font-weight:500;");
        out.println(" position:relative;");
        out.println(" z-index:1;");
        out.println(" font-family:'Inter',sans-serif;");
        out.println("}");

        out.println(".cyber-button{");
        out.println(" display:inline-block;");
        out.println(" padding:14px 32px;");
        out.println(" margin:10px;");
        out.println(" border-radius:8px;");
        out.println(" font-weight:600;");
        out.println(" text-decoration:none;");
        out.println(" color:var(--bg-dark);");
        out.println(" background:linear-gradient(90deg,var(--primary-cyan),var(--accent-teal));");
        out.println(" transition:all 0.3s ease;");
        out.println(" box-shadow:0 8px 24px rgba(6,182,212,0.3);");
        out.println(" letter-spacing:0.5px;");
        out.println("}");

        out.println(".cyber-button:hover{");
        out.println(" transform:translateY(-2px);");
        out.println(" box-shadow:0 12px 32px rgba(6,182,212,0.4);");
        out.println("}");

        out.println(".cyber-footer{");
        out.println(" margin-top:45px;");
        out.println(" padding-top:25px;");
        out.println(" border-top:1px solid var(--border-color);");
        out.println(" font-size:0.9em;");
        out.println(" opacity:0.8;");
        out.println(" color:var(--text-muted);");
        out.println(" font-family:'Inter',sans-serif;");
        out.println("}");

        out.println("@media(max-width:768px){");
        out.println(" h1{font-size:2.5em;}");
        out.println(" .cyber-container{padding:30px 20px;}");
        out.println("}");

        out.println("</style>");
        out.println("</head>");

        out.println("<body>");
        out.println(" <div class='cyber-container'>");
        out.println("   <h1>" + message + "</h1>");
        out.println("   <p class='subtitle'>Console de Supervision en Temps Réel</p>");
        out.println("   <p class='welcome-text'>Tableau de bord moderne pour l'analyse de vos données streaming et métriques de performance.</p>");

        out.println("   <div class='stats-grid'>");
        out.println("     <div class='stat-card'><div class='stat-number'>100K+</div><div class='stat-label'>Événements</div></div>");
        out.println("     <div class='stat-card'><div class='stat-number'>10K+</div><div class='stat-label'>Vidéos</div></div>");
        out.println("     <div class='stat-card'><div class='stat-number'>24/7</div><div class='stat-label'>Temps Réel</div></div>");
        out.println("   </div>");

        out.println("   <div style='margin:40px 0;'>");
        out.println("     <a href='stats' class='cyber-button'>Voir les Statistiques</a>");
        out.println("     <a href='/analytics-dashboard/' class='cyber-button'>Accueil</a>");
        out.println("   </div>");

        out.println("   <div class='cyber-footer'>");
        out.println("     <p>DataFlow Analytics Platform – 2025</p>");
        out.println("     <p>Propulsé par Jakarta EE & MongoDB</p>");
        out.println("   </div>");

        out.println(" </div>");
        out.println("</body>");
        out.println("</html>");

    }

    public void destroy() {
    }
}
