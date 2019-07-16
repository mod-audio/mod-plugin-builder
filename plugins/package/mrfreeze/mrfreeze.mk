######################################
#
# mrfreeze
#
######################################

MRFREEZE_VERSION = bce928d9f5b10dad76d425f8715833964fe8005f
MRFREEZE_SITE = $(call github,romi1502,MrFreeze,$(MRFREEZE_VERSION))
MRFREEZE_DEPENDENCIES = armadillo fftw-single eigen
MRFREEZE_BUNDLES = mrfreeze.lv2

MRFREEZE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

ifdef BR2_arm
MRFREEZE_WISDOM_FILE = mrfreeze.wisdom.duo
endif
ifdef BR2_aarch64
MRFREEZE_WISDOM_FILE = mrfreeze.wisdom.duox
endif

ifeq ($(BR2_arm)$(BR2_aarch64),y)
define MRFREEZE_PREBUILD_STEP
	cp $($(PKG)_PKGDIR)/$(MRFREEZE_WISDOM_FILE) $(@D)/mrfreeze.wisdom
endef
endif

define MRFREEZE_BUILD_CMDS
	$(MRFREEZE_PREBUILD_STEP)
	$(MRFREEZE_TARGET_MAKE)
endef

define MRFREEZE_INSTALL_TARGET_CMDS
	$(MRFREEZE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
endef

$(eval $(generic-package))
