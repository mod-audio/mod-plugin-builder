######################################
#
# gxsd1
#
######################################

GXSD1_VERSION = 456418cfead9b9efc726634323d66ee62e8f8f36
GXSD1_SITE = $(call github,brummer10,GxSD1.lv2,$(GXSD1_VERSION))
GXSD1_BUNDLES = gx_sd1sim.lv2

GXSD1_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXSD1_BUILD_CMDS
	$(GXSD1_TARGET_MAKE) mod
endef

define GXSD1_INSTALL_TARGET_CMDS
	$(GXSD1_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
