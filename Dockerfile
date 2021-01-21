# Use an official Python image.
# https://hub.docker.com/_/python
FROM pierrevincent/gradle-java8

WORKDIR /usr/src/app/

RUN pwd

COPY . .

RUN gradle build || return 0

EXPOSE 8080
ENTRYPOINT exec java -jar build/libs/redis-caching-java-0.0.1-SNAPSHOT.war