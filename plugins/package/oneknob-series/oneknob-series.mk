######################################
#
# oneknob-series
#
######################################

ONEKNOB_SERIES_VERSION = d3e790f0030a3999b72d89d95bcedcdca851bea4
ONEKNOB_SERIES_SITE = https://github.com/DISTRHO/OneKnob-Series.git
ONEKNOB_SERIES_SITE_METHOD = git
ONEKNOB_SERIES_BUNDLES = MOD-ConvolutionLoader.lv2

# needed for submodules support
ONEKNOB_SERIES_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

ONEKNOB_SERIES_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) CROSS_COMPILING=true MOD_BUILD=true NOOPT=true WITH_LTO=true -C $(@D)

define ONEKNOB_SERIES_BUILD_CMDS
	$(ONEKNOB_SERIES_TARGET_MAKE)
endef

define ONEKNOB_SERIES_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/MOD-ConvolutionLoader.lv2/* $(TARGET_DIR)/usr/lib/lv2/MOD-ConvolutionLoader.lv2/
endef

$(eval $(generic-package))
