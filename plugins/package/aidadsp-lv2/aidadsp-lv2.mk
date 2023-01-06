######################################
#
# aidadsp-lv2
#
######################################

AIDADSP_LV2_VERSION = 3c7a2b4e3f283a7df2b593c2c6dd3f0a24f5069f
AIDADSP_LV2_SITE = https://github.com/AidaDSP/aidadsp-lv2.git
AIDADSP_LV2_SITE_METHOD = git
AIDADSP_LV2_CONF_OPTS = -DRTNEURAL_EIGEN=ON
AIDADSP_LV2_BUNDLES = rt-neural-generic.lv2

# needed for submodules support
AIDADSP_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define AIDADSP_LV2_POST_INSTALL_TARGET_FILES
    mkdir -p $(TARGET_DIR)/usr/lib/lv2
    rm -rf $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2
    mv $(TARGET_DIR)/rt-neural-generic.lv2 $(TARGET_DIR)/usr/lib/lv2/
    cp $($(PKG)_PKGDIR)/stylesheet-rt-neural-generic.css $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2/modgui
endef

AIDADSP_LV2_POST_INSTALL_TARGET_HOOKS += AIDADSP_LV2_POST_INSTALL_TARGET_FILES

$(eval $(cmake-package))
