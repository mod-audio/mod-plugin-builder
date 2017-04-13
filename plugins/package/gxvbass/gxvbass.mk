######################################
#
# gxvbass
#
######################################

GXVBASS_VERSION = b9cedb51b8f044282500eb081b47d3675c5b246b
GXVBASS_SITE = $(call github,brummer10,GxVBassPreAmp.lv2,$(GXVBASS_VERSION))
GXVBASS_BUNDLES = gx_voxbass.lv2

GXVBASS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXVBASS_BUILD_CMDS
	$(GXVBASS_TARGET_MAKE) mod
endef

define GXVBASS_INSTALL_TARGET_CMDS
	$(GXVBASS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
