FROM unocha/alpine-php-fpm-drupal7:3.4

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version="5.6.26" \
      org.label-schema.name="php-fpm-drupal7-ghosts" \
      org.label-schema.description="This service provides a php-fpm platform for the FTS Drupal 7." \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF

RUN \
    # Change appuser UID and GID.
    sed -i s/4000/48/g /etc/group && \
    sed -i s/4000/48/g /etc/group- && \
    sed -i s/4000/48/g /etc/passwd && \
    sed -i s/4000/48/g /etc/shadow && \
    cat /etc/passwd && \
    # Install additional php libraries.
    apk add --update-cache \
      php5-calendar \
      php5-exif \
      php5-ftp \
      php5-gettext \
      php5-imap \
      php5-intl \
      php5-xsl \
      php5-soap && \
    rm -rf /var/cache/apk/* && \
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
    rm -f /tmp/casperjs.zip

# Found a possibly working PhantomJS at https://github.com/sgerrand/alpine-pkg-glibc/issues/13#issuecomment-241582002
# RUN curl -L -o /tmp/phantomjs.tar.bz2 https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 && \
#     tar -C /opt -xf /tmp/phantomjs.tar.bz2 && \
#     ln -sf /opt/phantomjs/phantomjs /usr/local/bin/phantomjs && \
#     rm -rf /tmp/phantomjs.tar.bz2

# Found an actual working PhantomJS at http://fabiorehm.com/blog/2015/07/22/building-a-minimum-viable-phantomjs-2-docker-image
# It's a year old, but it's newer than the old one (1.9.8) and it works.
# Mind you, only extract part of the archive, or our crafted passwd and shadow files wil be overwritten.
RUN curl -Ls https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz \
      | tar xz -C / bin etc/fonts etc/ssl lib lib64 usr/lib usr/local usr/share
