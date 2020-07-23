######################################
#
# triceratops-labs
#
######################################

TRICERATOPS_LABS_VERSION = 0.3.0
TRICERATOPS_LABS_SITE = http://download.sourceforge.net/triceratops/
TRICERATOPS_LABS_SOURCE = triceratops-lv2-v$(TRICERATOPS_LABS_VERSION).tar.gz
TRICERATOPS_LABS_BUNDLES = triceratops.lv2

TRICERATOPS_LABS_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define TRICERATOPS_LABS_CONFIGURE_CMDS
	(cd $(@D); $(TRICERATOPS_LABS_TARGET_WAF) configure --prefix=/usr)
endef

define TRICERATOPS_LABS_BUILD_CMDS
	(cd $(@D); $(TRICERATOPS_LABS_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define TRICERATOPS_LABS_INSTALL_TARGET_CMDS
	(cd $(@D); $(TRICERATOPS_LABS_TARGET_WAF) install -j1 --destdir=$(TARGET_DIR))
	cp -rL $($(PKG)_PKGDIR)/triceratops.lv2/* $(TARGET_DIR)/usr/lib/lv2/triceratops.lv2/
endef

$(eval $(generic-package))
