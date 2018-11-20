######################################
#
# calf
#
######################################

CALF_VERSION = 0.90.1
CALF_SITE = http://calf-studio-gear.org/files/
CALF_SOURCE = calf-$(CALF_VERSION).tar.gz
CALF_DEPENDENCIES = cairo expat libglib2
CALF_AUTORECONF = YES
CALF_MAKE = $(MAKE1)
CALF_BUNDLES = calf.lv2

define CALF_POST_INSTALL_TARGET_MODGUIS
	cp -rL $($(PKG)_PKGDIR)/calf.lv2/* $(TARGET_DIR)/usr/lib/lv2/calf.lv2/
endef

CALF_POST_INSTALL_TARGET_HOOKS += CALF_POST_INSTALL_TARGET_MODGUIS

$(eval $(autotools-package))
