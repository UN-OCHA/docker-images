FROM unocha/alpine-base-s6:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV NODE_APP_DIR=/srv/www \
    SRC_DIR=/src

RUN apk add --update-cache \
        git \
        nodejs-lts \
        && \
    rm -rf /var/cache/apk/* && \
    npm install -g \
        grunt-cli \
        bower \
        && \
    mkdir -p ${SRC_DIR} ${NODE_APP_DIR}

VOLUME ["${SRC_DIR}", "${NODE_APP_DIR}"]

# mainly used to build stuff so it makes sense to use ${SRC_DIR} as WORKDIR
WORKDIR ${SRC_DIR}
