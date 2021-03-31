#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package install -X

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build Doc/target/First-web-app.war /usr/local/lib/demo.war
EXPOSE 8085
ENTRYPOINT ["java","-war","/usr/local/lib/demo.war"]
