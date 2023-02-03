######################################
#
# mod-dwarf-jack-detector
#
######################################

MOD_DWARF_JACK_DETECTOR_VERSION = c3eb2464c13938b681ba91e4dfb20bcbc1502210
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
