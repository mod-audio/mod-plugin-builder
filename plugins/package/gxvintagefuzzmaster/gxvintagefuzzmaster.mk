######################################
#
# gxvintagefuzzmaster
#
######################################

GXVINTAGEFUZZMASTER_VERSION = eca863cc2e0514932e7a1f087506d960bc4a7ebd
GXVINTAGEFUZZMASTER_SITE = $(call github,moddevices,GxVintageFuzzMaster.lv2,$(GXVINTAGEFUZZMASTER_VERSION))
GXVINTAGEFUZZMASTER_BUNDLES = gx_vfm.lv2

GXVINTAGEFUZZMASTER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXVINTAGEFUZZMASTER_BUILD_CMDS
	$(GXVINTAGEFUZZMASTER_TARGET_MAKE)
endef

define GXVINTAGEFUZZMASTER_INSTALL_TARGET_CMDS
	$(GXVINTAGEFUZZMASTER_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/gx_vfm.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_vfm.lv2/
endef

$(eval $(generic-package))
