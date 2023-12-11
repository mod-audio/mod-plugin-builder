######################################
#
# oneknob-series
#
######################################

ONEKNOB_SERIES_VERSION = 19dacead63ec45da5c390c583d4f06d61dad668b
ONEKNOB_SERIES_SITE = https://github.com/DISTRHO/OneKnob-Series.git
ONEKNOB_SERIES_SITE_METHOD = git
ONEKNOB_SERIES_BUNDLES = OK-Filter.lv2
# OK-AB-InputSelector.lv2 OK-AB-OutputSelector.lv2 OK-BrickwallLimiter.lv2 OK-Compressor.lv2 OK-ConvolutionReverb.lv2 OK-DevilDistortion.lv2

# needed for submodules support
ONEKNOB_SERIES_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

ONEKNOB_SERIES_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD_BUILD=true NOOPT=true WITH_LTO=true -C $(@D)

define ONEKNOB_SERIES_BUILD_CMDS
	$(ONEKNOB_SERIES_TARGET_MAKE)
endef

define ONEKNOB_SERIES_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
