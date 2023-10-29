######################################
#
# mod-ams-lv2
#
######################################

MOD_AMS_LV2_VERSION = 75895e56f9aeca84463dcfc83390617fa3d3ff67
MOD_AMS_LV2_SITE = $(call github,moddevices,ams-lv2,$(MOD_AMS_LV2_VERSION))
MOD_AMS_LV2_DEPENDENCIES = fftw-double lvtk-1
MOD_AMS_LV2_BUNDLES = mod-ams.lv2

ifeq ($(BR2_PAWPAW),y)
MOD_AMS_LV2_PYTHON = $(HOST_DIR)/usr/bin/python3
else
MOD_AMS_LV2_PYTHON = $(HOST_DIR)/usr/bin/python
endif

MOD_AMS_LV2_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MOD_AMS_LV2_PYTHON) ./waf

define MOD_AMS_LV2_CONFIGURE_CMDS
        (cd $(@D); $(MOD_AMS_LV2_TARGET_WAF) configure --prefix=/usr --lv2dir=/usr/lib/lv2)
endef

define MOD_AMS_LV2_BUILD_CMDS
        (cd $(@D); $(MOD_AMS_LV2_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define MOD_AMS_LV2_INSTALL_TARGET_CMDS
        (cd $(@D); $(MOD_AMS_LV2_TARGET_WAF) install --destdir=$(TARGET_DIR))
endef

$(eval $(generic-package))
