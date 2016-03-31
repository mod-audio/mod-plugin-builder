######################################
#
# artyfx
#
######################################

ARTYFX_VERSION = 3fdeecd081c9a03b3a630d2ed0825674a30c05d5
ARTYFX_SITE = $(call github,harryhaaren,openAV-ArtyFX,$(ARTYFX_VERSION))
ARTYFX_DEPENDENCIES = libsndfile
ARTYFX_CONF_OPTS=-DBUILD_GUI=OFF
ARTYFX_BUNDLES = artyfx.lv2

define ARTYFX_POST_INSTALL_TARGET_TTLFILES
	cp -rL $(BR2_EXTERNAL)/package/artyfx/artyfx.lv2/* $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/
endef

ARTYFX_POST_INSTALL_TARGET_HOOKS += ARTYFX_POST_INSTALL_TARGET_TTLFILES

$(eval $(cmake-package))
