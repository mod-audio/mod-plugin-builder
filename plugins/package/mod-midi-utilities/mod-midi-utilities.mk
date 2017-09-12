######################################
#
# mod-midi-utilities
#
######################################

MOD_MIDI_UTILITIES_VERSION = ffa812ca034d0f6e5c924c29f59f78569246d958
MOD_MIDI_UTILITIES_SITE = $(call github,moddevices,mod-midi-utilities,$(MOD_MIDI_UTILITIES_VERSION))
MOD_MIDI_UTILITIES_BUNDLES = midi-switchbox.lv2 peak-to-cc.lv2 midi-inv-switchbox.lv2 midi-switchbox.lv2 midi-switchbox3.lv2 midi-switchbox4.lv2

MOD_MIDI_UTILITIES_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define MOD_MIDI_UTILITIES_BUILD_CMDS
	$(MOD_MIDI_UTILITIES_TARGET_MAKE)
endef

define MOD_MIDI_UTILITIES_INSTALL_TARGET_CMDS
	$(MOD_MIDI_UTILITIES_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
