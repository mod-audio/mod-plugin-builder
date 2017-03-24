######################################
#
# x42-tuna
#
######################################

X42_TUNA_VERSION = 54c0489df2e7c08947965bfcccd9a6afdd5f61b0
X42_TUNA_SITE = $(call github,x42,tuna.lv2,$(X42_TUNA_VERSION))
X42_TUNA_DEPENDENCIES = fftwf
X42_TUNA_BUNDLES = tuna.lv2

X42_TUNA_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only -DNDEBUG" PREFIX=/usr -C $(@D)

define X42_TUNA_BUILD_CMDS
	$(X42_TUNA_TARGET_MAKE)
endef

define X42_TUNA_INSTALL_TARGET_CMDS
	$(X42_TUNA_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
