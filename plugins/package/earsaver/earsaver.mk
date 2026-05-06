######################################
#
# earsaver
#
######################################
EARSAVER_VERSION = 069a41ef25a83e7210a5f85c830611cc9730de27
EARSAVER_SITE = https://github.com/sensorium/earsaver-lv2.git
EARSAVER_SITE_METHOD = git
EARSAVER_DEPENDENCIES = dpf hvcc
EARSAVER_BUNDLES = EarSaver.lv2

define EARSAVER_BUILD_CMDS
	# fetch heavylib if not already present
	test -f $(@D)/heavylib/hv.gt~.pd || \
		git clone --depth=1 https://github.com/Wasted-Audio/heavylib.git $(@D)/heavylib
	# create dpf-based build project
	$(STAGING_DIR)/usr/bin/hvcc $(@D)/EarSaver.pd \
		-n "EarSaver" -g dpf -o $(@D)/build \
		-p $(@D)/heavylib
	# symlink dpf dep into build dir
	ln -sf $(STAGING_DIR)/usr/src/dpf $(@D)/build
	# build dpf project
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)/build
endef

define EARSAVER_INSTALL_TARGET_CMDS
	cp -r $(@D)/build/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp $(@D)/EarSaver.lv2/*.ttl $(TARGET_DIR)/usr/lib/lv2/EarSaver.lv2/
	cp -r $(@D)/EarSaver.lv2/modgui $(TARGET_DIR)/usr/lib/lv2/EarSaver.lv2/
endef

$(eval $(generic-package))
