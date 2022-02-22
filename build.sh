#!/bin/bash -e

BASE=3.15-202202-01
VERSION=7.4.28-r0
VERSION8=8.0.16-r0
EXTRAVERSION=-202202-01
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

# First off, we build the base php 7 image.
pushd php/base/php7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE} build && \
  docker tag ${REGISTRY}/base-php:${VERSION}${EXTRAVERSION} ${REGISTRY}/base-php:7.4-${STABILITY} && \
  popd

# Build the base php 7 image with NewRelic.
pushd php/base/php7-newrelic && \
  make VERSION=${VERSION} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/base-php:${VERSION}-NR${EXTRAVERSION} ${REGISTRY}/base-php:7.4-NR-${STABILITY} && \
  popd

# Build the standard php 7 image.
pushd php/php7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php:${VERSION}${EXTRAVERSION} ${REGISTRY}/php:7.4-stable && \
  popd

# Build the standard php 7 image with New Relic.
pushd php/php7 && \
  make VERSION=${VERSION} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION}-NR${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php:${VERSION}-NR${EXTRAVERSION} ${REGISTRY}/php:7.4-NR-${STABILITY} && \
  popd

# Build the k8s php 7 image.
pushd php/php-k8s-v7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php-k8s:${VERSION}${EXTRAVERSION} ${REGISTRY}/php-k8s:7.4-${STABILITY} && \
  popd

# Build the k8s php 7 image with New Relic.
pushd php/php-k8s-v7 && \
  make VERSION=${VERSION} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION}-NR${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php-k8s:${VERSION}-NR${EXTRAVERSION} ${REGISTRY}/php-k8s:7.4-NR-${STABILITY} && \
  popd

# Build the php 7 builder image.
pushd php/builder7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=14-alpine build && \
  docker tag ${REGISTRY}/unified-builder:${VERSION}${EXTRAVERSION} ${REGISTRY}/unified-builder:7.4-${STABILITY} && \
  popd

# First off, we build the base php 8 image.
pushd php/base/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE} build && \
  docker tag ${REGISTRY}/base-php:${VERSION8}${EXTRAVERSION} ${REGISTRY}/base-php:8.0-${STABILITY} && \
  popd

# Build the base php 8 image with NewRelic.
pushd php/base/php8-newrelic && \
  make VERSION=${VERSION8} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/base-php:${VERSION8}-NR${EXTRAVERSION} ${REGISTRY}/base-php:8.0-NR-${STABILITY} && \
  popd

# Build the standard php 8 image.
pushd php/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php:${VERSION8}${EXTRAVERSION} ${REGISTRY}/php:8.0-${STABILITY} && \
  popd

# Build the standard php 8 image with New Relic.
pushd php/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION8}-NR${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php:${VERSION8}-NR${EXTRAVERSION} ${REGISTRY}/php:8.0-NR-${STABILITY} && \
  popd

# Build the k8s php 8 image.
pushd php/php-k8s-v8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php-k8s:${VERSION8}${EXTRAVERSION} ${REGISTRY}/php-k8s:8.0-${STABILITY} && \
  popd

# Build the k8s php 8 image with New Relic.
pushd php/php-k8s-v8 && \
  make VERSION=${VERSION8} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION8}-NR${EXTRAVERSION} build && \
  docker tag ${REGISTRY}/php-k8s:${VERSION8}-NR${EXTRAVERSION} ${REGISTRY}/php-k8s:8.0-NR-${STABILITY} && \
  popd

# Build the php 8 builder image.
pushd php/builder8 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=16-alpine build && \
  docker tag ${REGISTRY}/unified-builder:${VERSION}${EXTRAVERSION} ${REGISTRY}/unified-builder:8.0-${STABILITY} && \
  popd

# Login, so we can push.
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/unocha
