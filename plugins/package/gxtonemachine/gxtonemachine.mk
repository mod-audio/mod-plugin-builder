######################################
#
# gxtonemachine
#
######################################

GXTONEMACHINE_VERSION = efa8681a59b2fc69fed959efcf0234db1578f0c5
GXTONEMACHINE_SITE = $(call github,brummer10,GxToneMachine.lv2,$(GXTONEMACHINE_VERSION))
GXTONEMACHINE_BUNDLES = gx_tonemachine.lv2

ifdef BR2_cortex_a7
GXTONEMACHINE_SSE_CFLAGS = -mfpu=vfpv3
endif

GXTONEMACHINE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="$(GXTONEMACHINE_SSE_CFLAGS)" -C $(@D)

define GXTONEMACHINE_BUILD_CMDS
	$(GXTONEMACHINE_TARGET_MAKE) mod
endef

define GXTONEMACHINE_INSTALL_TARGET_CMDS
	$(GXTONEMACHINE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
