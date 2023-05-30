
# syncrepl directive
syncrepl rid=00${SID}
         provider=ldap://$REMOTE
         bindmethod=simple
         binddn="cn=Replicator,dc=$DOMAIN,dc=$SUFFIX"
         credentials=$REPLPASS
         searchbase="dc=$DOMAIN,dc=$SUFFIX"
         schemachecking=on
         type=refreshAndPersist
         retry="60 +"

mirrormode on
