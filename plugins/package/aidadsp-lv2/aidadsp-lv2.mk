######################################
#
# aida dsp lv2 bundle
#
######################################

AIDADSPLV2_VERSION = 2963a6d4996ab291e270c312c8e1ef4380aa6c9a
AIDADSPLV2_SITE = https://github.com/AidaDSP/aidadsp-lv2.git
AIDADSPLV2_SITE_METHOD = git
AIDADSPLV2_CONF_OPTS = -DRTNEURAL_ENABLE_AARCH64=ON -DRTNEURAL_XSIMD=ON
AIDADSPLV2_BUNDLES = rt-neural-generic.lv2

# needed for submodules support
AIDADSPLV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define AIDADSPLV2_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2
    cp -rL $(TARGET_DIR)/rt-neural-generic.lv2/* $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2/
endef

$(eval $(cmake-package))
