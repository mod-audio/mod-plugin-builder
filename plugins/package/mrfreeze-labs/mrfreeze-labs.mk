######################################
#
# mrfreeze-labs
#
######################################

MRFREEZE_LABS_VERSION = bce928d9f5b10dad76d425f8715833964fe8005f
MRFREEZE_LABS_SITE = $(call github,romi1502,MrFreeze,$(MRFREEZE_LABS_VERSION))
MRFREEZE_LABS_DEPENDENCIES = armadillo fftw-single eigen
MRFREEZE_LABS_BUNDLES = mrfreeze.lv2

MRFREEZE_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

ifdef BR2_cortex_a35
MRFREEZE_LABS_WISDOM_FILE = mrfreeze.wisdom.dwarf
else ifdef BR2_cortex_a53
MRFREEZE_LABS_WISDOM_FILE = mrfreeze.wisdom.duox
else ifdef BR2_arm
MRFREEZE_LABS_WISDOM_FILE = mrfreeze.wisdom.duo
endif

ifeq ($(BR2_arm)$(BR2_aarch64),y)
define MRFREEZE_LABS_PREBUILD_STEP
	cp $($(PKG)_PKGDIR)/$(MRFREEZE_LABS_WISDOM_FILE) $(@D)/mrfreeze.wisdom
endef
endif

define MRFREEZE_LABS_BUILD_CMDS
	$(MRFREEZE_LABS_PREBUILD_STEP)
	$(MRFREEZE_LABS_TARGET_MAKE)
endef

define MRFREEZE_LABS_INSTALL_TARGET_CMDS
	$(MRFREEZE_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
endef

$(eval $(generic-package))
