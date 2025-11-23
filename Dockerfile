# ---------- Stage 1: Build ----------
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
RUN ./mvnw dependency:go-offline

COPY src ./src
RUN ./mvnw package -DskipTests

# ---------- Stage 2: Runtime ----------
FROM eclipse-temurin:21-jre AS runtime

WORKDIR /app

# Уменьшаем размер
ENV JAVA_OPTS="--enable-preview"

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]