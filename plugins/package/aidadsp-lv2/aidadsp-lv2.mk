######################################
#
# aidadsp-lv2
#
######################################

AIDADSP_LV2_VERSION = f86e21dcb3b481246f0406c5f003f1a0c7d93d37
AIDADSP_LV2_SITE = https://github.com/AidaDSP/aidadsp-lv2.git
AIDADSP_LV2_SITE_METHOD = git
AIDADSP_LV2_BUNDLES = rt-neural-generic.lv2

# custom optimization flags
AIDADSP_LV2_TARGET_OPT  = $(filter-out -funsafe-loop-optimizations,$(subst ",,$(BR2_TARGET_OPTIMIZATION)))
AIDADSP_LV2_TARGET_OPT += -fno-unsafe-loop-optimizations
AIDADSP_LV2_TARGET_OPT += -fPIC

ifndef BR2_SKIP_LTO
AIDADSP_LV2_TARGET_OPT += -fno-strict-aliasing -flto -ffat-lto-objects
endif

# pass options into cmake
AIDADSP_LV2_CONF_OPTS = -DPREFIX="/usr/lib/lv2"
AIDADSP_LV2_CONF_OPTS += -DRTNEURAL_EIGEN=ON
AIDADSP_LV2_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(AIDADSP_LV2_TARGET_OPT)"
AIDADSP_LV2_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(AIDADSP_LV2_TARGET_OPT) -std=gnu++17"
AIDADSP_LV2_CONF_OPTS += -DCMAKE_SHARED_LINKER_FLAGS="$(TARGET_LDFLAGS) $(AIDADSP_LV2_TARGET_OPT)"

# needed for submodules support
AIDADSP_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

# FIXME path failure with some CMake versions, don't know why so let's workaround it
define AIDADSP_LV2_FIX_INSTALL_TARGET
	sed -i -e 's|CMakeFiles/CMakeRelink.dir/||' $(@D)/rt-neural-generic/cmake_install.cmake
endef
AIDADSP_LV2_PRE_INSTALL_TARGET_HOOKS += AIDADSP_LV2_FIX_INSTALL_TARGET

$(eval $(cmake-package))
