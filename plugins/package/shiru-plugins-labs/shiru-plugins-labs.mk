######################################
#
# shiru-plugins-labs
#
######################################

SHIRU_PLUGINS_LABS_VERSION = 089f4b1bbe7e19ada24d826cdfa86b6079d3430b
SHIRU_PLUGINS_LABS_SITE = $(call github,linuxmao-org,shiru-plugins,$(SHIRU_PLUGINS_LABS_VERSION))
SHIRU_PLUGINS_LABS_BUNDLES = 1bs_bitdrive.lv2 1bs_clickydrums.lv2 1bs_noisedrums.lv2 crushdmc.lv2 flopster.lv2

SHIRU_PLUGINS_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true HAVE_CAIRO=false HAVE_DGL=false -C $(@D)

# needed for git submodules
define SHIRU_PLUGINS_LABS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive https://github.com/linuxmao-org/shiru-plugins.git $(@D)
	(cd $(@D) && \
		git reset --hard $(SHIRU_PLUGINS_LABS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define SHIRU_PLUGINS_LABS_BUILD_CMDS
	$(SHIRU_PLUGINS_LABS_TARGET_MAKE)
endef

define SHIRU_PLUGINS_LABS_INSTALL_TARGET_CMDS
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
