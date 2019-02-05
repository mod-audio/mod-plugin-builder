######################################
#
# gxknightfuzz
#
######################################

GXKNIGHTFUZZ_VERSION = f7198434a47b9a02a75e6aea5e1329ef5a7ab649
GXKNIGHTFUZZ_SITE = $(call github,brummer10,GxKnightFuzz.lv2,$(GXKNIGHTFUZZ_VERSION))
GXKNIGHTFUZZ_BUNDLES = gx_KnightFuzz.lv2

GXKNIGHTFUZZ_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXKNIGHTFUZZ_BUILD_CMDS
	$(GXKNIGHTFUZZ_TARGET_MAKE) mod
endef

define GXKNIGHTFUZZ_INSTALL_TARGET_CMDS
	$(GXKNIGHTFUZZ_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
