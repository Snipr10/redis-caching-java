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
COPY build.gradle settings.gradle $APP_HOME

COPY gradle $APP_HOME/gradle
COPY --chown=gradle:gradle . /home/gradle/src
USER root
RUN chown -R gradle /home/gradle/src

RUN gradle build || return 0
COPY . .
RUN gradle clean build

# actual container

FROM adoptopenjdk/openjdk8:alpine
ENV ARTIFACT_NAME=redis-caching-java-0.0.1-SNAPSHOT.war
ENV APP_HOME=/usr/app/

WORKDIR $APP_HOME
COPY --from=TEMP_BUILD_IMAGE $APP_HOME/build/libs/$ARTIFACT_NAME .

EXPOSE 8080
ENTRYPOINT exec java -jar ${ARTIFACT_NAME}