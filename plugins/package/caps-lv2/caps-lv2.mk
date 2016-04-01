######################################
#
# caps-lv2
#
######################################

CAPS_LV2_VERSION = efdef2601435cf4f36da4b8f7b0412fa404facb8
CAPS_LV2_SITE = $(call github,moddevices,caps-lv2,$(CAPS_LV2_VERSION))
CAPS_LV2_BUNDLES = mod-caps-AmpVTS.lv2 mod-caps-AutoFilter.lv2 mod-caps-CabinetIII.lv2 mod-caps-CabinetIV.lv2 mod-caps-CEO.lv2 mod-caps-ChorusI.lv2 mod-caps-Click.lv2 mod-caps-Compress.lv2 mod-caps-CompressX2.lv2 mod-caps-Eq10.lv2 mod-caps-Eq10X2.lv2 mod-caps-Eq4p.lv2 mod-caps-EqFA4p.lv2 mod-caps-Fractal.lv2 mod-caps-Narrower.lv2 mod-caps-Noisegate.lv2 mod-caps-PhaserII.lv2 mod-caps-Plate.lv2 mod-caps-PlateX2.lv2 mod-caps-Saturate.lv2 mod-caps-Scape.lv2 mod-caps-Sin.lv2 mod-caps-Spice.lv2 mod-caps-SpiceX2.lv2 mod-caps-ToneStack.lv2 mod-caps-White.lv2 mod-caps-Wider.lv2

CAPS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define CAPS_LV2_BUILD_CMDS
	$(CAPS_TARGET_MAKE)
endef

define CAPS_LV2_INSTALL_TARGET_CMDS
	$(CAPS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
	cp -rL $($(PKG)_PKGDIR)/mod-caps-AmpVTS.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-caps-AmpVTS.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-AutoFilter.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-caps-AutoFilter.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-CabinetIII.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-caps-CabinetIII.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-CabinetIV.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-caps-CabinetIV.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-CEO.lv2/*        $(TARGET_DIR)/usr/lib/lv2/mod-caps-CEO.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-ChorusI.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-caps-ChorusI.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Click.lv2/*      $(TARGET_DIR)/usr/lib/lv2/mod-caps-Click.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Compress.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-caps-Compress.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-CompressX2.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-caps-CompressX2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Eq10.lv2/*       $(TARGET_DIR)/usr/lib/lv2/mod-caps-Eq10.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Eq10X2.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-caps-Eq10X2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Eq4p.lv2/*       $(TARGET_DIR)/usr/lib/lv2/mod-caps-Eq4p.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-EqFA4p.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-caps-EqFA4p.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Fractal.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-caps-Fractal.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Narrower.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-caps-Narrower.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Noisegate.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-caps-Noisegate.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-PhaserII.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-caps-PhaserII.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Plate.lv2/*      $(TARGET_DIR)/usr/lib/lv2/mod-caps-Plate.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-PlateX2.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-caps-PlateX2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Saturate.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-caps-Saturate.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Scape.lv2/*      $(TARGET_DIR)/usr/lib/lv2/mod-caps-Scape.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Sin.lv2/*        $(TARGET_DIR)/usr/lib/lv2/mod-caps-Sin.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Spice.lv2/*      $(TARGET_DIR)/usr/lib/lv2/mod-caps-Spice.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-SpiceX2.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-caps-SpiceX2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-ToneStack.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-caps-ToneStack.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Wider.lv2/*      $(TARGET_DIR)/usr/lib/lv2/mod-caps-Wider.lv2/
endef

$(eval $(generic-package))
