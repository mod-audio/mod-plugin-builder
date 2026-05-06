######################################
#
# earsaver
#
######################################
EARSAVER_VERSION = 491183f9a9ed44633ebf1d6e157344adc2ad6342
EARSAVER_SITE = https://github.com/sensorium/earsaver-lv2.git
EARSAVER_SITE_METHOD = git
EARSAVER_DEPENDENCIES = dpf hvcc
EARSAVER_BUNDLES = EarSaver.lv2
define EARSAVER_BUILD_CMDS
	# create dpf-based build project
	$(STAGING_DIR)/usr/bin/hvcc $(@D)/EarSaver.pd -n "EarSaver" -g dpf -o $(@D)/build
	# symlink dpf dep into build dir
	ln -sf $(STAGING_DIR)/usr/src/dpf $(@D)/build
	# build dpf project
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)/build
endef
define EARSAVER_INSTALL_TARGET_CMDS
	# install built bundles
	cp -r $(@D)/build/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	# install custom ttl
	cp $(@D)/EarSaver.lv2/*.ttl $(TARGET_DIR)/usr/lib/lv2/EarSaver.lv2/
	cp -r $(@D)/EarSaver.lv2/modgui $(TARGET_DIR)/usr/lib/lv2/EarSaver.lv2/
endef
$(eval $(generic-package))
