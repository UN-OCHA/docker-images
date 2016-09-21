FROM unocha/alpine-base-s6:latest

MAINTAINER "Serban TEODORESCU <teodorescu.serban@gmail.com>"

RUN apk update && \
    apk add --update-cache redis && \
    rm -rf /var/cache/apk/*
