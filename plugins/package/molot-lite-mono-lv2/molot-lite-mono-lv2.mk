######################################
#
# molot-lite-mono-lv2
#
######################################

MOLOT_LITE_MONO_LV2_VERSION = b2f8f6d04e9d33b38dfdcf3df9a98af0f3258b6f
MOLOT_LITE_MONO_LV2_SITE = $(call github,bernhardrusch,molot-lite-mono-lv2,$(MOLOT_LITE_MONO_LV2_VERSION))
MOLOT_LITE_MONO_LV2_DEPENDENCIES =
MOLOT_LITE_MONO_LV2_BUNDLES = molot-lite-mono.lv2

MOLOT_LITE_MONO_LV2_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/src

define MOLOT_LITE_MONO_LV2_BUILD_CMDS
	$(MOLOT_LITE_MONO_LV2_TARGET_MAKE)
endef

define MOLOT_LITE_MONO_LV2_INSTALL_TARGET_CMDS
	$(MOLOT_LITE_MONO_LV2_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
