######################################
#
# gxliquiddrive
#
######################################

GXLIQUIDDRIVE_VERSION = e12a9d94b6623343a2e0b81b6e73276f5fa0e9ad
GXLIQUIDDRIVE_SITE = $(call github,brummer10,GxLiquidDrive.lv2,$(GXLIQUIDDRIVE_VERSION))
GXLIQUIDDRIVE_BUNDLES = gx_liquiddrive.lv2

GXLIQUIDDRIVE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXLIQUIDDRIVE_BUILD_CMDS
	$(GXLIQUIDDRIVE_TARGET_MAKE) mod
endef

define GXLIQUIDDRIVE_INSTALL_TARGET_CMDS
	$(GXLIQUIDDRIVE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
