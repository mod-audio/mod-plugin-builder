######################################
#
# aidadsp-lv2
#
######################################

AIDADSP_LV2_VERSION = 6e54495ce95bcbaf2432ef4a3931299492b14671
AIDADSP_LV2_SITE = https://github.com/AidaDSP/aidadsp-lv2.git
AIDADSP_LV2_SITE_METHOD = git
AIDADSP_LV2_BUNDLES = rt-neural-generic.lv2

# prepare custom build flags
AIDADSP_LV2_TARGET_CFLAGS = $(TARGET_CFLAGS)
AIDADSP_LV2_TARGET_CXXFLAGS = $(TARGET_CXXFLAGS)

# can't use -funsafe-loop-optimizations
AIDADSP_LV2_TARGET_CFLAGS += $(filter-out -funsafe-loop-optimizations,$(subst ",,$(BR2_TARGET_OPTIMIZATION))) -fno-unsafe-loop-optimizations
AIDADSP_LV2_TARGET_CXXFLAGS += $(filter-out -funsafe-loop-optimizations,$(subst ",,$(BR2_TARGET_OPTIMIZATION))) -fno-unsafe-loop-optimizations

# LTO-specific flags (must be present on build and link stage)
AIDADSP_LV2_LTO_FLAGS = -fno-strict-aliasing -flto -ffat-lto-objects

# pass options into cmake
# AIDADSP_LV2_CONF_OPTS = -DRTNEURAL_XSIMD=ON
AIDADSP_LV2_CONF_OPTS = -DRTNEURAL_EIGEN=ON
AIDADSP_LV2_CONF_OPTS += -DCMAKE_C_FLAGS="$(AIDADSP_LV2_TARGET_CFLAGS) $(AIDADSP_LV2_LTO_FLAGS)"
AIDADSP_LV2_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(AIDADSP_LV2_TARGET_CXXFLAGS) $(AIDADSP_LV2_LTO_FLAGS)"
AIDADSP_LV2_CONF_OPTS += -DCMAKE_SHARED_LINKER_FLAGS="$(TARGET_LDFLAGS) $(AIDADSP_LV2_LTO_FLAGS)"

# needed for submodules support
AIDADSP_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define AIDADSP_LV2_POST_INSTALL_TARGET_FILES
    mkdir -p $(TARGET_DIR)/usr/lib/lv2
    rm -rf $(TARGET_DIR)/usr/lib/lv2/rt-neural-generic.lv2
    mv $(TARGET_DIR)/rt-neural-generic.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

AIDADSP_LV2_POST_INSTALL_TARGET_HOOKS += AIDADSP_LV2_POST_INSTALL_TARGET_FILES

$(eval $(cmake-package))
