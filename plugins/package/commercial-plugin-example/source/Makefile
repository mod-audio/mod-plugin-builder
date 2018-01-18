AR ?= gcc-ar
STRIP ?= strip

INCDIR ?= .
LIBDIR ?= .

CFLAGS += -O3 -fvisibility=hidden -fdata-sections -ffunction-sections -flto -fPIC -std=gnu99
CFLAGS += -Wall -Wextra -Werror -Wno-unused-parameter -I$(INCDIR)

LDFLAGS += -fvisibility=hidden -fdata-sections -ffunction-sections -flto
LDFLAGS += -Wl,--gc-sections -Wl,-O1 -Wl,--as-needed -Wl,--strip-all -L$(LIBDIR)

PREFIX ?= /usr
LV2DIR ?= $(PREFIX)/lib/lv2

PLUGIN = commercial-plugin-example
BUNDLE = $(PLUGIN).lv2

INSTALL_DIR = $(DESTDIR)$(LV2DIR)/$(BUNDLE)

$(PLUGIN).so: $(PLUGIN).c
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ -shared -Wl,--no-undefined -o $@ -lmodla
	$(STRIP) -s -x -X -R .comment -R .eh_frame -R .eh_frame_hdr -R .note.gnu.build-id -R .note.ABI-tag $@

install: $(PLUGIN).so
	install -d $(INSTALL_DIR)
	install -m 755 $(PLUGIN).so $(INSTALL_DIR)
	install -m 644 *.ttl $(INSTALL_DIR)

clean:
	rm -f $(PLUGIN).so
