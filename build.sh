#!/bin/bash -e

BASE=3.14-202106-01
VERSION=7.4.23-r0
VERSION8=8.0.10-r0
EXTRAVERSION=-202109-01
STABILITY=stable

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
pushd alpine-base-php/php7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE} build && \
  docker tag unocha/base-php:${VERSION}${EXTRAVERSION} unocha/base-php:7.4-${STABILITY} && \
  popd

# Build the base php 7 image with NewRelic.
pushd alpine-base-php/php7-newrelic && \
  make VERSION=${VERSION} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION}${EXTRAVERSION} build && \
  docker tag unocha/base-php:${VERSION}-NR${EXTRAVERSION} unocha/base-php:7.4-NR-${STABILITY} && \
  popd

# Build the standard php 7 image.
pushd alpine-php/php7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION}${EXTRAVERSION} build && \
  docker tag unocha/php:${VERSION}${EXTRAVERSION} unocha/php:7.4-stable && \
  docker tag unocha/php:${VERSION}${EXTRAVERSION} public.ecr.aws/unocha/php:${VERSION}${EXTRAVERSION} && \
  docker tag unocha/php:${VERSION}${EXTRAVERSION} public.ecr.aws/unocha/php:7.4-${STABILITY} && \
  popd

# Build the standard php 7 image with New Relic.
pushd alpine-php/php7 && \
  make VERSION=${VERSION} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION}-NR${EXTRAVERSION} build && \
  docker tag unocha/php:${VERSION}-NR${EXTRAVERSION} unocha/php:7.4-NR-${STABILITY} && \
  docker tag unocha/php:${VERSION}-NR${EXTRAVERSION} public.ecr.aws/unocha/php:${VERSION}-NR${EXTRAVERSION} && \
  docker tag unocha/php:${VERSION}-NR${EXTRAVERSION} public.ecr.aws/unocha/php:7.4-NR-${STABILITY} && \
  popd

# Build the k8s php 7 image.
pushd alpine-php/php-k8s-v7 && \
  make VERSION=${VERSION} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION}${EXTRAVERSION} build && \
  docker tag unocha/base-php:${VERSION}${EXTRAVERSION} unocha/php-k8s:7.4-${STABILITY} && \
  docker tag unocha/base-php:${VERSION}${EXTRAVERSION} public.ecr.aws/unocha/php-k8s:${VERSION}${EXTRAVERSION} && \
  docker tag unocha/base-php:${VERSION}${EXTRAVERSION} public.ecr.aws/unocha/php-k8s:7.4-${STABILITY} && \
  popd

# Build the k8s php 7 image with New Relic.
pushd alpine-php/php-k8s-v7 && \
  make VERSION=${VERSION} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION}-NR${EXTRAVERSION} build && \
  docker tag unocha/php-k8s:${VERSION}-NR${EXTRAVERSION} unocha/php-k8s:7.4-NR-${STABILITY} && \
  docker tag unocha/php-k8s:${VERSION}-NR${EXTRAVERSION} public.ecr.aws/unocha/php-k8s:${VERSION}-NR${EXTRAVERSION} && \
  docker tag unocha/php-k8s:${VERSION}-NR${EXTRAVERSION} public.ecr.aws/unocha/php-k8s:7.4-NR-${STABILITY} && \
  popd

# First off, we build the base php 8 image.
pushd alpine-base-php/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${BASE} build && \
  docker tag unocha/base-php:${VERSION8}${EXTRAVERSION} unocha/base-php:8.0-${STABILITY} && \
  popd

# Build the base php 8 image with NewRelic.
pushd alpine-base-php/php8-newrelic && \
  make VERSION=${VERSION8} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} build && \
  docker tag unocha/base-php:${VERSION8}-NR${EXTRAVERSION} unocha/base-php:8.0-NR-${STABILITY} && \
  popd

# Build the standard php 8 image.
pushd alpine-php/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} build && \
  docker tag unocha/php:${VERSION8}${EXTRAVERSION} unocha/php:8.0-${STABILITY} && \
  docker tag unocha/php:${VERSION8}${EXTRAVERSION} public.ecr.aws/unocha/php:${VERSION8}${EXTRAVERSION} && \
  docker tag unocha/php:${VERSION8}${EXTRAVERSION} public.ecr.aws/unocha/php:8.0-${STABILITY} && \
  popd

# Build the standard php 8 image with New Relic.
pushd alpine-php/php8 && \
  make VERSION=${VERSION8} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION8}-NR${EXTRAVERSION} build && \
  docker tag unocha/php:${VERSION8}-NR${EXTRAVERSION} unocha/php:8.0-NR-${STABILITY} && \
  docker tag unocha/php:${VERSION8}-NR${EXTRAVERSION} public.ecr.aws/unocha/php:${VERSION8}-NR${EXTRAVERSION} && \
  docker tag unocha/php:${VERSION8}-NR${EXTRAVERSION} public.ecr.aws/unocha/php:8.0-NR-${STABILITY} && \
  popd

# Build the k8s php 8 image.
pushd alpine-php/php-k8s-v8 && \
  make VERSION=${VERSION8} EXTRAVERSION=${EXTRAVERSION} UPSTREAM=${VERSION8}${EXTRAVERSION} build && \
  docker tag unocha/php-k8s:${VERSION8}${EXTRAVERSION} unocha/php-k8s:8.0-${STABILITY} && \
  docker tag unocha/php-k8s:${VERSION8}${EXTRAVERSION} public.ecr.aws/unocha/php-k8s:${VERSION8}${EXTRAVERSION} && \
  docker tag unocha/php-k8s:${VERSION8}${EXTRAVERSION} public.ecr.aws/unocha/php-k8s:8.0-${STABILITY} && \
  popd

# Build the k8s php 8 image with New Relic.
pushd alpine-php/php-k8s-v8 && \
  make VERSION=${VERSION8} EXTRAVERSION=-NR${EXTRAVERSION} UPSTREAM=${VERSION8}-NR${EXTRAVERSION} build && \
  docker tag unocha/php-k8s:${VERSION8}-NR${EXTRAVERSION} unocha/php-k8s:8.0-NR-${STABILITY} && \
  docker tag unocha/php-k8s:${VERSION8}-NR${EXTRAVERSION} public.ecr.aws/unocha/php-k8s:${VERSION8}-NR${EXTRAVERSION} && \
  docker tag unocha/php-k8s:${VERSION8}-NR${EXTRAVERSION} public.ecr.aws/unocha/php-k8s:8.0-NR-${STABILITY} && \
  popd

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/unocha
