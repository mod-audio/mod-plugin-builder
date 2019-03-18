######################################
#
# gxsupersonic
#
######################################

GXSUPERSONIC_VERSION = a116614cc8a2c31d81ae5ce7d867bf6222a0ba3a
GXSUPERSONIC_SITE = $(call github,brummer10,GxSuperSonic.lv2,$(GXSUPERSONIC_VERSION))
GXSUPERSONIC_BUNDLES = gx_supersonic.lv2

GXSUPERSONIC_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)  SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D) 

define GXSUPERSONIC_BUILD_CMDS
	$(GXSUPERSONIC_TARGET_MAKE) mod
endef

define GXSUPERSONIC_INSTALL_TARGET_CMDS
	$(GXSUPERSONIC_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
