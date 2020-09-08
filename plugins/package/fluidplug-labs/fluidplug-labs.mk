######################################
#
# fluidplug-labs
#
######################################

FLUIDPLUG_LABS_VERSION = 889b2568f5c4483b1c72b5d82e4090e27ef824de
FLUIDPLUG_LABS_SITE = $(call github,falkTX,FluidPlug,$(FLUIDPLUG_LABS_VERSION))
FLUIDPLUG_LABS_DEPENDENCIES = fluidsynth host-p7zip-light
FLUIDPLUG_LABS_BUNDLES = AirFont320.lv2 AVL_Drumkits_Perc.lv2

FLUIDPLUG_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define FLUIDPLUG_LABS_BUILD_CMDS
	$(FLUIDPLUG_LABS_TARGET_MAKE)
endef

define FLUIDPLUG_LABS_INSTALL_TARGET_CMDS
	$(FLUIDPLUG_LABS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/AirFont320.lv2/*         $(TARGET_DIR)/usr/lib/lv2/AirFont320.lv2/
	cp -rL $($(PKG)_PKGDIR)/AVL_Drumkits_Perc.lv2/*  $(TARGET_DIR)/usr/lib/lv2/AVL_Drumkits_Perc.lv2/
endef

$(eval $(generic-package))
