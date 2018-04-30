include /etc/openldap/schema/cosine.schema
include /etc/openldap/schema/inetorgperson.schema
include /etc/openldap/schema/nis.schema

suffix "dc=$DOMAIN,dc=$SUFFIX"
rootdn "cn=Manager,dc=$DOMAIN,dc=$SUFFIX"
rootpw $MNGRPASS

access to attrs=userPassword
    by dn="uid=root,ou=People,dc=$DOMAIN,dc=$SUFFIX" write
    by dn="cn=Manager,dc=$DOMAIN,dc=$SUFFIX" write
    by anonymous auth
    by self write
    by * none

access to dn.base="" by * read

access to *
    by dn="cn=Manager,dc=$DOMAIN,dc=$SUFFIX" write
    by * read

index objectClass eq
