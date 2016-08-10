FROM unocha/alpine-base-s6:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8 \
    FILEBEAT_VERSION=5.0.0-alpha4 \
    FILEBEAT_SHA1=49086e2916a13e80d2913779d5d224bcea929f5e \
    FILEBEAT_CFG=/etc/filebeat/filebeat.yml

COPY run_filebeat filebeat* /

RUN apk --update --no-cache add curl && \
    curl https://download.elastic.co/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -o /filebeat.tar.gz && \
    echo "${FILEBEAT_SHA1}  filebeat.tar.gz" | sha1sum -c - && \
    tar xzvf filebeat.tar.gz && \
    cd filebeat-* && \
    cp filebeat /usr/bin && \
    mkdir -p /etc/filebeat && \
    mv /filebeat.yml /etc/filebeat/ && \
    mv /filebeat.template.json /etc/filebeat && \
    cd / && \
    rm -rf filebeat* && \
    mkdir -p /etc/services.d/filebeat && \
    mv /run_filebeat /etc/services.d/filebeat/run

VOLUME ["/mnt"]
