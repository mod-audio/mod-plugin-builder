######################################
#
# gxultracab
#
######################################

GXULTRACAB_VERSION = 8e5fa23e93aa823468ab01a26744dded1d7d4c3b
GXULTRACAB_SITE = $(call github,brummer10,GxUltraCab.lv2,$(GXULTRACAB_VERSION))
GXULTRACAB_BUNDLES = gx_ultracab.lv2

ifdef BR2_cortex_a7
GXULTRACAB_SSE_CFLAGS = -mfpu=vfpv3
endif

GXULTRACAB_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)  SSE_CFLAGS="$(GXULTRACAB_SSE_CFLAGS)" -C $(@D) 

define GXULTRACAB_BUILD_CMDS
	$(GXULTRACAB_TARGET_MAKE) mod
endef

define GXULTRACAB_INSTALL_TARGET_CMDS
	$(GXULTRACAB_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
