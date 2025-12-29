package com.streaming.analytics.api;

import com.streaming.analytics.model.Recommendation;
import com.streaming.analytics.model.ViewEvent;
import com.streaming.analytics.model.VideoStats;
import com.streaming.analytics.service.EventProcessorService;
import com.streaming.analytics.service.RecommendationService;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;
import java.util.Map;

/**
 * API REST pour l'ingestion et l'analyse des événements de visualisation
 * 
 * EXEMPLE DE CODE FONCTIONNEL - À ADAPTER ET COMPLÉTER
 * 
 * Ce fichier montre la structure de base de l'API REST.
 * Les étudiants doivent :
 * 1. Implémenter les méthodes manquantes
 * 2. Ajouter la gestion d'erreurs
 * 3. Optimiser les performances
 * 4. Ajouter la validation des données
 */
@Path("/api/v1/analytics")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AnalyticsResource {

    // Service de recommandation (instancié manuellement car CDI non configuré)
    private final RecommendationService recommendationService;
    private final EventProcessorService eventProcessorService;

    public AnalyticsResource() {
        this.recommendationService = new RecommendationService();
        this.eventProcessorService = new EventProcessorService();
    }

    /**
     * Test endpoint simple
     * GET /api/v1/analytics/test
     */
    @GET
    @Path("/test")
    public Response test() {
        return Response.ok("API is working!").build();
    }

    /**
     * Health check de l'API
     * GET /api/v1/analytics/health
     */
    @GET
    @Path("/health")
    @Produces(MediaType.TEXT_HTML)
    public Response healthCheck() {
        String html = "<!DOCTYPE html>" +
                "<html lang='fr'>" +
                "<head>" +
                "    <meta charset='UTF-8'>" +
                "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
                "    <title>API Health - DataFlow Analytics</title>" +
                "    <link href='https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap' rel='stylesheet'>"
                +
                "    <style>" +
                "        * { margin: 0; padding: 0; box-sizing: border-box; }" +
                "        body {" +
                "            font-family: 'Space Grotesk', 'Inter', sans-serif;" +
                "            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);" +
                "            color: #f8fafc;" +
                "            min-height: 100vh;" +
                "            display: flex;" +
                "            align-items: center;" +
                "            justify-content: center;" +
                "            padding: 20px;" +
                "            position: relative;" +
                "        }" +
                "        body::before {" +
                "            content: '';" +
                "            position: fixed;" +
                "            top: -50%; left: -50%;" +
                "            width: 200%; height: 200%;" +
                "            background: radial-gradient(circle at 30% 40%, rgba(6, 182, 212, 0.08) 0%, transparent 50%),"
                +
                "                        radial-gradient(circle at 70% 60%, rgba(249, 115, 22, 0.08) 0%, transparent 50%);"
                +
                "            animation: rotate 20s linear infinite;" +
                "            pointer-events: none;" +
                "            z-index: 0;" +
                "        }" +
                "        @keyframes rotate {" +
                "            0% { transform: rotate(0deg); }" +
                "            100% { transform: rotate(360deg); }" +
                "        }" +
                "        .health-container {" +
                "            max-width: 600px;" +
                "            width: 100%;" +
                "            background: rgba(30, 41, 59, 0.6);" +
                "            border: 1px solid #475569;" +
                "            border-radius: 24px;" +
                "            padding: 50px;" +
                "            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);" +
                "            backdrop-filter: blur(20px);" +
                "            text-align: center;" +
                "            position: relative;" +
                "            z-index: 1;" +
                "        }" +
                "        h1 {" +
                "            font-size: 2.5em;" +
                "            font-weight: 700;" +
                "            margin-bottom: 30px;" +
                "            background: linear-gradient(90deg, #10b981 0%, #14b8a6 100%);" +
                "            -webkit-background-clip: text;" +
                "            -webkit-text-fill-color: transparent;" +
                "            background-clip: text;" +
                "        }" +
                "        .status-indicator {" +
                "            width: 80px;" +
                "            height: 80px;" +
                "            background: linear-gradient(135deg, #10b981 0%, #14b8a6 100%);" +
                "            border-radius: 50%;" +
                "            margin: 0 auto 30px;" +
                "            display: flex;" +
                "            align-items: center;" +
                "            justify-content: center;" +
                "            font-size: 3em;" +
                "            box-shadow: 0 0 30px rgba(20, 184, 166, 0.5);" +
                "            animation: pulse 2s infinite;" +
                "        }" +
                "        @keyframes pulse {" +
                "            0%, 100% { box-shadow: 0 0 30px rgba(20, 184, 166, 0.5); transform: scale(1); }" +
                "            50% { box-shadow: 0 0 50px rgba(20, 184, 166, 0.7); transform: scale(1.05); }" +
                "        }" +
                "        .info-grid {" +
                "            display: grid;" +
                "            gap: 20px;" +
                "            margin: 30px 0;" +
                "        }" +
                "        .info-item {" +
                "            background: rgba(30, 41, 59, 0.6);" +
                "            border: 1px solid #475569;" +
                "            border-radius: 12px;" +
                "            padding: 20px;" +
                "            backdrop-filter: blur(10px);" +
                "            position: relative;" +
                "            overflow: hidden;" +
                "        }" +
                "        .info-item::before {" +
                "            content: '';" +
                "            position: absolute;" +
                "            top: 0; left: 0;" +
                "            width: 4px; height: 100%;" +
                "            background: linear-gradient(180deg, #06b6d4, #f97316);" +
                "        }" +
                "        .info-label {" +
                "            color: #94a3b8;" +
                "            font-size: 0.85em;" +
                "            margin-bottom: 8px;" +
                "            text-transform: uppercase;" +
                "            letter-spacing: 1px;" +
                "            font-family: 'Inter', sans-serif;" +
                "        }" +
                "        .info-value {" +
                "            color: #f8fafc;" +
                "            font-size: 1.3em;" +
                "            font-weight: 600;" +
                "        }" +
                "        .back-button {" +
                "            display: inline-block;" +
                "            background: linear-gradient(90deg, #06b6d4 0%, #14b8a6 100%);" +
                "            color: #0f172a;" +
                "            padding: 14px 32px;" +
                "            text-decoration: none;" +
                "            border-radius: 8px;" +
                "            font-weight: 600;" +
                "            letter-spacing: 0.5px;" +
                "            transition: all 0.3s ease;" +
                "            box-shadow: 0 8px 24px rgba(6, 182, 212, 0.3);" +
                "            margin-top: 20px;" +
                "        }" +
                "        .back-button:hover {" +
                "            transform: translateY(-2px);" +
                "            box-shadow: 0 12px 32px rgba(6, 182, 212, 0.4);" +
                "        }" +
                "    </style>" +
                "</head>" +
                "<body>" +
                "    <div class='health-container'>" +
                "        <div class='status-indicator'>✓</div>" +
                "        <h1>Système Opérationnel</h1>" +
                "        <div class='info-grid'>" +
                "            <div class='info-item'>" +
                "                <div class='info-label'>Statut</div>" +
                "                <div class='info-value'>Actif & Opérationnel</div>" +
                "            </div>" +
                "            <div class='info-item'>" +
                "                <div class='info-label'>Service</div>" +
                "                <div class='info-value'>Analytics API</div>" +
                "            </div>" +
                "            <div class='info-item'>" +
                "                <div class='info-label'>Horodatage</div>" +
                "                <div class='info-value'>" + java.time.LocalDateTime.now().toString() + "</div>" +
                "            </div>" +
                "        </div>" +
                "        <a href='/analytics-dashboard/' class='back-button'>← Retour au Dashboard</a>" +
                "    </div>" +
                "</body>" +
                "</html>";

        return Response.ok()
                .entity(html)
                .build();
    }

    /**
     * ENDPOINT 1 : Ingestion d'un événement unique
     * POST /api/v1/analytics/events
     *
     * À COMPLÉTER PAR LES ÉTUDIANTS
     *
     * Objectifs :
     * - Accepter un événement ViewEvent en JSON
     * - Le valider et l'insérer dans MongoDB
     * - Retourner un accusé de réception
     */
    @POST
    @Path("/events")
    public Response ingestEvent(ViewEvent event) {
        try {
            eventProcessorService.processEvent(event);

            return Response.status(Response.Status.CREATED)
                    .entity("{\"message\":\"Event ingested successfully\"}")
                    .build();

        } catch (Exception e) {
            // TODO: Améliorer la gestion d'erreurs
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"error\":\"" + e.getMessage() + "\"}")
                    .build();
        }
    }

    /**
     * ENDPOINT 2 : Ingestion batch (lot d'événements)
     * POST /api/v1/analytics/events/batch
     * 
     * À COMPLÉTER PAR LES ÉTUDIANTS
     * 
     * Objectifs :
     * - Accepter une liste d'événements
     * - Insérer en batch pour optimiser les performances
     * - Retourner le nombre d'événements traités
     */
    @POST
    @Path("/events/batch")
    public Response ingestBatch(List<ViewEvent> events) {
        try {
            eventProcessorService.processBatch(events);
            return Response.ok("{\"message\":\"Batch processed\", \"count\":" + events.size() + "}").build();
        } catch (Exception e) {
            return Response.serverError().entity("{\"error\":\"" + e.getMessage() + "\"}").build();
        }
    }

    /**
     * ENDPOINT 3 : Top vidéos les plus vues
     * GET /api/v1/analytics/videos/top?limit=10
     * 
     * À COMPLÉTER PAR LES ÉTUDIANTS
     */
    @GET
    @Path("/videos/top")
    public Response getTopVideos(@QueryParam("limit") @DefaultValue("10") int limit) {
        try {
            List<VideoStats> stats = eventProcessorService.getTopVideos(limit);
            return Response.ok(stats).build();
        } catch (Exception e) {
            return Response.serverError().entity("{\"error\":\"" + e.getMessage() + "\"}").build();
        }
    }

    /**
     * ENDPOINT 4 : Statistiques pour une vidéo spécifique
     * GET /api/v1/analytics/videos/{videoId}/stats
     * 
     * À COMPLÉTER PAR LES ÉTUDIANTS
     */
    @GET
    @Path("/videos/{videoId}/stats")
    public Response getVideoStats(@PathParam("videoId") String videoId) {
        try {
            VideoStats stats = eventProcessorService.getVideoStats(videoId);
            if (stats == null) {
                return Response.status(Response.Status.NOT_FOUND).build();
            }
            return Response.ok(stats).build();
        } catch (Exception e) {
            return Response.serverError().entity("{\"error\":\"" + e.getMessage() + "\"}").build();
        }
    }

    /**
     * ENDPOINT 6 : Statistiques par catégorie (pour graphiques)
     * GET /api/v1/analytics/categories/stats
     */
    @GET
    @Path("/categories/stats")
    public Response getCategoryStats() {
        try {
            Map<String, Integer> stats = eventProcessorService.getCategoryStats();
            return Response.ok(stats).build();
        } catch (Exception e) {
            return Response.serverError().entity("{\"error\":\"" + e.getMessage() + "\"}").build();
        }
    }

    /**
     * ENDPOINT 5 : Recommandations personnalisées
     * GET /api/v1/analytics/users/{userId}/recommendations?limit=5
     * 
     * Retourne des recommandations personnalisées basées sur:
     * - Les catégories préférées de l'utilisateur
     * - Les vidéos regardées par des utilisateurs similaires
     * - Les vidéos populaires (pour les nouveaux utilisateurs)
     */
    @GET
    @Path("/users/{userId}/recommendations")
    public Response getRecommendations(
            @PathParam("userId") String userId,
            @QueryParam("limit") @DefaultValue("5") int limit) {
        try {
            // Validation des paramètres
            if (userId == null || userId.trim().isEmpty()) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity("{\"error\":\"userId is required\"}")
                        .build();
            }

            if (limit < 1 || limit > 50) {
                limit = 5; // Valeur par défaut si hors limites
            }

            // Générer les recommandations
            List<Recommendation> recommendations = recommendationService.getRecommendations(userId, limit);

            return Response.ok(recommendations).build();

        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"error\":\"" + e.getMessage() + "\"}")
                    .build();
        }
    }

    /**
     * BONUS : Streaming temps réel avec Server-Sent Events
     * GET /api/v1/analytics/realtime/stream
     *
     * AVANCÉ - Optionnel
     */
    // @GET
    // @Path("/realtime/stream")
    // @Produces(MediaType.SERVER_SENT_EVENTS)
    // public void streamRealtime(@Context SseEventSink sseEventSink, @Context Sse
    // sse) {
    // // TODO: Implémenter le streaming SSE
    // // Envoyer des stats toutes les 2 secondes
    // }
    /**
     * ENDPOINT UTILITAIRE : Seed de données
     * POST /api/v1/analytics/seed
     */
    @POST
    @Path("/seed")
    public Response seedData() {
        try {
            // Créer le repository de vidéos manuellement (hack CDI)
            com.streaming.analytics.repository.VideoRepository videoRepo = new com.streaming.analytics.repository.VideoRepository();
            com.streaming.analytics.repository.EventRepository eventRepo = new com.streaming.analytics.repository.EventRepository();

            // 1. Générer des vidéos
            String[] categories = { "Technologie", "Gaming", "Musique", "Vlog", "Éducation", "Sport" };
            for (int i = 1; i <= 30; i++) {
                com.streaming.analytics.model.Video v = new com.streaming.analytics.model.Video();
                v.setVideoId("vid_" + i);
                String cat = categories[i % categories.length];
                v.setTitle("Vidéo " + cat + " #" + i);
                v.setCategory(cat);
                v.setDuration(120 + (i * 10)); // Durée variable
                v.setUploadDate(java.time.LocalDateTime.now().minusDays(i).toString());
                v.setViews(1000 * i + (int) (Math.random() * 500)); // Vues significatives
                v.setLikes(v.getViews() / 10);

                videoRepo.save(v);
            }

            // 2. Générer quelques événements de vue pour les stats temps réel
            for (int i = 0; i < 50; i++) {
                ViewEvent event = new ViewEvent();
                event.setVideoId("vid_" + (i % 10 + 1));
                event.setUserId("user_" + (i % 5 + 1));
                event.setTimestamp(java.time.LocalDateTime.now().toString());
                event.setDuration(30 + (int) (Math.random() * 200));
                eventRepo.save(event);
            }

            return Response.ok("{\"message\":\"Database populated with seed data!\"}").build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.serverError().entity("{\"error\":\"" + e.getMessage() + "\"}").build();
        }
    }

}
