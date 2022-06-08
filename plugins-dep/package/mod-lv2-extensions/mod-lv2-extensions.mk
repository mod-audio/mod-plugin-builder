######################################
#
# mod-lv2-extensions
#
######################################

MOD_LV2_EXTENSIONS_VERSION = 8e5438a00b6719586497618d97f3f52fb3e864ab
MOD_LV2_EXTENSIONS_SITE = $(call github,moddevices,mod-lv2-extensions,$(MOD_LV2_EXTENSIONS_VERSION))

MOD_LV2_EXTENSIONS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) PREFIX=/usr

define MOD_LV2_EXTENSIONS_INSTALL_TARGET_CMDS
	$(MOD_LV2_EXTENSIONS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
