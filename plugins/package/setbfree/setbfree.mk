######################################
#
# setbfree
#
######################################

SETBFREE_VERSION = 8535a15bfe9832f50f5da53039c1af01cacfb992
SETBFREE_SITE = $(call github,pantherb,setBfree,$(SETBFREE_VERSION))
SETBFREE_DEPENDENCIES = fftw-single libsndfile zita-convolver
SETBFREE_BUNDLES = b_overdrive b_reverb b_synth b_whirl b_whirl_xt

SETBFREE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) INSTALL_EXTRA_LV2=yes MOD_BUILD=1 OPTIMIZATIONS= PREFIX=/usr -C $(@D)

define SETBFREE_BUILD_CMDS
	$(SETBFREE_TARGET_MAKE)
endef

define SETBFREE_INSTALL_TARGET_CMDS
	$(SETBFREE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/b_overdrive/* $(TARGET_DIR)/usr/lib/lv2/b_overdrive/
	cp -rL $($(PKG)_PKGDIR)/b_reverb/*    $(TARGET_DIR)/usr/lib/lv2/b_reverb/
	cp -rL $($(PKG)_PKGDIR)/b_synth/*     $(TARGET_DIR)/usr/lib/lv2/b_synth/

	# b_whirl has been manually splitted into separate bundles
	mv $(TARGET_DIR)/usr/lib/lv2/b_whirl/b_whirl.so $(TARGET_DIR)/usr/lib/lv2/b_whirl.so
	rm -rf $(TARGET_DIR)/usr/lib/lv2/b_whirl/
	cp -rL $($(PKG)_PKGDIR)/b_whirl    $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/b_whirl_xt $(TARGET_DIR)/usr/lib/lv2/
	cp $(TARGET_DIR)/usr/lib/lv2/b_whirl.so $(TARGET_DIR)/usr/lib/lv2/b_whirl/
	cp $(TARGET_DIR)/usr/lib/lv2/b_whirl.so $(TARGET_DIR)/usr/lib/lv2/b_whirl_xt/
	rm $(TARGET_DIR)/usr/lib/lv2/b_whirl.so
endef

$(eval $(generic-package))
