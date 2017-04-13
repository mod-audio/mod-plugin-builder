######################################
#
# gxhotbox
#
######################################

GXHOTBOX_VERSION = 3dcbffae4b32bd4bce6c6ad6270e9590adf9b282
GXHOTBOX_SITE = $(call github,brummer10,GxHotBox.lv2,$(GXHOTBOX_VERSION))
GXHOTBOX_BUNDLES = gx_hotbox.lv2

GXHOTBOX_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)  SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D) 

define GXHOTBOX_BUILD_CMDS
	$(GXHOTBOX_TARGET_MAKE) mod
endef

define GXHOTBOX_INSTALL_TARGET_CMDS
	$(GXHOTBOX_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
