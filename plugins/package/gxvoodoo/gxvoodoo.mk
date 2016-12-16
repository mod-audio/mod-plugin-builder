######################################
#
# gxvoodoo
#
######################################

GXVOODOO_VERSION = e643626806fd62ed63e9f4f0a70afc38c02c981d
GXVOODOO_SITE = $(call github,moddevices,GxVoodoFuzz.lv2,$(GXVOODOO_VERSION))
GXVOODOO_BUNDLES = gx_voodoo.lv2

GXVOODOO_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXVOODOO_BUILD_CMDS
	$(GXVOODOO_TARGET_MAKE)
endef

define GXVOODOO_INSTALL_TARGET_CMDS
	$(GXVOODOO_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/gx_voodoo.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_voodoo.lv2/
endef

$(eval $(generic-package))
