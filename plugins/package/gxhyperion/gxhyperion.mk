######################################
#
# gxhyperion
#
######################################

GXHYPERION_VERSION = aae0e12fad96af5345bc4e8c6081c0fc65d46205
GXHYPERION_SITE = $(call github,brummer10,GxHyperion.lv2,$(GXHYPERION_VERSION))
GXHYPERION_BUNDLES = gx_hyperion.lv2

GXHYPERION_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXHYPERION_BUILD_CMDS
	$(GXHYPERION_TARGET_MAKE) mod
endef

define GXHYPERION_INSTALL_TARGET_CMDS
	$(GXHYPERION_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
