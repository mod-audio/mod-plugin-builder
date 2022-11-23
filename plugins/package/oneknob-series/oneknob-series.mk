######################################
#
# oneknob-series
#
######################################

ONEKNOB_SERIES_VERSION = 9970eed4ef80fdc7a2c66d9d7801ab23acbe5818
ONEKNOB_SERIES_SITE = https://github.com/DISTRHO/OneKnob-Series.git
ONEKNOB_SERIES_SITE_METHOD = git
ONEKNOB_SERIES_BUNDLES = OK-ConvolutionReverb.lv2

# needed for submodules support
ONEKNOB_SERIES_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

ONEKNOB_SERIES_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) CROSS_COMPILING=true NOOPT=true WITH_LTO=true -C $(@D)

define ONEKNOB_SERIES_BUILD_CMDS
	$(ONEKNOB_SERIES_TARGET_MAKE)
endef

define ONEKNOB_SERIES_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/OK-ConvolutionReverb.lv2/* $(TARGET_DIR)/usr/lib/lv2/OK-ConvolutionReverb.lv2/
endef

$(eval $(generic-package))
