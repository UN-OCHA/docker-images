FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8 \
    PGDATA=/srv/db

COPY run_postgres /

RUN apk add --update \
        postgresql \
        postgresql-client \
        postgresql-contrib \
        && \
    rm -rf /var/lib/apk/* && \
    mkdir -p /etc/services.d/postgres && \
    mv /run_postgres /etc/services.d/postgres/run

EXPOSE 5432

VOLUME ["/srv/db"]
