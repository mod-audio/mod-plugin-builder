######################################
#
# audio-bridge-lv2
#
######################################

AUDIO_BRIDGE_LV2_VERSION = 1a7a663059c2196359076625bd1e933558a0bfbe
AUDIO_BRIDGE_LV2_SITE = $(call github,falkTX,audio-bridge,$(AUDIO_BRIDGE_LV2_VERSION))
AUDIO_BRIDGE_LV2_DEPENDENCIES = jack2mod
AUDIO_BRIDGE_LV2_BUNDLES = audio-bridge.lv2

define AUDIO_BRIDGE_LV2_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/$(AUDIO_BRIDGE_LV2_BUNDLES)
	install -m 644 $(@D)/$(AUDIO_BRIDGE_LV2_BUNDLES)/*.* $(TARGET_DIR)/usr/lib/lv2/$(AUDIO_BRIDGE_LV2_BUNDLES)
endef

$(eval $(cmake-package))
