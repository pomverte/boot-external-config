# build stage application packaging
FROM maven:3.5-jdk-8-slim AS build
WORKDIR /work

COPY pom.xml .
RUN mvn --batch-mode dependency:resolve

COPY src ./src
RUN mvn --batch-mode clean package

# build stage server
FROM openjdk:8-jdk-alpine3.7

LABEL fr.gouv.education.men.sirh.service=boot-external-config
LABEL fr.gouv.education.men.sirh.maintainer=hong.viet.ext@numerilab.education

EXPOSE 8080
RUN adduser java -h / -D

COPY --from=build /work/target/boot-external-config*.jar /boot-external-config.jar
RUN chown java /boot-external-config.jar
RUN sh -c 'touch /boot-external-config.jar'

USER java

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/boot-external-config.jar"]
