######################################
#
# artyfx-bad
#
######################################

ARTYFX_BAD_VERSION = 3fdeecd081c9a03b3a630d2ed0825674a30c05d5
ARTYFX_BAD_SITE = $(call github,harryhaaren,openAV-ArtyFX,$(ARTYFX_BAD_VERSION))
ARTYFX_BAD_DEPENDENCIES = libsndfile
ARTYFX_BAD_CONF_OPTS=-DBUILD_GUI=OFF
ARTYFX_BAD_BUNDLES = 

define ARTYFX_BAD_POST_INSTALL_TARGET_TTLFILES
	mv $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2 $(TARGET_DIR)/usr/lib/lv2/artyfx-bad.lv2
	cp -rL $($(PKG)_PKGDIR)/artyfx-bad.lv2/* $(TARGET_DIR)/usr/lib/lv2/artyfx-bad.lv2/
endef

ARTYFX_BAD_POST_INSTALL_TARGET_HOOKS += ARTYFX_BAD_POST_INSTALL_TARGET_TTLFILES

$(eval $(cmake-package))
