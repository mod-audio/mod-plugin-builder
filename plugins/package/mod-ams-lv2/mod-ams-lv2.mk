######################################
#
# mod-ams-lv2
#
######################################

MOD_AMS_LV2_VERSION = 85a2d5ff9da80b61c5f87a705ae95881a7f1a9e5
MOD_AMS_LV2_SITE = $(call github,moddevices,ams-lv2,$(MOD_AMS_LV2_VERSION))
MOD_AMS_LV2_DEPENDENCIES = fftw-double lvtk-1
MOD_AMS_LV2_BUNDLES = mod-ams.lv2

MOD_AMS_LV2_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define MOD_AMS_LV2_CONFIGURE_CMDS
        (cd $(@D); $(MOD_AMS_LV2_TARGET_WAF) configure --prefix=/usr)
endef

define MOD_AMS_LV2_BUILD_CMDS
        (cd $(@D); $(MOD_AMS_LV2_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define MOD_AMS_LV2_INSTALL_TARGET_CMDS
        (cd $(@D); $(MOD_AMS_LV2_TARGET_WAF) install --destdir=$(TARGET_DIR))
endef

$(eval $(generic-package))
