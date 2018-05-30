# $DOMAIN.$SUFFIX
dn: dc=$DOMAIN,dc=$SUFFIX
dc: $DOMAIN
o: $DOMAIN Organization
objectClass: dcObject
objectClass: organization

# Manager, $DOMAIN.$SUFFIX
dn: cn=Manager,dc=$DOMAIN,dc=$SUFFIX
cn: Manager
description: LDAP administrator
objectClass: organizationalRole
objectClass: top
roleOccupant: dc=$DOMAIN,dc=$SUFFIX

dn: cn=Replicator,dc=example,dc=org
cn: Replicator
description: LDAP replicator
objectClass: organizationalPerson
objectClass: top
sn: Replicator
userPassword: $REPLPASSCRYPT

# People, $DOMAIN.$SUFFIX
dn: ou=People,dc=$DOMAIN,dc=$SUFFIX
ou: People
objectClass: top
objectClass: organizationalUnit

# Groups, $DOMAIN.$SUFFIX
dn: ou=Groups,dc=$DOMAIN,dc=$SUFFIX
ou: Groups
objectClass: top
objectClass: organizationalUnit

# Users, Groups, $DOMAIN.$SUFFIX
dn: cn=Users,ou=Groups,dc=$DOMAIN,dc=$SUFFIX
objectClass: top
objectClass: posixGroup
cn: Users
description: Generic Users Group
gidNumber: 32000
############
