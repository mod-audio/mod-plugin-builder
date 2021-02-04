
VERSION = $(shell cat VERSION)
MINOR_VERSION = $(word 2, $(subst ., ,$(VERSION)))
MICRO_VERSION = $(word 3, $(subst ., ,$(VERSION)))

CFLAGS += -I. -Iprops.lv2 -fPIC -Wall -Wextra -std=gnu11 -D_GNU_SOURCE -fvisibility=hidden -DNOTES_VERSION="$(VERSION)"
LDFLAGS += -Wl,--no-undefined

TARGETS = notes.lv2/notes.so notes.lv2/manifest.ttl notes.lv2/notes.ttl

all: $(TARGETS)

clean:
	rm -rf notes.lv2 *.o

install: $(TARGETS)
	install -d $(DESTDIR)/usr/lib/lv2/notes.lv2
	install -m 644 $(TARGETS) $(DESTDIR)/usr/lib/lv2/notes.lv2

notes.lv2/notes.so: notes.o
	-mkdir -p $(shell dirname $@)
	$(CC) $< $(LDFLAGS) -shared -o $@

notes.lv2/manifest.ttl: manifest.ttl.in
	-mkdir -p $(shell dirname $@)
	sed $< \
		-e "s/@MODULE_SUFFIX@/.so/" \
		-e "s/@MINOR_VERSION@/$(MINOR_VERSION)/" \
		-e "s/@MICRO_VERSION@/$(MICRO_VERSION)/" > $@

notes.lv2/notes.ttl: notes.ttl
	-mkdir -p $(shell dirname $@)
	cp $< $@

notes.o: notes.c
	$(CC) $< $(CFLAGS) -c -o $@
