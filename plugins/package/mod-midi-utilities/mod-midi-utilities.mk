######################################
#
# mod-midi-utilities
#
######################################

MOD_MIDI_UTILITIES_VERSION = 66dde869ffc09326dccab14e4b227ff9738c591b
MOD_MIDI_UTILITIES_SITE = $(call github,moddevices,mod-midi-utilities,$(MOD_MIDI_UTILITIES_VERSION))
MOD_MIDI_UTILITIES_BUNDLES = midi-switchbox.lv2 peak-to-cc.lv2

MOD_MIDI_UTILITIES_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define MOD_MIDI_UTILITIES_BUILD_CMDS
	$(MOD_MIDI_UTILITIES_TARGET_MAKE)
endef

define MOD_MIDI_UTILITIES_INSTALL_TARGET_CMDS
	$(MOD_MIDI_UTILITIES_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
