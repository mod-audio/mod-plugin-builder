######################################
#
# dragonfly-reverb
#
######################################

DRAGONFLY_REVERB_VERSION = 3d1e043524fcef5102cbb8362cc948abab106240
DRAGONFLY_REVERB_SITE = https://github.com/michaelwillis/dragonfly-reverb.git
DRAGONFLY_REVERB_SITE = https://github.com/falkTX/dragonfly-reverb.git
DRAGONFLY_REVERB_SITE_METHOD = git
DRAGONFLY_REVERB_BUNDLES = DragonflyEarlyReflections.lv2 DragonflyHallReverb.lv2 DragonflyPlateReverb.lv2 DragonflyRoomReverb.lv2

# DISABLE_UNDENORMAL

# needed for submodules support
DRAGONFLY_REVERB_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

DRAGONFLY_REVERB_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true

define DRAGONFLY_REVERB_BUILD_CMDS
	$(DRAGONFLY_REVERB_TARGET_MAKE) lv2_dsp -C $(@D)/plugins/dragonfly-hall-reverb
	$(DRAGONFLY_REVERB_TARGET_MAKE) lv2_dsp -C $(@D)/plugins/dragonfly-room-reverb
	$(DRAGONFLY_REVERB_TARGET_MAKE) lv2_dsp -C $(@D)/plugins/dragonfly-plate-reverb
	$(DRAGONFLY_REVERB_TARGET_MAKE) lv2_dsp -C $(@D)/plugins/dragonfly-early-reflections
endef

define DRAGONFLY_REVERB_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/DragonflyEarlyReflections.lv2/* $(TARGET_DIR)/usr/lib/lv2/DragonflyEarlyReflections.lv2/
	cp -rL $($(PKG)_PKGDIR)/DragonflyHallReverb.lv2/*       $(TARGET_DIR)/usr/lib/lv2/DragonflyHallReverb.lv2/
	cp -rL $($(PKG)_PKGDIR)/DragonflyPlateReverb.lv2/*      $(TARGET_DIR)/usr/lib/lv2/DragonflyPlateReverb.lv2/
	cp -rL $($(PKG)_PKGDIR)/DragonflyRoomReverb.lv2/*       $(TARGET_DIR)/usr/lib/lv2/DragonflyRoomReverb.lv2/
endef

$(eval $(generic-package))
