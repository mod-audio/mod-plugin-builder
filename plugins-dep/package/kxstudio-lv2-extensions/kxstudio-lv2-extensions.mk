######################################
#
# kxstudio-lv2-extensions
#
######################################

KXSTUDIO_LV2_EXTENSIONS_VERSION = 58010323797754dc6cd50084d456e5ac2e7c034c
KXSTUDIO_LV2_EXTENSIONS_SITE = $(call github,KXStudio,LV2-Extensions,$(KXSTUDIO_LV2_EXTENSIONS_VERSION))

KXSTUDIO_LV2_EXTENSIONS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) PREFIX=/usr

define KXSTUDIO_LV2_EXTENSIONS_INSTALL_TARGET_CMDS
	$(KXSTUDIO_LV2_EXTENSIONS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
