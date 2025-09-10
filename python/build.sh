#!/bin/sh

EXTRAVERSION=-202408-01
ALPINE=3.20

for PY in 9 10 11 12; do
    UPSTREAM=3.${PY}-alpine${ALPINE}
    MANIFEST_VERSION=3.${PY}-stable

    make itso \
        UPSTREAM=${UPSTREAM} \
        VERSION=3.${PY} \
        EXTRAVERSION=${EXTRAVERSION}
        MANIFEST_VERSION=${MANIFEST_VERSION}

done
