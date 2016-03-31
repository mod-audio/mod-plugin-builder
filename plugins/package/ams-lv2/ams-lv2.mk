AMS_LV2_VERSION = 3564bd6d475320e68f7058c2dffd12cc03d35503
AMS_LV2_SITE = $(call github,blablack,ams-lv2,$(AMS_LV2_VERSION))
AMS_LV2_DEPENDENCIES = fftw lvtk
AMS_LV2_BUNDLES = 

AMS_LV2_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define AMS_LV2_CONFIGURE_CMDS
        (cd $(@D); $(AMS_LV2_TARGET_WAF) configure --prefix=/usr)
endef

define AMS_LV2_BUILD_CMDS
        (cd $(@D); $(AMS_LV2_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define AMS_LV2_INSTALL_TARGET_CMDS
        (cd $(@D); $(AMS_LV2_TARGET_WAF) install --destdir=$(TARGET_DIR))
endef

$(eval $(generic-package))
