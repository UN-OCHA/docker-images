FROM unocha/alpine-base-php-fpm:3.3

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to orakili <docker@orakili.net>

ENV DRUSH_VERSION=6 \
    DRUSH_RELEASE=6.7.0

RUN apk add --update-cache \
      php-cli \
      mysql-client \
      postgresql-client  && \
    rm -rf /var/cache/apk/* && \
    # Set unlimited memory for CLI php.
    sed -i 's/^memory_limit = .*/memory_limit = -1/' /etc/php/php.ini && \
    # Install composer, as suggested by https://getcomposer.org/
    # and https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
    COMPOSER_HASH=$(curl -sS https://composer.github.io/installer.sig) && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '$COMPOSER_HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    # Install drush and symlink it somewhere useful.
    COMPOSER_HOME=/usr/local/drush$DRUSH_VERSION \
      composer global require drush/drush:$DRUSH_RELEASE && \
    ln -sf /usr/local/drush$DRUSH_VERSION/vendor/bin/drush /usr/bin/drush && \
    drush status

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
