######################################
#
# cardinal-bin
#
######################################

CARDINAL_BIN_VERSION = 6795d8acba64ed3c63076e3856d19f4c653c7eed
CARDINAL_BIN_SITE_METHOD = local
CARDINAL_BIN_SITE = $($(PKG)_PKGDIR)/
CARDINAL_BIN_BUNDLES = CardinalFX.lv2

define CARDINAL_BIN_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/CardinalFX.lv2
	cp -r $(@D)/bundles/* $(TARGET_DIR)/usr/lib/lv2/
	cp $(@D)/binaries/$(MOD_BIN_COMPAT)/*.so $(TARGET_DIR)/usr/lib/lv2/CardinalFX.lv2/
endef

$(eval $(generic-package))
