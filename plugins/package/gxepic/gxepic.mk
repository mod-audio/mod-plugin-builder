######################################
#
# gxepic
#
######################################

GXEPIC_VERSION = f72db5b5d0992fb3a7ba70659a03d937211ad651
GXEPIC_SITE = $(call github,brummer10,GxEpic.lv2,$(GXEPIC_VERSION))
GXEPIC_BUNDLES = gx_epic.lv2

ifdef BR2_cortex_a7
GXEPIC_SSE_CFLAGS = -mfpu=vfpv3
endif

GXEPIC_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)  SSE_CFLAGS="$(GXEPIC_SSE_CFLAGS)" -C $(@D) 

define GXEPIC_BUILD_CMDS
	$(GXEPIC_TARGET_MAKE) mod
endef

define GXEPIC_INSTALL_TARGET_CMDS
	$(GXEPIC_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
