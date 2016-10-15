FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8 \
    PGDATA=/var/lib/pgsql

COPY run_postgres /

RUN apk add --update-cache \
        postgresql \
        postgresql-client \
        postgresql-contrib \
        && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/postgres && \
    mv /run_postgres /etc/services.d/postgres/run

EXPOSE 5432

VOLUME ["/var/lib/pgsql"]
