######################################
#
# gxliquiddrive
#
######################################

GXLIQUIDDRIVE_VERSION = 99061a03ccfe0fb5c9cb0e5d426b6bdcd05b8ab8
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
