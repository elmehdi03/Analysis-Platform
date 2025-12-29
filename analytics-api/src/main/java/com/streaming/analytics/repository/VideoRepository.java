package com.streaming.analytics.repository;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Sorts;
import com.streaming.analytics.model.Video;
import jakarta.enterprise.context.ApplicationScoped;
import org.bson.Document;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Repository pour les vidéos utilisant MongoDB driver
 */
@ApplicationScoped
public class VideoRepository {

    private final MongoClient mongoClient;
    private final MongoDatabase database;
    private final MongoCollection<Document> collection;

    public VideoRepository() {
        this.mongoClient = MongoClients.create("mongodb://admin:admin123@mongodb:27017");
        this.database = mongoClient.getDatabase("streaming_analytics");
        this.collection = database.getCollection("videos");
    }

    /**
     * Trouve une vidéo par ID
     */
    public Video findByVideoId(String videoId) {
        Document doc = collection.find(new Document("videoId", videoId)).first();
        if (doc != null) {
            return documentToVideo(doc);
        }
        return null;
    }

    /**
     * Trouve les vidéos par catégorie
     */
    public List<Video> findByCategory(String category, int limit) {
        List<Video> videos = new ArrayList<>();
        for (Document doc : collection.find(new Document("category", category))
                .sort(Sorts.descending("views"))
                .limit(limit)) {
            videos.add(documentToVideo(doc));
        }
        return videos;
    }

    /**
     * Trouve les vidéos les plus populaires
     */
    public List<Video> findTopByViews(int limit) {
        List<Video> videos = new ArrayList<>();
        for (Document doc : collection.find()
                .sort(Sorts.descending("views"))
                .limit(limit)) {
            videos.add(documentToVideo(doc));
        }
        return videos;
    }

    /**
     * Trouve les vidéos par liste d'IDs
     */
    public List<Video> findByVideoIds(Set<String> videoIds) {
        List<Video> videos = new ArrayList<>();
        if (videoIds == null || videoIds.isEmpty()) {
            return videos;
        }
        Document query = new Document("videoId", new Document("$in", new ArrayList<>(videoIds)));
        for (Document doc : collection.find(query)) {
            videos.add(documentToVideo(doc));
        }
        return videos;
    }

    /**
     * Récupère toutes les catégories distinctes
     */
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        for (String category : collection.distinct("category", String.class)) {
            categories.add(category);
        }
        return categories;
    }

    /**
     * Trouve les vidéos par catégories multiples, excluant certaines vidéos
     */
    public List<Video> findByCategoriesExcluding(List<String> categories, Set<String> excludeVideoIds, int limit) {
        List<Video> videos = new ArrayList<>();
        if (categories == null || categories.isEmpty()) {
            return videos;
        }

        Document query = new Document("category", new Document("$in", categories));
        if (excludeVideoIds != null && !excludeVideoIds.isEmpty()) {
            query.append("videoId", new Document("$nin", new ArrayList<>(excludeVideoIds)));
        }

        for (Document doc : collection.find(query)
                .sort(Sorts.descending("views"))
                .limit(limit)) {
            videos.add(documentToVideo(doc));
        }
        return videos;
    }

    /**
     * Sauvegarde ou met à jour une vidéo
     */
    public void save(Video video) {
        Document doc = new Document("videoId", video.getVideoId())
                .append("title", video.getTitle())
                .append("category", video.getCategory())
                .append("duration", video.getDuration())
                .append("uploadDate", video.getUploadDate())
                .append("views", video.getViews())
                .append("likes", video.getLikes());

        // Upsert: replace if exists, insert otherwise
        collection.replaceOne(
                new Document("videoId", video.getVideoId()),
                doc,
                new com.mongodb.client.model.ReplaceOptions().upsert(true));
    }

    /**
     * Incrémente le nombre de vues d'une vidéo
     */
    public void incrementViews(String videoId) {
        collection.updateOne(
                new Document("videoId", videoId),
                new Document("$inc", new Document("views", 1)));
    }

    private Video documentToVideo(Document doc) {
        Video video = new Video();
        video.setVideoId(doc.getString("videoId"));
        video.setTitle(doc.getString("title"));
        video.setCategory(doc.getString("category"));
        video.setDuration(doc.getInteger("duration", 0));
        video.setUploadDate(doc.getString("uploadDate"));
        video.setViews(doc.getInteger("views", 0));
        video.setLikes(doc.getInteger("likes", 0));
        return video;
    }
}
