######################################
#
# cardinal
#
######################################

CARDINAL_VERSION = 01ff9162ca072059072b10107c926367d7a24238
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
	$(MAKE) HEADLESS=true NOOPT=true WITH_LTO=true STATIC_BUILD=true -C $(@D)

define CARDINAL_BUILD_CMDS
	# fancy dance to skip building Standalone and VSTs
	$(CARDINAL_TARGET_MAKE) deps plugins dpf/utils/lv2_ttl_generator
	$(CARDINAL_TARGET_MAKE) -C src rack.a
	$(CARDINAL_TARGET_MAKE) -C src/CardinalFX lv2 resources
# 	$(CARDINAL_TARGET_MAKE) -C src/CardinalSynth lv2
	$(CARDINAL_TARGET_MAKE) -C plugins resources
	cd $(@D) && ./dpf/utils/generate-ttl.sh
endef

define CARDINAL_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/CardinalFX.lv2
	cp -rL $(@D)/bin/CardinalFX.lv2/* $(TARGET_DIR)/usr/lib/lv2/CardinalFX.lv2/
endef

$(eval $(generic-package))
