######################################
#
# gxtonemachine
#
######################################

GXTONEMACHINE_VERSION = bb32739039ddd1c83fdc901b7febbf92cf7a5a67
GXTONEMACHINE_SITE = $(call github,brummer10,GxToneMachine.lv2,$(GXTONEMACHINE_VERSION))
GXTONEMACHINE_BUNDLES = gx_tonemachine.lv2

GXTONEMACHINE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXTONEMACHINE_BUILD_CMDS
	$(GXTONEMACHINE_TARGET_MAKE) mod
endef

define GXTONEMACHINE_INSTALL_TARGET_CMDS
	$(GXTONEMACHINE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
