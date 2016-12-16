######################################
#
# gxosmu
#
######################################

GXOSMU_VERSION = 475e81b08065324f26b65dbd7661603a91407c0e
GXOSMU_SITE = $(call github,brummer10,GxOsMutantes.lv2,$(GXOSMU_VERSION))
GXOSMU_BUNDLES = gx_osmu.lv2

GXOSMU_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXOSMU_BUILD_CMDS
	$(GXOSMU_TARGET_MAKE)
endef

define GXOSMU_INSTALL_TARGET_CMDS
	$(GXOSMU_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
# 	cp -rL $($(PKG)_PKGDIR)/gx_osmu.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_osmu.lv2/
endef

$(eval $(generic-package))
