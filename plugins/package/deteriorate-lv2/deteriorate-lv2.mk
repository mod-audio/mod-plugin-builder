######################################
#
# deteriorate-lv2
#
######################################

DETERIORATE_LV2_VERSION = 93ea1762755d57dd44a45adee55822bacd2c0a3b
DETERIORATE_LV2_SITE = $(call github,blablack,deteriorate-lv2,$(DETERIORATE_LV2_VERSION))
DETERIORATE_LV2_DEPENDENCIES = lvtk-1
DETERIORATE_LV2_BUNDLES = deteriorate.lv2

DETERIORATE_LV2_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define DETERIORATE_LV2_CONFIGURE_CMDS
        (cd $(@D); $(DETERIORATE_LV2_TARGET_WAF) configure --prefix=/usr)
endef

define DETERIORATE_LV2_BUILD_CMDS
        (cd $(@D); $(DETERIORATE_LV2_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define DETERIORATE_LV2_INSTALL_TARGET_CMDS
        (cd $(@D); $(DETERIORATE_LV2_TARGET_WAF) install --destdir=$(TARGET_DIR))
endef

$(eval $(generic-package))
