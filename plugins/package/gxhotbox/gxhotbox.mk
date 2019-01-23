######################################
#
# gxhotbox
#
######################################

GXHOTBOX_VERSION = 3df0a127c1f0563ae9e089335dde30df333c4241
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
