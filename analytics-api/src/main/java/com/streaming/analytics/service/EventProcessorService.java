package com.streaming.analytics.service;

import com.streaming.analytics.model.ViewEvent;
import com.streaming.analytics.model.VideoStats;
import com.streaming.analytics.model.Video;
import com.streaming.analytics.repository.EventRepository;
import com.streaming.analytics.repository.VideoRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import com.streaming.analytics.model.MonthlyStats;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.time.format.DateTimeFormatter;
import java.util.Comparator;

/**
 * Service de traitement des événements de visualisation
 */
@ApplicationScoped
public class EventProcessorService {

    private EventRepository eventRepository;
    private VideoRepository videoRepository;

    public EventProcessorService() {
        this.eventRepository = new EventRepository();
        this.videoRepository = new VideoRepository();
    }

    /**
     * Traite un événement unique
     */
    public void processEvent(ViewEvent event) {
        eventRepository.save(event);
        updateVideoStats(event);
    }

    /**
     * Traite un lot d'événements
     */
    public void processBatch(List<ViewEvent> events) {
        eventRepository.saveAll(events);
        // Mise à jour simplifiée des stats pour éviter de surcharger
        // Dans un vrai système, on utiliserait un traitement asynchrone
        for (ViewEvent event : events) {
            updateVideoStats(event);
        }
    }

    /**
     * Met à jour les statistiques d'une vidéo
     */
    private void updateVideoStats(ViewEvent event) {
        // Dans cette implémentation simple, on met à jour directement le compteur de
        // vues dans Video
        // Idéalement, on recalculerait tout de manière asynchrone
        // Ici, on fait simpliste : on incrémente juste si c'est une vue
        com.streaming.analytics.model.Video video = videoRepository.findByVideoId(event.getVideoId());
        if (video != null) {
            // Note: VideoRepository n'a pas de méthode update simple pour l'instant,
            // mais on simule le traitement.
            // Pour le TP, on se concentre sur la lecture des données.
        }
    }

    /**
     * Récupère les vidéos les plus vues
     */
    public List<VideoStats> getTopVideos(int limit) {
        List<com.streaming.analytics.model.Video> videos = videoRepository.findTopByViews(limit);
        List<VideoStats> stats = new java.util.ArrayList<>();

        for (com.streaming.analytics.model.Video v : videos) {
            stats.add(convertToStats(v));
        }
        return stats;
    }

    private VideoStats convertToStats(com.streaming.analytics.model.Video video) {
        // Calculer des stats réelles basées sur les événements
        List<ViewEvent> events = eventRepository.findByVideoId(video.getVideoId());

        long totalWatchTime = events.stream().mapToLong(ViewEvent::getDuration).sum();
        long uniqueViewers = events.stream().map(ViewEvent::getUserId).distinct().count();
        double avgWatchTime = events.isEmpty() ? 0 : (double) totalWatchTime / events.size();

        return new VideoStats(
                video.getVideoId(),
                video.getViews(),
                totalWatchTime,
                avgWatchTime,
                (int) uniqueViewers,
                java.time.LocalDateTime.now().toString());
    }

    /**
     * Récupère les statistiques d'une vidéo
     */
    public VideoStats getVideoStats(String videoId) {
        com.streaming.analytics.model.Video video = videoRepository.findByVideoId(videoId);
        if (video == null)
            return null;
        return convertToStats(video);
    }

    /**
     * Récupère la répartition des vidéos par catégorie
     */
    public java.util.Map<String, Integer> getCategoryStats() {
        java.util.Map<String, Integer> stats = new java.util.HashMap<>();
        List<String> categories = videoRepository.getAllCategories();

        // Pour faire simple, on compte en récupérant tout (pas optimal mais ok pour le
        // projet)
        // Mieux: ajouter countByCategory dans VideoRepository
        for (String cat : categories) {
            List<com.streaming.analytics.model.Video> vids = videoRepository.findByCategory(cat, 1000);
            stats.put(cat, vids.size());
        }
        return stats;
    }

    /**
     * Génère des recommandations pour un utilisateur
     */
    public List<String> getRecommendations(String userId, int limit) {
        // Délègue au RecommendationService si besoin, ou implémentation simple ici
        return List.of();
    }

    /**
     * Calcule les performances mensuelles sur les 12 derniers mois
     */
    public List<MonthlyStats> getMonthlyPerformance() {
        // 1. Récupérer les événements des 12 derniers mois
        String oneYearAgo = java.time.LocalDateTime.now().minusMonths(12).withDayOfMonth(1).toString();
        List<ViewEvent> events = eventRepository.findEventsAfter(oneYearAgo);

        // 2. Grouper par mois (YYYY-MM)
        // On extrait les 7 premiers caractères du timestamp (ex: "2023-12")
        Map<String, List<ViewEvent>> eventsByMonth = events.stream()
                .collect(Collectors.groupingBy(e -> {
                    if (e.getTimestamp() != null && e.getTimestamp().length() >= 7) {
                        return e.getTimestamp().substring(0, 7);
                    }
                    return "Unknown";
                }));

        List<MonthlyStats> stats = new java.util.ArrayList<>();

        // 3. Calculer les métriques pour chaque mois
        eventsByMonth.forEach((month, monthEvents) -> {
            if (month.equals("Unknown"))
                return;

            int views = monthEvents.size();
            long visitors = monthEvents.stream().map(ViewEvent::getUserId).distinct().count();

            // Calculer Rétention moyenne (Duration vs Target 180s arbitraire)
            double avgDuration = monthEvents.stream().mapToLong(ViewEvent::getDuration).average().orElse(0);
            double retention = Math.min(100.0, (avgDuration / 180.0) * 100.0);

            // Calculer Engagement (Ratio Visiteurs / Vues * Facteur arbitraire pour demo)
            // Dans la réalité: (Actions / Vues) ou (Durée > X / Vues)
            // Ici: On simule un taux basé sur la 'qualité' et la durée
            long highQualityViews = monthEvents.stream()
                    .filter(e -> "1080p".equals(e.getQuality()) || "4k".equals(e.getQuality())).count();
            double engagement = ((double) highQualityViews / views) * 100.0 * 0.8; // Scaling factor

            stats.add(new MonthlyStats(month, views, (int) visitors,
                    Math.round(retention * 10) / 10.0,
                    Math.round(engagement * 10) / 10.0));
        });

        // 4. Trier par mois et remplir les mois manquants si nécessaire (optionnel, ici
        // on trie juste)
        stats.sort(Comparator.comparing(MonthlyStats::getMonth));

        return stats;
    }

    /**
     * Récupère les statistiques globales (Total Vidéos, Total Événements)
     */
    public Map<String, Long> getSummaryStats() {
        Map<String, Long> stats = new java.util.HashMap<>();
        stats.put("totalVideos", videoRepository.count());
        stats.put("totalEvents", eventRepository.count());
        return stats;
    }
}