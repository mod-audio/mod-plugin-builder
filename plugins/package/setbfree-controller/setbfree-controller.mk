######################################
#
# setbfree-controller
#
######################################

SETBFREE_CONTROLLER_VERSION = 259e15c1a020055d132fdc28e635aacfa6a6ed2c
SETBFREE_CONTROLLER_SITE = $(call github,vallsv,setbfree-controller.lv2,$(SETBFREE_CONTROLLER_VERSION))
SETBFREE_CONTROLLER_DEPENDENCIES =
SETBFREE_CONTROLLER_BUNDLES = setbfree-controller.lv2

SETBFREE_CONTROLLER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD_BUILD=1 OPTIMIZATIONS= PREFIX=/usr -C $(@D)

define SETBFREE_CONTROLLER_BUILD_CMDS
	$(SETBFREE_CONTROLLER_TARGET_MAKE) build
endef

define SETBFREE_CONTROLLER_INSTALL_TARGET_CMDS
	$(SETBFREE_CONTROLLER_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	#cp -rL $($(PKG)_PKGDIR)/b_overdrive/* $(TARGET_DIR)/usr/lib/lv2/b_overdrive/
endef

$(eval $(generic-package))
