include ../../Makefile.conf

IMAGE=curator

PYTHON=python:3.6-slim
UPSTREAM=3.6-slim
VERSION=$$(VERSION)
EXTRAVERSION=$$(EXTRAVERSION)

all: template build tag clean_images

mrproper: clean_images clean
