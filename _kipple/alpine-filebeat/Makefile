include ../Makefile.conf

IMAGE=alpine-filebeat

VERSION=$$(VERSION)
EXTRAVERSION=$$(EXTRAVERSION)

all: template build tag clean_images

mrproper: clean_images clean
