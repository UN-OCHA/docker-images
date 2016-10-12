FROM unocha/alpine-base-nodejs:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV DST_DIR=/dst

ENTRYPOINT []

RUN apk add --update \
        rsync \
        ruby-bundler \
        build-base \
        ruby-dev \
        libffi-dev && \
    gem install --no-document \
        compass && \
    npm install -g \
        less \
        karma && \
    apk del \
        build-base \
        ruby-dev \
        libffi-dev && \
    rm -rf /var/cache/apk/*

# inherits also as volumes SRC_DIR=/src and $NODE_APP_DIR=/srv/www
VOLUME ["${DST_DIR}"]
