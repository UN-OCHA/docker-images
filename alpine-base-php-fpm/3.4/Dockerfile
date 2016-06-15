FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to orakili <docker@orakili.net>

COPY php-fpm.conf run_fpm /

RUN apk update && \
    apk add \
      php5-bcmath \
      php5-bz2 \
      php5-cli \
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
      php5-zlib \
      mysql-client \
      postgresql-client  && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/fpm /srv/www /var/log/php && \
    mv /run_fpm /etc/services.d/fpm/run && \
    mv /etc/php5/php-fpm.conf /etc/php5/php-fpm.conf.verbose && \
    mv /php-fpm.conf /etc/php5/php-fpm.conf

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
