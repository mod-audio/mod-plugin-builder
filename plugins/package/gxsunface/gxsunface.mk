######################################
#
# gxsunface
#
######################################

GXSUNFACE_VERSION = 367639733df82ba2c0a3b5ddaa6b9ed59d9c3323
GXSUNFACE_SITE = $(call github,brummer10,GxSunFace.lv2,$(GXSUNFACE_VERSION))
GXSUNFACE_BUNDLES = gx_SunFace.lv2

GXSUNFACE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXSUNFACE_BUILD_CMDS
	$(GXSUNFACE_TARGET_MAKE) mod
endef

define GXSUNFACE_INSTALL_TARGET_CMDS
	$(GXSUNFACE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
