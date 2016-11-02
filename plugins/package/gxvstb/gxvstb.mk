######################################
#
# gxvstb
#
######################################

GXVSTB_VERSION = a8c1c1a0c5df8144fee72eb11c0b2cfc55b816a8
GXVSTB_SITE = $(call github,moddevices,GxSuppaToneBender.lv2,$(GXVSTB_VERSION))
GXVSTB_BUNDLES = gx_vstb.lv2

GXVSTB_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXVSTB_BUILD_CMDS
	$(GXVSTB_TARGET_MAKE)
endef

define GXVSTB_INSTALL_TARGET_CMDS
	$(GXVSTB_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/gx_vstb.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_vstb.lv2/
endef

$(eval $(generic-package))
