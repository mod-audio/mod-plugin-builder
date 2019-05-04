######################################
#
# gxuvox
#
######################################

GXUVOX_VERSION = a7ad702c586b9e9ecd1a50a434720f702cd7332f
GXUVOX_SITE = $(call github,brummer10,GxUVox720k.lv2,$(GXUVOX_VERSION))
GXUVOX_BUNDLES = gx_uvox.lv2

ifdef BR2_cortex_a7
GXUVOX_SSE_CFLAGS = -mfpu=vfpv3
endif

GXUVOX_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="$(GXUVOX_SSE_CFLAGS)" -C $(@D)

define GXUVOX_BUILD_CMDS
	$(GXUVOX_TARGET_MAKE) mod
endef

define GXUVOX_INSTALL_TARGET_CMDS
	$(GXUVOX_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
