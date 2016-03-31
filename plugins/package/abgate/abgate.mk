ABGATE_VERSION = 1.1.7
ABGATE_SITE = http://download.sourceforge.net/abgate/
ABGATE_SOURCE = abGate-$(ABGATE_VERSION).tar.gz
ABGATE_BUNDLES = 

ABGATE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define ABGATE_BUILD_CMDS
	$(ABGATE_TARGET_MAKE)
endef

define ABGATE_INSTALL_TARGET_CMDS
	$(ABGATE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/abGate.lv2/* $(TARGET_DIR)/usr/lib/lv2/abGate.lv2/
endef

$(eval $(generic-package))
