######################################
#
# tamgamp-labs
#
######################################

TAMGAMP_LABS_VERSION = 426da74142fcb6b7687a35b2b1dda3392e171b92
TAMGAMP_LABS_SITE = $(call github,sadko4u,tamgamp.lv2,$(TAMGAMP_LABS_VERSION))
TAMGAMP_LABS_DEPENDENCIES = zita-resampler
TAMGAMP_LABS_BUNDLES = tamgamp.lv2

ifeq ($(BR2_cortex_a7),y)
TAMGAMP_LABS_TARGET_ARCH = "armv7ve"
else ifeq ($(BR2_aarch64),y)
TAMGAMP_LABS_TARGET_ARCH = "aarch64"
else ifeq ($(BR2_x86_64),y)
TAMGAMP_LABS_TARGET_ARCH = "x86_64"
endif

TAMGAMP_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) PREFIX=/usr TARGET_ARCH=$(TAMGAMP_LABS_TARGET_ARCH) -C $(@D)

define TAMGAMP_LABS_BUILD_CMDS
	$(TAMGAMP_LABS_TARGET_MAKE)
endef

define TAMGAMP_LABS_INSTALL_TARGET_CMDS
	$(TAMGAMP_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
# 	cp -rL $($(PKG)_PKGDIR)/tamgamp.lv2/* $(TARGET_DIR)/usr/lib/lv2/tamgamp.lv2/
endef

$(eval $(generic-package))
