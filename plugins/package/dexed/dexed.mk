######################################
#
# dexed
#
######################################

DEXED_VERSION = 6801e49fcabe2cd6925be2e0045ad5e83320548b
DEXED_SITE = $(call github,dcoredump,dexed,$(DEXED_VERSION))
DEXED_DEPENDENCIES = lvtk
DEXED_BUNDLES = dexed.lv2

DEXED_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 -C $(@D)/src

define DEXED_BUILD_CMDS
	$(DEXED_TARGET_MAKE) -j $(PARALLEL_JOBS)
endef

define DEXED_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2
	cp -rL $(@D)/src/dexed.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
