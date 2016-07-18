FROM unocha/alpine-base-mongo:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8

COPY run_mongo /

RUN mkdir -p /etc/services.d/mongo && \
    mv /run_mongo /etc/services.d/mongo/run

EXPOSE 27017

VOLUME ["/srv/db"]
