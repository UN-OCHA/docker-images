FROM unocha/alpine-base
MAINTAINER orakili <docker@orakili.net>

# Alpine based docker image.
# Includes php composer and ruby bundler.

RUN apk -U --no-cache add \
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
      ruby-json \
 && curl -sS https://getcomposer.org/installer \
      | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /tmp

CMD ["sh"]

