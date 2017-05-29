######################################
#
# mod-mrfreeze
#
######################################

MRFREEZE_VERSION = bce928d9f5b10dad76d425f8715833964fe8005f
MRFREEZE_SITE = $(call github,romi1502,MrFreeze,$(MRFREEZE_VERSION))
MRFREEZE_DEPENDENCIES = armadillo fftwf eigen
# host-fftwf host-python host-python-mpmath 
MRFREEZE_BUNDLES = mrfreeze.lv2

MRFREEZE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define MRFREEZE_PREBUILD_STEP
	cp $($(PKG)_PKGDIR)/mrfreeze.wisdom.duo $(@D)/mrfreeze.wisdom
endef

define MRFREEZE_BUILD_CMDS
	$(MRFREEZE_PREBUILD_STEP)
	$(MRFREEZE_TARGET_MAKE)
endef

define MRFREEZE_INSTALL_TARGET_CMDS
	$(MRFREEZE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
	#cp -rL $($(PKG)_PKGDIR)/mod-mrfreeze.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mrfreeze.lv2/
endef

$(eval $(generic-package))
