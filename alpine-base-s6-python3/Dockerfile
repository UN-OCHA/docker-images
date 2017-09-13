FROM unocha/alpine-base-s6:3.6

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apk add --update-cache \
        python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    rm -rf /var/cache/apk/*
