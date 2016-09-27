FROM unocha/alpine-php-fpm-drupal7:3.4

MAINTAINER Peter Lieverdink <peterl@humanitarianresponse.info>

# Thanks to orakili <docker@orakili.net>

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version="5.6.26" \
      org.label-schema.name="php-fpm-drupal7-nr" \
      org.label-schema.description="This service provides a php-fpm platform with New Relic for Drupal 7 with Drush and composer." \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF

ENV NR_VERSION php5-6.7.0.174-linux-musl

COPY run_newrelic /

RUN curl -s -o /tmp/newrelic.tar.gz \
      https://download.newrelic.com/php_agent/release/newrelic-$NR_VERSION.tar.gz && \
    mkdir -p /etc/newrelic /var/log/newrelic && \
    tar xvf /tmp/newrelic.tar.gz -C /tmp && \
    mv /tmp/newrelic-$NR_VERSION/daemon/newrelic-daemon.x64 \
       /usr/bin/newrelic-daemon && \
    mv /tmp/newrelic-$NR_VERSION/agent/x64/newrelic-20131226.so \
       /usr/lib/php5/modules/newrelic.so && \
    mv /tmp/newrelic-$NR_VERSION/scripts/newrelic.cfg.template \
       /etc/newrelic/newrelic.cfg && \
    mv /tmp/newrelic-$NR_VERSION/scripts/newrelic.ini.template \
       /etc/php5/conf.d/newrelic.ini && \
    rm -rf /tmp/newrelic-php5-$NR_VERSION /tmp/newrelic.tar.gz && \
    mkdir -p /etc/services.d/newrelic && \
    mv /run_newrelic /etc/services.d/newrelic/run

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php /var/log/newrelic
# - Data: /srv/www, /var/lib/php/session
