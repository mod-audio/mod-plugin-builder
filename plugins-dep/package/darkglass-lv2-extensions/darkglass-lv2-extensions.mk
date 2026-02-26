######################################
#
# darkglass-lv2-extensions
#
######################################

DARKGLASS_LV2_EXTENSIONS_VERSION = bdfabb8fd91d23b098bdb62c5716b80656a4fdb7
DARKGLASS_LV2_EXTENSIONS_SITE = $(call github,Darkglass-Electronics,LV2-Extensions,$(DARKGLASS_LV2_EXTENSIONS_VERSION))

DARKGLASS_LV2_EXTENSIONS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) PREFIX=/usr

define DARKGLASS_LV2_EXTENSIONS_INSTALL_TARGET_CMDS
	$(DARKGLASS_LV2_EXTENSIONS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
