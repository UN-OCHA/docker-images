FROM unocha/alpine-base-mongo:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8 \
    DB_PATH=/srv/db

COPY run_mongo /tmp/

RUN mkdir -p /etc/services.d/mongo && \
    mv /tmp/run_mongo /etc/services.d/mongo/run

EXPOSE 27017

VOLUME ["${DB_PATH}"]
