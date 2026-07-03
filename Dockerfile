# Stage 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Deploy to Tomcat 10
FROM tomcat:10.1-jdk17
# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy our compiled WAR file as the ROOT webapp
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
