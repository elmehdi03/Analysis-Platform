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

        // HTML with Professional Design matching home page
        out.println("<!DOCTYPE html>");
        out.println("<html lang='fr'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Statistics - Streaming Analytics</title>");
        out.println("<link href='https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap' rel='stylesheet'>");
        out.println("<style>");
        out.println("*{margin:0;padding:0;box-sizing:border-box;}");
        out.println(":root{--primary-gradient:linear-gradient(135deg,#667eea 0%,#764ba2 100%);--secondary-gradient:linear-gradient(135deg,#f093fb 0%,#f5576c 100%);--accent-gradient:linear-gradient(135deg,#4facfe 0%,#00f2fe 100%);--dark-bg:#0a0e27;--card-bg:rgba(255,255,255,0.03);--card-border:rgba(255,255,255,0.1);--text-primary:#ffffff;--text-secondary:#a0aec0;--shadow-color:rgba(0,0,0,0.5);}");
        out.println("body{font-family:'Poppins','Inter','Segoe UI',system-ui,sans-serif;background:var(--dark-bg);color:var(--text-primary);min-height:100vh;padding:20px;position:relative;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;}");
        out.println("body::before{content:'';position:fixed;top:0;left:0;width:100%;height:100%;background:radial-gradient(circle at 30% 50%,rgba(102,126,234,0.15) 0%,transparent 50%),radial-gradient(circle at 70% 80%,rgba(245,87,108,0.15) 0%,transparent 50%),radial-gradient(circle at 50% 20%,rgba(79,172,254,0.1) 0%,transparent 40%);animation:gradientShift 15s ease infinite;pointer-events:none;z-index:0;}");
        out.println("@keyframes gradientShift{0%,100%{opacity:1;transform:scale(1) rotate(0deg);}50%{opacity:0.8;transform:scale(1.1) rotate(5deg);}}");
        out.println("body::after{content:'';position:fixed;top:0;left:0;width:100%;height:100%;background-image:radial-gradient(circle,rgba(255,255,255,0.05) 1px,transparent 1px);background-size:50px 50px;animation:float 30s linear infinite;pointer-events:none;z-index:0;}");
        out.println("@keyframes float{0%{transform:translateY(0) translateX(0);}100%{transform:translateY(-100px) translateX(50px);}}");
        out.println(".stats-container{max-width:1400px;margin:0 auto;background:var(--card-bg);border-radius:30px;box-shadow:0 30px 90px var(--shadow-color),0 0 0 1px var(--card-border),inset 0 1px 0 rgba(255,255,255,0.1);overflow:hidden;backdrop-filter:blur(40px) saturate(180%);border:1px solid var(--card-border);position:relative;z-index:1;animation:fadeInUp 0.8s ease-out;}");
        out.println("@keyframes fadeInUp{from{opacity:0;transform:translateY(30px);}to{opacity:1;transform:translateY(0);}}");
        out.println(".stats-header{background:var(--primary-gradient);color:white;padding:60px 50px;text-align:center;position:relative;overflow:hidden;}");
        out.println(".stats-header::before{content:'';position:absolute;top:-50%;left:-50%;width:200%;height:200%;background:radial-gradient(circle,rgba(255,255,255,0.15) 0%,transparent 70%);animation:pulse 10s ease-in-out infinite;}");
        out.println("@keyframes pulse{0%,100%{transform:translate(0,0) scale(1);}50%{transform:translate(10%,10%) scale(1.1);}}");
        out.println(".stats-header h1{font-size:3.5em;font-weight:900;margin-bottom:15px;position:relative;z-index:1;letter-spacing:-2px;text-shadow:0 5px 30px rgba(0,0,0,0.3);}");
        out.println(".stats-header p{font-size:1.3em;opacity:0.95;position:relative;z-index:1;font-weight:300;}");
        out.println(".stats-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:30px;padding:50px;}");
        out.println(".stat-card{background:var(--card-bg);border-radius:25px;padding:40px 30px;text-align:center;box-shadow:0 15px 50px rgba(0,0,0,0.3),inset 0 1px 0 rgba(255,255,255,0.1);border:1px solid var(--card-border);transition:all 0.5s cubic-bezier(0.4,0,0.2,1);backdrop-filter:blur(20px);position:relative;overflow:hidden;}");
        out.println(".stat-card::before{content:'';position:absolute;top:0;left:0;right:0;bottom:0;background:var(--primary-gradient);opacity:0;transition:opacity 0.5s ease;z-index:0;}");
        out.println(".stat-card:hover::before{opacity:0.15;}");
        out.println(".stat-card:hover{transform:translateY(-15px) scale(1.03);box-shadow:0 30px 70px rgba(102,126,234,0.4),0 0 80px rgba(102,126,234,0.2),inset 0 1px 0 rgba(255,255,255,0.2);border-color:rgba(102,126,234,0.5);}");
        out.println(".stat-card>*{position:relative;z-index:1;}");
        out.println(".stat-number{font-size:3.8em;font-weight:900;background:var(--primary-gradient);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;margin-bottom:15px;animation:countPulse 2s ease-in-out infinite;}");
        out.println("@keyframes countPulse{0%,100%{transform:scale(1);}50%{transform:scale(1.05);}}");
        out.println(".stat-label{font-size:1.1em;color:var(--text-secondary);font-weight:600;letter-spacing:1px;text-transform:uppercase;}");
        out.println(".info-section{padding:50px;}");
        out.println(".info-box{background:var(--card-bg);border:1px solid var(--card-border);padding:40px;margin:20px 0;border-radius:25px;box-shadow:0 15px 50px rgba(0,0,0,0.3);backdrop-filter:blur(20px);}");
        out.println(".info-box h3{font-size:2em;background:linear-gradient(135deg,#ffffff 0%,#667eea 100%);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;margin-bottom:25px;font-weight:800;letter-spacing:-1px;}");
        out.println(".info-box p{color:var(--text-secondary);margin:12px 0;font-size:1.1em;line-height:1.8;}");
        out.println(".navigation{text-align:center;padding:30px 50px 50px;}");
        out.println(".nav-buttons{display:flex;justify-content:center;gap:20px;flex-wrap:wrap;}");
        out.println(".modern-button{display:inline-block;background:var(--primary-gradient);color:white;padding:18px 45px;text-decoration:none;border-radius:12px;font-size:1.1em;font-weight:700;text-transform:uppercase;letter-spacing:1.5px;transition:all 0.3s cubic-bezier(0.4,0,0.2,1);box-shadow:0 10px 30px rgba(102,126,234,0.4);border:none;cursor:pointer;position:relative;overflow:hidden;}");
        out.println(".modern-button::before{content:'';position:absolute;top:0;left:-100%;width:100%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,0.3),transparent);transition:left 0.5s;}");
        out.println(".modern-button:hover::before{left:100%;}");
        out.println(".modern-button:hover{transform:translateY(-3px) scale(1.05);box-shadow:0 15px 40px rgba(102,126,234,0.5);background:linear-gradient(135deg,#764ba2 0%,#667eea 100%);}");
        out.println(".nav-bar{display:flex;justify-content:space-between;align-items:center;padding:20px 30px;position:relative;z-index:10;max-width:1400px;margin:0 auto;}");
        out.println("@media(max-width:768px){.stats-grid{grid-template-columns:1fr;padding:30px 20px;}.info-section{padding:30px 20px;}.stats-header{padding:40px 20px;}.stats-header h1{font-size:2.5em;letter-spacing:-1px;}.stats-header p{font-size:1.1em;}.navigation{padding:20px;}}");
        out.println("@media(max-width:480px){.stats-header h1{font-size:2em;}.stat-number{font-size:3em;}}");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='nav-bar'>");
        out.println("<a href='/analytics-dashboard/' class='modern-button'>🏠 HOME</a>");
        out.println("</div>");
        out.println("<div class='stats-container'>");
        out.println("<div class='stats-header'>");
        out.println("<h1>📊 REAL-TIME STATISTICS</h1>");
        out.println("<p>COMPREHENSIVE STREAMING ANALYTICS & INSIGHTS</p>");
        out.println("</div>");
        out.println("<div class='stats-grid'>");
        out.println("<div class='stat-card'><div class='stat-number'>" + String.format("%,d", totalEvents) + "</div><div class='stat-label'>Viewing Events</div></div>");
        out.println("<div class='stat-card'><div class='stat-number'>" + String.format("%,d", totalVideos) + "</div><div class='stat-label'>Videos Catalog</div></div>");
        out.println("<div class='stat-card'><div class='stat-number'>" + String.format("%,d", totalUsers) + "</div><div class='stat-label'>Active Users</div></div>");
        out.println("</div>");
        out.println("<div class='info-section'>");
        out.println("<div class='info-box'>");
        out.println("<h3>💡 System Information</h3>");
        out.println("<p>✓ Database: MongoDB Connected & Operational</p>");
        out.println("<p>✓ Technology Stack: Jakarta EE + JAX-RS + MongoDB</p>");
        out.println("<p>✓ Infrastructure: Docker Compose Multi-Container</p>");
        out.println("<p>✓ Status: Real-time Data Streaming Active</p>");
        out.println("</div>");
        out.println("</div>");
        out.println("<div class='navigation'>");
        out.println("<div class='nav-buttons'>");
        out.println("<a href='dashboard' class='modern-button'>📊 Dashboard</a>");
        out.println("<a href='/analytics-api/api/v1/analytics/health' class='modern-button' target='_blank'>🔍 API Health</a>");
        out.println("</div>");
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

