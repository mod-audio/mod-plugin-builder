######################################
#
# screcord
#
######################################

SCRECORD_VERSION = 8faadb15799b53cbc5a75f696f37c19db632d3c0
SCRECORD_SITE = $(call github,brummer10,screcord.lv2,$(SCRECORD_VERSION))
SCRECORD_BUNDLES = sc_record.lv2

ifdef BR2_cortex_a7
SCRECORD_SSE_CFLAGS = -mfpu=vfpv3
else
SCRECORD_SSE_CFLAGS = ""
endif

SCRECORD_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)  SSE_CFLAGS="$(SCRECORD_SSE_CFLAGS)" -C $(@D)

define SCRECORD_BUILD_CMDS
	$(SCRECORD_TARGET_MAKE) mod
endef

define SCRECORD_INSTALL_TARGET_CMDS
	$(SCRECORD_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
