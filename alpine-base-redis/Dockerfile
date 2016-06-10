FROM unocha/alpine-base-s6

MAINTAINER "Serban TEODORESCU <teodorescu.serban@gmail.com>"

COPY run_redis redis.conf /srv/

RUN apk update && \
    apk add redis && \
    rm -rf /var/lib/apk/* && \
    mkdir -p /etc/redis /etc/services.d/redis && \
    mv /srv/run_redis /etc/services.d/redis/run && \
    mv /srv/redis.conf /etc/redis/

EXPOSE 6379

VOLUME ["/var/log/redis"]

#CMD ["/init"]
