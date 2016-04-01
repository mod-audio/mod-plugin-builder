######################################
#
# sooperlooper-lv2
#
######################################

SOOPERLOOPER_LV2_VERSION = 8f4fcb589866512c334f832e0a2bc39d1dd81779
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
