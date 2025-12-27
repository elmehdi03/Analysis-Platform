FROM tomcat:10.1-jdk17

# Supprimer les applications par défaut de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Créer le dossier webapps s'il n'existe pas
RUN mkdir -p /usr/local/tomcat/webapps

# Copier les fichiers WAR dans le dossier webapps de Tomcat
COPY analytics-api/target/analytics-api-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/analytics-api.war
COPY analytics-dashboard/target/analytics-dashboard-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/analytics-dashboard.war

# Variables d'environnement
ENV CATALINA_OPTS="-Xms512m -Xmx1024m"
ENV MONGODB_HOST=mongodb
ENV MONGODB_PORT=27017
ENV MONGODB_DATABASE=streaming_analytics
ENV MONGODB_USERNAME=admin
ENV MONGODB_PASSWORD=admin123

# Exposer le port 8080
EXPOSE 8080

# Démarrer Tomcat
CMD ["catalina.sh", "run"]

