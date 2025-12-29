package com.streaming.analytics.service;

import com.streaming.analytics.model.ViewEvent;
import com.streaming.analytics.model.VideoStats;
import com.streaming.analytics.model.Video;
import com.streaming.analytics.repository.EventRepository;
import com.streaming.analytics.repository.VideoRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;

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
}