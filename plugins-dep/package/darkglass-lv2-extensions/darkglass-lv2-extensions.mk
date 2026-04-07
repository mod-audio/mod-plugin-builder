######################################
#
# darkglass-lv2-extensions
#
######################################

DARKGLASS_LV2_EXTENSIONS_VERSION = 28fe05d99063951bf1e08a51bcd52de139014a88
DARKGLASS_LV2_EXTENSIONS_SITE = $(call github,Darkglass-Electronics,LV2-Extensions,$(DARKGLASS_LV2_EXTENSIONS_VERSION))

DARKGLASS_LV2_EXTENSIONS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) PREFIX=/usr

define DARKGLASS_LV2_EXTENSIONS_INSTALL_TARGET_CMDS
	$(DARKGLASS_LV2_EXTENSIONS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
