######################################
#
# aidadsp-lv2
#
######################################

AIDADSP_LV2_VERSION = 436d5a6c6964856f7a4c969d3029fcff686afc25
AIDADSP_LV2_SITE = https://github.com/AidaDSP/aidadsp-lv2.git
AIDADSP_LV2_SITE_METHOD = git
AIDADSP_LV2_BUNDLES = rt-neural-generic.lv2

# custom optimization flags
AIDADSP_LV2_TARGET_OPT  = $(filter-out -funsafe-loop-optimizations,$(subst ",,$(BR2_TARGET_OPTIMIZATION)))
AIDADSP_LV2_TARGET_OPT += -fno-unsafe-loop-optimizations
AIDADSP_LV2_TARGET_OPT += -fno-strict-aliasing -flto -ffat-lto-objects
AIDADSP_LV2_TARGET_OPT += -fPIC

# pass options into cmake
AIDADSP_LV2_CONF_OPTS = -DPREFIX="/usr/lib/lv2"
AIDADSP_LV2_CONF_OPTS += -DRTNEURAL_EIGEN=ON
AIDADSP_LV2_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(AIDADSP_LV2_TARGET_OPT)"
AIDADSP_LV2_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(AIDADSP_LV2_TARGET_OPT) -std=gnu++17"
AIDADSP_LV2_CONF_OPTS += -DCMAKE_SHARED_LINKER_FLAGS="$(TARGET_LDFLAGS) $(AIDADSP_LV2_TARGET_OPT)"

# needed for submodules support
AIDADSP_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

$(eval $(cmake-package))
