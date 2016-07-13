FROM unocha/alpine-base-s6:latest

MAINTAINER "Serban TEODORESCU <teodorescu.serban@gmail.com>"

RUN apk update && \
    apk add redis && \
    rm -rf /var/lib/apk/*
