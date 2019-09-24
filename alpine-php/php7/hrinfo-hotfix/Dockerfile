FROM unocha/php7:7.2.18-r0-201906-01-NR

MAINTAINER UN-OCHA Operations <ops+docker@humanitarianresponse.info>

# Configure the opcache for hopefully slightly faster performance.
COPY 00_opcache.ini /etc/php7/conf.d/00_opcache.ini
# Make a container with a built-in GEOS.
# COPY 00_geos.ini /etc/php7/conf.d/00_geos.ini
# COPY geos.so /usr/lib/php7/modules/geos.so
# COPY geos.la /usr/lib/php7/modules/geos.la

# Downgrade ghostscript (and dependency libs) so pdf previews work.
RUN echo "@3-4-main http://dl-cdn.alpinelinux.org/alpine/v3.4/main" >> /etc/apk/repositories && \
    apk add --no-cache 'freetype@3-4-main=~2.6' 'ghostscript@3-4-main=~9.22' 'fontconfig@3-4-main=~2.12.1' && \
    # Add in the GEOS library and PHP module. \
    # echo "@edge-testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    # apk add 'geos@edge-testing=~3.7.2' && \
    rm -rf /var/cache/apk/*
