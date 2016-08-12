######################################
#
# gxswitchlesswah
#
######################################

GXSWITCHLESSWAH_VERSION = 511456fb6e0496748e11fad0385202d060ac32c1
GXSWITCHLESSWAH_SITE = $(call github,moddevices,GxSwitchlessWah.lv2,$(GXSWITCHLESSWAH_VERSION))
GXSWITCHLESSWAH_BUNDLES = GxSwitchlessWah.lv2

GXSWITCHLESSWAH_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="" -C $(@D)

define GXSWITCHLESSWAH_BUILD_CMDS
	$(GXSWITCHLESSWAH_TARGET_MAKE)
endef

define GXSWITCHLESSWAH_INSTALL_TARGET_CMDS
	$(GXSWITCHLESSWAH_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/GxSwitchlessWah.lv2/* $(TARGET_DIR)/usr/lib/lv2/GxSwitchlessWah.lv2/
endef

$(eval $(generic-package))
