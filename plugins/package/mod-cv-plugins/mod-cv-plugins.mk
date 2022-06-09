######################################
#
# mod-cv-plugins
#
######################################

MOD_CV_PLUGINS_VERSION = 5b3ffb1b163d7770d993261867bad3b17db1a929
MOD_CV_PLUGINS_SITE = https://github.com/moddevices/mod-cv-plugins.git
MOD_CV_PLUGINS_DEPENDENCIES =
MOD_CV_PLUGINS_BUNDLES = logic-operators.lv2 mod-audio-to-cv.lv2 mod-button-to-cv.lv2 mod-cv-abs.lv2 mod-cv-attenuverter.lv2 mod-cv-clock.lv2 mod-cv-control.lv2 mod-cv-gate.lv2 mod-cv-meter.lv2 mod-cv-parameter-modulation.lv2 mod-cv-random.lv2 mod-cv-range.lv2 mod-cv-round.lv2 mod-cv-slew.lv2 mod-cv-switch1.lv2 mod-cv-switch2.lv2 mod-cv-switch3.lv2 mod-cv-switch4.lv2 mod-midi-to-cv-mono.lv2 mod-midi-to-cv-poly.lv2
# unused:
# mod-cv-to-audio.lv2
# mod-cv-transport.lv2

# needed for submodules support
MOD_CV_PLUGINS_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

# call make with the current arguments and path. "$(@D)" is the build directory.
MOD_CV_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define MOD_CV_PLUGINS_BUILD_CMDS
	$(MOD_CV_PLUGINS_TARGET_MAKE)
endef

define MOD_CV_PLUGINS_INSTALL_TARGET_CMDS
	$(MOD_CV_PLUGINS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
	cp -rL $($(PKG)_PKGDIR)/logic-operators.lv2/*             $(TARGET_DIR)/usr/lib/lv2/logic-operators.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-audio-to-cv.lv2/*             $(TARGET_DIR)/usr/lib/lv2/mod-audio-to-cv.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-abs.lv2/*                  $(TARGET_DIR)/usr/lib/lv2/mod-cv-abs.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-attenuverter.lv2/*         $(TARGET_DIR)/usr/lib/lv2/mod-cv-attenuverter.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-clock.lv2/*                $(TARGET_DIR)/usr/lib/lv2/mod-cv-clock.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-control.lv2/*              $(TARGET_DIR)/usr/lib/lv2/mod-cv-control.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-gate.lv2/*                 $(TARGET_DIR)/usr/lib/lv2/mod-cv-gate.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-meter.lv2/*                $(TARGET_DIR)/usr/lib/lv2/mod-cv-meter.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-parameter-modulation.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-cv-parameter-modulation.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-random.lv2/*               $(TARGET_DIR)/usr/lib/lv2/mod-cv-random.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-range.lv2/*                $(TARGET_DIR)/usr/lib/lv2/mod-cv-range.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-round.lv2/*                $(TARGET_DIR)/usr/lib/lv2/mod-cv-round.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-slew.lv2/*                 $(TARGET_DIR)/usr/lib/lv2/mod-cv-slew.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-switch1.lv2/*              $(TARGET_DIR)/usr/lib/lv2/mod-cv-switch1.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-switch2.lv2/*              $(TARGET_DIR)/usr/lib/lv2/mod-cv-switch2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-switch3.lv2/*              $(TARGET_DIR)/usr/lib/lv2/mod-cv-switch3.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-switch4.lv2/*              $(TARGET_DIR)/usr/lib/lv2/mod-cv-switch4.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-to-audio.lv2/*             $(TARGET_DIR)/usr/lib/lv2/mod-cv-to-audio.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-midi-to-cv-mono.lv2/*         $(TARGET_DIR)/usr/lib/lv2/mod-midi-to-cv-mono.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-midi-to-cv-poly.lv2/*         $(TARGET_DIR)/usr/lib/lv2/mod-midi-to-cv-poly.lv2/
endef

$(eval $(generic-package))
