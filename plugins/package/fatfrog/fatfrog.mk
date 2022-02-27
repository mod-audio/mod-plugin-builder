######################################
#
# fatfrog
#
######################################

FATFROG_VERSION = 3361dd312f0933c69397f156a62388ed2c411fe6
FATFROG_SITE = $(call github,brummer10,FatFrog,$(FATFROG_VERSION))
FATFROG_BUNDLES = FatFrog.lv2

ifdef BR2_cortex_a7
FATFROG_SSE_CFLAGS = -mfpu=vfpv3
endif

FATFROG_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)  SSE_CFLAGS="$(FATFROG_SSE_CFLAGS)" -C $(@D)

define FATFROG_BUILD_CMDS
	$(FATFROG_TARGET_MAKE) mod
endef

define FATFROG_INSTALL_TARGET_CMDS
	$(FATFROG_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
