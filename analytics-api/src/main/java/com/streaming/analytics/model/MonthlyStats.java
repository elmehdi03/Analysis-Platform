package com.streaming.analytics.model;

/**
 * DTO pour les statistiques mensuelles
 */
public class MonthlyStats {
    private String month; // Format "YYYY-MM"
    private int totalViews;
    private int uniqueVisitors;
    private double retentionRate; // En pourcentage
    private double engagementRate; // En pourcentage

    // Constructeur vide
    public MonthlyStats() {
    }

    public MonthlyStats(String month, int totalViews, int uniqueVisitors, double retentionRate, double engagementRate) {
        this.month = month;
        this.totalViews = totalViews;
        this.uniqueVisitors = uniqueVisitors;
        this.retentionRate = retentionRate;
        this.engagementRate = engagementRate;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public int getTotalViews() {
        return totalViews;
    }

    public void setTotalViews(int totalViews) {
        this.totalViews = totalViews;
    }

    public int getUniqueVisitors() {
        return uniqueVisitors;
    }

    public void setUniqueVisitors(int uniqueVisitors) {
        this.uniqueVisitors = uniqueVisitors;
    }

    public double getRetentionRate() {
        return retentionRate;
    }

    public void setRetentionRate(double retentionRate) {
        this.retentionRate = retentionRate;
    }

    public double getEngagementRate() {
        return engagementRate;
    }

    public void setEngagementRate(double engagementRate) {
        this.engagementRate = engagementRate;
    }
}
