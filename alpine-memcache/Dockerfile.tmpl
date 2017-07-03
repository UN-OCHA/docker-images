FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8 \
    MEMCACHE_PORT=11211 \
    MEMCACHE_MAX_MEMORY=1024 \
    MEMCACHE_SLAB_SIZE=1M \
    MEMCACHE_USER=memcached

COPY run_memcache /

RUN apk add --update-cache \
        memcached \
        && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/memcache && \
    mv /run_memcache /etc/services.d/memcache/run

EXPOSE 11211
