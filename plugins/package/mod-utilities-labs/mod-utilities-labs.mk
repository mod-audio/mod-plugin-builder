######################################
#
# mod-utilities
#
######################################

MOD_UTILITIES_LABS_VERSION = 4a92aa81351c5c95fefa0505fafad5fbea494dd0
MOD_UTILITIES_LABS_SITE = $(call github,moddevices,mod-utilities,$(MOD_UTILITIES_LABS_VERSION))
MOD_UTILITIES_LABS_DEPENDENCIES = alsa-lib
MOD_UTILITIES_LABS_BUNDLES = mod-switchtrigger4.lv2 inverted-switchbox.lv2 stereoswitchbox.lv2 stereoswitchbox2.lv2

MOD_UTILITIES_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true MOD=1 -C $(@D)

define MOD_UTILITIES_LABS_BUILD_CMDS
	$(MOD_UTILITIES_LABS_TARGET_MAKE)
endef

define MOD_UTILITIES_LABS_INSTALL_TARGET_CMDS
	$(MOD_UTILITIES_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/mod-switchtrigger4.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-switchtrigger4.lv2/
endef

$(eval $(generic-package))
