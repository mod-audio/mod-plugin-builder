######################################
#
# modspectre-labs
#
######################################

MODSPECTRE_LABS_VERSION = cefe4a8c154f995b6cd2604fa0c03b3f47a21194
MODSPECTRE_LABS_SITE = $(call github,x42,modspectre.lv2,$(MODSPECTRE_LABS_VERSION))
MODSPECTRE_LABS_BUNDLES = modspectre.lv2

MODSPECTRE_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" -C $(@D)

define MODSPECTRE_LABS_BUILD_CMDS
	$(MODSPECTRE_LABS_TARGET_MAKE)
endef

define MODSPECTRE_LABS_INSTALL_TARGET_CMDS
	$(MODSPECTRE_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
endef

$(eval $(generic-package))
