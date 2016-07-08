FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8

RUN apk add --update \
        mysql \
        mysql-client \
        && \
    rm -rf /var/lib/apk/*
