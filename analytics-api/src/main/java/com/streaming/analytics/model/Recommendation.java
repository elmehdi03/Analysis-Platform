package com.streaming.analytics.model;

/**
 * Entité représentant une recommandation de vidéo
 */
public class Recommendation {

    private String videoId;
    private String title;
    private String category;
    private double score;
    private String reason;

    // Constructors
    public Recommendation() {
    }

    public Recommendation(String videoId, String title, String category, double score, String reason) {
        this.videoId = videoId;
        this.title = title;
        this.category = category;
        this.score = score;
        this.reason = reason;
    }

    // Static factory method for easy creation from Video
    public static Recommendation fromVideo(Video video, double score, String reason) {
        return new Recommendation(
                video.getVideoId(),
                video.getTitle(),
                video.getCategory(),
                score,
                reason);
    }

    // Getters and Setters
    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    @Override
    public String toString() {
        return "Recommendation{" +
                "videoId='" + videoId + '\'' +
                ", title='" + title + '\'' +
                ", category='" + category + '\'' +
                ", score=" + score +
                ", reason='" + reason + '\'' +
                '}';
    }
}
