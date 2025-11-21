# Stage 1: Build
FROM maven:3.9.5-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -DskipTests package

# Stage 2: Minimal runtime
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar sentiment-api.jar

EXPOSE 8080

CMD ["java", "-jar", "sentiment-api.jar"]
