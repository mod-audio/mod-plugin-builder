######################################
#
# mod-lv2-extensions
#
######################################

MOD_LV2_EXTENSIONS_VERSION = f4341a6c2b2f50e2eb405b06ce19f9f0b4b1a62b
MOD_LV2_EXTENSIONS_SITE = $(call github,moddevices,mod-lv2-extensions,$(MOD_LV2_EXTENSIONS_VERSION))

MOD_LV2_EXTENSIONS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) PREFIX=/usr

define MOD_LV2_EXTENSIONS_INSTALL_TARGET_CMDS
	$(MOD_LV2_EXTENSIONS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
