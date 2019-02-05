######################################
#
# gxquack
#
######################################

GXQUACK_VERSION = 05e53d6491a994e718f3da56522faac3ff8b0fae
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
