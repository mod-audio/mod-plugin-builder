######################################
#
# tamgamp
#
######################################

TAMGAMP_VERSION = 9b0d417728d3c36fa0f445375de48dc5f380c364
TAMGAMP_SITE = $(call github,sadko4u,tamgamp.lv2,$(TAMGAMP_VERSION))
TAMGAMP_BUNDLES = tamgamp.lv2

ifdef BR2_cortex_a7
TAMGAMP_TARGET_ARCH = "armv7ve"
endif

ifdef BR2_cortex_a53
TAMGAMP_TARGET_ARCH = "aarch64"
endif

TAMGAMP_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) PREFIX=/usr TARGET_ARCH=$(TAMGAMP_TARGET_ARCH) -C $(@D)

define TAMGAMP_BUILD_CMDS
	$(TAMGAMP_TARGET_MAKE)
endef

define TAMGAMP_INSTALL_TARGET_CMDS
	$(TAMGAMP_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
# 	cp -rL $($(PKG)_PKGDIR)/tamgamp.lv2/* $(TARGET_DIR)/usr/lib/lv2/tamgamp.lv2/
endef

$(eval $(generic-package))
