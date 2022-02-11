######################################
#
# cardinal-bin
#
######################################

CARDINAL_BIN_VERSION = 78485054bd42a62d4205c4a12479f2ab36a6d83f
CARDINAL_BIN_SITE_METHOD = local
CARDINAL_BIN_SITE = $($(PKG)_PKGDIR)/
CARDINAL_BIN_BUNDLES = CardinalFX.lv2

define CARDINAL_BIN_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/CardinalFX.lv2
	cp -r $(@D)/bundles/* $(TARGET_DIR)/usr/lib/lv2/
	cp $(@D)/binaries/$(MOD_BIN_COMPAT)/*.so $(TARGET_DIR)/usr/lib/lv2/CardinalFX.lv2/
endef

$(eval $(generic-package))
