######################################
#
# ams-lv2
#
######################################

AMS_LV2_LABS_VERSION = 0f60ee0a0e6df64877210dfee2d30f126dc3137f
AMS_LV2_LABS_SITE = $(call github,blablack,ams-lv2,$(AMS_LV2_LABS_VERSION))
AMS_LV2_LABS_DEPENDENCIES = fftw-double lvtk-1
AMS_LV2_LABS_BUNDLES = ams.lv2

AMS_LV2_LABS_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define AMS_LV2_LABS_CONFIGURE_CMDS
        (cd $(@D); $(AMS_LV2_LABS_TARGET_WAF) configure --prefix=/usr)
endef

define AMS_LV2_LABS_BUILD_CMDS
        (cd $(@D); $(AMS_LV2_LABS_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define AMS_LV2_LABS_INSTALL_TARGET_CMDS
        (cd $(@D); $(AMS_LV2_LABS_TARGET_WAF) install --destdir=$(TARGET_DIR))
endef

$(eval $(generic-package))
