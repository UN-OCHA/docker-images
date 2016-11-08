FROM unocha/alpine-nodejs-builder
MAINTAINER orakili <docker@orakili.net>

# Alpine based docker image.
# Includes php composer, ruby bundler, less, npm, jasmine, compass and drush.

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="alpine-php-builder" \
      org.label-schema.description="This service provides a builder container for PHP, with node and sass helpers." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.4" \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 ctype curl dom fpm gd iconv imagick json mcrypt mysql opcache openssl pdo pdo_mysql pdo_pgsql phar posix sockets xml xmlreader zip zlib memcached redis" \
      info.humanitarianresponse.php.sapi="cli" \
      info.humanitarianresponse.composer="1.2.1" \
      info.humanitarianresponse.drush="6.7.0" \
      info.humanitarianresponse.npm="2.15.1" \
      info.humanitarianresponse.compass="1.0.3" \
      info.humanitarianresponse.jasmine="2.5.2"

ENV DRUSH_VERSION=6 \
    DRUSH_RELEASE=6.7.0

RUN npm install --global \
      jasmine && \
    rm -rf /tmp/npm-* && \
    \
    gem install --no-document \
      compass_radix && \
    \
    apk add --update-cache \
      bash \
      ca-certificates \
      curl \
      build-base \
      git \
      gzip \
      openssh-client \
      patch \
      rsync \
      tar \
      wget \
      php5-bcmath \
      php5-bz2 \
      php5-calendar \
      php5-cli \
      php5-ctype \
      php5-curl \
      php5-dom \
      php5-exif \
      php5-ftp \
      php5-gd \
      php5-gettext \
      php5-iconv \
      php5-imagick \
      php5-imap \
      php5-intl \
      php5-json \
      php5-mcrypt \
      php5-posix \
      php5-opcache \
      php5-openssl \
      php5-pdo \
      php5-phar \
      php5-soap \
      php5-sockets \
      php5-xml \
      php5-xmlreader \
      php5-xsl \
      php5-zip \
      php5-zlib \
      ruby-bundler \
      ruby-io-console \
      ruby-rdoc \
      ruby-json && \
    rm -rf /var/cache/apk/* && \
    cd /tmp && \
    COMPOSER_HASH=$(curl -sS https://composer.github.io/installer.sig) && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '$COMPOSER_HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    # Install drush and symlink it somewhere useful.
    COMPOSER_HOME=/usr/local/drush$DRUSH_VERSION \
    composer global require drush/drush:$DRUSH_RELEASE && \
    ln -sf /usr/local/drush$DRUSH_VERSION/vendor/bin/drush /usr/bin/drush && \
    drush status && \
    # Build igbinary php extension.
    apk add --update-cache --virtual .build-dependencies \
      git \
      php5-dev \
      autoconf \
      g++ \
      make && \
    cd /tmp && \
    git clone https://github.com/phadej/igbinary && \
    cd igbinary && \
    phpize && \
    ./configure CFLAGS="-O2 -g" -enable-igbinary -with-php-config=/usr/bin/php-config && \
    make && \
    make install && \
    echo 'extension=igbinary.so > /etc/php5/conf.d/igbinary.ini' && \
    cd .. && \
    rm -rf igbinary && \
    rm -rf /usr/include/php/ && \
    apk del .build-dependencies && \
    rm -rf /var/cache/apk/* && \
    # Add dependencies for capsper and phantom.
    apk add --update-cache \
      fontconfig \
      libc6-compat \
      python && \
    rm -rf /var/cache/apk/* && \
    # Install casper.
    curl -L -o /tmp/casperjs.zip https://github.com/n1k0/casperjs/archive/master.zip && \
    mkdir /opt && \
    unzip /tmp/casperjs.zip -d /opt && \
    mv /opt/casperjs-master /opt/casperjs && \
    ln -s /opt/casperjs/bin/casperjs /usr/local/bin/casperjs && \
    rm -f /tmp/casperjs.zip && \
    \
    # A working PhantomJS for FTS.
    curl -Ls https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz \
      | tar xz -C / bin etc/fonts etc/ssl lib lib64 usr/lib usr/local usr/share

WORKDIR /tmp

CMD ["bash"]
