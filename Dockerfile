# Build Stage
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code and package the application
COPY src ./src
RUN mvn clean package

# Run Stage
FROM tomcat:10.1-jdk21

# Remove the default ROOT app provided by Tomcat
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the generated WAR file into the Tomcat webapps directory as ROOT.war
# This ensures the app is accessible at the root URL (/) instead of (/fashionstore)
COPY --from=build /app/target/fashionstore.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
