######################################
#
# lv2-examples
#
######################################

LV2_EXAMPLES_VERSION = 611759daacc377a2dba97723097338fceffd6ef8
LV2_EXAMPLES_SITE = https://github.com/lv2/lv2.git
LV2_EXAMPLES_SITE_METHOD = git
LV2_EXAMPLES_DEPENDENCIES = host-python
LV2_EXAMPLES_BUNDLES = eg-metro.lv2 eg-sampler.lv2

LV2_EXAMPLES_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python3 ./waf

# needed for submodules support
LV2_EXAMPLES_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define LV2_EXAMPLES_CONFIGURE_CMDS
	(cd $(@D); $(LV2_EXAMPLES_TARGET_WAF) configure --prefix=/usr)
endef

define LV2_EXAMPLES_BUILD_CMDS
	(cd $(@D); $(LV2_EXAMPLES_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define LV2_EXAMPLES_INSTALL_TARGET_CMDS
	(cd $(@D); $(LV2_EXAMPLES_TARGET_WAF) install --destdir=$(TARGET_DIR))
	cp -rL $($(PKG)_PKGDIR)/eg-sampler.lv2/* $(TARGET_DIR)/usr/lib/lv2/eg-sampler.lv2/
	cp -rL $($(PKG)_PKGDIR)/eg-metro.lv2/* $(TARGET_DIR)/usr/lib/lv2/eg-metro.lv2/
endef

$(eval $(generic-package))
