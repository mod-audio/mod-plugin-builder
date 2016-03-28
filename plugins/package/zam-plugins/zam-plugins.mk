######################################
#
# zam-plugins
#
######################################

ZAM_PLUGINS_VERSION = 21ccac0c15e1e54d482ff0931b55975a7e2ac62e
ZAM_PLUGINS_SITE = $(call github,zamaudio,zam-plugins,$(ZAM_PLUGINS_VERSION))
ZAM_PLUGINS_DEPENDENCIES = host-zam-plugins
ZAM_PLUGINS_BUNDLES = ZamAutoSat.lv2 ZaMaximX2.lv2 ZamComp.lv2 ZamCompX2.lv2 ZamDelay.lv2 ZamEQ2.lv2 ZamGate.lv2 ZamGateX2.lv2 ZamGEQ31.lv2 ZamHeadX2.lv2 ZamTube.lv2 ZaMultiComp.lv2 ZaMultiCompX2.lv2

ZAM_PLUGINS_HOST_MAKE   = $(HOST_MAKE_ENV)   $(HOST_CONFIGURE_OPTS)   $(MAKE) NOOPT=true -C $(@D)
ZAM_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

ZAM_PLUGINS_TMP_DIR = $(HOST_DIR)/tmp-zam-plugins

# needed for git submodules
define ZAM_PLUGINS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/zamaudio/zam-plugins $(@D)
	(cd $(@D) && \
		git reset --hard $(ZAM_PLUGINS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define HOST_ZAM_PLUGINS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/zamaudio/zam-plugins $(@D)
	(cd $(@D) && \
		git reset --hard $(ZAM_PLUGINS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

# build plugins in host to generate ttls
define HOST_ZAM_PLUGINS_BUILD_CMDS
	# build everything
	$(ZAM_PLUGINS_HOST_MAKE)

	# delete binaries
	rm $(@D)/bin/*.lv2/*.so

	# create temp dir
	rm -rf $(ZAM_PLUGINS_TMP_DIR)
	mkdir -p $(ZAM_PLUGINS_TMP_DIR)

	# copy the generated bundles without binaries to temp dir
	cp -r $(@D)/bin/*.lv2 $(ZAM_PLUGINS_TMP_DIR)
endef

# build plugins in target skipping ttl generation
define ZAM_PLUGINS_BUILD_CMDS
	# create dummy generator
	touch $(@D)/dpf/utils/lv2_ttl_generator
	chmod +x $(@D)/dpf/utils/lv2_ttl_generator

	# copy previously generated bundles
	cp -r $(ZAM_PLUGINS_TMP_DIR)/*.lv2 $(@D)/bin/

	# now build in target
	$(ZAM_PLUGINS_TARGET_MAKE)

	# cleanup
	rm $(@D)/dpf/utils/lv2_ttl_generator
	rm -r $(ZAM_PLUGINS_TMP_DIR)
endef

define ZAM_PLUGINS_INSTALL_TARGET_CMDS
	$(ZAM_PLUGINS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
