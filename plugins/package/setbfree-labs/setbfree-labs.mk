######################################
#
# setbfree-labs
#
######################################

SETBFREE_LABS_VERSION = 30f1ec6267afb0ee17b472db0c4826d5bd96fad8
SETBFREE_LABS_SITE = $(call github,pantherb,setBfree,$(SETBFREE_LABS_VERSION))
SETBFREE_LABS_DEPENDENCIES = fftw-single libsndfile zita-convolver
SETBFREE_LABS_BUNDLES = b_overdrive b_reverb b_whirl_xt

SETBFREE_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD_BUILD=1 OPTIMIZATIONS= PREFIX=/usr -C $(@D)

define SETBFREE_LABS_BUILD_CMDS
	$(SETBFREE_LABS_TARGET_MAKE)
endef

define SETBFREE_LABS_INSTALL_TARGET_CMDS
	$(SETBFREE_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/b_overdrive/* $(TARGET_DIR)/usr/lib/lv2/b_overdrive/
	cp -rL $($(PKG)_PKGDIR)/b_reverb/*    $(TARGET_DIR)/usr/lib/lv2/b_reverb/

	# b_whirl has been manually splitted into separate bundles
	mv $(TARGET_DIR)/usr/lib/lv2/b_whirl/b_whirl.so $(TARGET_DIR)/usr/lib/lv2/b_whirl.so
	rm -rf $(TARGET_DIR)/usr/lib/lv2/b_whirl/
	cp -rL $($(PKG)_PKGDIR)/b_whirl_xt $(TARGET_DIR)/usr/lib/lv2/
	cp $(TARGET_DIR)/usr/lib/lv2/b_whirl.so $(TARGET_DIR)/usr/lib/lv2/b_whirl_xt/
	rm $(TARGET_DIR)/usr/lib/lv2/b_whirl.so
endef

$(eval $(generic-package))
