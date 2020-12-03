######################################
#
# samplv1
#
######################################

SAMPLV1_VERSION = 0.9.18
SAMPLV1_SITE = http://download.sourceforge.net/samplv1/
SAMPLV1_SOURCE = samplv1-$(SAMPLV1_VERSION).tar.gz
SAMPLV1_BUNDLES = samplv1.lv2
SAMPLV1_AUTORECONF = YES

SAMPLV1_CONF_OPTS=--disable-jack --disable-lv2-ui-x11 --disable-lv2-ui-external

define SAMPLV1_INSTALL_TARGET_CMDS
	cp -rL $($(PKG)_PKGDIR)/samplv1.lv2/* $(TARGET_DIR)/usr/lib/lv2/samplv1.lv2/
endef

$(eval $(autotools-package))
