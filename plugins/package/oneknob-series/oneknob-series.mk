######################################
#
# oneknob-series
#
######################################

ONEKNOB_SERIES_VERSION = 2eeb5654e0e7f8609d396fe8b5a1c29f1e8331f5
ONEKNOB_SERIES_SITE = https://github.com/DISTRHO/OneKnob-Series.git
ONEKNOB_SERIES_SITE_METHOD = git
ONEKNOB_SERIES_BUNDLES = OK-ConvolutionReverb.lv2

# needed for submodules support
ONEKNOB_SERIES_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

ONEKNOB_SERIES_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true WITH_LTO=true -C $(@D)

define ONEKNOB_SERIES_BUILD_CMDS
	$(ONEKNOB_SERIES_TARGET_MAKE)
endef

define ONEKNOB_SERIES_INSTALL_TARGET_CMDS
	# $(ONEKNOB_SERIES_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
