######################################
#
# calf-labs
#
######################################

CALF_LABS_VERSION = 0.0.60
CALF_LABS_SITE = http://calf-studio-gear.org/files/
CALF_LABS_SOURCE = calf-$(CALF_LABS_VERSION).tar.gz
CALF_LABS_DEPENDENCIES = cairo expat libglib2
CALF_LABS_AUTORECONF = YES
CALF_LABS_MAKE = $(MAKE1)
CALF_LABS_BUNDLES = calf-bad.lv2

define CALF_LABS_POST_INSTALL_TARGET_MODGUIS
	mv $(TARGET_DIR)/usr/lib/lv2/calf.lv2 $(TARGET_DIR)/usr/lib/lv2/calf-bad.lv2
	cp -rL $($(PKG)_PKGDIR)/calf-bad.lv2/* $(TARGET_DIR)/usr/lib/lv2/calf-bad.lv2/
endef

CALF_LABS_POST_INSTALL_TARGET_HOOKS += CALF_LABS_POST_INSTALL_TARGET_MODGUIS

$(eval $(autotools-package))
