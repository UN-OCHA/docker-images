#!/bin/bash -e

EXTRAVERSION=-202607-01
ALPINE=3.24

for PY in 12 13 14; do
    UPSTREAM=3.${PY}-alpine${ALPINE}
    VERSION=3.${PY}
    MANIFEST_VERSION=3.${PY}-stable

    make \
        UPSTREAM=${UPSTREAM} \
        VERSION=${VERSION} \
        EXTRAVERSION=${EXTRAVERSION} \
        MANIFEST_VERSION=${MANIFEST_VERSION} \
        buildx tagx

    echo
    echo "Built and pushed public.ecr.aws/unocha/python:${VERSION}${EXTRAVERSION} (${MANIFEST_VERSION})"
    echo

done

for PY in 15; do
    UPSTREAM=3.${PY}-rc-alpine${ALPINE}
    VERSION=3.${PY}
    MANIFEST_VERSION=3.${PY}-unstable

    make \
        UPSTREAM=${UPSTREAM} \
        VERSION=${VERSION} \
        EXTRAVERSION=${EXTRAVERSION} \
        MANIFEST_VERSION=${MANIFEST_VERSION} \
        buildx tagx

    echo
    echo "Built and pushed public.ecr.aws/unocha/python:${VERSION}${EXTRAVERSION} (${MANIFEST_VERSION})"
    echo

done
