######################################
#
# gxsfp
#
######################################

GXSFP_VERSION = ad44308d489dfe61eec75b89b8e745da131c89c4
GXSFP_SITE = $(call github,moddevices,GxSuperFuzz.lv2,$(GXSFP_VERSION))
GXSFP_BUNDLES = gx_sfp.lv2

GXSFP_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="" -C $(@D)

define GXSFP_BUILD_CMDS
	$(GXSFP_TARGET_MAKE)
endef

define GXSFP_INSTALL_TARGET_CMDS
	$(GXSFP_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/gx_sfp.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_sfp.lv2/
endef

$(eval $(generic-package))
