######################################
#
# gxsunface-labs
#
######################################

GXSUNFACE_LABS_VERSION = b2fc690d918837f24412d32f50ba98f695bdd3cb
GXSUNFACE_LABS_SITE = $(call github,brummer10,GxSunFace.lv2,$(GXSUNFACE_LABS_VERSION))
GXSUNFACE_LABS_BUNDLES = gx_SunFace.lv2

ifdef BR2_cortex_a7
GXSUNFACE_LABS_SSE_CFLAGS = -mfpu=vfpv3
endif

GXSUNFACE_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="$(GXSUNFACE_LABS_SSE_CFLAGS)" -C $(@D)

define GXSUNFACE_LABS_BUILD_CMDS
	$(GXSUNFACE_LABS_TARGET_MAKE) mod
endef

define GXSUNFACE_LABS_INSTALL_TARGET_CMDS
	$(GXSUNFACE_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
