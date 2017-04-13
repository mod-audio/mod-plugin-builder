######################################
#
# gxvmk2d
#
######################################

GXVMK2D_VERSION = 5f61c3d0dd8bca6fb622295a2af2a5ecba0dbfdd
GXVMK2D_SITE = $(call github,brummer10,GxVmk2.lv2,$(GXVMK2D_VERSION))
GXVMK2D_BUNDLES = gx_vmk2d.lv2

GXVMK2D_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXVMK2D_BUILD_CMDS
	$(GXVMK2D_TARGET_MAKE) mod
endef

define GXVMK2D_INSTALL_TARGET_CMDS
	$(GXVMK2D_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
