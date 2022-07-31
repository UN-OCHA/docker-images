#!/bin/bash -e

SEVEN=0
EIGHT=0
EIGHTONE=1

# BASE=3.15-202203-01
BASE=3.16-202206-01
VERSION=7.4.30-r0
VERSION8=8.0.21-r0
VERSION81=8.1.8-r0
EXTRAVERSION=-202207-02
STABILITY=develop
REGISTRY=public.ecr.aws/unocha

# Is there a version?
if [ -z "${VERSION}" ]; then
  echo "The scripts require a non-empty version string."
  exit 1
fi

# Is there an extra version?
if [ -z "${EXTRAVERSION}" ]; then
  echo "The scripts require a non-empty extraversion string."
  exit 1
fi

# Login, so we can pull.
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/unocha

if [ ${SEVEN} -eq 1 ]; then
PHP=7

# First off, we build the base php 7 image.
pushd php/base/php7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE} build && \
  docker tag ${REGISTRY}/base-php:${VERSION}${EXTRAVERSION} ${REGISTRY}/base-php:7.4-${STABILITY} && \
  popd

# Build the standard php 7 image.
pushd php/php7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php:${VERSION}${EXTRAVERSION} ${REGISTRY}/php:7.4-stable && \
  popd

# Build the k8s php 7 image.
pushd php/php-k8s-v7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php-k8s:${VERSION}${EXTRAVERSION} ${REGISTRY}/php-k8s:7.4-${STABILITY} && \
  popd

# Build the k8s php 7 image with New Relic.
pushd php/php-k8s-v7-NR && \
  make VERSION=${VERSION} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php-k8s:${VERSION}-NR${EXTRAVERSION} ${REGISTRY}/php-k8s:7.4-NR-${STABILITY} && \
  popd

# Build the php 7 builder image.
# pushd php/builder7 && \
#   make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=14-alpine build && \
#   docker tag ${REGISTRY}/unified-builder:${VERSION}${EXTRAVERSION} ${REGISTRY}/unified-builder:7.4-${STABILITY} && \
#   popd

else
  echo "Skipping PHP7 builds."
fi

if [ ${EIGHT} -eq 1 ]; then
PHP=8

# First off, we build the base php 8 image.
pushd php/base/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE} PHP=${PHP} build && \
  docker tag ${REGISTRY}/base-php:${VERSION8}${EXTRAVERSION} ${REGISTRY}/base-php:8.0-${STABILITY} && \
  popd

# Build the standard php 8 image.
pushd php/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} PHP=${PHP} build && \
  docker tag ${REGISTRY}/php:${VERSION8}${EXTRAVERSION} ${REGISTRY}/php:8.0-${STABILITY} && \
  popd

# Build the k8s php 8 image.
pushd php/php-k8s-v8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} PHP=${PHP} build && \
  docker tag ${REGISTRY}/php-k8s:${VERSION8}${EXTRAVERSION} ${REGISTRY}/php-k8s:8.0-${STABILITY} && \
  popd

# Build the k8s php 8 image with New Relic.
pushd php/php-k8s-v8-NR && \
  make VERSION=${VERSION8} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} PHP=${PHP} build && \
  docker tag ${REGISTRY}/php-k8s:${VERSION8}-NR${EXTRAVERSION} ${REGISTRY}/php-k8s:8.0-NR-${STABILITY} && \
  popd

# Build the php 8 builder image.
pushd php/builder8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=16-alpine PHP=${PHP} build && \
  docker tag ${REGISTRY}/unified-builder:${VERSION8}${EXTRAVERSION} ${REGISTRY}/unified-builder:8.0-${STABILITY} && \
  popd

else
  echo "Skipping PHP8 builds."
fi


if [ ${EIGHTONE} -eq 1 ]; then
PHP=81

# First off, we build the base php 8.1 image.
if [ true = false ]; then
pushd php/base/php81 && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE} build && \
  docker tag ${REGISTRY}/base-php:${VERSION81}${EXTRAVERSION} ${REGISTRY}/base-php:8.1-${STABILITY} && \
  popd

# Build the standard php 8.1 image.
pushd php/php8 && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION81}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php:${VERSION81}${EXTRAVERSION} ${REGISTRY}/php:8.1-${STABILITY} && \
  popd
fi

# Build the k8s php 81 image.
pushd php/php-k8s-v81 && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION81}${EXTRAVERSION} && \
  docker tag ${REGISTRY}/php-k8s:${VERSION81}${EXTRAVERSION} ${REGISTRY}/php-k8s:8.1-${STABILITY} && \
  popd

# Build the k8s php 8 image with New Relic.
pushd php/php-k8s-v81-NR && \
  make VERSION=${VERSION81} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION81}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php-k8s:${VERSION81}-NR${EXTRAVERSION} ${REGISTRY}/php-k8s:8.1-NR-${STABILITY} && \
  popd

# Build the php 8.1 builder image.
pushd php/builder81 && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=16-alpine build && \
  docker tag ${REGISTRY}/unified-builder:${VERSION81}${EXTRAVERSION} ${REGISTRY}/unified-builder:8.1-${STABILITY} && \
  popd

else
  echo "Skipping PHP8 builds."
fi

# Login, so we can push.
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/unocha
