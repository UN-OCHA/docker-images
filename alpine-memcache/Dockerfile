FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8 \
    MEMCACHE_PORT=11212 \
    MEMCACHE_MAX_MEMORY=1024 \
    MEMCACHE_SLAB_SIZE=1M

COPY run_memcache /

RUN apk add --update \
        memcached \
        && \
    rm -rf /var/lib/apk/* && \
    mkdir -p /etc/services.d/memcache && \
    mv /run_memcache /etc/services.d/memcache/run
