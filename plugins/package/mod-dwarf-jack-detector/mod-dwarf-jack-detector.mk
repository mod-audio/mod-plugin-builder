######################################
#
# mod-dwarf-jack-detector
#
######################################

MOD_DWARF_JACK_DETECTOR_VERSION = f3a47fba802991797c0b724fb9a17642e9d9f0b8
MOD_DWARF_JACK_DETECTOR_SITE = $(call github,moddevices,mod-dwarf-jack-detector,$(MOD_DWARF_JACK_DETECTOR_VERSION))
MOD_DWARF_JACK_DETECTOR_DEPENDENCIES = alsa-lib
MOD_DWARF_JACK_DETECTOR_BUNDLES = mod-auto-input-selector.lv2 mod-auto-output-selector.lv2 mod-cv-jack-detector.lv2

MOD_DWARF_JACK_DETECTOR_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define MOD_DWARF_JACK_DETECTOR_BUILD_CMDS
	$(MOD_DWARF_JACK_DETECTOR_TARGET_MAKE)
endef

define MOD_DWARF_JACK_DETECTOR_INSTALL_TARGET_CMDS
	$(MOD_DWARF_JACK_DETECTOR_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
