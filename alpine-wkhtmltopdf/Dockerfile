FROM unocha/nodejs:8.11.3

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV PORT=3000

COPY wrapper /tmp/

RUN apk add --update-cache \
        xvfb \
        dbus \
        ttf-freefont \
        fontconfig && \
    apk add --update-cache \
            --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
            --allow-untrusted \
        wkhtmltopdf && \
    apk add --update-cache \
        python \
        make \
        g++ && \
    npm install wkhtmltox && \
    rm -rf /var/cache/apk/* && \
    mv /tmp/wrapper /usr/bin/service-wrapper && \
    chmod +x /usr/bin/service-wrapper
