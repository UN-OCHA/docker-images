FROM unocha/alpine-base-postgres:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV POSTGIS_VERSION 2.2.2

RUN apk add --update-cache --virtual .build-dependencies \
        file \
        g++ \
        gcc \
        libgcc \
        libxml2-dev \
        make \
        perl \
        postgresql-dev && \
    # Packages from edge testing.
    apk add --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
            --allow-untrusted --virtual .build-dependencies-testing \
        gdal \
        gdal-dev \
        geos \
        geos-dev \
        proj4 \
        proj4-dev && \
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
    apk del .build-dependencies .build-dependencies-testing && \
    rm -rf /var/cache/apk/*

