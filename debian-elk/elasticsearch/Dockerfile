FROM elasticsearch:5.0.0-alpha4

ENV CURATOR_VERSION 4.0.0
ENV CURATOR_REPO_BASE http://packages.elastic.co/curator/4/debian
ENV BEATS_VERSION 5.0.0-alpha4
ENV BEATS_REPO_BASE https://download.elastic.co/beats

RUN echo "deb $CURATOR_REPO_BASE stable main" > /etc/apt/sources.list.d/curator.list

RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends && \
      python-elasticsearch-curator=${CURATOR_VERSION} && \
      python-setuptools && \
    cd /tmp && \
    curl -L -O ${BEATS_REPO_BASE}/filebeat/filebeat-${BEATS_VERSION}-amd64.deb && \
    curl -L -O ${BEATS_REPO_BASE}/metricbeat/metricbeat-${BEATS_VERSION}-amd64.deb && \
    curl -L -O ${BEATS_REPO_BASE}/packetbeat/packetbeat-${BEATS_VERSION}-amd64.deb && \
    dpkg -i filebeat-5.0.0-alpha4-amd64.deb && \
    dpkg -i metricbeat-5.0.0-alpha4-amd64.deb && \
    dpkg -i packetbeat-5.0.0-alpha4-amd64.deb && \
    rm -r /tmp/*.deb && \
    rm -rf /var/lib/apt/lists/*

COPY load_beats_templates.sh /usr/local/bin/
COPY load_beats_dashboards.sh /usr/local/bin/
