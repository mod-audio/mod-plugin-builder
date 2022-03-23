######################################
#
# wolf-shaper-labs
#
######################################

WOLF_SHAPER_LABS_VERSION = d0b46c9ece642488efed3cd255df22516966b334
WOLF_SHAPER_LABS_SITE = $(call github,pdesaulniers,wolf-shaper,$(WOLF_SHAPER_LABS_VERSION))
WOLF_SHAPER_LABS_BUNDLES = wolf-shaper.lv2

WOLF_SHAPER_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) BUILD_LV2=true HAVE_DGL=false NOOPT=true -C $(@D)

# needed for git submodules
define WOLF_SHAPER_LABS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive https://github.com/pdesaulniers/wolf-shaper.git $(@D)
	(cd $(@D) && \
		git reset --hard $(WOLF_SHAPER_LABS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define WOLF_SHAPER_LABS_BUILD_CMDS
	$(WOLF_SHAPER_LABS_TARGET_MAKE)
endef

define WOLF_SHAPER_LABS_INSTALL_TARGET_CMDS
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
