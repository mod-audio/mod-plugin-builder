######################################
#
# gxsaturate
#
######################################

GXSATURATE_VERSION = 52bf9e3042e3adf56f6d253a245218818b530359
GXSATURATE_SITE = $(call github,brummer10,GxSaturator.lv2,$(GXSATURATE_VERSION))
GXSATURATE_BUNDLES = gx_saturate.lv2

ifdef BR2_cortex_a7
GXSATURATE_SSE_CFLAGS = -mfpu=vfpv3
endif

GXSATURATE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="$(GXSATURATE_SSE_CFLAGS)" -C $(@D)

define GXSATURATE_BUILD_CMDS
	$(GXSATURATE_TARGET_MAKE) mod
endef

define GXSATURATE_INSTALL_TARGET_CMDS
	$(GXSATURATE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
