######################################
#
# wolf-shaper
#
######################################

WOLF_SHAPER_VERSION = ed9db523859437cba61d05d3fd08fd579a4a4992
WOLF_SHAPER_SITE = https://github.com/falkTX/wolf-shaper.git
WOLF_SHAPER_SITE_METHOD = git
WOLF_SHAPER_BUNDLES = wolf-shaper.lv2

# needed for submodules support
WOLF_SHAPER_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

WOLF_SHAPER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) BUILD_LV2=true BUILD_CLAP= BUILD_JACK= BUILD_VST2= BUILD_VST3= HAVE_OPENGL=false NOOPT=true -C $(@D)

define WOLF_SHAPER_BUILD_CMDS
	$(WOLF_SHAPER_TARGET_MAKE)
endef

define WOLF_SHAPER_INSTALL_TARGET_CMDS
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/wolf-shaper.lv2/* $(TARGET_DIR)/usr/lib/lv2/wolf-shaper.lv2/
endef

$(eval $(generic-package))
