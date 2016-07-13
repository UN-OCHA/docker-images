FROM unocha/alpine-php-fpm-drupal7:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

RUN sed -i s/4000/518/g /etc/group && \
    sed -i s/4000/518/g /etc/group- && \
    sed -i s/4000/518/g /etc/passwd && \
    sed -i s/4000/518/g /etc/shadow
