FROM unocha/alpine-base-s6

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to orakili <docker@orakili.net>

COPY php-fpm.conf run_fpm /

RUN apk update && \
    apk add \
      php-bcmath \
      php-bz2 \
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
      php-pdo_mysql \
      php-pdo_pgsql \
      php-phar \
      php-sockets \
      php-zip \
      php-zlib \
      php-xml \
      php-xmlreader \
      mysql-client \
      postgresql-client  && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/fpm /srv/www /var/log/php && \
    mv /run_fpm /etc/services.d/fpm/run && \
    mv /etc/php/php-fpm.conf /etc/php/php-fpm.conf.verbose && \
    mv /php-fpm.conf /etc/php/php-fpm.conf

# Install composer, as suggested by https://getcomposer.org/
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '070854512ef404f16bac87071a6db9fd9721da1684cd4589→
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

# Install drush and symlink it somewhere useful.
RUN COMPOSER_HOME=/usr/local/drush \
    composer global require drush/drush 7.x
RUN ln -sf /usr/local/drush/vendor/bin/drush /usr/bin/drush

EXPOSE 9000

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
