######################################
#
# oneknob-series-labs
#
######################################

ONEKNOB_SERIES_LABS_VERSION = 2eeb5654e0e7f8609d396fe8b5a1c29f1e8331f5
ONEKNOB_SERIES_LABS_SITE = https://github.com/DISTRHO/OneKnob-Series.git
ONEKNOB_SERIES_LABS_SITE_METHOD = git
ONEKNOB_SERIES_LABS_BUNDLES = OK-AB-InputSelector.lv2 OK-AB-OutputSelector.lv2 OK-BrickwallLimiter.lv2 OK-DevilDistortion.lv2
# not working yet
# OK-Compressor.lv2

# needed for submodules support
ONEKNOB_SERIES_LABS_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

ONEKNOB_SERIES_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true WITH_LTO=true -C $(@D)

define ONEKNOB_SERIES_LABS_BUILD_CMDS
	$(ONEKNOB_SERIES_LABS_TARGET_MAKE)
endef

define ONEKNOB_SERIES_LABS_INSTALL_TARGET_CMDS
	# $(ONEKNOB_SERIES_LABS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
