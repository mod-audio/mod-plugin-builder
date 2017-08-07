######################################
#
# setbfree-mod
#
######################################

SETBFREE_MOD_VERSION = 30f1ec6267afb0ee17b472db0c4826d5bd96fad8
SETBFREE_MOD_SITE = $(call github,pantherb,setBfree,$(SETBFREE_MOD_VERSION))
SETBFREE_MOD_DEPENDENCIES = fftwf libsndfile zita-convolver
SETBFREE_MOD_BUNDLES = b_whirl_mod

SETBFREE_MOD_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS= PREFIX=/usr -C $(@D)

define SETBFREE_MOD_BUILD_CMDS
	$(SETBFREE_MOD_TARGET_MAKE)
endef

define SETBFREE_MOD_INSTALL_TARGET_CMDS
	$(SETBFREE_MOD_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)

	install -d $(TARGET_DIR)/usr/lib/lv2/b_whirl_mod
	cp -rL $($(PKG)_PKGDIR)/b_whirl_mod/* $(TARGET_DIR)/usr/lib/lv2/b_whirl_mod/
	cp $(TARGET_DIR)/usr/lib/lv2/b_whirl/*.so $(TARGET_DIR)/usr/lib/lv2/b_whirl_mod/
endef

$(eval $(generic-package))
