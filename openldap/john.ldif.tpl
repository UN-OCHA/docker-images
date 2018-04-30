# user_joe.ldif
dn: uid=johndoe,ou=People,dc=$DOMAIN,dc=$SUFFIX
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: johndoe
cn: John Doe
sn: Doe
givenName: John
title: Mr. Nobody
telephoneNumber: +0 000 000 0000
mobile: +0 000 000 0000
postalAddress: AddressLine1$AddressLine2$AddressLine3
userPassword: $JOHNPASS
labeledURI: https://$DOMAIN.$SUFFIX/
loginShell: /bin/bash
uidNumber: 9999
gidNumber: 9999
homeDirectory: /home/johndoe/
description: This is an example user
