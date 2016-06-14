FROM alpine:3.3

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Default user id and group id.
# a good idea from orakili <docker@orakili.net>
ENV APPUSER_GID=4000 \
    APPUSER_UID=4000

RUN apk update && \
    apk add curl \
        nano && \
    rm -rf /var/lib/apk/* && \
    addgroup -g $APPUSER_GID -S appuser && \
    adduser -u $APPUSER_UID -s /sbin/nologin -g 'Docker App User' -h /home/appuser -D -G appuser appuser
