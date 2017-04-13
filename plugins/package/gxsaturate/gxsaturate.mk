######################################
#
# gxsaturate
#
######################################

GXSATURATE_VERSION = 9d253531b6d2aae6e507f61c92962fc23f66dbc4
GXSATURATE_SITE = $(call github,brummer10,GxSaturator.lv2,$(GXSATURATE_VERSION))
GXSATURATE_BUNDLES = gx_saturate.lv2

GXSATURATE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXSATURATE_BUILD_CMDS
	$(GXSATURATE_TARGET_MAKE) mod
endef

define GXSATURATE_INSTALL_TARGET_CMDS
	$(GXSATURATE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
