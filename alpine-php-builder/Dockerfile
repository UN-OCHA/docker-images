FROM unocha/alpine-base
MAINTAINER orakili <docker@orakili.net>

# Alpine based docker image.
# Includes php composer and ruby bundler.

RUN apk add --update-cache \
      curl \
      git \
      gzip \
      openssh-client \
      patch \
      tar \
      php5-bcmath \
      php5-cli \
      php5-ctype \
      php5-curl \
      php5-dom \
      php5-fpm \
      php5-gd \
      php5-iconv \
      php5-json \
      php5-mcrypt \
      php5-posix \
      php5-opcache \
      php5-openssl \
      php5-pdo \
      php5-phar \
      php5-sockets \
      php5-zip \
      php5-zlib \
      php5-xml \
      php5-xmlreader \
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
    php -r "unlink('composer-setup.php');"

WORKDIR /tmp

CMD ["sh"]

