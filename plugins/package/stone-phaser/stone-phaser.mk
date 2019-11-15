######################################
#
# stone-phaser
#
######################################

STONE_PHASER_VERSION = 8ae2fc7544259525027ee4496e7fa0c7527f71e7
STONE_PHASER_SITE = https://github.com/jpcima/stone-phaser.git
STONE_PHASER_SITE_METHOD = git
STONE_PHASER_BUNDLES = stone-phaser.lv2 stone-phaser-stereo.lv2

STONE_PHASER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true BUILD_UI=false -C $(@D)

# needed for git submodules
define STONE_PHASER_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive $(STONE_PHASER_SITE) $(@D)
	(cd $(@D) && \
		git reset --hard $(STONE_PHASER_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define STONE_PHASER_BUILD_CMDS
	$(STONE_PHASER_TARGET_MAKE)
endef

define STONE_PHASER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
