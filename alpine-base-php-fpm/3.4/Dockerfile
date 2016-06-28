FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to orakili <docker@orakili.net>

COPY php-fpm.conf run_fpm /

RUN apk update && \
    apk add \
      php5-bcmath \
      php5-bz2 \
      php5-ctype \
      php5-curl \
      php5-dom \
      php5-fpm \
      php5-gd \
      php5-iconv \
      php5-json \
      php5-mcrypt \
      php5-memcache \
      php5-opcache \
      php5-openssl \
      php5-pdo \
      php5-pdo_mysql \
      php5-pdo_pgsql \
      php5-phar \
      php5-posix \
      php5-sockets \
      php5-xml \
      php5-xmlreader \
      php5-zip \
      php5-zlib && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/fpm /srv/www /var/log/php && \
    mv /run_fpm /etc/services.d/fpm/run && \
    mv /etc/php5/php-fpm.conf /etc/php5/php-fpm.conf.verbose && \
    mv /php-fpm.conf /etc/php5/php-fpm.conf

# Add php-redis from edge.
RUN apk add \
      --update-cache --allow-untrusted \
      --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
        php-redis && \
    rm -rf /var/cache/apk/*

# Redis installs to the wrong spot. Oops.
RUN mv /etc/php/conf.d/redis.ini /etc/php5/conf.d/redis.ini && \
    rmdir /etc/php/conf.d /etc/php && \
    mv /usr/lib/php/modules/redis.so /usr/lib/php5/modules/redis.so && \
    rmdir /usr/lib/php/modules /usr/lib/php

EXPOSE 9000

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
