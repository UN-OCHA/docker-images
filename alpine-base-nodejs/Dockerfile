FROM unocha/alpine-base-s6:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

COPY server.js node-run /tmp/

RUN apk update && \
    apk add git && \
    apk add nodejs==4.4.2-r0 --update-cache \
        --repository http://cdn.alpinelinux.org/alpine/edge/main && \
    rm -rf /var/lib/apk/* && \
    npm install -g grunt-cli && \
    npm install -g bower && \
    mkdir -p /srv/www /etc/services.d/node && \
    mv /tmp/node-run /etc/services.d/node/run && \
    mv /tmp/server.js /srv/www/

EXPOSE 3000

VOLUME ["/srv/www"]
