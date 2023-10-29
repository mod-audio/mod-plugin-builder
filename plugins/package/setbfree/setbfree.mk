######################################
#
# setbfree
#
######################################

SETBFREE_VERSION = 30f1ec6267afb0ee17b472db0c4826d5bd96fad8
SETBFREE_SITE = $(call github,pantherb,setBfree,$(SETBFREE_VERSION))
SETBFREE_DEPENDENCIES = fftw-single libsndfile zita-convolver
SETBFREE_BUNDLES = b_synth b_whirl

SETBFREE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD_BUILD=1 OPTIMIZATIONS= PREFIX=/usr -C $(@D)

define SETBFREE_BUILD_CMDS
	$(SETBFREE_TARGET_MAKE)
endef

define SETBFREE_INSTALL_TARGET_CMDS
	$(SETBFREE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/b_synth/* $(TARGET_DIR)/usr/lib/lv2/b_synth/

	# b_whirl has been manually splitted into separate bundles
	mv $(TARGET_DIR)/usr/lib/lv2/b_whirl/b_whirl.* $(TARGET_DIR)/usr/lib/lv2/
	rm -rf $(TARGET_DIR)/usr/lib/lv2/b_whirl/
	cp -rL $($(PKG)_PKGDIR)/b_whirl $(TARGET_DIR)/usr/lib/lv2/
	cp $(TARGET_DIR)/usr/lib/lv2/b_whirl.* $(TARGET_DIR)/usr/lib/lv2/b_whirl/
	rm $(TARGET_DIR)/usr/lib/lv2/b_whirl.*
endef

$(eval $(generic-package))
