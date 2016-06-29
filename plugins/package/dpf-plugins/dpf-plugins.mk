######################################
#
# dpf-plugins
#
######################################

DPF_PLUGINS_VERSION = 4b0e9dbea7d903cdd1aa62119dc4f468d4bf1dfc
DPF_PLUGINS_SITE = $(call github,DISTRHO,DPF-Plugins,$(DPF_PLUGINS_VERSION))
DPF_PLUGINS_BUNDLES = 3BandEQ.lv2 3BandSplitter.lv2 AmplitudeImposer.lv2 CycleShifter.lv2 Kars.lv2 MaBitcrush.lv2 MaFreeverb.lv2 MaGigaverb.lv2 MaPitchshift.lv2 MVerb.lv2 Nekobi.lv2 PingPongPan.lv2 SoulForce.lv2

DPF_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

# build plugins in target skipping ttl generation
define DPF_PLUGINS_BUILD_CMDS
	$(DPF_PLUGINS_TARGET_MAKE)
endef

define DPF_PLUGINS_INSTALL_TARGET_CMDS
	$(DPF_PLUGINS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/3BandEQ.lv2/*          $(TARGET_DIR)/usr/lib/lv2/3BandEQ.lv2/
	cp -rL $($(PKG)_PKGDIR)/3BandSplitter.lv2/*    $(TARGET_DIR)/usr/lib/lv2/3BandSplitter.lv2/
	cp -rL $($(PKG)_PKGDIR)/AmplitudeImposer.lv2/* $(TARGET_DIR)/usr/lib/lv2/AmplitudeImposer.lv2/
	cp -rL $($(PKG)_PKGDIR)/CycleShifter.lv2/*     $(TARGET_DIR)/usr/lib/lv2/CycleShifter.lv2/
	cp -rL $($(PKG)_PKGDIR)/Kars.lv2/*             $(TARGET_DIR)/usr/lib/lv2/Kars.lv2/
	cp -rL $($(PKG)_PKGDIR)/MaBitcrush.lv2/*       $(TARGET_DIR)/usr/lib/lv2/MaBitcrush.lv2/
	cp -rL $($(PKG)_PKGDIR)/MaFreeverb.lv2/*       $(TARGET_DIR)/usr/lib/lv2/MaFreeverb.lv2/
	cp -rL $($(PKG)_PKGDIR)/MaGigaverb.lv2/*       $(TARGET_DIR)/usr/lib/lv2/MaGigaverb.lv2/
	cp -rL $($(PKG)_PKGDIR)/MaPitchshift.lv2/*     $(TARGET_DIR)/usr/lib/lv2/MaPitchshift.lv2/
	cp -rL $($(PKG)_PKGDIR)/MVerb.lv2/*            $(TARGET_DIR)/usr/lib/lv2/MVerb.lv2/
	cp -rL $($(PKG)_PKGDIR)/Nekobi.lv2/*           $(TARGET_DIR)/usr/lib/lv2/Nekobi.lv2/
	cp -rL $($(PKG)_PKGDIR)/PingPongPan.lv2/*      $(TARGET_DIR)/usr/lib/lv2/PingPongPan.lv2/
	cp -rL $($(PKG)_PKGDIR)/SoulForce.lv2/*        $(TARGET_DIR)/usr/lib/lv2/SoulForce.lv2/
endef

$(eval $(generic-package))
