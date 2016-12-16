######################################
#
# gxvstb
#
######################################

GXVSTB_VERSION = fd8b1a83062248510550744bd018da6cd5f100cb
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
