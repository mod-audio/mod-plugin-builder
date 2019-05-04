######################################
#
# gxhyperion
#
######################################

GXHYPERION_VERSION = dd863082443222fe06196660f9d57026556ec698
GXHYPERION_SITE = $(call github,brummer10,GxHyperion.lv2,$(GXHYPERION_VERSION))
GXHYPERION_BUNDLES = gx_hyperion.lv2

ifdef BR2_cortex_a7
GXHYPERION_SSE_CFLAGS = -mfpu=vfpv3
endif

GXHYPERION_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="$(GXHYPERION_SSE_CFLAGS)" -C $(@D)

define GXHYPERION_BUILD_CMDS
	$(GXHYPERION_TARGET_MAKE) mod
endef

define GXHYPERION_INSTALL_TARGET_CMDS
	$(GXHYPERION_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
