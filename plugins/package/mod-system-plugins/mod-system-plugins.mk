######################################
#
# mod-system-plugins
#
######################################

MOD_SYSTEM_PLUGINS_VERSION = db77cf51e43bc89eefa5c28d9073fe69b0a894c5
MOD_SYSTEM_PLUGINS_SITE = $(call github,moddevices,mod-system-plugins,$(MOD_SYSTEM_PLUGINS_VERSION))
MOD_SYSTEM_PLUGINS_BUNDLES = system-noisegate.lv2 advanced-noisegate.lv2 system-compressor.lv2 advanced-compressor.lv2

MOD_SYSTEM_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define MOD_SYSTEM_PLUGINS_BUILD_CMDS
	$(MOD_SYSTEM_PLUGINS_TARGET_MAKE)
endef

define MOD_SYSTEM_PLUGINS_INSTALL_TARGET_CMDS
	$(MOD_SYSTEM_PLUGINS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
