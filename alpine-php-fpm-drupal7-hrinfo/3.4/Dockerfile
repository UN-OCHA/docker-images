FROM unocha/alpine-php-fpm-drupal7:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version="5.6.26" \
      org.label-schema.name="php-fpm-drupal7-hrinfo" \
      org.label-schema.description="This service provides a php-fpm platform for the humanitarianresponse.info Drupal 7." \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF

RUN sed -i s/4000/518/g /etc/group && \
    sed -i s/4000/518/g /etc/group- && \
    sed -i s/4000/518/g /etc/passwd && \
    sed -i s/4000/518/g /etc/shadow
