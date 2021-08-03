######################################
#
# abgate
#
######################################

ABGATE_VERSION = c416c29d66c09da610dc632605adad14781ede8d
ABGATE_SITE = $(call github,antanasbruzas,abGate,$(ABGATE_VERSION))
ABGATE_BUNDLES = abGate.lv2

ABGATE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define ABGATE_BUILD_CMDS
	$(ABGATE_TARGET_MAKE)
endef

define ABGATE_INSTALL_TARGET_CMDS
	$(ABGATE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/abGate.lv2/* $(TARGET_DIR)/usr/lib/lv2/abGate.lv2/
endef

$(eval $(generic-package))
