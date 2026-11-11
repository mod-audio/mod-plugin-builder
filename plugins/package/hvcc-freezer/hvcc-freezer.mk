######################################
#
# hvcc-freezer
#
######################################

HVCC_FREEZER_VERSION = 8951053f960e5cfb780cacc38631037e1c6b83b7
HVCC_FREEZER_SITE = $(call github,mod-audio,hvcc-plugins,$(HVCC_FREEZER_VERSION))
HVCC_FREEZER_DEPENDENCIES = dpf hvcc
HVCC_FREEZER_BUNDLES = Freezer.lv2

HVCC_FREEZER_PLUGIN_DIR = $(@D)/plugins/BatteryNotIncluded-Freezer
HVCC_FREEZER_CUSTOM_TTL_DIR = $(@D)/custom-ttl/BatteryNotIncluded-Freezer

define HVCC_FREEZER_BUILD_CMDS
	# create dpf-based build project
	$(STAGING_DIR)/usr/bin/hvcc $(HVCC_FREEZER_PLUGIN_DIR)/plugin.pd -m $(HVCC_FREEZER_PLUGIN_DIR)/plugin.json -n "Freezer" -g dpf -o $(@D)/build

	# symlink dpf dep into build dir
	ln -sf $(STAGING_DIR)/usr/src/dpf $(@D)/build

	# build dpf project
	# the modgui comes from custom-ttl, so tell dpf not to generate one (it needs UI size macros an hvcc
	# plugin without a desktop UI does not define)
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) CXXFLAGS="$(TARGET_CXXFLAGS) -DDISTRHO_PLUGIN_USES_CUSTOM_MODGUI=1" \
		$(MAKE) NOOPT=true -C $(@D)/build
endef

define HVCC_FREEZER_INSTALL_TARGET_CMDS
	# install built bundle
	cp -r $(@D)/build/bin/Freezer.lv2 $(TARGET_DIR)/usr/lib/lv2/

	# install custom ttl and modgui
	cp $(HVCC_FREEZER_CUSTOM_TTL_DIR)/*.ttl $(TARGET_DIR)/usr/lib/lv2/Freezer.lv2/
	cp -r $(HVCC_FREEZER_CUSTOM_TTL_DIR)/modgui $(TARGET_DIR)/usr/lib/lv2/Freezer.lv2/
endef

$(eval $(generic-package))
