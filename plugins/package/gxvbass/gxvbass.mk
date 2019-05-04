######################################
#
# gxvbass
#
######################################

GXVBASS_VERSION = d7f2f6aeada1e16d76c8520bb8a3be3e69c4a4d6
GXVBASS_SITE = $(call github,brummer10,GxVBassPreAmp.lv2,$(GXVBASS_VERSION))
GXVBASS_BUNDLES = gx_voxbass.lv2

ifdef BR2_cortex_a7
GXVBASS_SSE_CFLAGS = -mfpu=vfpv3
endif

GXVBASS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="$(GXVBASS_SSE_CFLAGS)" -C $(@D)

define GXVBASS_BUILD_CMDS
	$(GXVBASS_TARGET_MAKE) mod
endef

define GXVBASS_INSTALL_TARGET_CMDS
	$(GXVBASS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
