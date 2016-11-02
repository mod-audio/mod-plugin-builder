######################################
#
# gxsaturate
#
######################################

GXSATURATE_VERSION = ec3e0f83b93feecdbc3a086773fe6f8a080c20cd
GXSATURATE_SITE = $(call github,moddevices,GxSaturator.lv2,$(GXSATURATE_VERSION))
GXSATURATE_BUNDLES = gx_saturate.lv2

GXSATURATE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXSATURATE_BUILD_CMDS
	$(GXSATURATE_TARGET_MAKE)
endef

define GXSATURATE_INSTALL_TARGET_CMDS
	$(GXSATURATE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/gx_saturate.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_saturate.lv2/
endef

$(eval $(generic-package))
