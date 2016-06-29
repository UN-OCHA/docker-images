FROM unocha/alpine-php-fpm-drupal7:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to orakili <docker@orakili.net>

ENV NR_VERSION php5-6.4.0.163-linux-musl

COPY run_newrelic /

RUN curl -s -o /tmp/newrelic.tar.gz \
      https://download.newrelic.com/php_agent/release/newrelic-$NR_VERSION.tar.gz

RUN mkdir -p /etc/newrelic /var/log/newrelic && \
    tar xvf /tmp/newrelic.tar.gz -C /tmp && \
    mv /tmp/newrelic-$NR_VERSION/daemon/newrelic-daemon.x64 \
       /usr/bin/newrelic-daemon && \
    mv /tmp/newrelic-$NR_VERSION/agent/x64/newrelic-20131226.so \
       /usr/lib/php5/modules/newrelic.so && \
    mv /tmp/newrelic-$NR_VERSION/scripts/newrelic.cfg.template \
       /etc/newrelic/newrelic.cfg && \
    mv /tmp/newrelic-$NR_VERSION/scripts/newrelic.ini.template \
       /etc/php5/conf.d/newrelic.ini && \
    rm -rf /tmp/newrelic-php5-$NR_VERSION /tmp/newrelic.tar.gz

RUN mkdir -p /etc/services.d/newrelic && \
    mv /run_newrelic /etc/services.d/newrelic/run

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php /var/log/newrelic
# - Data: /srv/www, /var/lib/php/session
