######################################
#
# setbfree
#
######################################

SETBFREE_VERSION = 8bb8d1fe429559d5dafa7f0a4e5fbdd2171af0d8
SETBFREE_SITE = $(call github,pantherb,setBfree,$(SETBFREE_VERSION))
SETBFREE_DEPENDENCIES = fftwf libsndfile zita-convolver
SETBFREE_BUNDLES = 

SETBFREE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) ENABLE_CONVOLUTION=yes OPTIMIZATIONS= PREFIX=/usr -C $(@D)

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
