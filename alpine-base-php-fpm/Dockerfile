FROM unocha/alpine-base-s6

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# inspiration: orakili <docker@orakili.net>

COPY php-fpm.conf run_fpm /

# Install php.
RUN apk --update add \
      php-bcmath \
      php-cli \
      php-ctype \
      php-curl \
      php-dom \
      php-fpm \
      php-gd \
      php-iconv \
      php-json \
      php-mcrypt \
      php-posix \
      php-opcache \
      php-openssl \
      php-pdo \
      php-phar \
      php-sockets \
      php-zip \
      php-zlib \
      php-xml \
      php-xmlreader \
 && rm -rf /var/cache/apk/* \
 && mkdir -p /etc/services.d/fpm /srv/www /var/log/php \
 && mv /run_fpm /etc/services.d/fpm/run \
 && mv /etc/php/php-fpm.conf /etc/php/php-fpm.conf.verbose \
 && mv /php-fpm.conf /etc/php/php-fpm.conf

EXPOSE 9000

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
