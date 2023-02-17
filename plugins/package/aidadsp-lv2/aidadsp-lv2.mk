######################################
#
# aidadsp-lv2
#
######################################

AIDADSP_LV2_VERSION = 29a3dd1291b16da60349a9825dc3be429ba6fb52
AIDADSP_LV2_SITE = https://github.com/AidaDSP/aidadsp-lv2.git
AIDADSP_LV2_SITE_METHOD = git
AIDADSP_LV2_CONF_OPTS = -DRTNEURAL_XSIMD=ON
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
