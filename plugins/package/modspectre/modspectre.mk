######################################
#
# modspectre
#
######################################

MODSPECTRE_VERSION = 10ae3925308ab6b9ddfe2b570381273002db41de
MODSPECTRE_SITE = $(call github,x42,modspectre.lv2,$(MODSPECTRE_VERSION))
MODSPECTRE_BUNDLES = modspectre.lv2

MODSPECTRE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" -C $(@D)

define MODSPECTRE_BUILD_CMDS
	$(MODSPECTRE_TARGET_MAKE)
endef

define MODSPECTRE_INSTALL_TARGET_CMDS
	$(MODSPECTRE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
endef

$(eval $(generic-package))
