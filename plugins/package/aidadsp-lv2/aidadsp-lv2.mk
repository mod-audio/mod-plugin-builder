######################################
#
# aida dsp lv2 bundle
#
######################################

AIDADSP_LV2_VERSION = 977dbdd630e0921aa26cb9c6c46b58a1d9f45e5c
AIDADSP_LV2_SITE = https://github.com/AidaDSP/aidadsp-lv2.git
AIDADSP_LV2_SITE_METHOD = git
AIDADSP_LV2_BUNDLES = rt-neural-generic.lv2

# needed for submodules support
AIDADSP_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

ifdef BR2_cortex_a35
    AIDADSP_LV2_CONF_OPTS = -DMOD_DWARF_GCC_750=ON -DRTNEURAL_EIGEN=ON
endif

define AIDADSP_LV2_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2
    cp -rL $(TARGET_DIR)/rt-neural-generic.lv2/* $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2/
endef

define AIDADSP_LV2_INSTALL_TARGET_CMDS
    $(AIDADSP_LV2_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)/usr/lib/lv2
endef

$(eval $(cmake-package))
