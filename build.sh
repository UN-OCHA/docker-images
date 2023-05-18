#!/bin/bash -e

SEVEN=0
EIGHT=1
EIGHTONE=1
EIGHTTWO=1

BASE=3.17
VERSION=7.4.33-r0
VERSION8=8.0.28-r0
VERSION81=8.1.19-r0
VERSION82=8.2.6-r1
EXTRAVERSION=-202305-01

STABILITY=stable
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
SAVEBASE=${BASE}
BASE=3.15-202203-01
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

# Build the php 7 builder image.
pushd php/builder7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=alpine-14 build && \
  docker tag ${REGISTRY}/unified-builder:${VERSION}${EXTRAVERSION} ${REGISTRY}/unified-builder:7.4-${STABILITY} && \
  popd

BASE=${SAVEBASE}

else
  echo "Skipping PHP7 builds."
fi

if [ ${EIGHT} -eq 1 ]; then
SAVEBASE=${BASE}
BASE=3.16

# First off, we build the base php 8 image.
pushd php/base/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE} build && \
  docker tag ${REGISTRY}/base-php:${VERSION8}${EXTRAVERSION} ${REGISTRY}/base-php:8.0-${STABILITY} && \
  popd

# Build the standard php 8 image.
pushd php/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php:${VERSION8}${EXTRAVERSION} ${REGISTRY}/php:8.0-${STABILITY} && \
  popd

# Build the k8s php 8 image.
pushd php/php-k8s-v8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php-k8s:${VERSION8}${EXTRAVERSION} ${REGISTRY}/php-k8s:8.0-${STABILITY} && \
  popd

# Build the php 8 builder image.
# pushd php/builder8 && \
#    make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=16.19.0-alpine3.16 build && \
#    docker tag ${REGISTRY}/unified-builder:${VERSION8}${EXTRAVERSION} ${REGISTRY}/unified-builder:8.0-${STABILITY} && \
#   popd

BASE=${SAVEBASE}

else
  echo "Skipping PHP8 builds."
fi


if [ ${EIGHTONE} -eq 1 ]; then

# First off, we build the base php 8.1 image.
pushd php/base/php81 && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE} build && \
  docker tag ${REGISTRY}/base-php:${VERSION81}${EXTRAVERSION} ${REGISTRY}/base-php:8.1-${STABILITY} && \
  popd

# Build the standard php 8.1 image.
pushd php/php81 && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION81}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php:${VERSION81}${EXTRAVERSION} ${REGISTRY}/php:8.1-${STABILITY} && \
  popd

# Build the k8s php 81 image.
pushd php/php-k8s-v81 && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION81}${EXTRAVERSION} && \
  docker tag ${REGISTRY}/php-k8s:${VERSION81}${EXTRAVERSION} ${REGISTRY}/php-k8s:8.1-${STABILITY} && \
  popd

# Build the php 8.1 builder image.
# pushd php/builder81 && \
#   make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=16.19.0-alpine build && \
#   docker tag ${REGISTRY}/unified-builder:${VERSION81}${EXTRAVERSION} ${REGISTRY}/unified-builder:8.1-${STABILITY} && \
#   popd

else
  echo "Skipping PHP8.1 builds."
fi

if [ ${EIGHTTWO} -eq 1 ]; then
# STABILITY=unstable
SAVEBASE=${BASE}
BASE=3.18

# First off, we build the base php 8.2 image.
pushd php/base/php82 && \
  make VERSION=${VERSION82} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE} build && \
  docker tag ${REGISTRY}/base-php:${VERSION82}${EXTRAVERSION} ${REGISTRY}/base-php:8.2-${STABILITY} && \
  popd

# Build the standard php 8.2 image.
pushd php/php82 && \
  make VERSION=${VERSION82} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION82}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php:${VERSION82}${EXTRAVERSION} ${REGISTRY}/php:8.2-${STABILITY} && \
  popd

# Build the k8s php 82 image.
pushd php/php-k8s-v82 && \
  make VERSION=${VERSION82} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION82}${EXTRAVERSION} && \
  docker tag ${REGISTRY}/php-k8s:${VERSION82}${EXTRAVERSION} ${REGISTRY}/php-k8s:8.2-${STABILITY} && \
  popd

# Do not bother with New Relic since we will stop using it.

# Since sass is not needed, node is not needed, which means builder is not needed.

# Build the php 8.2 builder image.
# pushd php/builder82 && \
#   make VERSION=${VERSION82} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=16-alpine build && \
#   docker tag ${REGISTRY}/unified-builder:${VERSION82}${EXTRAVERSION} ${REGISTRY}/unified-builder:8.2-${STABILITY} && \
#   popd

else
  echo "Skipping PHP8.2 builds."
fi

# Login, so we can push.
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/unocha
