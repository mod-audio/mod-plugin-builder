######################################
#
# caps-lv2
#
######################################

CAPS_LV2_LABS_VERSION = efdef2601435cf4f36da4b8f7b0412fa404facb8
CAPS_LV2_LABS_SITE = $(call github,moddevices,caps-lv2,$(CAPS_LV2_LABS_VERSION))
CAPS_LV2_LABS_BUNDLES = mod-caps-CabinetIII.lv2 mod-caps-ChorusI.lv2 mod-caps-Compress.lv2 mod-caps-CompressX2.lv2 mod-caps-Eq10.lv2 mod-caps-Eq10X2.lv2 mod-caps-Eq4p.lv2 mod-caps-EqFA4p.lv2 mod-caps-Fractal.lv2 mod-caps-Narrower.lv2 mod-caps-Noisegate.lv2 mod-caps-Saturate.lv2 mod-caps-Sin.lv2 mod-caps-ToneStack.lv2


CAPS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define CAPS_LV2_LABS_BUILD_CMDS
	$(CAPS_TARGET_MAKE)
endef

define CAPS_LV2_LABS_INSTALL_TARGET_CMDS
	$(CAPS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
	cp -rL $($(PKG)_PKGDIR)/mod-caps-CabinetIII.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-caps-CabinetIII.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-ChorusI.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-caps-ChorusI.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Compress.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-caps-Compress.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-CompressX2.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-caps-CompressX2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Eq10.lv2/*       $(TARGET_DIR)/usr/lib/lv2/mod-caps-Eq10.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Eq10X2.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-caps-Eq10X2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Eq4p.lv2/*       $(TARGET_DIR)/usr/lib/lv2/mod-caps-Eq4p.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-EqFA4p.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-caps-EqFA4p.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Fractal.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-caps-Fractal.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Narrower.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-caps-Narrower.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Noisegate.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-caps-Noisegate.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Saturate.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-caps-Saturate.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-Sin.lv2/*        $(TARGET_DIR)/usr/lib/lv2/mod-caps-Sin.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-caps-ToneStack.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-caps-ToneStack.lv2/
endef

$(eval $(generic-package))
