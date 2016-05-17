#!/usr/bin/make -f
# Makefile for eg-amp.lv2 #
# ----------------------- #
# Created by falkTX
#

include Makefile.mk

# --------------------------------------------------------------

PREFIX  ?= /usr/local
DESTDIR ?=

# --------------------------------------------------------------
# Default target is to build all plugins

all: build
build: eg-amp

# --------------------------------------------------------------
# eg-amp build rules

eg-amp: eg-amp.lv2/amp$(LIB_EXT) eg-amp.lv2/manifest.ttl

eg-amp.lv2/amp$(LIB_EXT): amp.c
	$(CC) $^ $(BUILD_C_FLAGS) $(LINK_FLAGS) -lm $(SHARED) -o $@

eg-amp.lv2/manifest.ttl: eg-amp.lv2/manifest.ttl.in
	sed -e "s|@LIB_EXT@|$(LIB_EXT)|" $< > $@

# --------------------------------------------------------------

clean:
	rm -f eg-amp.lv2/amp$(LIB_EXT) eg-amp.lv2/manifest.ttl

# --------------------------------------------------------------

install: build
	install -d $(DESTDIR)$(PREFIX)/lib/lv2/eg-amp.lv2

	install -m 644 eg-amp.lv2/*.so  $(DESTDIR)$(PREFIX)/lib/lv2/eg-amp.lv2/
	install -m 644 eg-amp.lv2/*.ttl $(DESTDIR)$(PREFIX)/lib/lv2/eg-amp.lv2/

# --------------------------------------------------------------
