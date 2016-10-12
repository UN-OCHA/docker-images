FROM unocha/alpine-nodejs:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV PORT=3000

RUN apk add --update-cache \
        xvfb \
        ttf-freefont \
        fontconfig && \
    apk add --update-cache \
            --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
            --allow-untrusted \
        wkhtmltopdf && \
    apk add --update-cache \
        python \
        make \
        g++ && \
    npm install wkhtmltox && \
    rm -rf /var/cache/apk/*
