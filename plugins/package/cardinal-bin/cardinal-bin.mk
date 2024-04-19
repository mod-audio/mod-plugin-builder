######################################
#
# cardinal-bin
#
######################################

CARDINAL_BIN_VERSION = 24.04
CARDINAL_BIN_SITE_METHOD = local
CARDINAL_BIN_SITE = $($(PKG)_PKGDIR)/
CARDINAL_BIN_BUNDLES = Cardinal.lv2 CardinalFX.lv2 CardinalMini.lv2

define CARDINAL_BIN_INSTALL_TARGET_CMDS
	tar xf $(@D)/binaries.tar.xz -C $(@D) \
		binaries/$(MOD_BIN_COMPAT)/Cardinal.so \
		binaries/$(MOD_BIN_COMPAT)/CardinalFX.so \
		binaries/$(MOD_BIN_COMPAT)/CardinalMini_dsp.so

	mkdir -p $(TARGET_DIR)/usr/lib/lv2
	cp -r $(@D)/bundles/* $(TARGET_DIR)/usr/lib/lv2/
	cp $(@D)/binaries/$(MOD_BIN_COMPAT)/Cardinal.so $(TARGET_DIR)/usr/lib/lv2/Cardinal.lv2/
	cp $(@D)/binaries/$(MOD_BIN_COMPAT)/CardinalFX.so $(TARGET_DIR)/usr/lib/lv2/CardinalFX.lv2/
	cp $(@D)/binaries/$(MOD_BIN_COMPAT)/CardinalMini_dsp.so $(TARGET_DIR)/usr/lib/lv2/CardinalMini.lv2/
endef

$(eval $(generic-package))
