######################################
#
# mod-lv2-extensions
#
######################################

MOD_LV2_EXTENSIONS_VERSION = 2fe7c7728faa551b2838baa49c0d1953c64f2151
MOD_LV2_EXTENSIONS_SITE = $(call github,moddevices,mod-sdk,$(MOD_LV2_EXTENSIONS_VERSION))

MOD_LV2_EXTENSIONS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) PREFIX=/usr

define MOD_LV2_EXTENSIONS_INSTALL_TARGET_CMDS
	$(MOD_LV2_EXTENSIONS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
