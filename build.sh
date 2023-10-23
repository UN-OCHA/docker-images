#!/bin/bash -e
#
BASE=lol

SEVEN=0
EIGHT=1
EIGHTONE=1
EIGHTTWO=1
EIGHTTHREE=1

BASE7=3.15-202203-01
BASE8=3.16
BASE81=3.17
BASE82=3.18
BASE83=3.18

VERSION=7.4.33-r1
VERSION8=8.0.30-r0
VERSION81=8.1.22-r0
VERSION82=8.2.10-r0
VERSION83=8.3.0_rc4-r1

EXTRAVERSION=-202310-02

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
PHP=7

# First off, we build the base php 7 image.
pushd php/base/php7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE7} buildx && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=7.4-${STABILITY} tagx && \
  popd

# Build the standard php 7 image.
pushd php/php7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION}${EXTRAVERSION} buildx && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=7.4-${STABILITY} tagx && \
  popd

# Build the k8s php 7 image.
pushd php/php-k8s-v7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION}${EXTRAVERSION} buildx && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=7.4-${STABILITY} tagx && \
  popd

# Build the php 7 builder image.
pushd php/builder7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=alpine-14 build && \
  docker tag ${REGISTRY}/unified-builder:${VERSION}${EXTRAVERSION} ${REGISTRY}/unified-builder:7.4-${STABILITY} && \
  popd

else
  echo "Skipping PHP7 builds."
fi

if [ ${EIGHT} -eq 1 ]; then

# First off, we build the base php 8 image.
pushd php/base/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE8} buildx && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.0-${STABILITY} tagx && \
  popd

# Build the standard php 8 image.
pushd php/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} buildx && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.0-${STABILITY} tagx && \
  popd

# Build the k8s php 8 image.
pushd php/php-k8s-v8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} buildx && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.0-${STABILITY} tagx && \
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
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE81} buildx && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.1-${STABILITY} tagx && \
  popd

# Build the standard php 8.1 image.
pushd php/php81 && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION81}${EXTRAVERSION} buildx && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.1-${STABILITY} tagx && \
  popd

# Build the k8s php 81 image.
pushd php/php-k8s-v81 && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION81}${EXTRAVERSION} buildx && \
  make VERSION=${VERSION81} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.1-${STABILITY} tagx && \
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

# First off, we build the base php 8.2 image.
pushd php/base/php82 && \
  make VERSION=${VERSION82} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE82} buildx && \
  make VERSION=${VERSION82} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.2-${STABILITY} tagx && \
  popd

# Build the standard php 8.2 image.
pushd php/php82 && \
  make VERSION=${VERSION82} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION82}${EXTRAVERSION} buildx && \
  make VERSION=${VERSION82} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.2-${STABILITY} tagx && \
  popd

# Build the k8s php 82 image.
pushd php/php-k8s-v82 && \
  make VERSION=${VERSION82} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION82}${EXTRAVERSION} buildx && \
  make VERSION=${VERSION82} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.2-${STABILITY} tagx && \
  popd

# Since sass is not needed, node is not needed, which means builder is not needed.

# Build the php 8.2 builder image.
# pushd php/builder82 && \
#   make VERSION=${VERSION82} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=16-alpine build && \
#   docker tag ${REGISTRY}/unified-builder:${VERSION82}${EXTRAVERSION} ${REGISTRY}/unified-builder:8.2-${STABILITY} && \
#   popd

else
  echo "Skipping PHP8.2 builds."
fi

if [ ${EIGHTTHREE} -eq 1 ]; then

STABILITY=unstable

# First off, we build the base php 8.3 image.
pushd php/base/php83 && \
  make VERSION=${VERSION83} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE83} buildx && \
  make VERSION=${VERSION83} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.3-${STABILITY} tagx && \
  popd

# Build the standard php 8.3 image.
pushd php/php83 && \
  make VERSION=${VERSION83} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION83}${EXTRAVERSION} buildx && \
  make VERSION=${VERSION83} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.3-${STABILITY} tagx && \
  popd

# Build the k8s php 83 image.
pushd php/php-k8s-v83 && \
  make VERSION=${VERSION83} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION83}${EXTRAVERSION} buildx && \
  make VERSION=${VERSION83} EXTRAVERSION=${EXTRAVERSION} MANIFEST_VERSION=8.3-${STABILITY} tagx && \
  popd

else
  echo "Skipping PHP8.3 builds."
fi

# Login, so we can push.
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/unocha
