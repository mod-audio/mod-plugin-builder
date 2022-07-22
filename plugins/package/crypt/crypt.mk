######################################
#
# crypt
#
######################################

CRYPT_VERSION = 1e0a3fd633f16e98d3013d247ba94fde04c470ef
CRYPT_SITE = https://github.com/moddevices/crypt/
CRYPT_SITE_METHOD = git
CRYPT_DEPENDENCIES = juce6
CRYPT_CONF_ENV = DESTDIR="$(TARGET_DIR)"
CRYPT_CONF_OPTS = -DCMAKE_TOOLCHAIN_FILE=$(JUCE6_TOOLCHAIN_FILE) -DSKIP_LV2_TTL_GENERATOR=ON
CRYPT_BUNDLES = Crypt.lv2

define CRYPT_POST_INSTALL_TARGET_TTL
	cp -rL $($(PKG)_PKGDIR)/Crypt.lv2/* $(TARGET_DIR)/usr/lib/lv2/Crypt.lv2/
endef

CRYPT_POST_INSTALL_TARGET_HOOKS += CRYPT_POST_INSTALL_TARGET_TTL

$(eval $(cmake-package))
