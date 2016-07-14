FROM unocha/alpine-php-fpm-drupal7:3.4-newrelic

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

RUN sed -i 's/4000/518/g' /etc/group && \
    sed -i 's/4000/518/g' /etc/group- && \
    sed -i 's/4000/518/g' /etc/passwd && \
    sed -i 's/4000/518/g' /etc/shadow && \
    sed -i '$ s/\/sbin\/nologin/\/bin\/sh/' /etc/passwd
