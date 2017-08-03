FROM unocha/alpine-base-s6:3.6

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV NODE_APP_DIR=/srv/www \
    NODE_PATH=/usr/lib/node_modules \
    NPM_CONFIG_SPIN=false \
    NPM_CONFIG_PROGRESS=false \
    SRC_DIR=/src \
    NEW_RELIC_HOME=/srv/ \
    NEW_RELIC_LOG_LEVEL=info \
    NEW_RELIC_LICENSE_KEY=aaa \
    NEW_RELIC_APP_NAME=nodeapp \
    NEW_RELIC_NO_CONFIG_FILE=True

RUN apk add --update-cache \
        git && \
    apk add --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
        nodejs \
        nodejs-npm && \
    rm -rf /var/cache/apk/* && \
    npm install -g \
        grunt-cli \
        bower \
        newrelic \
        webpack \
        yarn && \
    npm cache clean && \
    rm -rf /tmp && \
    mkdir -p /tmp && \
    chmod 1777 /tmp && \
    mkdir -p ${SRC_DIR} ${NODE_APP_DIR} && \
    cp -a /usr/lib/node_modules/newrelic/newrelic.js /srv

#define the volumes at run time - far better
#VOLUME ["${SRC_DIR}", "${NODE_APP_DIR}"]

# mainly used to build stuff so it makes sense to use ${SRC_DIR} as WORKDIR
# but we let the downstream images to decide
#WORKDIR ${SRC_DIR}
