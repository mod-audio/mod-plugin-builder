######################################
#
# fomp
#
######################################

FOMP_VERSION = 4511cfc6641bb9b4b08d63f3cd7d16911bce8372
FOMP_SITE = http://git.drobilla.net/fomp.lv2.git
FOMP_SITE_METHOD = git
FOMP_BUNDLES = fomp.lv2

FOMP_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python2 ./waf

define FOMP_CONFIGURE_CMDS
	(cd $(@D); $(FOMP_TARGET_WAF) configure --prefix=/usr --lv2dir=/usr/lib/lv2)
endef

define FOMP_BUILD_CMDS
	(cd $(@D); $(FOMP_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define FOMP_INSTALL_TARGET_CMDS
	(cd $(@D); $(FOMP_TARGET_WAF) install --destdir=$(TARGET_DIR))
	cp -rL $($(PKG)_PKGDIR)/fomp.lv2/* $(TARGET_DIR)/usr/lib/lv2/fomp.lv2/
endef

$(eval $(generic-package))
