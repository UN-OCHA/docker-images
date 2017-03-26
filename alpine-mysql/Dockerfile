FROM unocha/alpine-base-mysql

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8 \
    MYSQL_DIR=/var/lib/mysql \
    MYSQL_ROOT_PASS=rootpass \
    MYSQL_DB=test_db \
    MYSQL_USER=test_user \
    MYSQL_PASS=test_pass

COPY run_mysql fix_* /

RUN mkdir -p /etc/services.d/mysql && \
    mv /run_mysql /etc/services.d/mysql/run && \
    mkdir -p /etc/fix-attrs.d && \
    cp /fix_data_dir /etc/fix-attrs.d/01-fix-data-dir && \
    cp /fix_logs_dir /etc/fix-attrs.d/02-fix-logs-dir && \
    cp /fix_tmp_dir  /etc/fix-attrs.d/03-fix-tmp-dir

EXPOSE 3306

VOLUME /var/lib/mysql /var/log/mysql /var/tmp/mysql
