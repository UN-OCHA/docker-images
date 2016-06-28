FROM unocha/alpine-base-php-fpm:3.3

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to orakili <docker@orakili.net>

RUN apk update && \
    apk add \
      php-cli \
      mysql-client \
      postgresql-client  && \
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

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
