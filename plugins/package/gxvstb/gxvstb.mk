######################################
#
# gxvstb
#
######################################

GXVSTB_VERSION = 0fd30518846be377b7c4ce1228a90756f4fa4b72
GXVSTB_SITE = $(call github,brummer10,GxSuppaToneBender.lv2,$(GXVSTB_VERSION))
GXVSTB_BUNDLES = gx_vstb.lv2

GXVSTB_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXVSTB_BUILD_CMDS
	$(GXVSTB_TARGET_MAKE) mod
endef

define GXVSTB_INSTALL_TARGET_CMDS
	$(GXVSTB_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
