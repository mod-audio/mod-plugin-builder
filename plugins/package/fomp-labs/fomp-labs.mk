######################################
#
# fomp-labs
#
######################################

FOMP_LABS_VERSION = 4511cfc6641bb9b4b08d63f3cd7d16911bce8372
FOMP_LABS_SITE = http://git.drobilla.net/fomp.lv2.git
FOMP_LABS_SITE_METHOD = git
FOMP_LABS_BUNDLES = fomp-bad.lv2

FOMP_LABS_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python2 ./waf

define FOMP_LABS_CONFIGURE_CMDS
	(cd $(@D); $(FOMP_LABS_TARGET_WAF) configure --prefix=/usr)
endef

define FOMP_LABS_BUILD_CMDS
	(cd $(@D); $(FOMP_LABS_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define FOMP_LABS_INSTALL_TARGET_CMDS
	(cd $(@D); $(FOMP_LABS_TARGET_WAF) install --destdir=$(TARGET_DIR))
	mv $(TARGET_DIR)/usr/lib/lv2/fomp.lv2 $(TARGET_DIR)/usr/lib/lv2/fomp-bad.lv2
	cp -rL $($(PKG)_PKGDIR)/fomp-bad.lv2/* $(TARGET_DIR)/usr/lib/lv2/fomp-bad.lv2/
endef

$(eval $(generic-package))
