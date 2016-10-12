FROM unocha/alpine-base-s6:3.4

MAINTAINER orakili <docker@orakili.net>

COPY run_elasticsearch fix_* elasticsearch.yml logging.yml /

ENV ELASTICSEARCH_VERSION=2.4.1 \
    ELASTICSEARCH_SHA1=6a6acfc7bf7b4354dc6136daea54db1c844d632f \
    ELASTICSEARCH_URL=https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch \
    ES_HEAP_SIZE=1g

RUN \
    # Install OpenJRE.
    apk add --update-cache curl openjdk8-jre && \
    rm -rf /var/cache/apk/* && \
    # Create elasticsearch user.
    addgroup -S elasticsearch && \
    adduser -s /sbin/nologin -g 'Docker Elastisearch' -h /var/lib/elasticsearch -D -G elasticsearch elasticsearch && \
    # Create directory structure and set up default ES config.
    mkdir -p /etc/elasticsearch/scripts /var/log/elasticsearch /var/lib/elasticsearch /etc/services.d/elasticsearch /opt && \
    mv /elasticsearch.yml /logging.yml /etc/elasticsearch/ && \
    # Add init script and ownership fixes.
    mv /run_elasticsearch /etc/services.d/elasticsearch/run && \
    mv /fix_data_dir /etc/fix-attrs.d/01-fix-data-dir && \
    mv /fix_logs_dir /etc/fix-attrs.d/02-fix-logs-dir && \
    # Download Elasticsearch.
    curl -o /tmp/elasticsearch.tar.gz $ELASTICSEARCH_URL/$ELASTICSEARCH_VERSION/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
    echo "$ELASTICSEARCH_SHA1  /tmp/elasticsearch.tar.gz" | sha1sum -c - && \
    tar -zxvf /tmp/elasticsearch.tar.gz -C /opt && \
    mv /opt/elasticsearch-$ELASTICSEARCH_VERSION /opt/elasticsearch && \
    rm -rf /tmp/* && \
    # Set ownership and create symlinks to config, data and logs.
    chown -R elasticsearch:elasticsearch /opt/elasticsearch /etc/elasticsearch /var/log/elasticsearch /var/lib/elasticsearch && \
    rm -rf /opt/elasticsearch/config && \
    ln -s /etc/elasticsearch /opt/elasticsearch/config && \
    ln -s /var/log/elasticsearch /opt/elasticsearch/logs && \
    ln -s /var/lib/elasticsearch /opt/elasticsearch/data

EXPOSE 9200 9300

VOLUME ["/etc/elasticsearch" "/var/lib/elasticsearch" "/var/log/elasticsearch"]

# Volumes
# - Conf: /etc/elasticsearch
# - Logs: /var/log/elasticsearch
# - Data: /var/lib/elasticsearch
