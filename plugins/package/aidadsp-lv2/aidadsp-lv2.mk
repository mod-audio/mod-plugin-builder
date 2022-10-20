######################################
#
# aida dsp lv2 bundle
#
######################################

AIDADSP_LV2_VERSION = 2d0b276a44fa2a7d08e17587e3ba4b9789cf17a3
AIDADSP_LV2_SITE = https://github.com/AidaDSP/aidadsp-lv2.git
AIDADSP_LV2_SITE_METHOD = git
AIDADSP_LV2_BUNDLES = rt-neural-generic.lv2

# needed for submodules support
AIDADSP_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

ifdef BR2_arm
    AIDADSP_LV2_CONF_OPTS = -DMOD_DUO_GCC_750=ON -DRTNEURAL_EIGEN=ON
else ifdef BR2_cortex_a35
    AIDADSP_LV2_CONF_OPTS = -DMOD_DWARF_GCC_750=ON -DRTNEURAL_EIGEN=ON
else ifdef BR2_cortex_a53
    AIDADSP_LV2_CONF_OPTS = -DMOD_DUOX_GCC_750=ON -DRTNEURAL_EIGEN=ON
else ifdef BR2_cortex_a72
    AIDADSP_LV2_CONF_OPTS = -DMPB_RPI4_GCC_750=ON -DRTNEURAL_EIGEN=ON
endif

define AIDADSP_LV2_POST_INSTALL_TARGET_FILES
    mkdir -p $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2
    cp -rL $(TARGET_DIR)/rt-neural-generic.lv2/* $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2/
    rm -rf $(TARGET_DIR)/rt-neural-generic.lv2
endef

AIDADSP_LV2_POST_INSTALL_TARGET_HOOKS += AIDADSP_LV2_POST_INSTALL_TARGET_FILES

$(eval $(cmake-package))
