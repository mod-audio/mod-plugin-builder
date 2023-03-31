######################################
#
# neural-amp-modeler-lv2
#
######################################

NEURAL_AMP_MODELER_LV2_VERSION = ca90becaca5ac6f63e606d98f9506e85c931d4e1
NEURAL_AMP_MODELER_LV2_SITE = https://github.com/mikeoliphant/neural-amp-modeler-lv2.git
NEURAL_AMP_MODELER_LV2_SITE_METHOD = git
NEURAL_AMP_MODELER_LV2_BUNDLES = neural_amp_modeler.lv2

# needed for submodules support
NEURAL_AMP_MODELER_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define NEURAL_AMP_MODELER_LV2_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)
	install -m 644 $(@D)/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/*.* $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/
endef

$(eval $(cmake-package))
