######################################
#
# stone-phaser
#
######################################

STONE_PHASER_VERSION = da7157e6026f779ac4ae7cf3fb4df2a83ea2fc35
STONE_PHASER_SITE = https://github.com/jpcima/stone-phaser.git
STONE_PHASER_SITE_METHOD = git
STONE_PHASER_DEPENDENCIES = host-stone-phaser
STONE_PHASER_BUNDLES = stone-phaser.lv2 stone-phaser-stereo.lv2

STONE_PHASER_HOST_MAKE = $(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) NOOPT=true BUILD_UI=false -C $(@D)
STONE_PHASER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true BUILD_UI=false CROSS_COMPILING=true -C $(@D)

STONE_PHASER_TMP_DIR = $(HOST_DIR)/tmp-stone-phaser

# needed for git submodules
define HOST_STONE_PHASER_EXTRACT_CMDS
	$(call STONE_PHASER_EXTRACT_CMDS)
endef

define STONE_PHASER_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive $(STONE_PHASER_SITE) $(@D)
	(cd $(@D) && \
		git reset --hard $(STONE_PHASER_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

# build plugins in host to generate ttls
define HOST_STONE_PHASER_BUILD_CMDS
	$(STONE_PHASER_HOST_MAKE)
	rm $(@D)/bin/*.lv2/*.so
	rm -rf $(STONE_PHASER_TMP_DIR)
	mkdir -p $(STONE_PHASER_TMP_DIR)
	cp -r $(@D)/bin/*.lv2 $(STONE_PHASER_TMP_DIR)
endef

# build plugins in target skipping ttl generation
define STONE_PHASER_BUILD_CMDS
	mkdir -p $(@D)/bin/
	cp -r $(STONE_PHASER_TMP_DIR)/*.lv2 $(@D)/bin/
	$(STONE_PHASER_TARGET_MAKE)
	rm -r $(STONE_PHASER_TMP_DIR)
endef

define STONE_PHASER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

# import everything else from the buildroot generic package
$(eval $(generic-package))
# import host version too
$(eval $(host-generic-package))
