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
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="base-php-fpm" \
      org.label-schema.description="This service provides a base php-fpm platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.4" \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 ctype curl dom fpm gd iconv json mcrypt opcache openssl pdo pdo_mysql pdo_pgsql phar posix sockets xml xmlreader zip zlib memcached redis" \
      info.humanitarianresponse.php.sapi="fpm"

# There is no php7-imagick, so no need to work around the s6 binary clash.
# RUN mv /usr/bin/import /usr/bin/s6-import

COPY php-fpm.conf run_fpm msmtprc /

RUN apk update && \
    apk add \
      fcgi \
      msmtp && \
    \
    apk add \
      --update-cache --allow-untrusted \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
      --allow-untrusted \
        php7-bcmath \
        php7-bz2 \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-iconv \
        php7-fpm \
        php7-iconv \
        php7-json \
        php7-mcrypt \
        php7-memcached \
        php7-opcache \
        php7-openssl \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-phar \
        php7-posix \
        php7-redis \
        php7-sockets \
        php7-xml \
        php7-xmlreader \
        php7-zip \
        php7-zlib && \
    rm -rf /var/cache/apk/* && \
    \
    mkdir -p /etc/services.d/fpm /srv/www/html && \
    mv /msmtprc /etc/msmtprc && \
    mv /run_fpm /etc/services.d/fpm/run && \
    mv /php-fpm.conf /etc/php7/php-fpm.conf && \
    \
    sed -i \
        -e "s/^expose_php.*/expose_php = Off/" \
        -e "s/^;date.timezone.*/date.timezone = UTC/" \
        -e "s/^memory_limit.*/memory_limit = -1/" \
        -e "s/^max_execution_time.*/max_execution_time = 300/" \
        -e "s/^post_max_size.*/post_max_size = 128M/" \
        -e "s/^upload_max_filesize.*/upload_max_filesize = 128M/" \
        -e "s/^;sendmail_path =/sendmail_path = \/usr\/bin\/sendmail -t/" \
      /etc/php7/php.ini && \
    echo "error_log = \"/var/log/php/error.log\"" | tee -a /etc/php7/php.ini && \
    rm -rf /var/log/php7 && \
    mkdir /var/log/php && \
    touch /var/log/php/error.log && \
    touch /var/log/php/fpm-error.log && \
    touch /var/log/php/fpm-slow.log && \
    ln -s /usr/bin/msmtp /usr/bin/sendmail

EXPOSE 9000

# Health check for the FPM server on port 9000.
HEALTHCHECK --interval=30s --timeout=5s \
        CMD REDIRECT_STATUS=true SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET cgi-fcgi -bind -connect 127.0.0.1:9000

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
