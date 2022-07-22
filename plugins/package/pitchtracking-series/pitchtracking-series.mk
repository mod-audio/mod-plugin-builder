######################################
#
# pitchtracking-series
#
######################################

PITCHTRACKING_SERIES_VERSION = 626f5d80340581a4cf4915536a6dcec950d1586a
PITCHTRACKING_SERIES_SITE = https://github.com/DISTRHO/PitchTrackingSeries.git
PITCHTRACKING_SERIES_SITE_METHOD = git
PITCHTRACKING_SERIES_BUNDLES = AudioToCVPitch.lv2

PITCHTRACKING_SERIES_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

# needed for submodules support
PITCHTRACKING_SERIES_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define PITCHTRACKING_SERIES_BUILD_CMDS
	$(PITCHTRACKING_SERIES_TARGET_MAKE)
endef

define PITCHTRACKING_SERIES_INSTALL_TARGET_CMDS
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/AudioToCVPitch.lv2
	cp -rL $($(PKG)_PKGDIR)/AudioToCVPitch.lv2/* $(TARGET_DIR)/usr/lib/lv2/AudioToCVPitch.lv2/
endef

$(eval $(generic-package))
