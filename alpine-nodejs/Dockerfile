FROM unocha/alpine-base-nodejs:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV NODE_APP_DIR=/srv/www

COPY node-run package.json server.js /

WORKDIR "${NODE_APP_DIR}"

RUN mkdir -p /srv/www /srv/example /etc/services.d/node && \
    mv /node-run /etc/services.d/node/run && \
    mv /server.js /srv/example/ && \
    mv /package.json /srv/example/

EXPOSE 3000

# mainly used to serve stuff so it makes sense to use ${NODE_APP_DIR} as WORKDIR
VOLUME ["${NODE_APP_DIR}"]
