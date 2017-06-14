FROM unocha/alpine-base:3.6

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN curl -sL https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-amd64.tar.gz -o /tmp/s6.tgz && \
    tar xzf /tmp/s6.tgz -C / && \
    rm -f /tmp/s6.tgz

ENTRYPOINT ["/init"]

CMD []
