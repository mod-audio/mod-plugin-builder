######################################
#
# gxsunface
#
######################################

GXSUNFACE_VERSION = c7a021e155f74bad7dce0ee60019a2121e8b58c9
GXSUNFACE_SITE = $(call github,brummer10,GxSunFace.lv2,$(GXSUNFACE_VERSION))
GXSUNFACE_BUNDLES = gx_SunFace.lv2

GXSUNFACE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXSUNFACE_BUILD_CMDS
	$(GXSUNFACE_TARGET_MAKE) mod
endef

define GXSUNFACE_INSTALL_TARGET_CMDS
	$(GXSUNFACE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
