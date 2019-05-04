######################################
#
# gxsd1
#
######################################

GXSD1_VERSION = 9c8d6a4d7cd4218150e41e66c4c541ab0e06e748
GXSD1_SITE = $(call github,brummer10,GxSD1.lv2,$(GXSD1_VERSION))
GXSD1_BUNDLES = gx_sd1sim.lv2

ifdef BR2_cortex_a7
GXSD1_SSE_CFLAGS = -mfpu=vfpv3
endif

GXSD1_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="$(GXSD1_SSE_CFLAGS)" -C $(@D)

define GXSD1_BUILD_CMDS
	$(GXSD1_TARGET_MAKE) mod
endef

define GXSD1_INSTALL_TARGET_CMDS
	$(GXSD1_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
