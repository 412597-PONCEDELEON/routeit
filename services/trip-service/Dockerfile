FROM maven:3.9-eclipse-temurin-21-alpine AS build
WORKDIR /workspace
COPY pom.xml .
COPY services/discovery-server/pom.xml services/discovery-server/
COPY services/config-server/pom.xml services/config-server/
COPY services/api-gateway/pom.xml services/api-gateway/
COPY services/user-service/pom.xml services/user-service/
COPY services/trip-service/pom.xml services/trip-service/
COPY services/stops-service/pom.xml services/stops-service/
COPY services/subscription-service/pom.xml services/subscription-service/
COPY services/groups-service/pom.xml services/groups-service/
COPY services/stats-service/pom.xml services/stats-service/
RUN mvn dependency:go-offline -pl services/trip-service -am -q
COPY services/trip-service/src services/trip-service/src
RUN mvn -pl services/trip-service -am package -DskipTests -q

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /workspace/services/trip-service/target/trip-service-*.jar app.jar
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "app.jar"]
