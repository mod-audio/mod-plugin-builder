######################################
#
# mod-mrfreeze
#
######################################

MOD_MRFREEZE_VERSION = 3d07ae1f2eb672cc7d3b1d36b979e87c652b397e
MOD_MRFREEZE_SITE = $(call github,romi1502,MrFreeze,$(MOD_MRFREEZE_VERSION))
MOD_MRFREEZE_DEPENDENCIES = armadillo fftwf host-fftwf host-python host-python-mpmath eigen
MOD_MRFREEZE_BUNDLES = mod-mrfreeze.lv2

define MOD_MRFREEZE_PREBUILD_STEP
	cp $($(PKG)_PKGDIR)/mrfreeze.wisdom.duo $(@D)/mrfreeze.wisdom
endef


MOD_MRFREEZE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define MOD_MRFREEZE_BUILD_CMDS
	$(MOD_MRFREEZE_PREBUILD_STEP)
	$(MOD_MRFREEZE_TARGET_MAKE)
endef

define MOD_MRFREEZE_INSTALL_TARGET_CMDS
	$(MOD_MRFREEZE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
	#cp -rL $($(PKG)_PKGDIR)/mod-mrfreeze.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mrfreeze.lv2/
endef

$(eval $(generic-package))
