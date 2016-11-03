######################################
#
# sooperlooper-lv2
#
######################################

SOOPERLOOPER_LV2_VERSION = 39c81b5e3996b3f10b89e333dab3a194b9ea5011
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
