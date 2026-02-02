FROM maven:3.9.8-eclipse-temurin-21 AS build
WORKDIR /app

COPY pom.xml mvnw mvnw.cmd ./
COPY .mvn .mvn
RUN ./mvnw -q -DskipTests dependency:go-offline

COPY src src
RUN ./mvnw -q -DskipTests -Proot package

FROM tomcat:10.1-jdk21-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
