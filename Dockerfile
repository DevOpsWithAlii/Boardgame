# ---------- Build stage ----------
FROM maven:3.8.6-eclipse-temurin-11 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

# ---------- Runtime stage ----------
FROM eclipse-temurin:11-jre-jammy

WORKDIR /app

COPY --from=build /app/target/database_service_project-0.0.4.jar app.jar

EXPOSE 8383

ENTRYPOINT ["java", "-jar", "app.jar"]
