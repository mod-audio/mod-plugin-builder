######################################
#
# fluida-labs
#
######################################

FLUIDA_LABS_VERSION = f22e828c319a05fe03aaafcd1bdb06a2b63a96c9
FLUIDA_LABS_SITE = $(call github,brummer10,fluida.lv2,$(FLUIDA_LABS_VERSION))
FLUIDA_LABS_DEPENDENCIES = fluidsynth
FLUIDA_LABS_BUNDLES = Fluida.lv2

ifdef BR2_cortex_a7
FLUIDA_LABS_SSE_CFLAGS = -mfpu=vfpv3
endif

FLUIDA_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="$(FLUIDA_LABS_SSE_CFLAGS)"

define FLUIDA_LABS_BUILD_CMDS
	$(FLUIDA_LABS_TARGET_MAKE) -C $(@D) mod
endef

define FLUIDA_LABS_INSTALL_TARGET_CMDS
	$(FLUIDA_LABS_TARGET_MAKE) -C $(@D)/Fluida install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
