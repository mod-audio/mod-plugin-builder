######################################
#
# dpf-plugins-labs
#
######################################

DPF_PLUGINS_LABS_VERSION = 86084a934adb26f529038cbcf901fd7a09b95897
DPF_PLUGINS_LABS_SITE = $(call github,DISTRHO,DPF-Plugins,$(DPF_PLUGINS_LABS_VERSION))
DPF_PLUGINS_LABS_BUNDLES = 3BandEQ.lv2 3BandSplitter.lv2 AmplitudeImposer.lv2 CycleShifter.lv2 MaBitcrush.lv2 MaFreeverb.lv2 MaGigaverb.lv2 MaPitchshift.lv2 SoulForce.lv2

DPF_PLUGINS_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true HAVE_CAIRO=false HAVE_GL=false -C $(@D)

define DPF_PLUGINS_LABS_BUILD_CMDS
	$(DPF_PLUGINS_LABS_TARGET_MAKE)
endef

define DPF_PLUGINS_LABS_INSTALL_TARGET_CMDS
	$(DPF_PLUGINS_LABS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/3BandEQ.lv2/*          $(TARGET_DIR)/usr/lib/lv2/3BandEQ.lv2/
	cp -rL $($(PKG)_PKGDIR)/3BandSplitter.lv2/*    $(TARGET_DIR)/usr/lib/lv2/3BandSplitter.lv2/
	cp -rL $($(PKG)_PKGDIR)/AmplitudeImposer.lv2/* $(TARGET_DIR)/usr/lib/lv2/AmplitudeImposer.lv2/
	cp -rL $($(PKG)_PKGDIR)/CycleShifter.lv2/*     $(TARGET_DIR)/usr/lib/lv2/CycleShifter.lv2/
	cp -rL $($(PKG)_PKGDIR)/MaBitcrush.lv2/*       $(TARGET_DIR)/usr/lib/lv2/MaBitcrush.lv2/
	cp -rL $($(PKG)_PKGDIR)/MaFreeverb.lv2/*       $(TARGET_DIR)/usr/lib/lv2/MaFreeverb.lv2/
	cp -rL $($(PKG)_PKGDIR)/MaGigaverb.lv2/*       $(TARGET_DIR)/usr/lib/lv2/MaGigaverb.lv2/
	cp -rL $($(PKG)_PKGDIR)/MaPitchshift.lv2/*     $(TARGET_DIR)/usr/lib/lv2/MaPitchshift.lv2/
	cp -rL $($(PKG)_PKGDIR)/SoulForce.lv2/*        $(TARGET_DIR)/usr/lib/lv2/SoulForce.lv2/
endef

$(eval $(generic-package))
