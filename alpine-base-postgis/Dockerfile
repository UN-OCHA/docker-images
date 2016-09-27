FROM unocha/alpine-base-postgres:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV POSTGIS_VERSION 2.2.2

RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --update-cache --virtual .build-dependencies@testing \
        postgresql-dev \
        perl \
        file \
        geos@testing \
        geos-dev@testing \
        libxml2-dev \
        gdal@testing \
        gdal-dev@testing \
        proj4@testing \
        proj4-dev@testing \
        gcc \
        make \
        libgcc g++ && \
    cd /tmp && \
    wget http://download.osgeo.org/postgis/source/postgis-${POSTGIS_VERSION}.tar.gz -O - | tar -xz && \
    chown root:root -R postgis-${POSTGIS_VERSION} && \
    cd /tmp/postgis-${POSTGIS_VERSION} && \
    ./configure && \
    echo "PERL = /usr/bin/perl" >> extensions/postgis/Makefile && \
    echo "PERL = /usr/bin/perl" >> extensions/postgis_topology/Makefile && \
    make -s && \
    make -s install  && \
    cd / && \
    rm -rf /tmp/postgis-${POSTGIS_VERSION} && \
    apk del .build-dependencies && \
    rm -rf /var/cache/apk/*

