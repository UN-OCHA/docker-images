FROM unocha/alpine-base-s6:3.3

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
      php-memcache \
      php-opcache \
      php-openssl \
      php-pdo \
      php-pdo_mysql \
      php-pdo_pgsql \
      php-phar \
      php-posix \
      php-sockets \
      php-xml \
      php-xmlreader \
      php-zip \
      php-zlib \
      mysql-client \
      postgresql-client  && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/fpm /srv/www /var/log/php && \
    mv /run_fpm /etc/services.d/fpm/run && \
    mv /etc/php/php-fpm.conf /etc/php/php-fpm.conf.verbose && \
    mv /php-fpm.conf /etc/php/php-fpm.conf

# Add php-redis from edge.
RUN apk add \
      --update-cache --allow-untrusted \
      --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
        php-redis && \
    rm -rf /var/cache/apk/*

# Set unlimited memory for CLI php.
RUN sed -i 's/^memory_limit = .*/memory_limit = -1/' /etc/php/php.ini

# Install composer, as suggested by https://getcomposer.org/
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '070854512ef404f16bac87071a6db9fd9721da1684cd4589b1196c3faf71b9a2682e2311b36a5079825e155ac7ce150d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

# Install drush and symlink it somewhere useful.
RUN COMPOSER_HOME=/usr/local/drush6 \
    composer global require drush/drush 6.x
RUN ln -sf /usr/local/drush6/vendor/bin/drush /usr/bin/drush

EXPOSE 9000

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
