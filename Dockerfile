FROM eclipse-temurin:17-jdk

# Expose port 8080 to allow traffic to this port
EXPOSE 8080

# Set the environment variable for the application home directory
ENV APP_HOME=/usr/src/app

# Create the app directory (optional, but recommended for better organization)
RUN mkdir -p $APP_HOME

# Copy the jar file into the app directory
COPY target/*.jar $APP_HOME/app.jar

# Set the working directory to APP_HOME
WORKDIR $APP_HOME

# Command to run the application
CMD ["java", "-jar", "app.jar"]
