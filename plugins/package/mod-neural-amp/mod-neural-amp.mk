######################################
#
# mod-neural-amp
#
######################################

MOD_NEURAL_AMP_VERSION = 0dd7c8149a6cedf9904fddad259ee4d12998d030
MOD_NEURAL_AMP_SITE = https://github.com/moddevices/mod-neural-amp.git
MOD_NEURAL_AMP_SITE_METHOD = git
MOD_NEURAL_AMP_BUNDLES = mod-neural-amp.lv2

# prepare custom build flags
MOD_NEURAL_AMP_TARGET_CFLAGS = $(TARGET_CFLAGS)
MOD_NEURAL_AMP_TARGET_CXXFLAGS = $(TARGET_CXXFLAGS) -std=gnu++17
MOD_NEURAL_AMP_TARGET_OPTIMIZATION = -fPIC $(filter-out -funsafe-loop-optimizations,$(subst ",,$(BR2_TARGET_OPTIMIZATION)))

# can't use -funsafe-loop-optimizations
MOD_NEURAL_AMP_TARGET_CFLAGS += $(MOD_NEURAL_AMP_TARGET_OPTIMIZATION)
MOD_NEURAL_AMP_TARGET_CXXFLAGS += $(MOD_NEURAL_AMP_TARGET_OPTIMIZATION)

# LTO-specific flags (must be present on build and link stage)
MOD_NEURAL_AMP_LTO_FLAGS = -fno-strict-aliasing -flto -ffat-lto-objects

# pass options into cmake
MOD_NEURAL_AMP_CONF_OPTS = -DPREFIX="/usr/lib/lv2"
MOD_NEURAL_AMP_CONF_OPTS += -DCMAKE_C_FLAGS_RELEASE="$(MOD_NEURAL_AMP_TARGET_CFLAGS) $(MOD_NEURAL_AMP_LTO_FLAGS)"
MOD_NEURAL_AMP_CONF_OPTS += -DCMAKE_CXX_FLAGS_RELEASE="$(MOD_NEURAL_AMP_TARGET_CXXFLAGS) $(MOD_NEURAL_AMP_LTO_FLAGS)"
MOD_NEURAL_AMP_CONF_OPTS += -DCMAKE_SHARED_LINKER_FLAGS_RELEASE="$(TARGET_LDFLAGS) $(MOD_NEURAL_AMP_LTO_FLAGS)"

# needed for submodules support
MOD_NEURAL_AMP_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

$(eval $(cmake-package))
