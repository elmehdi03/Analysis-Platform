package com.streaming.analytics.service;

import com.streaming.analytics.model.Recommendation;
import com.streaming.analytics.model.Video;
import com.streaming.analytics.model.ViewEvent;
import com.streaming.analytics.repository.EventRepository;
import com.streaming.analytics.repository.VideoRepository;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Service de recommandation de vidéos
 * 
 * Utilise une approche hybride combinant:
 * 1. Filtrage par contenu (catégories préférées)
 * 2. Filtrage collaboratif (utilisateurs similaires)
 * 3. Popularité (pour les nouveaux utilisateurs)
 */
public class RecommendationService {

    private final EventRepository eventRepository;
    private final VideoRepository videoRepository;

    public RecommendationService() {
        this.eventRepository = new EventRepository();
        this.videoRepository = new VideoRepository();
    }

    /**
     * Génère des recommandations personnalisées pour un utilisateur
     */
    public List<Recommendation> getRecommendations(String userId, int limit) {
        List<Recommendation> recommendations = new ArrayList<>();

        // Récupérer l'historique de l'utilisateur
        List<ViewEvent> userHistory = eventRepository.findByUserId(userId);
        Set<String> watchedVideoIds = userHistory.stream()
                .map(ViewEvent::getVideoId)
                .collect(Collectors.toSet());

        // Si l'utilisateur n'a pas d'historique, retourner les vidéos populaires
        if (userHistory.isEmpty()) {
            return getPopularRecommendations(limit);
        }

        // Stratégie hybride: combiner différentes approches
        int categoryLimit = (int) Math.ceil(limit * 0.6); // 60% basé sur les catégories
        int collaborativeLimit = (int) Math.ceil(limit * 0.3); // 30% collaboratif
        // Le reste sera complété avec des vidéos populaires si nécessaire

        // 1. Recommandations basées sur les catégories préférées
        List<Recommendation> categoryBased = getCategoryBasedRecommendations(
                userHistory, watchedVideoIds, categoryLimit);
        recommendations.addAll(categoryBased);

        // 2. Recommandations collaboratives (utilisateurs similaires)
        Set<String> alreadyRecommended = recommendations.stream()
                .map(Recommendation::getVideoId)
                .collect(Collectors.toSet());
        alreadyRecommended.addAll(watchedVideoIds);

        List<Recommendation> collaborative = getCollaborativeRecommendations(
                userId, watchedVideoIds, alreadyRecommended, collaborativeLimit);
        recommendations.addAll(collaborative);

        // 3. Compléter avec des vidéos populaires si nécessaire
        if (recommendations.size() < limit) {
            alreadyRecommended = recommendations.stream()
                    .map(Recommendation::getVideoId)
                    .collect(Collectors.toSet());
            alreadyRecommended.addAll(watchedVideoIds);

            List<Recommendation> popular = getPopularRecommendations(
                    limit - recommendations.size(), alreadyRecommended);
            recommendations.addAll(popular);
        }

        // Trier par score et limiter
        return recommendations.stream()
                .sorted(Comparator.comparingDouble(Recommendation::getScore).reversed())
                .limit(limit)
                .collect(Collectors.toList());
    }

    /**
     * Recommandations basées sur les catégories préférées de l'utilisateur
     */
    private List<Recommendation> getCategoryBasedRecommendations(
            List<ViewEvent> userHistory, Set<String> watchedVideoIds, int limit) {

        List<Recommendation> recommendations = new ArrayList<>();

        // Compter les vues par catégorie
        Map<String, Integer> categoryViewCounts = new HashMap<>();
        for (ViewEvent event : userHistory) {
            Video video = videoRepository.findByVideoId(event.getVideoId());
            if (video != null && video.getCategory() != null) {
                categoryViewCounts.merge(video.getCategory(), 1, Integer::sum);
            }
        }

        if (categoryViewCounts.isEmpty()) {
            return recommendations;
        }

        // Trier les catégories par nombre de vues
        List<Map.Entry<String, Integer>> sortedCategories = categoryViewCounts.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .collect(Collectors.toList());

        int totalViews = categoryViewCounts.values().stream().mapToInt(Integer::intValue).sum();

        // Récupérer des vidéos de chaque catégorie préférée
        for (Map.Entry<String, Integer> entry : sortedCategories) {
            String category = entry.getKey();
            double categoryWeight = (double) entry.getValue() / totalViews;
            int categoryLimit = Math.max(1, (int) Math.ceil(limit * categoryWeight));

            List<Video> categoryVideos = videoRepository.findByCategory(category, categoryLimit * 2);

            for (Video video : categoryVideos) {
                if (!watchedVideoIds.contains(video.getVideoId()) &&
                        recommendations.stream().noneMatch(r -> r.getVideoId().equals(video.getVideoId()))) {

                    double score = 0.8 * categoryWeight + 0.2 * normalizeViews(video.getViews());
                    String reason = "Based on your interest in " + category;

                    recommendations.add(Recommendation.fromVideo(video, score, reason));

                    if (recommendations.size() >= limit) {
                        break;
                    }
                }
            }

            if (recommendations.size() >= limit) {
                break;
            }
        }

        return recommendations;
    }

