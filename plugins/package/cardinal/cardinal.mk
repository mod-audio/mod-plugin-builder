######################################
#
# cardinal
#
######################################

CARDINAL_VERSION = 718538beb8706cfad383c834c19bf7933c5b58bc
CARDINAL_SITE = https://github.com/DISTRHO/Cardinal.git
CARDINAL_SITE_METHOD = git
# CARDINAL_DEPENDENCIES = libsndfile
CARDINAL_BUNDLES = CardinalFX.lv2

# needed for submodules support
CARDINAL_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

CARDINAL_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) \
	CFLAGS="-ffat-lto-objects -fsingle-precision-constant" \
	CXXFLAGS="-ffat-lto-objects -fsingle-precision-constant" \
	LDFLAGS="-ffat-lto-objects -fsingle-precision-constant" \
	$(MAKE) HEADLESS=true MOD_BUILD=true NOOPT=true STATIC_BUILD=true WITH_LTO=true -C $(@D)

define CARDINAL_BUILD_CMDS
	$(CARDINAL_TARGET_MAKE)
endef

define CARDINAL_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/CardinalFX.lv2
	cp -rL $(@D)/bin/CardinalFX.lv2/* $(TARGET_DIR)/usr/lib/lv2/CardinalFX.lv2/
endef

$(eval $(generic-package))
