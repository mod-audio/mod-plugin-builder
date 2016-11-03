######################################
#
# gxosmu
#
######################################

GXOSMU_VERSION = a317ac978b692100393bb76d62403bf53973a7d0
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
