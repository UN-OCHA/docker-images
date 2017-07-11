FROM unocha/alpine-base:3.6

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

COPY vsftpd.conf /etc/vsftpd/

RUN apk add --update-cache \
        build-base \
        linux-pam-dev \
        vsftpd && \
    mkdir /pwdfile && \
    cd /pwdfile && \
    curl -sSL https://github.com/tiwe-de/libpam-pwdfile/archive/v1.0.tar.gz | tar xz --strip 1 && \
    make install && \
    cd / && \
    rm -rf /pwdfile && \
    apk del \
        build-base \
        linux-pam-dev && \
    passwd -l root && \
    adduser -D virtual && \
    rm -rf /var/cache/apk/*

VOLUME /var/lib/ftp
WORKDIR /var/lib/ftp

EXPOSE 21

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]