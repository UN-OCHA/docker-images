FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to orakili <docker@orakili.net>

# Work around s6 containing a binary called `import' which
# clashes with imagemagick. D'oh.
RUN mv /usr/bin/import /usr/bin/s6-import

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
      php5-imagick \
      php5-json \
      php5-mcrypt \
      php5-mysql \
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
      php5-xmlwriter \
      php5-zip \
      php5-zlib && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/fpm /srv/www /var/log/php && \
    mv /run_fpm /etc/services.d/fpm/run && \
    mv /etc/php5/php-fpm.conf /etc/php5/php-fpm.conf.verbose && \
    mv /php-fpm.conf /etc/php5/php-fpm.conf

RUN mv /usr/bin/import /usr/bin/im-import
RUN mv /usr/bin/s6-import /usr/bin/import

# Add php-redis from edge.
RUN apk add \
      --update-cache --allow-untrusted \
      --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
        php5-memcached php5-redis && \
    rm -rf /var/cache/apk/*

EXPOSE 9000

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
