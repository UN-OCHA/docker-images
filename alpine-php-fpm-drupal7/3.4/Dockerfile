FROM unocha/alpine-base-php-fpm:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to orakili <docker@orakili.net>

ENV COMPOSER_HASH e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae

RUN apk update && \
    apk add \
      php5-cli \
      mysql-client \
      postgresql-client  && \
    rm -rf /var/cache/apk/*

# Set unlimited memory for CLI php.
RUN sed -i 's/^memory_limit = .*/memory_limit = -1/' /etc/php5/php.ini

# Install composer, as suggested by https://getcomposer.org/
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '$COMPOSER_HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

# Install drush and symlink it somewhere useful.
RUN COMPOSER_HOME=/usr/local/drush \
    composer global require drush/drush 6.7
RUN drush @none dl registry_rebuild
RUN ln -sf /usr/local/drush/vendor/bin/drush /usr/bin/drush

# Add our default drushrc.php file.
COPY drushrc.php /drushrc.php
RUN mkdir -p /etc/drush && \
    mv /drushrc.php /etc/drush/drushrc.php

# Volumes
# - Conf: /etc/php5/ (php.ini, php-fpm.conf, conf.d/)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
