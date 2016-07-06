FROM unocha/alpine-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apk add --no-cache \
        python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    rm -rf /var/lib/apk/*
