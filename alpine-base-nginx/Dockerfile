FROM unocha/alpine-base-s6

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# inspiration: orakili <docker@orakili.net>

COPY nginx.conf default.conf index.html run_nginx /

# Install nginx.
RUN apk add --update-cache \
      nginx \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/nginx /srv/www/html /var/log/nginx /var/cache/nginx && \
    mv /run_nginx /etc/services.d/nginx/run && \
    mv /nginx.conf /etc/nginx/nginx.conf && \
    mv /default.conf /etc/nginx/conf.d/default.conf && \
    mv /index.html /srv/www/html/default.conf

EXPOSE 80

# Volumes
# - Conf: /etc/nginx/conf.d (default.conf)
# - Logs: /var/log/nginx
# - Data: /srv/www/html
