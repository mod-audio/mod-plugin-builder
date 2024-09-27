######################################
#
# gxswitchlesswah
#
######################################

GXSWITCHLESSWAH_VERSION = f712b18346faa678d551fb1f949ff752590ed114
GXSWITCHLESSWAH_SITE = $(call github,moddevices,GxSwitchlessWah.lv2,$(GXSWITCHLESSWAH_VERSION))
GXSWITCHLESSWAH_BUNDLES = GxSwitchlessWah.lv2

ifdef BR2_cortex_a7
GXSWITCHLESSWAH_SSE_CFLAGS = -mfpu=vfpv3
endif

# FIXME remove this, workaround for build issue https://github.com/mod-audio/mod-plugin-builder/pull/178
GXSWITCHLESSWAH_SSE_CFLAGS += -std=gnu++11

GXSWITCHLESSWAH_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="$(GXSWITCHLESSWAH_SSE_CFLAGS)" -C $(@D)

define GXSWITCHLESSWAH_BUILD_CMDS
	$(GXSWITCHLESSWAH_TARGET_MAKE)
endef

define GXSWITCHLESSWAH_INSTALL_TARGET_CMDS
	$(GXSWITCHLESSWAH_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
