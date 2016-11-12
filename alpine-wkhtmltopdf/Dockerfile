FROM unocha/alpine-nodejs:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV DISPLAY=:100.0
ENV PORT=3000

COPY run_node /etc/services.d/node/run

RUN apk add --update-cache \
        xvfb \
        ttf-freefont \
        fontconfig \
        dbus && \
    apk add --update-cache \
            --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
            --allow-untrusted \
        wkhtmltopdf && \
    rm -rf /var/cache/apk/*
