FROM unocha/alpine-php-fpm-drupal7:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to orakili <docker@orakili.net>

# Set a TERM environment for the mysql client.
ENV TERM xterm

# Install pre-built mupdf and hoedown packages.
RUN apk update && \
    apk add curl gzip tar && \
      rm -rf /var/cache/apk/*

# Download resources.
ADD resources/php-hoedown.tar.gz resources/mupdf.tar.gz /opt/

# Symlink resources.
RUN ln -s /opt/mupdf/bin/mutool /usr/bin/mudraw && \
    ln -s /opt/mupdf/bin/mutool /usr/bin/mubusy && \
    mv /opt/php/modules/hoedown.so /usr/lib/php5/modules/hoedown.so && \
    echo "extension=hoedown.so" > /etc/php5/conf.d/hoedown.ini

RUN apk del curl gzip tar && \
      rm -rf /var/cache/apk/*
RUN rm -f /tmp/mupdf.tgz /tmp/php-hoedown.tgz && \
    rm -rf /opt/php

# Volumes
# - Conf: /etc/php5/ (php.ini, php-fpm.conf, conf.d/)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
