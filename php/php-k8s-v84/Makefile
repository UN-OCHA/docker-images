include ../../Makefile.conf
include ../../Makefile.buildx.conf
include ../Makefile.conf

UPSTREAM=$$(UPSTREAM)
VERSION=$$(VERSION)
IMAGE=php-k8s

all: template buildx testx tagx clean_images

mrproper: clean_images clean
