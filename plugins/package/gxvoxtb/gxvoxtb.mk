######################################
#
# gxvoxtb
#
######################################

GXVOXTB_VERSION = 186d3e99ea42a95e9dae982aec106f5c46c82829
GXVOXTB_SITE = $(call github,moddevices,gx_vobtb.lv2,$(GXVOXTB_VERSION))
GXVOXTB_BUNDLES = gx_voxtb.lv2

GXVOXTB_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXVOXTB_BUILD_CMDS
	$(GXVOXTB_TARGET_MAKE)
endef

define GXVOXTB_INSTALL_TARGET_CMDS
	$(GXVOXTB_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/gx_voxtb.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_voxtb.lv2/
endef

$(eval $(generic-package))
