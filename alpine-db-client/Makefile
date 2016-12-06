include ../alpine-base-php-fpm/Makefile.conf

IMAGE=alpine-db-client
VERSION=201612-01
MYSQL_VERSION=10.1.19-r0
PGSQL_VERSION=9.5.4-r0

all: build tag

build: clean
	$(DOCKER) build \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg VCS_URL=`git config --get remote.origin.url` \
	--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VERSION=$(VERSION) \
	--build-arg MYSQL_VERSION=$(MYSQL_VERSION) \
	--build-arg PGSQL_VERSION=$(PGSQL_VERSION) \
		. | tee buildlog.txt

tag: build
	$(eval IMAGE_HASH=$(shell tail -n 1 buildlog.txt | $(AWK) '{print $$NF}'))
	$(DOCKER) tag $(IMAGE_HASH) $(ORGANISATION)/$(IMAGE):$(VERSION)

push:
→ $(DOCKER) push $(ORGANISATION)/$(IMAGE):$(VERSION)

clean:
	$(RM) -f buildlog.txt

clean_images:
	@echo Clean up intemediate images.
	for i in `$(GREP) '^ ---> ([a-z0-9]){12}$$' buildlog.txt | $(AWK) '{print $$2}'`; do \
		$(DOCKER) rmi -f $$i; \
	done

mrproper: clean_images clean

.PHONY: clean
