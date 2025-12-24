package com.streaming.analytics.servlet;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.bson.Document;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "statsServlet", value = "/stats")
public class StatsServlet extends HttpServlet {

    private MongoClient mongoClient;
    private MongoDatabase database;
    private MongoCollection<Document> eventsCollection;
    private MongoCollection<Document> videosCollection;

    public void init() {
        try {
            this.mongoClient = MongoClients.create("mongodb://admin:admin123@mongodb:27017");
            this.database = mongoClient.getDatabase("streaming_analytics");
            this.eventsCollection = database.getCollection("viewevents");
            this.videosCollection = database.getCollection("videos");
        } catch (Exception e) {
            System.err.println("Erreur de connexion MongoDB: " + e.getMessage());
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        // Statistiques
        long totalEvents = 0;
        long totalVideos = 0;
        long totalUsers = 0;

        try {
            totalEvents = eventsCollection.countDocuments();
            totalVideos = videosCollection.countDocuments();
            List<String> distinctUsers = eventsCollection.distinct("userId", String.class).into(new ArrayList<>());
            totalUsers = distinctUsers.size();
        } catch (Exception e) {
            System.err.println("Erreur statistiques: " + e.getMessage());
        }

        // HTML with Cyber Neon Design
        out.println("<!DOCTYPE html>");
        out.println("<html lang='fr'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>⚡ Statistics - Streaming Analytics ⚡</title>");
        out.println("<link href='https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Rajdhani:wght@400;600;700&display=swap' rel='stylesheet'>");
        out.println("<style>");
        out.println(":root{--neon-cyan:#00f5ff;--neon-magenta:#ff0080;--neon-purple:#7928ca;--dark-bg:#050505;}");
        out.println("*{margin:0;padding:0;box-sizing:border-box;}");
        out.println("body{font-family:'Rajdhani',sans-serif;background:var(--dark-bg);color:white;min-height:100vh;padding:20px;position:relative;}");
        out.println("body::before{content:'';position:fixed;top:0;left:0;width:100%;height:100%;background:linear-gradient(90deg,rgba(0,245,255,0.03) 1px,transparent 1px),linear-gradient(0deg,rgba(0,245,255,0.03) 1px,transparent 1px),radial-gradient(circle at 30% 50%,rgba(0,245,255,0.15),transparent 50%);background-size:50px 50px,50px 50px,100% 100%;animation:gridPulse 8s ease infinite;pointer-events:none;}");
        out.println("@keyframes gridPulse{0%,100%{opacity:0.3}50%{opacity:0.5}}");
        out.println("@keyframes borderRotate{0%,100%{background-position:0% 50%}50%{background-position:100% 50%}}");
        out.println("@keyframes pulse{0%,100%{box-shadow:0 0 10px #10b981}50%{box-shadow:0 0 20px #10b981}}");
        out.println(".cyber-container{max-width:1400px;margin:0 auto;background:rgba(10,10,10,0.8);border-radius:20px;padding:60px;box-shadow:0 0 60px rgba(0,245,255,0.5);backdrop-filter:blur(40px);border:2px solid transparent;position:relative;z-index:1;}");
        out.println(".cyber-container::before{content:'';position:absolute;top:0;left:0;right:0;bottom:0;border-radius:20px;padding:2px;background:linear-gradient(45deg,var(--neon-cyan),var(--neon-magenta),var(--neon-purple),var(--neon-cyan));background-size:300% 300%;-webkit-mask:linear-gradient(#fff 0 0) content-box,linear-gradient(#fff 0 0);mask:linear-gradient(#fff 0 0) content-box,linear-gradient(#fff 0 0);-webkit-mask-composite:xor;mask-composite:exclude;animation:borderRotate 4s linear infinite;z-index:-1;}");
        out.println("h1{font-family:'Orbitron',sans-serif;font-size:3.5em;font-weight:900;text-align:center;margin-bottom:50px;background:linear-gradient(135deg,var(--neon-cyan),var(--neon-magenta),var(--neon-purple));-webkit-background-clip:text;-webkit-text-fill-color:transparent;letter-spacing:5px;text-transform:uppercase;}");
        out.println(".status-indicator{display:inline-block;width:12px;height:12px;background:#10b981;border-radius:50%;box-shadow:0 0 10px #10b981;margin-right:15px;animation:pulse 2s infinite;}");
        out.println(".stats-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:30px;margin:50px 0;}");
        out.println(".stat-card{background:rgba(10,10,10,0.6);border-radius:15px;padding:45px 35px;text-align:center;box-shadow:0 0 30px rgba(0,245,255,0.2);border:1px solid rgba(0,245,255,0.3);transition:all 0.5s;backdrop-filter:blur(20px);}");
        out.println(".stat-card:hover{transform:translateY(-15px) scale(1.05);box-shadow:0 0 60px rgba(0,245,255,0.5);border-color:var(--neon-cyan);}");
        out.println(".stat-number{font-family:'Orbitron',sans-serif;font-size:4.5em;font-weight:900;background:linear-gradient(135deg,var(--neon-cyan),var(--neon-magenta));-webkit-background-clip:text;-webkit-text-fill-color:transparent;margin-bottom:15px;}");
        out.println(".stat-label{font-family:'Rajdhani',sans-serif;font-size:1.2em;color:#b0b0b0;font-weight:700;letter-spacing:3px;text-transform:uppercase;}");
        out.println(".info-box{background:rgba(0,245,255,0.05);border:1px solid rgba(0,245,255,0.3);padding:30px;margin:40px 0;border-radius:15px;}");
        out.println(".info-box h3{color:var(--neon-cyan);font-size:1.5em;margin-bottom:15px;letter-spacing:2px;}");
        out.println(".info-box p{color:#b0b0b0;margin:10px 0;font-size:1.1em;}");
        out.println(".cyber-button{font-family:'Orbitron',sans-serif;display:inline-block;background:transparent;color:var(--neon-cyan);padding:18px 40px;text-decoration:none;font-size:1em;font-weight:700;text-transform:uppercase;letter-spacing:3px;transition:all 0.4s;box-shadow:0 0 20px rgba(0,245,255,0.5);margin:10px;border:2px solid var(--neon-cyan);cursor:pointer;overflow:hidden;clip-path:polygon(10% 0%,100% 0%,90% 100%,0% 100%);}");
        out.println(".cyber-button:hover{color:white;transform:translateY(-5px) scale(1.05);box-shadow:0 0 40px rgba(0,245,255,0.5);border-color:var(--neon-magenta);text-shadow:0 0 10px var(--neon-cyan);background:rgba(0,245,255,0.1);}");
        out.println(".navigation{text-align:center;margin:40px 0;}");
        out.println(".cyber-footer{text-align:center;margin-top:60px;padding-top:40px;border-top:1px solid rgba(0,245,255,0.2);color:#b0b0b0;font-size:0.9em;}");
        out.println("@media(max-width:768px){.cyber-container{padding:30px 20px;}h1{font-size:2.5em;}.stats-grid{grid-template-columns:1fr;}}");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='cyber-container'>");
        out.println("<h1><span class='status-indicator'></span>⚡ REAL-TIME STATISTICS ⚡</h1>");
        out.println("<div class='stats-grid'>");
        out.println("<div class='stat-card'><div class='stat-number'>" + String.format("%,d", totalEvents) + "</div><div class='stat-label'>VIEWING EVENTS</div></div>");
        out.println("<div class='stat-card'><div class='stat-number'>" + String.format("%,d", totalVideos) + "</div><div class='stat-label'>VIDEOS CATALOG</div></div>");
        out.println("<div class='stat-card'><div class='stat-number'>" + String.format("%,d", totalUsers) + "</div><div class='stat-label'>ACTIVE USERS</div></div>");
        out.println("</div>");
        out.println("<div class='info-box'>");
        out.println("<h3>💡 SYSTEM INFORMATION</h3>");
        out.println("<p>✓ Database: MongoDB Connected</p>");
        out.println("<p>✓ Technology: Jakarta EE + JAX-RS</p>");
        out.println("<p>✓ Infrastructure: Docker Compose</p>");
        out.println("<p>✓ Status: Real-time Data Streaming Active</p>");
        out.println("</div>");
        out.println("<div class='navigation'>");
        out.println("<a href='/analytics-dashboard/' class='cyber-button'>⚡ HOME ⚡</a>");
        out.println("<a href='dashboard' class='cyber-button'>⚡ DASHBOARD ⚡</a>");
        out.println("<a href='/analytics-api/api/v1/analytics/health' class='cyber-button' target='_blank'>⚡ API CHECK ⚡</a>");
        out.println("</div>");
        out.println("<div class='cyber-footer'>");
        out.println("<p>⚡ REAL-TIME DATA • STREAMING ANALYTICS PLATFORM - 2025 ⚡</p>");
        out.println("<p style='margin-top:10px;opacity:0.7;'>Powered by Jakarta EE & MongoDB</p>");
        out.println("</div>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }

    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}

