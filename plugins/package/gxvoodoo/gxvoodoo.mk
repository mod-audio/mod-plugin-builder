######################################
#
# gxvoodoo
#
######################################

GXVOODOO_VERSION = 7356f5aae5e741dae1d2e64c4518525057325be4
GXVOODOO_SITE = $(call github,brummer10,GxVoodoFuzz.lv2,$(GXVOODOO_VERSION))
GXVOODOO_BUNDLES = gx_voodoo.lv2

GXVOODOO_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXVOODOO_BUILD_CMDS
	$(GXVOODOO_TARGET_MAKE) mod
endef

define GXVOODOO_INSTALL_TARGET_CMDS
	$(GXVOODOO_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
