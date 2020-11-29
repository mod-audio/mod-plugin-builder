######################################
#
# lv2-examples-labs
#
######################################

LV2_EXAMPLES_LABS_VERSION = bd93d6d7008ed7d6eabd8f5df3d37e6f969cb183
LV2_EXAMPLES_LABS_SITE = https://github.com/lv2/lv2.git
LV2_EXAMPLES_LABS_SITE_METHOD = git
LV2_EXAMPLES_LABS_DEPENDENCIES = host-python
LV2_EXAMPLES_LABS_BUNDLES = eg-amp.lv2 eg-fifths.lv2 eg-midigate.lv2 eg-params.lv2 eg-sampler.lv2

LV2_EXAMPLES_LABS_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

# needed for git submodules
define LV2_EXAMPLES_LABS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive $(LV2_EXAMPLES_LABS_SITE) $(@D)
	(cd $(@D) && \
		git reset --hard $(LV2_EXAMPLES_LABS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define LV2_EXAMPLES_LABS_CONFIGURE_CMDS
	(cd $(@D); $(LV2_EXAMPLES_LABS_TARGET_WAF) configure --prefix=/usr)
endef

define LV2_EXAMPLES_LABS_BUILD_CMDS
	(cd $(@D); $(LV2_EXAMPLES_LABS_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define LV2_EXAMPLES_LABS_INSTALL_TARGET_CMDS
	(cd $(@D); $(LV2_EXAMPLES_LABS_TARGET_WAF) install --destdir=$(TARGET_DIR))
	cp -rL $($(PKG)_PKGDIR)/eg-sampler.lv2/* $(TARGET_DIR)/usr/lib/lv2/eg-sampler.lv2/
	cp -rL $($(PKG)_PKGDIR)/eg-params.lv2/*  $(TARGET_DIR)/usr/lib/lv2/eg-params.lv2/
endef

$(eval $(generic-package))
