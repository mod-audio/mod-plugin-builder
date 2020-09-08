######################################
#
# deteriorate-lv2
#
######################################

DETERIORATE_LV2_LABS_VERSION = 93ea1762755d57dd44a45adee55822bacd2c0a3b
DETERIORATE_LV2_LABS_SITE = $(call github,blablack,deteriorate-lv2,$(DETERIORATE_LV2_LABS_VERSION))
DETERIORATE_LV2_LABS_DEPENDENCIES = lvtk-1
DETERIORATE_LV2_LABS_BUNDLES = deteriorate.lv2

DETERIORATE_LV2_LABS_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define DETERIORATE_LV2_LABS_CONFIGURE_CMDS
        (cd $(@D); $(DETERIORATE_LV2_LABS_TARGET_WAF) configure --prefix=/usr)
endef

define DETERIORATE_LV2_LABS_BUILD_CMDS
        (cd $(@D); $(DETERIORATE_LV2_LABS_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define DETERIORATE_LV2_LABS_INSTALL_TARGET_CMDS
        (cd $(@D); $(DETERIORATE_LV2_LABS_TARGET_WAF) install --destdir=$(TARGET_DIR))
endef

$(eval $(generic-package))
