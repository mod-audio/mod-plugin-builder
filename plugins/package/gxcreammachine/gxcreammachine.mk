######################################
#
# gxcreammachine
#
######################################

GXCREAMMACHINE_VERSION = 4d2a7a0614fca82a1bfb8a3c583d28fb05aee392
GXCREAMMACHINE_SITE = $(call github,brummer10,GxCreamMachine.lv2,$(GXCREAMMACHINE_VERSION))
GXCREAMMACHINE_BUNDLES = gx_CreamMachine.lv2

GXCREAMMACHINE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXCREAMMACHINE_BUILD_CMDS
	$(GXCREAMMACHINE_TARGET_MAKE) mod
endef

define GXCREAMMACHINE_INSTALL_TARGET_CMDS
	$(GXCREAMMACHINE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
