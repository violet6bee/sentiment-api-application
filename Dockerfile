# Stage 1: Build with Maven
FROM maven:3.9.5-eclipse-temurin-21 AS builder

WORKDIR /app

# Копируем pom и исходники
COPY pom.xml .
COPY src ./src

# Сборка jar без тестов
RUN mvn -DskipTests package

# Stage 2: Runtime
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Копируем jar из билд-стадии
COPY --from=builder /app/target/*.jar sentiment-api.jar

# Создание non-root пользователя
RUN addgroup -S appgroup && adduser -S appuser -G appgroup && \
    chown -R appuser:appgroup /app
USER appuser

EXPOSE 8080

# Запуск Spring Boot приложения
CMD ["java", "-jar", "sentiment-api.jar"]
