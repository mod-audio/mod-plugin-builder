######################################
#
# gxsfp
#
######################################

GXSFP_VERSION = 8ef00b8d7b77d5123c09af8a685a41447a87c267
GXSFP_SITE = $(call github,brummer10,GxSuperFuzz.lv2,$(GXSFP_VERSION))
GXSFP_BUNDLES = gx_sfp.lv2

GXSFP_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXSFP_BUILD_CMDS
	$(GXSFP_TARGET_MAKE) mod
endef

define GXSFP_INSTALL_TARGET_CMDS
	$(GXSFP_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
