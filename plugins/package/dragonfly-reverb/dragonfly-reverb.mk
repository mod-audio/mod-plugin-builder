######################################
#
# dragonfly-reverb
#
######################################

DRAGONFLY_REVERB_VERSION = ba76b88ade015cf597fac19337938c03851f67aa
DRAGONFLY_REVERB_SITE = https://github.com/michaelwillis/dragonfly-reverb.git
DRAGONFLY_REVERB_SITE_METHOD = git
DRAGONFLY_REVERB_BUNDLES = DragonflyHallReverb.lv2 DragonflyRoomReverb.lv2 DragonflyEarlyReflections.lv2 DragonflyPlateReverb.lv2

DRAGONFLY_REVERB_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

# needed for git submodules
define DRAGONFLY_REVERB_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive $(DRAGONFLY_REVERB_SITE) $(@D)
	(cd $(@D) && \
		git reset --hard $(DRAGONFLY_REVERB_VERSION) && \
		git submodule update)
	# FIXME: remove next 2 lines when upstream updates its dpf version
	(cd $(@D)/dpf && \
		git reset --hard a40eafdf187d6cba5ec68a2d1a3b4ced44b22361)
	touch $(@D)/.stamp_downloaded
endef

define DRAGONFLY_REVERB_BUILD_CMDS
	$(DRAGONFLY_REVERB_TARGET_MAKE)
endef

define DRAGONFLY_REVERB_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
