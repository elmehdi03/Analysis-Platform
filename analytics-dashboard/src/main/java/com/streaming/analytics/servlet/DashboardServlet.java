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
        out.println("  <title>Streaming Analytics Dashboard</title>");
        out.println("  <link href='https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800;900&display=swap' rel='stylesheet'>");

        out.println("<style>");

        /* ===================== */
        /* VARIABLES (COULEURS IDENTIQUES) */
        /* ===================== */
        out.println(":root{");
        out.println(" --primary-purple:#a855f7;");
        out.println(" --primary-pink:#ec4899;");
        out.println(" --primary-cyan:#06b6d4;");
        out.println(" --bg-dark-1:#0f0c29;");
        out.println(" --bg-dark-2:#302b63;");
        out.println(" --bg-dark-3:#24243e;");
        out.println(" --card-bg:rgba(30,27,75,0.75);");
        out.println(" --card-border:rgba(168,85,247,0.25);");
        out.println(" --text-primary:#e8eaf6;");
        out.println(" --text-secondary:#c4b5fd;");
        out.println("}");

        out.println("*{margin:0;padding:0;box-sizing:border-box;}");

        out.println("body{");
        out.println(" font-family:'Inter',system-ui,sans-serif;");
        out.println(" background:linear-gradient(160deg,var(--bg-dark-1),var(--bg-dark-2),var(--bg-dark-3));");
        out.println(" color:var(--text-primary);");
        out.println(" min-height:100vh;");
        out.println(" display:flex;");
        out.println(" align-items:center;");
        out.println(" justify-content:center;");
        out.println(" padding:30px;");
        out.println("}");

        out.println(".cyber-container{");
        out.println(" width:100%;");
        out.println(" max-width:1100px;");
        out.println(" background:var(--card-bg);");
        out.println(" border-radius:18px;");
        out.println(" padding:45px;");
        out.println(" border:1px solid var(--card-border);");
        out.println(" backdrop-filter:blur(18px);");
        out.println(" box-shadow:0 30px 60px rgba(0,0,0,0.35);");
        out.println(" text-align:center;");
        out.println(" animation:fadeIn 0.8s ease;");
        out.println("}");

        out.println("@keyframes fadeIn{from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:none;}}");

        out.println("h1{");
        out.println(" font-size:3em;");
        out.println(" font-weight:900;");
        out.println(" margin-bottom:15px;");
        out.println(" background:linear-gradient(90deg,var(--primary-purple),var(--primary-pink));");
        out.println(" -webkit-background-clip:text;");
        out.println(" -webkit-text-fill-color:transparent;");
        out.println("}");

        out.println(".subtitle{");
        out.println(" font-size:1.1em;");
        out.println(" color:var(--text-secondary);");
        out.println(" margin-bottom:35px;");
        out.println("}");

        out.println(".welcome-text{");
        out.println(" max-width:750px;");
        out.println(" margin:0 auto 40px;");
        out.println(" line-height:1.7;");
        out.println("}");

        out.println(".stats-grid{");
        out.println(" display:grid;");
        out.println(" grid-template-columns:repeat(auto-fit,minmax(220px,1fr));");
        out.println(" gap:25px;");
        out.println(" margin:40px 0;");
        out.println("}");

        out.println(".stat-card{");
        out.println(" padding:30px;");
        out.println(" border-radius:14px;");
        out.println(" background:linear-gradient(145deg,rgba(168,85,247,0.12),rgba(236,72,153,0.12));");
        out.println(" border:1px solid var(--card-border);");
        out.println(" transition:all 0.35s ease;");
        out.println("}");

        out.println(".stat-card:hover{");
        out.println(" transform:translateY(-6px);");
        out.println(" box-shadow:0 20px 40px rgba(168,85,247,0.35);");
        out.println("}");

        out.println(".stat-number{");
        out.println(" font-size:3.2em;");
        out.println(" font-weight:800;");
        out.println(" margin-bottom:8px;");
        out.println(" color:var(--primary-cyan);");
        out.println("}");

        out.println(".stat-label{");
        out.println(" font-size:0.9em;");
        out.println(" letter-spacing:1px;");
        out.println(" text-transform:uppercase;");
        out.println(" color:var(--text-secondary);");
        out.println("}");

        out.println(".cyber-button{");
        out.println(" display:inline-block;");
        out.println(" padding:15px 38px;");
        out.println(" margin:10px;");
        out.println(" border-radius:10px;");
        out.println(" font-weight:700;");
        out.println(" text-decoration:none;");
        out.println(" color:white;");
        out.println(" background:linear-gradient(90deg,var(--primary-purple),var(--primary-pink));");
        out.println(" transition:all 0.3s ease;");
        out.println("}");

        out.println(".cyber-button:hover{");
        out.println(" transform:scale(1.05);");
        out.println(" box-shadow:0 12px 30px rgba(236,72,153,0.45);");
        out.println("}");

        out.println(".cyber-footer{");
        out.println(" margin-top:45px;");
        out.println(" padding-top:25px;");
        out.println(" border-top:1px solid var(--card-border);");
        out.println(" font-size:0.85em;");
        out.println(" opacity:0.8;");
        out.println("}");

        out.println("@media(max-width:768px){");
        out.println(" h1{font-size:2.3em;}");
        out.println(" .cyber-container{padding:30px 20px;}");
        out.println("}");

        out.println("</style>");
        out.println("</head>");

        out.println("<body>");
        out.println(" <div class='cyber-container'>");
        out.println("   <h1>📊 " + message + " 📊</h1>");
        out.println("   <p class='subtitle'>Real-Time Streaming Insights & Performance Metrics</p>");
        out.println("   <p class='welcome-text'><strong>Nouveau design professionnel</strong> – clair, moderne et orienté analytics.</p>");

        out.println("   <div class='stats-grid'>");
        out.println("     <div class='stat-card'><div class='stat-number'>100K+</div><div class='stat-label'>Events</div></div>");
        out.println("     <div class='stat-card'><div class='stat-number'>10K+</div><div class='stat-label'>Videos</div></div>");
        out.println("     <div class='stat-card'><div class='stat-number'>24/7</div><div class='stat-label'>Real-Time</div></div>");
        out.println("   </div>");

        out.println("   <div style='margin:40px 0;'>");
        out.println("     <a href='stats' class='cyber-button'>VIEW STATISTICS</a>");
        out.println("     <a href='/analytics-dashboard/' class='cyber-button'>HOME</a>");
        out.println("   </div>");

        out.println("   <div class='cyber-footer'>");
        out.println("     <p>Advanced Streaming Analytics Platform – 2025</p>");
        out.println("     <p>Powered by Jakarta EE & MongoDB</p>");
        out.println("   </div>");

        out.println(" </div>");
        out.println("</body>");
        out.println("</html>");

    }

    public void destroy() {
    }
}

