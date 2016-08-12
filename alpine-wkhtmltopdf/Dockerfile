FROM unocha/alpine-nodejs:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

RUN apk add --no-cache --update \
        xvfb \
        ttf-freefont \
        fontconfig && \
    apk add --update-cache \
            --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
            --allow-untrusted \
        wkhtmltopdf && \
    apk add --no-cache --update \
        python \
        make \
        g++ && \
    npm install wkhtmltox
