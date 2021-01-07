######################################
#
# mod-midi-utilities
#
######################################

MOD_MIDI_UTILITIES_VERSION = c912a9556a028df5d59838778b8b3c31f0d394b0
MOD_MIDI_UTILITIES_SITE = $(call github,moddevices,mod-midi-utilities,$(MOD_MIDI_UTILITIES_VERSION))
MOD_MIDI_UTILITIES_BUNDLES = midi-switchbox_1-2_2C.lv2 midi-switchbox_1-2.lv2 midi-switchbox_1-3.lv2 midi-switchbox_2-1_2C.lv2 midi-switchbox_2-1.lv2 midi-switchbox_3-1.lv2

MOD_MIDI_UTILITIES_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define MOD_MIDI_UTILITIES_BUILD_CMDS
	$(MOD_MIDI_UTILITIES_TARGET_MAKE)
endef

define MOD_MIDI_UTILITIES_INSTALL_TARGET_CMDS
	$(MOD_MIDI_UTILITIES_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/midi-switchbox_1-2_2C.lv2/* $(TARGET_DIR)/usr/lib/lv2/midi-switchbox_1-2_2C.lv2/
	cp -rL $($(PKG)_PKGDIR)/midi-switchbox_1-2.lv2/*    $(TARGET_DIR)/usr/lib/lv2/midi-switchbox_1-2.lv2/
	cp -rL $($(PKG)_PKGDIR)/midi-switchbox_1-3.lv2/*    $(TARGET_DIR)/usr/lib/lv2/midi-switchbox_1-3.lv2/
	cp -rL $($(PKG)_PKGDIR)/midi-switchbox_2-1_2C.lv2/* $(TARGET_DIR)/usr/lib/lv2/midi-switchbox_2-1_2C.lv2/
	cp -rL $($(PKG)_PKGDIR)/midi-switchbox_2-1.lv2/*    $(TARGET_DIR)/usr/lib/lv2/midi-switchbox_2-1.lv2/
	cp -rL $($(PKG)_PKGDIR)/midi-switchbox_3-1.lv2/*    $(TARGET_DIR)/usr/lib/lv2/midi-switchbox_3-1.lv2/
endef

$(eval $(generic-package))
