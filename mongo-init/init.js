// MongoDB Initialization Script for Streaming Analytics Platform

// Create database and collections
db = db.getSiblingDB('streaming_analytics');

// Create events collection with indexes
db.createCollection('events');
db.events.createIndex({ "timestamp": -1 });
db.events.createIndex({ "videoId": 1 });
db.events.createIndex({ "userId": 1 });
db.events.createIndex({ "eventType": 1 });
db.events.createIndex({ "userId": 1, "videoId": 1 }); // Composite index for recommendations

// Create videos collection with indexes
db.createCollection('videos');
db.videos.createIndex({ "videoId": 1 }, { unique: true });
db.videos.createIndex({ "category": 1 });

// Create users collection with indexes
db.createCollection('users');
db.users.createIndex({ "userId": 1 }, { unique: true });

// Create analytics collection for aggregated data
db.createCollection('analytics');
db.analytics.createIndex({ "videoId": 1 });
db.analytics.createIndex({ "date": -1 });

print('MongoDB initialized successfully for streaming_analytics database');

