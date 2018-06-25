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

# Policy, $DOMAIN.$SUFFIX
dn: ou=Policy,dc=$DOMAIN,dc=$SUFFIX
objectClass: organizationalUnit
objectClass: top
ou: Policy

# default, Policy, $DOMAIN.$SUFFIX
dn: cn=default,ou=Policy,dc=$DOMAIN,dc=$SUFFIX
cn: default policy
objectClass: pwdPolicy
objectClass: person
objectClass: top
pwdAllowUserChange: TRUE
pwdAttribute: userPassword
pwdCheckQuality: 2
pwdExpireWarning: 600
pwdFailureCountInterval: 30
pwdGraceAuthNLimit: 5
pwdInHistory: 5
pwdLockout: TRUE
pwdLockoutDuration: 0
pwdMaxAge: 0
pwdMaxFailure: 5
pwdMinAge: 0
pwdMinLength: 5
pwdMustChange: FALSE
pwdSafeModify: FALSE
sn: default

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

# Visitor, Role, $DOMAIN.$SUFFIX
dn: cn=Visitor,ou=Role,dc=$DOMAIN,dc=$SUFFIX
cn: Visitor
objectClass: groupOfNames
member: cn=Manager,dc=$DOMAIN,dc=$SUFFIX
############
