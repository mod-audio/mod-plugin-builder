######################################
#
# mod-nam-loader
#
######################################

MOD_NAM_LOADER_VERSION = 88eccbe1111a4918761357164269cd3caeb73c39
# The repository is private, so an anonymous HTTPS clone cannot fetch it. Switch to the
# https:// line below once mod-audio/mod-nam-loader is public - that is what CI and other
# developers need; SSH only works for someone whose key already has access.
MOD_NAM_LOADER_SITE = git@github.com:mod-audio/mod-nam-loader.git
#MOD_NAM_LOADER_SITE = https://github.com/mod-audio/mod-nam-loader.git
MOD_NAM_LOADER_SITE_METHOD = git
MOD_NAM_LOADER_GIT_SUBMODULES = y
MOD_NAM_LOADER_BUNDLES = mod-nam-loader.lv2

# custom optimization flags, matching those tuned for neural-amp-modeler-lv2
MOD_NAM_LOADER_FILTERED_FLAGS = -funroll-loops
MOD_NAM_LOADER_TARGET_OPT = $(filter-out $(MOD_NAM_LOADER_FILTERED_FLAGS),$(subst ",,$(BR2_TARGET_OPTIMIZATION)))
MOD_NAM_LOADER_TARGET_OPT += -fno-unroll-loops
MOD_NAM_LOADER_TARGET_OPT += -ftree-vectorize -fmove-loop-invariants -fexceptions -funsafe-math-optimizations
MOD_NAM_LOADER_TARGET_OPT += -fdata-sections -ffunction-sections -pipe -fno-math-errno -fno-trapping-math -falign-functions=16 -falign-loops=16
MOD_NAM_LOADER_TARGET_OPT += -fsingle-precision-constant
MOD_NAM_LOADER_TARGET_OPT += -pthread

ifndef BR2_SKIP_LTO
MOD_NAM_LOADER_TARGET_OPT += -flto -ffat-lto-objects
endif

# EIGEN
MOD_NAM_LOADER_TARGET_OPT += -DEIGEN_DONT_PARALLELIZE=ON

# pass options into cmake
MOD_NAM_LOADER_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(MOD_NAM_LOADER_TARGET_OPT)"
MOD_NAM_LOADER_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(MOD_NAM_LOADER_TARGET_OPT)"
MOD_NAM_LOADER_CONF_OPTS += -DCMAKE_SHARED_LINKER_FLAGS="$(TARGET_LDFLAGS) $(MOD_NAM_LOADER_TARGET_OPT)"
MOD_NAM_LOADER_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
MOD_NAM_LOADER_CONF_OPTS += -DNAM_ENABLE_A2_FAST=ON
MOD_NAM_LOADER_CONF_OPTS += -DNAM_USE_INLINE_GEMM=ON
MOD_NAM_LOADER_CONF_OPTS += -DDISABLE_DENORMALS=ON
MOD_NAM_LOADER_CONF_OPTS += -DBUILD_TESTS=OFF

# needed for submodules support
MOD_NAM_LOADER_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define MOD_NAM_LOADER_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/$(MOD_NAM_LOADER_BUNDLES)
	install -m 644 $(@D)/$(MOD_NAM_LOADER_BUNDLES)/*.ttl $(TARGET_DIR)/usr/lib/lv2/$(MOD_NAM_LOADER_BUNDLES)/
	install -m 755 $(@D)/$(MOD_NAM_LOADER_BUNDLES)/*.so $(TARGET_DIR)/usr/lib/lv2/$(MOD_NAM_LOADER_BUNDLES)/
endef

$(eval $(cmake-package))
