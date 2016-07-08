######################################
#
# sooperlooper-lv2
#
######################################

SOOPERLOOPER_LV2_VERSION = 1557047a6ed75b23d234ca6fd1b141e76d9b7a19
SOOPERLOOPER_LV2_SITE = $(call github,moddevices,sooperlooper-lv2-plugin,$(SOOPERLOOPER_LV2_VERSION))
SOOPERLOOPER_LV2_BUNDLES = sooperlooper.lv2

SOOPERLOOPER_LV2_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)/sooperlooper

define SOOPERLOOPER_LV2_BUILD_CMDS
	$(SOOPERLOOPER_LV2_TARGET_MAKE)
endef

define SOOPERLOOPER_LV2_INSTALL_TARGET_CMDS
	$(SOOPERLOOPER_LV2_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/sooperlooper.lv2/* $(TARGET_DIR)/usr/lib/lv2/sooperlooper.lv2/
endef

$(eval $(generic-package))
