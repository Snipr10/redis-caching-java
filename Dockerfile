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
FROM gradle:6.7.0-jdk8 AS TEMP_BUILD_IMAGE
ENV APP_HOME=/usr/app/
WORKDIR $APP_HOME
COPY . .

USER root

RUN gradle build --no-daemon
RUN echo $(ls)


# actual container

FROM adoptopenjdk/openjdk8:alpine

EXPOSE 8080
COPY ${JAR_FILE} app.war
ENTRYPOINT ["java","-jar","/app.war"]
