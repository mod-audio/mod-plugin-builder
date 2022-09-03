######################################
#
# aida dsp lv2 bundle
#
######################################

AIDADSP_LV2_VERSION = f9fcc4871101cb9bcfebb4ee607870914ad0d3b8
AIDADSP_LV2_SITE = https://github.com/AidaDSP/aidadsp-lv2.git
AIDADSP_LV2_SITE_METHOD = git
AIDADSP_LV2_CONF_OPTS = -DRTNEURAL_ENABLE_AARCH64=ON -DRTNEURAL_XSIMD=ON
AIDADSP_LV2_BUNDLES = rt-neural-generic.lv2

# needed for submodules support
AIDADSP_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define AIDADSP_LV2_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2
    cp -rL $(@D)/rt-neural-generic/* $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2/
endef

$(eval $(cmake-package))
