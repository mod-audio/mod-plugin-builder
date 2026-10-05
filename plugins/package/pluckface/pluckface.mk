######################################
#
# pluckface
#
######################################
# get version hash with: git rev-parse HEAD
PLUCKFACE_VERSION = f35372012c2c8b2b2e85e089e342ea8d9a8b7bec
PLUCKFACE_SITE = https://github.com/sensorium/pluckface.git
PLUCKFACE_SITE_METHOD = git
PLUCKFACE_DEPENDENCIES = lv2
PLUCKFACE_BUNDLES = pluckface.lv2

define PLUCKFACE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 AUBIO_MODE=vendored -C $(@D)
endef

define PLUCKFACE_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/pluckface.lv2
	install -m755 $(@D)/build/pluckface.so $(TARGET_DIR)/usr/lib/lv2/pluckface.lv2/
	install -m644 $(@D)/build/manifest.ttl $(@D)/build/pluckface.ttl \
		$(TARGET_DIR)/usr/lib/lv2/pluckface.lv2/
	install -d $(TARGET_DIR)/usr/lib/lv2/pluckface.lv2/modgui
	cp -r $(@D)/build/modgui/* $(TARGET_DIR)/usr/lib/lv2/pluckface.lv2/modgui/
	chmod -R a+rX $(TARGET_DIR)/usr/lib/lv2/pluckface.lv2/modgui
endef

$(eval $(generic-package))
