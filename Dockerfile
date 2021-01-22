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
FROM gradle:6.8.0-jdk11-openj9

WORKDIR /usr/src/app/

RUN pwd

COPY . .


RUN echo $(ls)
RUN echo $(ls)

RUN gradle build --no-daemon

RUN echo $(ls)

EXPOSE 5000
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app1.jar"]
ENTRYPOINT ["java","-jar","build/libs/redis-caching-java-0.0.1-SNAPSHOT.jar"]