######################################
#
# mrfreeze
#
######################################

MRFREEZE_VERSION = bb4ea12e3202a1284e8e671e5ea0b3830171cd7f
MRFREEZE_SITE = $(call github,romi1502,MrFreeze,$(MRFREEZE_VERSION))
MRFREEZE_DEPENDENCIES = armadillo fftwf host-fftwf host-python host-python-mpmath eigen
MRFREEZE_BUNDLES = mrfreeze.lv2

define MRFREEZE_PREBUILD_STEP
	cp $($(PKG)_PKGDIR)/mrfreeze.wisdom.duo $(@D)/mrfreeze.wisdom
endef


MRFREEZE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define MRFREEZE_BUILD_CMDS
	$(MRFREEZE_PREBUILD_STEP)
	$(MRFREEZE_TARGET_MAKE)
endef

define MRFREEZE_INSTALL_TARGET_CMDS
	$(MRFREEZE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
	echo $($(PKG)_PKGDIR)/mrfreeze.lv2/*
	echo $(TARGET_DIR)/usr/lib/lv2/mrfreeze.lv2/
	cp -rL $($(PKG)_PKGDIR)/mrfreeze.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mrfreeze.lv2/
endef

$(eval $(generic-package))
