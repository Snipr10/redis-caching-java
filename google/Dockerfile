## Use an official Python image.
## https://hub.docker.com/_/python
#FROM pierrevincent/gradle-java8

#WORKDIR /usr/src/app/

#RUN pwd

#COPY . .


## Copy local code to the container image.

## Service must listen to $PORT environment variable.
## This default value facilitates local development.


## Setting this ensures print statements and log messages
## promptly appear in Cloud Logging.


#CMD exec python3 manage.py runserver 0.0.0.0:$PORT
FROM gradle:5.3.0-jdk-alpine AS TEMP_BUILD_IMAGE
ENV APP_HOME=/usr/app/
WORKDIR $APP_HOME
COPY . .

USER root
RUN echo $(ls)

RUN gradle build --no-daemon
RUN echo $(ls)

COPY --from=TEMP_BUILD_IMAGE $APP_HOME/build/libs/*.war /app/spring-boot-application.war

# actual container

FROM adoptopenjdk/openjdk8:alpine

EXPOSE 8080

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.war /app/spring-boot-application.war

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/spring-boot-application.war"]