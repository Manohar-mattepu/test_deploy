FROM openjdk:17
COPY target/java-k8s-app-1.0.0.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]