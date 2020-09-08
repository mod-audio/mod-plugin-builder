######################################
#
# mod-cv-plugins
#
######################################

MOD_CV_PLUGINS_VERSION = 99aa2b1a6f849f6d2c4153ed02a7fe0b62561e52
MOD_CV_PLUGINS_SITE = $(call github,moddevices,mod-cv-plugins,$(MOD_CV_PLUGINS_VERSION))
MOD_CV_PLUGINS_BUNDLES = mod-audio-to-cv.lv2 mod-cv-attenuverter.lv2 mod-cv-clock.lv2 mod-cv-control.lv2 mod-cv-switch1.lv2 mod-cv-switch2.lv2 mod-cv-switch3.lv2 mod-cv-switch4.lv2 mod-midi-to-cv-mono.lv2 mod-midi-to-cv-poly.lv2 mod-cv-meter.lv2 mod-cv-random.lv2 mod-cv-slew.lv2 mod-cv-gate.lv2 mod-cv-range.lv2 mod-cv-round.lv2 mod-cv-abs.lv2 mod-cv-parameter-modulation.lv2

# dependencies (list of other buildroot packages, separated by space)
MOD_CV_PLUGINS_DEPENDENCIES =

# call make with the current arguments and path. "$(@D)" is the build directory.
MOD_CV_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define MOD_CV_PLUGINS_BUILD_CMDS
	$(MOD_CV_PLUGINS_TARGET_MAKE)
endef

define MOD_CV_PLUGINS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/source/mod-cv*/*.lv2    $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/source/mod-midi*/*.lv2  $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/source/mod-audio*/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-audio-to-cv.lv2/*        $(TARGET_DIR)/usr/lib/lv2/mod-audio-to-cv.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-attenuverter.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-cv-attenuverter.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-clock.lv2/*           $(TARGET_DIR)/usr/lib/lv2/mod-cv-clock.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-control.lv2/*         $(TARGET_DIR)/usr/lib/lv2/mod-cv-control.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-meter.lv2/*           $(TARGET_DIR)/usr/lib/lv2/mod-cv-meter.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-random.lv2/*          $(TARGET_DIR)/usr/lib/lv2/mod-cv-random.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-range.lv2/*           $(TARGET_DIR)/usr/lib/lv2/mod-cv-range.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-slew.lv2/*            $(TARGET_DIR)/usr/lib/lv2/mod-cv-slew.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-switch1.lv2/*         $(TARGET_DIR)/usr/lib/lv2/mod-cv-switch1.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-switch2.lv2/*         $(TARGET_DIR)/usr/lib/lv2/mod-cv-switch2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-switch3.lv2/*         $(TARGET_DIR)/usr/lib/lv2/mod-cv-switch3.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-switch4.lv2/*         $(TARGET_DIR)/usr/lib/lv2/mod-cv-switch4.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-midi-to-cv-mono.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-midi-to-cv-mono.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-midi-to-cv-poly.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-midi-to-cv-poly.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-cv-parameter-modulation.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-cv-parameter-modulation.lv2/
endef

$(eval $(generic-package))
