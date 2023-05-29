#!/usr/bin/with-contenv sh

BASEDIR=/srv/solr

cd $BASEDIR

bin/solr create -c demo
