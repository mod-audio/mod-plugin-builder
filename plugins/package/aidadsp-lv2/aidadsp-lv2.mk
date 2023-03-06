######################################
#
# aidadsp-lv2
#
######################################

AIDADSP_LV2_VERSION = 0bac2f3feb811115d696b11ec2293f5f03a535ac
AIDADSP_LV2_SITE = https://github.com/AidaDSP/aidadsp-lv2.git
AIDADSP_LV2_SITE_METHOD = git
# FIXME something wrong here, overoptimization?
# AIDADSP_LV2_CONF_OPTS = -DRTNEURAL_XSIMD=ON
AIDADSP_LV2_CONF_OPTS = -DRTNEURAL_EIGEN=ON
AIDADSP_LV2_BUNDLES = rt-neural-generic.lv2

# needed for submodules support
AIDADSP_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define AIDADSP_LV2_POST_INSTALL_TARGET_FILES
    mkdir -p $(TARGET_DIR)/usr/lib/lv2
    rm -rf $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2
    mv $(TARGET_DIR)/rt-neural-generic.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

AIDADSP_LV2_POST_INSTALL_TARGET_HOOKS += AIDADSP_LV2_POST_INSTALL_TARGET_FILES

$(eval $(cmake-package))
