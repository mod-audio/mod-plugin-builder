######################################
#
# sensorium-plugins
#
######################################

SENSORIUM_PLUGINS_VERSION = 232e95a478937efcab02f5dc51e55045796134df
SENSORIUM_PLUGINS_SITE = https://github.com/sensorium/sensorium-plugins.git
SENSORIUM_PLUGINS_SITE_METHOD = git
SENSORIUM_PLUGINS_DEPENDENCIES = dpf hvcc
SENSORIUM_PLUGINS_BUNDLES = TheCloud.lv2

define SENSORIUM_PLUGINS_BUILD_CMDS
	# create dpf-based build project
	$(STAGING_DIR)/usr/bin/hvcc $(@D)/Pd/TheCloud.pd -m $(@D)/thecloud.json -n "TheCloud" -g dpf -o $(@D)/build

	# symlink dpf dep into build dir
	ln -sf $(STAGING_DIR)/usr/src/dpf $(@D)/build

	# build dpf project
	rm -f TheCloud.lv2/TheCloud_dsp.so
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)/build
endef

define SENSORIUM_PLUGINS_INSTALL_TARGET_CMDS
	# install built bundles
	cp -r $(@D)/build/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/

	# install custom ttl
	cp $(@D)/TheCloud.lv2/*.ttl $(TARGET_DIR)/usr/lib/lv2/TheCloud.lv2/
	cp -r $(@D)/TheCloud.lv2/modgui $(TARGET_DIR)/usr/lib/lv2/TheCloud.lv2/
endef

$(eval $(generic-package))
