FROM unocha/alpine-jdk:8

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to Anastas Dancha "anapsix@random.io"

ENV SOLR_VERSION 6.0.1
ENV SOLR solr-$SOLR_VERSION
ENV JDBC_MYSQL_VERSION 5.1.38
ENV JDBC_PSQL_VERSION 9.4.1207

COPY run-solr /

RUN apk add --update \
        bash \
        curl && \
    cd /tmp && \
    echo "getting solr $SOLR_VERSION" >&2 && \
    curl -sSL http://mirrors.gigenet.com/apache/lucene/solr/$SOLR_VERSION/$SOLR.tgz -o /tmp/$SOLR.tgz && \
    mkdir -p /opt && \
    gzip -dc /tmp/$SOLR.tgz | tar -C /opt -x && \
    ln -sf /opt/$SOLR /opt/solr && \
    echo "getting PSQL JDBC" >&2 && \
    curl -sSL http://jdbc.postgresql.org/download/postgresql-$JDBC_PSQL_VERSION.jar -o /opt/solr/dist/postgresql-$JDBC_PSQL_VERSION.jar && \
    echo "getting MYSQL JDBC" >&2 && \
    curl -sSL http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz -o /tmp/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz && \
    echo mysql-connector-java-$JDBC_MYSQL_VERSION/mysql-connector-java-$JDBC_MYSQL_VERSION-bin.jar > /tmp/include && \
    gzip -dc /tmp/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz | tar -x -T /tmp/include > /opt/solr/dist/mysql-connector-java-$JDBC_MYSQL_VERSION-bin.jar && \
    echo "cleaning up.." >&2 && \
    apk del curl || true && \
    rm -rf /tmp/* && \
    mkdir /etc/services.d/solr && \
    mv /run-solr /etc/services.d/solr/run

EXPOSE 8983

WORKDIR /opt/solr
