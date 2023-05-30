MAKE = make

VERSION=$$(VERSION))
EXTRAVERSION=$$(EXTRAVERSION))

SUBDIRS = elasticsearch kibana logstash curator

.PHONY: subdirs $(SUBDIRS)

subdirs: $(SUBDIRS)

$(SUBDIRS):
	@echo "Running make in $@"
	$(MAKE) -C $@
