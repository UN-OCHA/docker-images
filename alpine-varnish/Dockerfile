FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV DAEMON_USER=varnish \
    LISTEN_ADDR=0.0.0.0 \
    LISTEN_PORT=80 \
    CONFIG_FILE=/etc/varnish/default.vcl \
    STORAGE_BACKEND=malloc,128M \
    # Extra options to pass to the varnish daemon.
    VARNISHD_OPTS=

COPY run_varnish default.vcl /

RUN apk add --update-cache varnish && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/varnish /etc/varnish && \
    mv /run_varnish /etc/services.d/varnish/run && \
    mv /default.vcl /etc/varnish/ && \
    chown -R varnish:varnish /etc/varnish

VOLUME ["/etc/varnish"]

EXPOSE 80 6082

