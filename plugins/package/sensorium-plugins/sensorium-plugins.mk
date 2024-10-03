######################################
#
# sensorium-plugins
#
######################################

SENSORIUM_PLUGINS_VERSION = 8880e2890658b5763c3f5bd0c436f48e0c468711
SENSORIUM_PLUGINS_SITE = https://github.com/sensorium/sensorium-plugins.git
SENSORIUM_PLUGINS_SITE_METHOD = git
SENSORIUM_PLUGINS_DEPENDENCIES = dpf
SENSORIUM_PLUGINS_BUNDLES = TheCloud.lv2

define SENSORIUM_PLUGINS_CONFIGURE_CMDS
	# install hvcc
	# --break-system-packages
	pip3 install git+https://github.com/Wasted-Audio/hvcc.git \
		--disable-pip-version-check \
		--isolated \
		--no-cache-dir
endef

define SENSORIUM_PLUGINS_BUILD_CMDS
	# create dpf-based build project
	hvcc $(@D)/Pd/TheCloud.pd -m $(@D)/thecloud.json -n "TheCloud" -g dpf -o $(@D)/build

	# symlink dpf dep into build dir
	ln -sf $(STAGING_DIR)/usr/src/dpf $(@D)/build

	# build dpf project
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
