######################################
#
# gxquack
#
######################################

GXQUACK_VERSION = 84fef2efc2bed31d3e9a8ed3dfb4e8b1602e2c94
GXQUACK_SITE = $(call github,brummer10,GxQuack.lv2,$(GXQUACK_VERSION))
GXQUACK_BUNDLES = gx_quack.lv2

GXQUACK_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXQUACK_BUILD_CMDS
	$(GXQUACK_TARGET_MAKE) mod
endef

define GXQUACK_INSTALL_TARGET_CMDS
	$(GXQUACK_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
