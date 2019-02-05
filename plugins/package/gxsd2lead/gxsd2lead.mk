######################################
#
# gxsd2lead
#
######################################

GXSD2LEAD_VERSION = ad987d005bf5b4c64ebc2cfcb8d9ebc8dd6bc9bf
GXSD2LEAD_SITE = $(call github,brummer10,GxSD2Lead.lv2,$(GXSD2LEAD_VERSION))
GXSD2LEAD_BUNDLES = gx_sd2lead.lv2

GXSD2LEAD_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXSD2LEAD_BUILD_CMDS
	$(GXSD2LEAD_TARGET_MAKE) mod
endef

define GXSD2LEAD_INSTALL_TARGET_CMDS
	$(GXSD2LEAD_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
