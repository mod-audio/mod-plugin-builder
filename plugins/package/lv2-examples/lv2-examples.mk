######################################
#
# lv2-examples
#
######################################

LV2_EXAMPLES_VERSION = 1.18.0
LV2_EXAMPLES_SITE = http://lv2plug.in/spec
LV2_EXAMPLES_SOURCE = lv2-$(LV2_EXAMPLES_VERSION).tar.bz2
LV2_EXAMPLES_DEPENDENCIES = host-python
LV2_EXAMPLES_BUNDLES = eg-metro.lv2

LV2_EXAMPLES_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define LV2_EXAMPLES_CONFIGURE_CMDS
	(cd $(@D); $(LV2_EXAMPLES_TARGET_WAF) configure --prefix=/usr)
endef

define LV2_EXAMPLES_BUILD_CMDS
	(cd $(@D); $(LV2_EXAMPLES_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define LV2_EXAMPLES_INSTALL_TARGET_CMDS
	(cd $(@D); $(LV2_EXAMPLES_TARGET_WAF) install --destdir=$(TARGET_DIR))
	cp -rL $($(PKG)_PKGDIR)/eg-metro.lv2/* $(TARGET_DIR)/usr/lib/lv2/eg-metro.lv2/
endef

$(eval $(generic-package))
