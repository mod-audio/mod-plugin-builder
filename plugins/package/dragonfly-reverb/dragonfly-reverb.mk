######################################
#
# dragonfly-reverb
#
######################################

DRAGONFLY_REVERB_VERSION = 67d942d8bf24c507fea7c83e5dda8b3f17b064c0
DRAGONFLY_REVERB_SITE = https://github.com/michaelwillis/dragonfly-reverb.git
DRAGONFLY_REVERB_SITE_METHOD = git
DRAGONFLY_REVERB_BUNDLES = DragonflyHallReverb.lv2 DragonflyRoomReverb.lv2

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
		git reset --hard 196977645eb0ffc1928369538b1c262e7c267316)
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
