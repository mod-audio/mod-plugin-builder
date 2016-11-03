######################################
#
# gxuvox
#
######################################

GXUVOX_VERSION = 7255be979266f15ce31cc42a4d7636c0fa231ced
GXUVOX_SITE = $(call github,brummer10,GxUVox720k.lv2,$(GXUVOX_VERSION))
GXUVOX_BUNDLES = gx_uvox.lv2

GXUVOX_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXUVOX_BUILD_CMDS
	$(GXUVOX_TARGET_MAKE)
endef

define GXUVOX_INSTALL_TARGET_CMDS
	$(GXUVOX_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
# 	cp -rL $($(PKG)_PKGDIR)/gx_uvox.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_uvox.lv2/
endef

$(eval $(generic-package))
