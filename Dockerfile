# ── Étape 1 : Compiler le projet avec Maven ──────────────────
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copier le pom.xml et les sources
COPY pom.xml .
COPY src ./src

# Compiler et créer le fichier .war
RUN mvn clean package -DskipTests

# ── Étape 2 : Déployer sur Tomcat 9 + JDK 17 ────────────────
FROM tomcat:9.0-jdk17

# Supprimer l'application par défaut de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copier le .war compilé comme application ROOT
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat écoute sur le port 8080
EXPOSE 8080

# Démarrer Tomcat
CMD ["catalina.sh", "run"]