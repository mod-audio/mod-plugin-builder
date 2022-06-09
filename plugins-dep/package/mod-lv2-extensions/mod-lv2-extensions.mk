######################################
#
# mod-lv2-extensions
#
######################################

MOD_LV2_EXTENSIONS_VERSION = 60abe7176b4e4f46f20a41cdf3d65d909c8d8a34
MOD_LV2_EXTENSIONS_SITE = $(call github,moddevices,mod-lv2-extensions,$(MOD_LV2_EXTENSIONS_VERSION))

MOD_LV2_EXTENSIONS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) PREFIX=/usr

define MOD_LV2_EXTENSIONS_INSTALL_TARGET_CMDS
	$(MOD_LV2_EXTENSIONS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
