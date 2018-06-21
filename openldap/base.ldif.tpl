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

dn: cn=Replicator,dc=$DOMAIN,dc=$SUFFIX
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

# Group, $DOMAIN.$SUFFIX
dn: ou=Group,dc=$DOMAIN,dc=$SUFFIX
ou: Group
objectClass: top
objectClass: organizationalUnit

# Users, Group, $DOMAIN.$SUFFIX
dn: cn=Users,ou=Group,dc=$DOMAIN,dc=$SUFFIX
objectClass: top
objectClass: posixGroup
cn: Users
description: Generic Users Group
gidNumber: 32000

# Role, $DOMAIN.$SUFFIX
dn: ou=Role,dc=$DOMAIN,dc=$SUFFIX
ou: Role
objectClass: top
objectClass: organizationalUnit

# Visitors, Role, $DOMAIN.$SUFFIX
dn: cn=Visitors,ou=Role,dc=$DOMAIN,dc=$SUFFIX
cn: Visitors
objectClass: groupOfNames
member: cn=Manager,dc=$DOMAIN,dc=$SUFFIX
############
