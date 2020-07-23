######################################
#
# beatslash-lv2-labs
#
######################################

BEATSLASH_LV2_LABS_VERSION = 98ef36eca1b6f6320282a8c01bbcee0118d8a302
BEATSLASH_LV2_LABS_SITE = $(call github,blablack,beatslash-lv2,$(BEATSLASH_LV2_LABS_VERSION))
BEATSLASH_LV2_LABS_DEPENDENCIES = lvtk-1
BEATSLASH_LV2_LABS_BUNDLES = beatslash.lv2

BEATSLASH_LV2_LABS_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define BEATSLASH_LV2_LABS_CONFIGURE_CMDS
        (cd $(@D); $(BEATSLASH_LV2_LABS_TARGET_WAF) configure --prefix=/usr)
endef

define BEATSLASH_LV2_LABS_BUILD_CMDS
        (cd $(@D); $(BEATSLASH_LV2_LABS_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define BEATSLASH_LV2_LABS_INSTALL_TARGET_CMDS
        (cd $(@D); $(BEATSLASH_LV2_LABS_TARGET_WAF) install --destdir=$(TARGET_DIR))
endef

$(eval $(generic-package))
