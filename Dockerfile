FROM openjdk:8-jre-alpine
LABEL MAINTAINER="Damien DUPORTAL <dduportal@cloudbees.com>"

COPY ./target/demoapp.jar /app/app.jar
COPY hello-world.yml /app/config.yml
EXPOSE 9000

ENTRYPOINT ["java","-jar","/app/app.jar"]
CMD ["server","/app/config.yml"]
