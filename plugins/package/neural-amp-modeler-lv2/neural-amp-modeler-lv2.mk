######################################
#
# neural-amp-modeler-lv2
#
######################################

NEURAL_AMP_MODELER_LV2_VERSION = c5451faba1cc62f6498fa56c53670aa479ae33c8
NEURAL_AMP_MODELER_LV2_SITE = https://github.com/micahvdm/neural-amp-modeler-lv2.git
NEURAL_AMP_MODELER_LV2_SITE_METHOD = git
NEURAL_AMP_MODELER_LV2_BUNDLES = neural_amp_modeler.lv2

# LTO-specific flags (must be present on build and link stage)
NEURAL_AMP_MODELER_LV2_LTO_FLAGS = -fno-strict-aliasing -flto -ffat-lto-objects

# pass options into cmake
AIDADSP_LV2_CONF_OPTS += -DCMAKE_C_FLAGS_RELEASE="$(BR2_TARGET_OPTIMIZATION) $(NEURAL_AMP_MODELER_LV2_LTO_FLAGS)"
AIDADSP_LV2_CONF_OPTS += -DCMAKE_CXX_FLAGS_RELEASE="$(BR2_TARGET_OPTIMIZATION) $(NEURAL_AMP_MODELER_LV2_LTO_FLAGS)"
AIDADSP_LV2_CONF_OPTS += -DCMAKE_SHARED_LINKER_FLAGS_RELEASE="$(TARGET_LDFLAGS) $(BR2_TARGET_OPTIMIZATION) $(NEURAL_AMP_MODELER_LV2_LTO_FLAGS)"

# needed for submodules support
NEURAL_AMP_MODELER_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define NEURAL_AMP_MODELER_LV2_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)
	install -m 644 $(@D)/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/*.* $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/
endef

$(eval $(cmake-package))
