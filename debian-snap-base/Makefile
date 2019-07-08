include ../Makefile.conf

IMAGE=debian-snap-base

VERSION=$$(VERSION)
NODE_VERSION=$$(NODE_VERSION)

EXTRAOPTIONS=--build-arg NODE_VERSION=$(NODE_VERSION)

all: build tag

mrproper: clean_images clean
