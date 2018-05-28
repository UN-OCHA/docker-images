include /etc/openldap/schema/core.schema
include /etc/openldap/schema/cosine.schema
include /etc/openldap/schema/inetorgperson.schema
include /etc/openldap/schema/nis.schema

serverID $SID

database	mdb
maxsize		1073741824
directory	/var/lib/openldap/openldap-data

suffix "dc=$DOMAIN,dc=$SUFFIX"
rootdn "cn=Manager,dc=$DOMAIN,dc=$SUFFIX"
rootpw $MNGRPASS

include /etc/openldap/conf.d/syncrepl.conf

overlay syncprov
syncprov-checkpoint 100 10
syncprov-sessionlog 100

access to attrs=userPassword
    by anonymous auth
    by self write
    by * none

access to dn.base="" by * read

access to *
    by * read

index objectClass eq
