FROM unocha/alpine-base-php-fpm:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to orakili <docker@orakili.net>

# A little bit of metadata management.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version="5.6.26" \
      org.label-schema.name="php-fpm-drupal7" \
      org.label-schema.description="This service provides a php-fpm platform for Drupal 7 with Drush and composer." \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF

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
RUN ln -sf /usr/local/drush/vendor/bin/drush /usr/bin/drush

# Install registry_rebuild to the appuser's homedir.
RUN drush -y @none dl --destination=/home/appuser/.drush/commands registry_rebuild

# Symlink the appuser's drush module to root's.
RUN mkdir -p /root/.drush
RUN ln -s /home/appuser/.drush/commands /root/.drush/commands

# Add our default drushrc.php file.
COPY drushrc.php /drushrc.php
RUN mkdir -p /etc/drush && \
    mv /drushrc.php /etc/drush/drushrc.php

# Volumes
# - Conf: /etc/php5/ (php.ini, php-fpm.conf, conf.d/)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
