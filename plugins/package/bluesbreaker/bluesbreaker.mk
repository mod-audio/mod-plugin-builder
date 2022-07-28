######################################
#
# bluesbreaker
#
######################################

BLUESBREAKER_VERSION = ad4ab327fdda47ff9b4152d04356623d1f20ae23
BLUESBREAKER_SITE = $(call github,brummer10,bluesbreaker.lv2,$(BLUESBREAKER_VERSION))
BLUESBREAKER_BUNDLES = bluesbreaker.lv2

ifdef BR2_cortex_a7
BLUESBREAKER_SSE_CFLAGS = -mfpu=vfpv3
endif

BLUESBREAKER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)  SSE_CFLAGS="$(BLUESBREAKER_SSE_CFLAGS)" -C $(@D) 

define BLUESBREAKER_BUILD_CMDS
	$(BLUESBREAKER_TARGET_MAKE) mod
endef

define BLUESBREAKER_INSTALL_TARGET_CMDS
	$(BLUESBREAKER_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
