######################################
#
# tap-lv2-labs
#
######################################

TAP_LV2_LABS_VERSION = de26a3c8c8c2227e6d7fba3dcb54ec5fe2def258
TAP_LV2_LABS_SITE = $(call github,moddevices,tap-lv2,$(TAP_LV2_LABS_VERSION))
TAP_LV2_LABS_BUNDLES = tap-deesser.lv2 tap-limiter.lv2 tap-pitch.lv2 tap-rotspeak.lv2 tap-vibrato.lv2

TAP_LV2_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define TAP_LV2_LABS_BUILD_CMDS
	$(TAP_LV2_LABS_TARGET_MAKE)
endef

define TAP_LV2_LABS_INSTALL_TARGET_CMDS
	$(TAP_LV2_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/tap-deesser.lv2/*       $(TARGET_DIR)/usr/lib/lv2/tap-deesser.lv2/
	cp -rL $($(PKG)_PKGDIR)/tap-limiter.lv2/*       $(TARGET_DIR)/usr/lib/lv2/tap-limiter.lv2/
	cp -rL $($(PKG)_PKGDIR)/tap-pitch.lv2/*         $(TARGET_DIR)/usr/lib/lv2/tap-pitch.lv2/
	cp -rL $($(PKG)_PKGDIR)/tap-rotspeak.lv2/*      $(TARGET_DIR)/usr/lib/lv2/tap-rotspeak.lv2/
	cp -rL $($(PKG)_PKGDIR)/tap-vibrato.lv2/*       $(TARGET_DIR)/usr/lib/lv2/tap-vibrato.lv2/
endef

$(eval $(generic-package))
