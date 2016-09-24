FROM unocha/alpine-base-s6:3.4

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
      org.label-schema.name="base-php-fpm" \
      org.label-schema.description="This service provides a base php-fpm platform." \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF

# Work around s6 containing a binary called `import' which
# clashes with imagemagick. D'oh.
RUN mv /usr/bin/import /usr/bin/s6-import

COPY php-fpm.conf run_fpm msmtprc /

RUN apk update && \
    apk add --update-cache \
      fcgi \
      msmtp \
      php5-bcmath \
      php5-bz2 \
      php5-ctype \
      php5-curl \
      php5-dom \
      php5-fpm \
      php5-gd \
      php5-iconv \
      php5-imagick \
      php5-json \
      php5-mcrypt \
      php5-mysql \
      php5-opcache \
      php5-openssl \
      php5-pdo \
      php5-pdo_mysql \
      php5-pdo_pgsql \
      php5-phar \
      php5-posix \
      php5-sockets \
      php5-xml \
      php5-xmlreader \
      php5-zip \
      php5-zlib && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/fpm /srv/www/html /var/log/php && \
    mv /msmtprc /etc/msmtprc && \
    mv /run_fpm /etc/services.d/fpm/run && \
    mv /etc/php5/php-fpm.conf /etc/php5/php-fpm.conf.verbose && \
    mv /php-fpm.conf /etc/php5/php-fpm.conf

RUN mv /usr/bin/import /usr/bin/im-import
RUN mv /usr/bin/s6-import /usr/bin/import

# Add php-redis from edge.
RUN apk add \
      --update-cache --allow-untrusted \
      --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
        php5-memcached php5-redis && \
    rm -rf /var/cache/apk/*

# Fixup the sendmail path for msmtp and set it as mailer.
# Disable expose_php so we do not advertise a potentially vulnerable version.
RUN ln -s /usr/bin/msmtp /usr/bin/sendmail && \
    sed -i 's/^;sendmail_path =/sendmail_path = \/usr\/bin\/sendmail -t/' /etc/php5/php.ini && \
    sed -i 's/^expose_php = On/expose_php = Off/' /etc/php5/php.ini

EXPOSE 9000

# Health check for the FPM server on port 9000.
HEALTHCHECK --interval=30s --timeout=5s \
        CMD REDIRECT_STATUS=true SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET cgi-fcgi -bind -connect 127.0.0.1:9000

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
