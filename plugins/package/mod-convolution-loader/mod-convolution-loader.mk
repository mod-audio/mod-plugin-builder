######################################
#
# mod-convolution-loader
#
######################################

MOD_CONVOLUTION_LOADER_VERSION = a626adc3ccb18ce1d575523404c4d6eaa3b3f226
MOD_CONVOLUTION_LOADER_SITE = https://github.com/moddevices/mod-convolution-loader.git
MOD_CONVOLUTION_LOADER_SITE_METHOD = git
MOD_CONVOLUTION_LOADER_BUNDLES = MOD-CabinetLoader.lv2 MOD-ConvolutionLoader.lv2

# needed for submodules support
MOD_CONVOLUTION_LOADER_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

MOD_CONVOLUTION_LOADER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) CROSS_COMPILING=true NOOPT=true WITH_LTO=true -C $(@D)

define MOD_CONVOLUTION_LOADER_BUILD_CMDS
	$(MOD_CONVOLUTION_LOADER_TARGET_MAKE)
endef

define MOD_CONVOLUTION_LOADER_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/MOD-CabinetLoader.lv2/* $(TARGET_DIR)/usr/lib/lv2/MOD-CabinetLoader.lv2/
	cp -rL $($(PKG)_PKGDIR)/MOD-ConvolutionLoader.lv2/* $(TARGET_DIR)/usr/lib/lv2/MOD-ConvolutionLoader.lv2/
endef

$(eval $(generic-package))
