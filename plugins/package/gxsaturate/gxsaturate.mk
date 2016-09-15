######################################
#
# gxsaturate
#
######################################

GXSATURATE_VERSION = 9bf9d9d8f10d906d4dbe00b077439234028c09aa
GXSATURATE_SITE = $(call github,moddevices,GxSaturator.lv2,$(GXSATURATE_VERSION))
GXSATURATE_BUNDLES = gx_saturate.lv2

GXSATURATE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="" -C $(@D)

define GXSATURATE_BUILD_CMDS
	# FIXME remove this
	mkdir $(@D)/modgui
	$(GXSATURATE_TARGET_MAKE)
endef

define GXSATURATE_INSTALL_TARGET_CMDS
	$(GXSATURATE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
# 	cp -rL $($(PKG)_PKGDIR)/gx_saturate.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_saturate.lv2/
endef

$(eval $(generic-package))
