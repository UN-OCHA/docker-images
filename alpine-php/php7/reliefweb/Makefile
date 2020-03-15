include ../../../Makefile.conf
include ../../Makefile.conf

UPSTREAM=$$(UPSTREAM))
VERSION=$$(VERSION))
IMAGE=php7-reliefweb
EXTRAOPTIONS=--build-arg PHP_HOEDOWN_VERSION=$(PHP_HOEDOWN_VERSION)

all: template build tag clean_images

mrproper: clean_images clean
