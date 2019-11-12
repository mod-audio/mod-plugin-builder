######################################
#
# midimsg-lv2
#
######################################

MIDIMSG_LV2_VERSION = 46beb4891ac6f223b33b298b96764535d8f80e18
MIDIMSG_LV2_SITE = $(call github,blablack,midimsg-lv2,$(MIDIMSG_LV2_VERSION))
MIDIMSG_LV2_DEPENDENCIES = lvtk-1
MIDIMSG_LV2_BUNDLES = deteriorate.lv2

MIDIMSG_LV2_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define MIDIMSG_LV2_CONFIGURE_CMDS
        (cd $(@D); $(MIDIMSG_LV2_TARGET_WAF) configure --prefix=/usr)
endef

define MIDIMSG_LV2_BUILD_CMDS
        (cd $(@D); $(MIDIMSG_LV2_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define MIDIMSG_LV2_INSTALL_TARGET_CMDS
        (cd $(@D); $(MIDIMSG_LV2_TARGET_WAF) install --destdir=$(TARGET_DIR))
endef

$(eval $(generic-package))
