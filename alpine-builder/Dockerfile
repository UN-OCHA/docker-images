FROM unocha/alpine-base-nodejs:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Alpine based docker image.
# Includes php composer, ruby bundler, nodejs, npm, grunt, karma, lessc, sass, compass

ENV NODE_APP_DIR=/srv/www \
    SRC_DIR=/src \
    DST_DIR=/dst

ENTRYPOINT []

RUN apk add --update-cache \
        git \
        rsync \
        nodejs-lts \
        ruby-bundler \
        ruby-io-console \
        ruby-json \
        build-base \
        ruby-dev \
        libffi-dev && \
    npm install -g \
        grunt-cli \
        bower \
        less \
        karma && \
    gem install --no-document \
        bootstrap-sass \
        font-awesome-sass \
        sass-globbing \
        compass && \
    apk add \
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
        php5-xmlreader && \
    curl -sS https://getcomposer.org/installer \
        | php -- --install-dir=/usr/local/bin --filename=composer && \
    rm -rf /var/cache/apk/*

#    apk del \
#        ruby-dev \
#        libffi-dev && \

# this image is mainly used to build stuff so it makes sense to use ${SRC_DIR} as WORKDIR
# DO NOT FORGET TO MAP ${SRC_DIR} or you will get a full /var/lib/docker :)
WORKDIR ${SRC_DIR}


VOLUME ["${SRC_DIR}" "${DST_DIR}" "${NODE_APP_DIR}"]

CMD ["sh"]

