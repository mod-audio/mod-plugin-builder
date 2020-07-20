######################################
#
# gxsupersonic
#
######################################

GXSUPERSONIC_VERSION = a116614cc8a2c31d81ae5ce7d867bf6222a0ba3a
GXSUPERSONIC_SITE = $(call github,brummer10,GxSuperSonic.lv2,$(GXSUPERSONIC_VERSION))
GXSUPERSONIC_BUNDLES = gx_supersonic.lv2

ifdef BR2_cortex_a7
GXSUPERSONIC_SSE_CFLAGS = -mfpu=vfpv3
endif

GXSUPERSONIC_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)  SSE_CFLAGS="$(GXSUPERSONIC_SSE_CFLAGS)" -C $(@D)

define GXSUPERSONIC_BUILD_CMDS
	$(GXSUPERSONIC_TARGET_MAKE) mod
endef

define GXSUPERSONIC_INSTALL_TARGET_CMDS
	$(GXSUPERSONIC_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/gx_supersonic.lv2/*        $(TARGET_DIR)/usr/lib/lv2/gx_supersonic.lv2/
endef

$(eval $(generic-package))
