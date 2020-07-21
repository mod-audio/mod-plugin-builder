######################################
#
# lv2-examples-labs
#
######################################

LV2_EXAMPLES_LABS_VERSION = 1.18.0
LV2_EXAMPLES_LABS_SITE = http://lv2plug.in/spec
LV2_EXAMPLES_LABS_SOURCE = lv2-$(LV2_EXAMPLES_LABS_VERSION).tar.bz2
LV2_EXAMPLES_LABS_DEPENDENCIES = host-python
LV2_EXAMPLES_LABS_BUNDLES = eg-amp.lv2 eg-fifths.lv2 eg-midigate.lv2 eg-sampler.lv2

LV2_EXAMPLES_LABS_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define LV2_EXAMPLES_LABS_CONFIGURE_CMDS
	(cd $(@D); $(LV2_EXAMPLES_LABS_TARGET_WAF) configure --prefix=/usr)
endef

define LV2_EXAMPLES_LABS_BUILD_CMDS
	(cd $(@D); $(LV2_EXAMPLES_LABS_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define LV2_EXAMPLES_LABS_INSTALL_TARGET_CMDS
	(cd $(@D); $(LV2_EXAMPLES_LABS_TARGET_WAF) install --destdir=$(TARGET_DIR))
	cp -rL $($(PKG)_PKGDIR)/eg-sampler.lv2/* $(TARGET_DIR)/usr/lib/lv2/eg-sampler.lv2/
endef

$(eval $(generic-package))
