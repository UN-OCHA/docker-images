FROM unocha/alpine-base-s6:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

COPY node-run /tmp/

ENV NODE_APP_DIR /srv/www

RUN apk update && \
    apk add --update \
        git \
        nodejs-lts \
        && \
    rm -rf /var/lib/apk/* && \
    npm install -g
        grunt-cli \
        bower \
        && \
    mkdir -p /srv/www /etc/services.d/node && \
    mv /tmp/node-run /etc/services.d/node/run

EXPOSE 3000

VOLUME ["/srv/www"]
