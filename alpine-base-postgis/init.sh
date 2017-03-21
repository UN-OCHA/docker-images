#!/bin/sh

set -e

PGSQL_USER=${PGSQL_USER:-"gis"}
PGSQL_PASS=${PGSQL_PASS:-"gis"}
PGSQL_DB=${PGSQL_DB:-"gis"}

if [ "$1" != "-s" ]; then
    echo "By running this script,"
    echo "$PGSQL_USER user will be created as superuser and with $PGSQL_PASS as password,"
    echo "database $PGSQL_DB owned by $PGSQL_USER will be created"
    echo "and postgis and postgis_topology will be created."

    read -p "Are you sure? (y) " -n 1 -r ACCEPT

    if [ "$ACCEPT" != "y" ]; then
        echo -e "\nAborting."
        exit 1
    fi
    echo ""
fi

cat << EOSQL > /srv/template.plsql
CREATE USER $PGSQL_USER WITH SUPERUSER;
ALTER USER $PGSQL_USER WITH PASSWORD '$PGSQL_PASS';
CREATE DATABASE $PGSQL_DB OWNER $PGSQL_USER;
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;
EOSQL

s6-setuidgid postgres psql -f /srv/template.plsql
