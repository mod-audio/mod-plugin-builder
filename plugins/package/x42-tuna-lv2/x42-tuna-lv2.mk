######################################
#
# x42-tuna-lv2
#
######################################

X42_TUNA_LV2_VERSION = 54c0489df2e7c08947965bfcccd9a6afdd5f61b0
X42_TUNA_LV2_SITE = $(call github,x42,tuna.lv2,$(X42_TUNA_LV2_VERSION))
X42_TUNA_LV2_DEPENDENCIES = fftw-single
X42_TUNA_LV2_BUNDLES = tuna.lv2

X42_TUNA_LV2_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only -DNDEBUG" PREFIX=/usr -C $(@D)

define X42_TUNA_LV2_BUILD_CMDS
	$(X42_TUNA_LV2_TARGET_MAKE)
endef

define X42_TUNA_LV2_INSTALL_TARGET_CMDS
	$(X42_TUNA_LV2_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
