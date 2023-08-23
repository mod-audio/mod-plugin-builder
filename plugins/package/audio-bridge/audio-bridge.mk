######################################
#
# audio-bridge
#
######################################

AUDIO_BRIDGE_VERSION = b85ef510dfca27e48fb7c86030b0ad854aaf63f3
AUDIO_BRIDGE_SITE = $(call github,falkTX,audio-bridge,$(AUDIO_BRIDGE_VERSION))
AUDIO_BRIDGE_DEPENDENCIES = jack2mod
AUDIO_BRIDGE_BUNDLES = audio-bridge.lv2

define AUDIO_BRIDGE_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/$(AUDIO_BRIDGE_BUNDLES)
	install -m 644 $(@D)/$(AUDIO_BRIDGE_BUNDLES)/*.* $(TARGET_DIR)/usr/lib/lv2/$(AUDIO_BRIDGE_BUNDLES)
endef

$(eval $(cmake-package))
