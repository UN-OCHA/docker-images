FROM unocha/alpine-base-s6

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# inspiration: orakili <docker@orakili.net>

COPY nginx.conf default.conf index.html run_nginx /

ENV NGINX_VERSION nginx-1.10.1

RUN build_pkgs="build-base linux-headers openssl-dev pcre-dev wget zlib-dev" \
  && runtime_pkgs="ca-certificates openssl pcre zlib" \
  && apk --update add ${build_pkgs} ${runtime_pkgs} \
  && cd /tmp \
  && wget https://github.com/masterzen/nginx-upload-progress-module/archive/v0.9.1.zip \
  && unzip v0.9.1.zip \
  && wget http://nginx.org/download/${NGINX_VERSION}.tar.gz \
  && tar xzf ${NGINX_VERSION}.tar.gz \
  && cd /tmp/${NGINX_VERSION} \
  && ./configure \
    --prefix=/etc/nginx \
    --sbin-path=/usr/sbin/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --user=nginx \
    --group=nginx \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_stub_status_module \
    --with-http_auth_request_module \
    --with-threads \
    --with-stream \
    --with-stream_ssl_module \
    --with-http_slice_module \
    --with-file-aio \
    --with-http_v2_module \
    --add-module=/tmp/nginx-upload-progress-module-0.9.1/ \
  && make \
  && make install \
  && sed -i -e 's/#access_log  logs\/access.log  main;/access_log \/dev\/stdout;/' -e 's/#error_log  logs\/error.log  notice;/error_log stderr notice;/' /etc/nginx/nginx.conf \
  && adduser -D nginx \
  && rm -rf /tmp/* \
  && apk del ${build_pkgs} \
  && mkdir -p /etc/services.d/nginx /srv/www/html /var/log/nginx /var/cache/nginx \
  && mv /run_nginx /etc/services.d/nginx/run \
  && mv /nginx.conf /etc/nginx/nginx.conf \
  && mv /default.conf /etc/nginx/conf.d/default.conf \
  && mv /index.html /srv/www/html/default.conf
  && rm -rf /var/cache/apk/*

EXPOSE 80

# Volumes
# - Conf: /etc/nginx/conf.d (default.conf)
# - Logs: /var/log/nginx
# - Data: /srv/www/html
