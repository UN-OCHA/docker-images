FROM unocha/alpine-base-s6:3.4
MAINTAINER Peter Lieverdink <peterl@humanitarianresponse.info>

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE
ARG MYSQL_VERSION
ARG PGSQL_VERSION

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="alpine-db-client" \
      org.label-schema.description="This service provides database clients for MySQL and Postgres." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.4" \
      info.humanitarianresponse.mysql=$MYSQL_VERSION \
      info.humanitarianresponse.postgres=$PGSQL_VERSION

ENV LANG=en_US.utf8

RUN apk add --update-cache \
        bash \
        mysql-client \
        postgresql-client \
        postgresql-contrib \
        && \
    rm -rf /var/cache/apk/*

WORKDIR /tmp

CMD ["bash"]
