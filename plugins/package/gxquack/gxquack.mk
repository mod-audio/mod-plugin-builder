######################################
#
# gxquack
#
######################################

GXQUACK_VERSION = 2668d1e5253bb3aafc2bfc16e726e7a5a7f3271b
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
