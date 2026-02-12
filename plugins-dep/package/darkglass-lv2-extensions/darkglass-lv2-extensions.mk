######################################
#
# darkglass-lv2-extensions
#
######################################

DARKGLASS_LV2_EXTENSIONS_VERSION = 154b84e20380bac7ba089e28a7ff7d83a1f4d6d9
DARKGLASS_LV2_EXTENSIONS_SITE = $(call github,Darkglass-Electronics,LV2-Extensions,$(DARKGLASS_LV2_EXTENSIONS_VERSION))

DARKGLASS_LV2_EXTENSIONS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) PREFIX=/usr

define DARKGLASS_LV2_EXTENSIONS_INSTALL_TARGET_CMDS
	$(DARKGLASS_LV2_EXTENSIONS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
