######################################
#
# audio-bridge
#
######################################

AUDIO_BRIDGE_VERSION = caca521802f892d7b6c3e6cb2989a22c81562736
AUDIO_BRIDGE_SITE = $(call github,falkTX,audio-bridge,$(AUDIO_BRIDGE_VERSION))
AUDIO_BRIDGE_DEPENDENCIES = jack2mod
AUDIO_BRIDGE_BUNDLES = audio-bridge.lv2

define AUDIO_BRIDGE_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/$(AUDIO_BRIDGE_BUNDLES)
	install -m 644 $(@D)/audio-bridge.so $(TARGET_DIR)/usr/lib/lv2/$(AUDIO_BRIDGE_BUNDLES)
	install -m 644 $(@D)/res/*.ttl $(TARGET_DIR)/usr/lib/lv2/$(AUDIO_BRIDGE_BUNDLES)
endef

$(eval $(cmake-package))
