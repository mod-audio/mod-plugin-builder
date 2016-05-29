######################################
#
# rubberband
#
######################################

RUBBERBAND_VERSION = 4c32e02b5d58e4a2282156106b64e60b6e773ca3
RUBBERBAND_SITE = $(call github,falkTX,rubberband,$(RUBBERBAND_VERSION))
RUBBERBAND_DEPENDENCIES = libsamplerate libsndfile fftwf vamp-sdk
# ladspa
RUBBERBAND_BUNDLES = rubberband.lv2

RUBBERBAND_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define RUBBERBAND_LV2_BUILD_CMDS
	$(RUBBERBAND_LV2_TARGET_MAKE)
endef

define RUBBERBAND_LV2_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/rubberband.lv2
	install -m 644 $(@D)/rubberband.lv2/*.ttl $(TARGET_DIR)/usr/lib/lv2/rubberband.lv2
endef

$(eval $(autotools-package))
