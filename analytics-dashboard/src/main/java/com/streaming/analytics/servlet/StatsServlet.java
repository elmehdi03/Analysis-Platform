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

        // HTML with New Cyan/Orange Design
        out.println("<!DOCTYPE html>");
        out.println("<html lang='fr'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Statistiques - DataFlow Analytics</title>");
        out.println("<link href='https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap' rel='stylesheet'>");
        out.println("<style>");
        out.println("*{margin:0;padding:0;box-sizing:border-box;}");
        out.println(":root{--primary-cyan:#06b6d4;--primary-orange:#f97316;--accent-teal:#14b8a6;--bg-dark:#0f172a;--bg-slate:#1e293b;--bg-card:#334155;--text-white:#f8fafc;--text-gray:#cbd5e1;--text-muted:#94a3b8;--border-color:#475569;}");
        out.println("body{font-family:'Space Grotesk','Inter',sans-serif;background:linear-gradient(135deg,var(--bg-dark) 0%,var(--bg-slate) 100%);color:var(--text-white);min-height:100vh;padding:20px;position:relative;}");
        out.println("body::before{content:'';position:fixed;top:-50%;left:-50%;width:200%;height:200%;background:radial-gradient(circle at 30% 40%,rgba(6,182,212,0.08) 0%,transparent 50%),radial-gradient(circle at 70% 60%,rgba(249,115,22,0.08) 0%,transparent 50%);animation:rotate 20s linear infinite;pointer-events:none;z-index:0;}");
        out.println("@keyframes rotate{0%{transform:rotate(0deg);}100%{transform:rotate(360deg);}}");
        out.println(".stats-container{max-width:1400px;margin:0 auto;background:rgba(30,41,59,0.6);border-radius:24px;box-shadow:0 20px 60px rgba(0,0,0,0.4);overflow:hidden;backdrop-filter:blur(20px);border:1px solid var(--border-color);position:relative;z-index:1;}");
        out.println(".stats-header{background:linear-gradient(90deg,var(--primary-cyan) 0%,var(--primary-orange) 100%);color:white;padding:60px 50px;text-align:center;position:relative;overflow:hidden;}");
        out.println(".stats-header h1{font-size:3.5em;font-weight:700;margin-bottom:15px;position:relative;z-index:1;letter-spacing:-2px;text-shadow:0 5px 30px rgba(0,0,0,0.3);}");
        out.println(".stats-header p{font-size:1.3em;opacity:0.95;position:relative;z-index:1;font-weight:400;font-family:'Inter',sans-serif;}");
        out.println(".stats-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:24px;padding:50px;}");
        out.println(".stat-card{background:rgba(30,41,59,0.6);border-radius:12px;padding:32px;text-align:center;border:1px solid var(--border-color);transition:all 0.3s ease;position:relative;overflow:hidden;}");
        out.println(".stat-card::before{content:'';position:absolute;top:0;left:0;width:4px;height:100%;background:linear-gradient(180deg,var(--primary-cyan),var(--primary-orange));transition:width 0.3s ease;}");
        out.println(".stat-card:hover::before{width:100%;opacity:0.1;}");
        out.println(".stat-card:hover{transform:translateY(-8px);border-color:var(--primary-cyan);box-shadow:0 20px 40px rgba(6,182,212,0.2);}");
        out.println(".stat-card>*{position:relative;z-index:1;}");
        out.println(".stat-number{font-size:3.2em;font-weight:700;color:var(--text-white);margin-bottom:12px;}");
        out.println(".stat-label{font-size:0.95em;color:var(--text-muted);font-weight:500;letter-spacing:0.5px;text-transform:uppercase;font-family:'Inter',sans-serif;}");
        out.println(".info-section{padding:50px;}");
        out.println(".info-box{background:rgba(30,41,59,0.6);border:1px solid var(--border-color);padding:40px;margin:20px 0;border-radius:16px;backdrop-filter:blur(20px);}");
        out.println(".info-box h3{font-size:1.8em;color:var(--text-white);margin-bottom:20px;font-weight:600;}");
        out.println(".info-box p{color:var(--text-gray);margin:12px 0;font-size:1.05em;line-height:1.7;font-family:'Inter',sans-serif;}");
        out.println(".navigation{text-align:center;padding:30px 50px 50px;}");
        out.println(".nav-buttons{display:flex;justify-content:center;gap:20px;flex-wrap:wrap;}");
        out.println(".modern-button{display:inline-block;background:linear-gradient(90deg,var(--primary-cyan) 0%,var(--accent-teal) 100%);color:var(--bg-dark);padding:14px 32px;text-decoration:none;border-radius:8px;font-size:1em;font-weight:600;letter-spacing:0.5px;transition:all 0.3s ease;box-shadow:0 8px 24px rgba(6,182,212,0.3);border:none;cursor:pointer;}");
        out.println(".modern-button:hover{transform:translateY(-2px);box-shadow:0 12px 32px rgba(6,182,212,0.4);}");
        out.println(".nav-bar{display:flex;justify-content:space-between;align-items:center;padding:20px 30px;position:relative;z-index:10;max-width:1400px;margin:0 auto;}");
        out.println("@media(max-width:768px){.stats-grid{grid-template-columns:1fr;padding:30px 20px;}.info-section{padding:30px 20px;}.stats-header{padding:40px 20px;}.stats-header h1{font-size:2.5em;}.stats-header p{font-size:1.1em;}.navigation{padding:20px;}}");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='nav-bar'>");
        out.println("<a href='/analytics-dashboard/' class='modern-button'>Accueil</a>");
        out.println("</div>");
        out.println("<div class='stats-container'>");
        out.println("<div class='stats-header'>");
        out.println("<h1>Statistiques en Temps Réel</h1>");
        out.println("<p>Analyse Complète des Données de Streaming</p>");
        out.println("</div>");
        out.println("<div class='stats-grid'>");
        out.println("<div class='stat-card'><div class='stat-number'>" + String.format("%,d", totalEvents) + "</div><div class='stat-label'>Événements de Vue</div></div>");
        out.println("<div class='stat-card'><div class='stat-number'>" + String.format("%,d", totalVideos) + "</div><div class='stat-label'>Catalogue Vidéos</div></div>");
        out.println("<div class='stat-card'><div class='stat-number'>" + String.format("%,d", totalUsers) + "</div><div class='stat-label'>Utilisateurs Actifs</div></div>");
        out.println("</div>");
        out.println("<div class='info-section'>");
        out.println("<div class='info-box'>");
        out.println("<h3>Informations Système</h3>");
        out.println("<p>✓ Base de données : MongoDB connectée et opérationnelle</p>");
        out.println("<p>✓ Stack technologique : Jakarta EE + JAX-RS + MongoDB</p>");
        out.println("<p>✓ Infrastructure : Docker Compose multi-conteneurs</p>");
        out.println("<p>✓ Statut : Streaming de données en temps réel actif</p>");
        out.println("</div>");
        out.println("</div>");
        out.println("<div class='navigation'>");
        out.println("<div class='nav-buttons'>");
        out.println("<a href='dashboard' class='modern-button'>Console</a>");
        out.println("<a href='/analytics-api/api/v1/analytics/health' class='modern-button' target='_blank'>API Health</a>");
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

