FROM unocha/alpine-base-s6:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV NODE_APP_DIR=/srv/www \
    SRC_DIR=/src \
    NEW_RELIC_HOME=/srv/ \
    NEW_RELIC_LOG_LEVEL=info \
    NEW_RELIC_LICENSE_KEY=aaa \
    NEW_RELIC_APP_NAME=nodeapp \
    NEW_RELIC_NO_CONFIG_FILE=True

RUN apk add --update-cache \
        git \
        nodejs-lts \
        && \
    rm -rf /var/cache/apk/* && \
    npm install -g \
        grunt-cli \
        bower \
        newrelic \
        && \
    mkdir -p ${SRC_DIR} ${NODE_APP_DIR} && \
    cp -a /usr/lib/node_modules/newrelic/newrelic.js ${NODE_APP_DIR}

VOLUME ["${SRC_DIR}", "${NODE_APP_DIR}"]

# mainly used to build stuff so it makes sense to use ${SRC_DIR} as WORKDIR
WORKDIR ${SRC_DIR}
