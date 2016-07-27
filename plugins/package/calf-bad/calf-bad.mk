######################################
#
# calf-bad
#
######################################

CALF_BAD_VERSION = 0.0.60
CALF_BAD_SITE = http://calf-studio-gear.org/files/
CALF_BAD_SOURCE = calf-$(CALF_BAD_VERSION).tar.gz
CALF_BAD_DEPENDENCIES = cairo expat libglib2
CALF_BAD_AUTORECONF = YES
CALF_BAD_BUNDLES = calf-bad.lv2

define CALF_BAD_POST_INSTALL_TARGET_MODGUIS
	mv $(TARGET_DIR)/usr/lib/lv2/calf.lv2 $(TARGET_DIR)/usr/lib/lv2/calf-bad.lv2
	cp -rL $($(PKG)_PKGDIR)/calf-bad.lv2/* $(TARGET_DIR)/usr/lib/lv2/calf-bad.lv2/
endef

CALF_BAD_POST_INSTALL_TARGET_HOOKS += CALF_BAD_POST_INSTALL_TARGET_MODGUIS

$(eval $(autotools-package))