    /**
     * Recommandations basées sur le filtrage collaboratif
     * Trouve des utilisateurs avec un historique similaire et recommande leurs
     * vidéos
     */
    private List<Recommendation> getCollaborativeRecommendations(
            String userId, Set<String> watchedVideoIds, Set<String> excludeVideoIds, int limit) {

        List<Recommendation> recommendations = new ArrayList<>();

        if (watchedVideoIds.isEmpty()) {
            return recommendations;
        }

        // Pour chaque vidéo regardée, trouver les autres utilisateurs
        Map<String, Integer> similarUserScores = new HashMap<>();

        for (String videoId : watchedVideoIds) {
            List<ViewEvent> videoEvents = eventRepository.findByVideoId(videoId);
            for (ViewEvent event : videoEvents) {
                if (!event.getUserId().equals(userId)) {
                    similarUserScores.merge(event.getUserId(), 1, Integer::sum);
                }
            }
        }

        // Trier les utilisateurs par similarité (nombre de vidéos en commun)
        List<String> similarUsers = similarUserScores.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .limit(10) // Top 10 utilisateurs similaires
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());

        // Récupérer les vidéos regardées par les utilisateurs similaires
        Map<String, Double> videoScores = new HashMap<>();
        for (int i = 0; i < similarUsers.size(); i++) {
            String similarUserId = similarUsers.get(i);
            double userWeight = 1.0 / (i + 1); // Les utilisateurs plus similaires ont plus de poids

            List<ViewEvent> similarUserEvents = eventRepository.findByUserId(similarUserId);
            for (ViewEvent event : similarUserEvents) {
                String videoId = event.getVideoId();
                if (!excludeVideoIds.contains(videoId)) {
                    videoScores.merge(videoId, userWeight, Double::sum);
                }
            }
        }

        // Trier et créer les recommandations
        List<Map.Entry<String, Double>> sortedVideos = videoScores.entrySet().stream()
                .sorted(Map.Entry.<String, Double>comparingByValue().reversed())
                .limit(limit)
                .collect(Collectors.toList());

        double maxScore = sortedVideos.isEmpty() ? 1.0 : sortedVideos.get(0).getValue();

        for (Map.Entry<String, Double> entry : sortedVideos) {
            Video video = videoRepository.findByVideoId(entry.getKey());
            if (video != null) {
                double normalizedScore = 0.7 * (entry.getValue() / maxScore);
                String reason = "Viewers like you also watched this";
                recommendations.add(Recommendation.fromVideo(video, normalizedScore, reason));
            }
        }

        return recommendations;
    }

    /**
     * Recommandations basées sur la popularité (pour les nouveaux utilisateurs)
     */
    public List<Recommendation> getPopularRecommendations(int limit) {
        return getPopularRecommendations(limit, Collections.emptySet());
    }

    private List<Recommendation> getPopularRecommendations(int limit, Set<String> excludeVideoIds) {
        List<Recommendation> recommendations = new ArrayList<>();
        List<Video> popularVideos = videoRepository.findTopByViews(limit + excludeVideoIds.size());

        for (Video video : popularVideos) {
            if (!excludeVideoIds.contains(video.getVideoId())) {
                double score = 0.5 * normalizeViews(video.getViews());
                String reason = "Trending now";
                recommendations.add(Recommendation.fromVideo(video, score, reason));

                if (recommendations.size() >= limit) {
                    break;
                }
            }
        }

        return recommendations;
    }

    /**
     * Normalise le nombre de vues entre 0 et 1
     */
    private double normalizeViews(int views) {
        // Log normalization pour éviter que les grosses valeurs dominent
        return Math.min(1.0, Math.log10(views + 1) / 6.0); // 10^6 = 1M vues = score 1.0
    }
}
