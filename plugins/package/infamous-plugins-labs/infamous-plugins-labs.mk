######################################
#
# infamous-plugins
#
######################################

INFAMOUS_PLUGINS_LABS_VERSION = 8c42ee211171d17059e0cd216a14096bce1ba67e
INFAMOUS_PLUGINS_LABS_SITE = $(call github,ssj71,infamousPlugins,$(INFAMOUS_PLUGINS_LABS_VERSION))
#envfollower.lv2 ewham.lv2 casynth.lv2 cheapdist.lv2 hip2b.lv2 lushlife.lv2 powercut.lv2 powerup.lv2 stuck.lv2 bentdelay.lv2
INFAMOUS_PLUGINS_LABS_BUNDLES = ewham.lv2 bentdelay.lv2

define INFAMOUS_PLUGINS_LABS_POST_INSTALL_TARGET_TTLFILES
	cp -rL $($(PKG)_PKGDIR)/ewham.lv2/* $(TARGET_DIR)/usr/lib/lv2/ewham.lv2/
endef

INFAMOUS_PLUGINS_LABS_POST_INSTALL_TARGET_HOOKS += INFAMOUS_PLUGINS_LABS_POST_INSTALL_TARGET_TTLFILES

$(eval $(cmake-package))
