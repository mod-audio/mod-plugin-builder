######################################
#
# gxguvnor
#
######################################

GXGUVNOR_VERSION = 26c94e97874de098d1b306aed9e049e35744e443
GXGUVNOR_SITE = $(call github,brummer10,GxGuvnor.lv2,$(GXGUVNOR_VERSION))
GXGUVNOR_BUNDLES = gx_guvnor.lv2

GXGUVNOR_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)  SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D) 

define GXGUVNOR_BUILD_CMDS
	$(GXGUVNOR_TARGET_MAKE) mod
endef

define GXGUVNOR_INSTALL_TARGET_CMDS
	$(GXGUVNOR_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
