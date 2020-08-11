######################################
#
# midimsg-lv2-labs
#
######################################

MIDIMSG_LV2_LABS_VERSION = 46beb4891ac6f223b33b298b96764535d8f80e18
MIDIMSG_LV2_LABS_SITE = $(call github,blablack,midimsg-lv2,$(MIDIMSG_LV2_LABS_VERSION))
MIDIMSG_LV2_LABS_DEPENDENCIES = lvtk-1
MIDIMSG_LV2_LABS_BUNDLES = deteriorate.lv2

MIDIMSG_LV2_LABS_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define MIDIMSG_LV2_LABS_CONFIGURE_CMDS
        (cd $(@D); $(MIDIMSG_LV2_LABS_TARGET_WAF) configure --prefix=/usr)
endef

define MIDIMSG_LV2_LABS_BUILD_CMDS
        (cd $(@D); $(MIDIMSG_LV2_LABS_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define MIDIMSG_LV2_LABS_INSTALL_TARGET_CMDS
        (cd $(@D); $(MIDIMSG_LV2_LABS_TARGET_WAF) install --destdir=$(TARGET_DIR))
endef

$(eval $(generic-package))
