######################################
#
# audio-bridge
#
######################################

AUDIO_BRIDGE_VERSION = 1a7a663059c2196359076625bd1e933558a0bfbe
AUDIO_BRIDGE_SITE = $(call github,falkTX,audio-bridge,$(AUDIO_BRIDGE_VERSION))
AUDIO_BRIDGE_DEPENDENCIES = jack2mod
AUDIO_BRIDGE_BUNDLES = audio-bridge.lv2

define AUDIO_BRIDGE_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/$(AUDIO_BRIDGE_BUNDLES)
	install -m 644 $(@D)/$(AUDIO_BRIDGE_BUNDLES)/*.* $(TARGET_DIR)/usr/lib/lv2/$(AUDIO_BRIDGE_BUNDLES)
endef

$(eval $(cmake-package))
