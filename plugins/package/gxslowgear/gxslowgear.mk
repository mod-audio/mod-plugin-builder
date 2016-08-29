######################################
#
# gxslowgear
#
######################################

GXSLOWGEAR_VERSION = c15e7505aa421a4670b6afd70a2895effe43a1ab
GXSLOWGEAR_SITE = $(call github,moddevices,GxSlowGear.lv2,$(GXSLOWGEAR_VERSION))
GXSLOWGEAR_BUNDLES = gx_slowgear.lv2

GXSLOWGEAR_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="" -C $(@D)

define GXSLOWGEAR_BUILD_CMDS
	$(GXSLOWGEAR_TARGET_MAKE)
endef

define GXSLOWGEAR_INSTALL_TARGET_CMDS
	$(GXSLOWGEAR_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/gx_slowgear.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_slowgear.lv2/
endef

$(eval $(generic-package))
