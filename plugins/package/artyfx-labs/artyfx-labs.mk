######################################
#
# artyfx-labs
#
######################################

ARTYFX_LABS_VERSION = 3fdeecd081c9a03b3a630d2ed0825674a30c05d5
ARTYFX_LABS_SITE = $(call github,harryhaaren,openAV-ArtyFX,$(ARTYFX_LABS_VERSION))
ARTYFX_LABS_DEPENDENCIES = libsndfile
ARTYFX_LABS_CONF_OPTS=-DBUILD_GUI=OFF
ARTYFX_LABS_BUNDLES = artyfx-bad.lv2

define ARTYFX_LABS_POST_INSTALL_TARGET_TTLFILES
	mv $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2 $(TARGET_DIR)/usr/lib/lv2/artyfx-bad.lv2
	cp -rL $($(PKG)_PKGDIR)/artyfx-bad.lv2/* $(TARGET_DIR)/usr/lib/lv2/artyfx-bad.lv2/
endef

ARTYFX_LABS_POST_INSTALL_TARGET_HOOKS += ARTYFX_LABS_POST_INSTALL_TARGET_TTLFILES

$(eval $(cmake-package))
