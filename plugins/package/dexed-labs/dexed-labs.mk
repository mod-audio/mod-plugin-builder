######################################
#
# dexed-labs
#
######################################

DEXED_LABS_VERSION = f3518feb75c6039d94a60b99aff2126bd197296b
DEXED_LABS_SITE = $(call github,dcoredump,dexed,$(DEXED_LABS_VERSION))
DEXED_LABS_DEPENDENCIES = lvtk
DEXED_LABS_BUNDLES = dexed.lv2

DEXED_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 -C $(@D)/src

define DEXED_LABS_BUILD_CMDS
	$(DEXED_LABS_TARGET_MAKE) -j $(PARALLEL_JOBS)
endef

define DEXED_LABS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2
	cp -rL $(@D)/src/dexed.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
