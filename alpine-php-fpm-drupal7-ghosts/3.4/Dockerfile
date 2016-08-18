FROM unocha/alpine-php-fpm-drupal7:3.4

RUN sed -i s/4000/48/g /etc/group && \
    sed -i s/4000/48/g /etc/group- && \
    sed -i s/4000/48/g /etc/passwd && \
    sed -i s/4000/48/g /etc/shadow

RUN apk update && \
  apk add \
    php5-calendar \
    php5-exif \
    php5-ftp \
    php5-gettext \
    php5-imap \
    php5-intl \
    php5-xsl \
    php5-soap && \
  rm -rf /var/cache/apk/*

RUN apk update && \
  apk add \
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
  apk del \
    make \
    g++ \
    autoconf \
    perl \
    m4 \
    binutils-libs \
    binutils \
    libpcrecpp \
    pcre-dev \
    php5-dev \
    git && \
  rm -rf /var/cache/apk/*

# RUN curl -L -o /tmp/casperjs.zip https://github.com/n1k0/casperjs/archive/master.zip && \
#   mkdir /opt && \
#   unzip /tmp/casperjs.zip -d /opt && \
#   mv /opt/casperjs-master /opt/casperjs && \
#   ln -s /opt/casperjs/bin/casperjs /usr/local/bin/casperjs && \
#   rm -f /tmp/casperjs.zip

# RUN curl -L -o /tmp/phantomjs.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2 && \
#   tar xf /tmp/phantomjs.tar.bz2 phantomjs-1.9.8-linux-x86_64/bin/phantomjs && \
#   mv phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin && \
#   rm -rf phantomjs-1.9.8-linux-x86_64 /tmp/phantomjs.tar.bz2
