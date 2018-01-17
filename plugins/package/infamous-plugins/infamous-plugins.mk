######################################
#
# infamous-plugins
#
######################################

INFAMOUS_PLUGINS_VERSION = 364ee20c722e23b3fffe10cd4bd8a463bf3c0946
INFAMOUS_PLUGINS_SITE = $(call github,ssj71,infamousPlugins,$(INFAMOUS_PLUGINS_VERSION))
#envfollower.lv2 ewham.lv2 casynth.lv2 cheapdist.lv2 hip2b.lv2 lushlife.lv2 powercut.lv2 powerup.lv2 stuck.lv2 bentdelay.lv2
INFAMOUS_PLUGINS_BUNDLES = ewham.lv2 stuck.lv2 powercut.lv2 bentdelay.lv2 hip2b.lv2 mindi.lv2

define INFAMOUS_PLUGINS_POST_INSTALL_TARGET_TTLFILES
	cp -rL $($(PKG)_PKGDIR)/ewham.lv2/* $(TARGET_DIR)/usr/lib/lv2/ewham.lv2/
	cp -rL $($(PKG)_PKGDIR)/stuck.lv2/* $(TARGET_DIR)/usr/lib/lv2/stuck.lv2/
endef

INFAMOUS_PLUGINS_POST_INSTALL_TARGET_HOOKS += INFAMOUS_PLUGINS_POST_INSTALL_TARGET_TTLFILES

$(eval $(cmake-package))
