#!/bin/sh

# create user entry
[ -s /etc/vsftpd/passwd ] || echo "$FTPUSER:$(openssl passwd -1 $FTPPASS)" > /etc/vsftpd/passwd

chown vsftp:ftp /var/lib/ftp
chmod 775 /var/lib/ftp

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
