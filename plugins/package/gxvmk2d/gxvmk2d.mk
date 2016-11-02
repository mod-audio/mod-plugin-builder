######################################
#
# gxvmk2d
#
######################################

GXVMK2D_VERSION = 66f5e7971f13e43ec8661871bb4b00eef2dd9eb9
GXVMK2D_SITE = $(call github,brummer10,GxVmk2.lv2,$(GXVMK2D_VERSION))
GXVMK2D_BUNDLES = gx_vmk2d.lv2

GXVMK2D_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXVMK2D_BUILD_CMDS
	$(GXVMK2D_TARGET_MAKE)
endef

define GXVMK2D_INSTALL_TARGET_CMDS
	$(GXVMK2D_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
# 	cp -rL $($(PKG)_PKGDIR)/gx_vmk2d.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_vmk2d.lv2/
endef

$(eval $(generic-package))
