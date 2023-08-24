######################################
#
# audio-bridge
#
######################################

AUDIO_BRIDGE_VERSION = 47b6ef99dc11c4b3697b94c1328a3ef2bec24709
AUDIO_BRIDGE_SITE = $(call github,falkTX,audio-bridge,$(AUDIO_BRIDGE_VERSION))
AUDIO_BRIDGE_DEPENDENCIES = jack2mod
AUDIO_BRIDGE_BUNDLES = audio-bridge.lv2

define AUDIO_BRIDGE_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/$(AUDIO_BRIDGE_BUNDLES)
	install -m 644 $(@D)/$(AUDIO_BRIDGE_BUNDLES)/*.* $(TARGET_DIR)/usr/lib/lv2/$(AUDIO_BRIDGE_BUNDLES)
endef

$(eval $(cmake-package))
