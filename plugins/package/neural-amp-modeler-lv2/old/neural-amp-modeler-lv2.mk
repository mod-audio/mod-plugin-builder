######################################
#
# neural-amp-modeler-lv2
#main270528v1 sin patch 06_271 y solo filter funroll-loops, cambiado por fno-unroll-loops..... algo mejor A2 nano 51%
#main270528v2 patch03 copilot
#main270528v3 patch04 copilot
#main270528v4 patch05 and 06 copilot
#main270528v5 back git and disable INLINE ufff 100% nano
#main270528v5 enable again OK
#main270528v6 sin A2 FAST uiii no entra
#main270528v7 local con cambio copilot  guaaauu 37% source v3
#main270528v8 local con cambio copilot  anteriores source v4 uiii va peor. vuelve a 50%
#main270529v9 local back to v3 optimize ch8 source v5  sigue 100%
#main270529v9 local back to v3 optimize ch8 source v5  sigue 100%
#main270529v10 local back to v3 optimize ch8 source v6
######################################

NEURAL_AMP_MODELER_LV2_VERSION = main270528v10
#NEURAL_AMP_MODELER_LV2_SITE = https://github.com/mikeoliphant/neural-amp-modeler-lv2.git
#NEURAL_AMP_MODELER_LV2_SITE_METHOD = git
#NEURAL_AMP_MODELER_LV2_GIT_SUBMODULES = y

NEURAL_AMP_MODELER_LV2_SITE = /home/fer/Documents/local_src/NAM/neural-amp-modeler-lv2-main270528v6/
NEURAL_AMP_MODELER_LV2_SITE_METHOD = local

NEURAL_AMP_MODELER_LV2_BUNDLES = neural_amp_modeler.lv2

# Update NeuralAudio and NeuralAmpModelerCore submodules to latest
#define NEURAL_AMP_MODELER_LV2_POST_EXTRACT_HOOKS
#	cd $(@D) && git submodule update --remote deps/NeuralAudio
#	cd $(@D)/deps/NeuralAudio && git submodule update --remote deps/NeuralAmpModelerCore
	#cd $(@D) && git -C deps/NeuralAudio checkout d988d4e25822c2897ceca791ca9ef7b3df3d1345
	#cd $(@D)/deps/NeuralAudio && git -C deps/NeuralAmpModelerCore checkout ab72c078cd141be60d963d357bd501d56cc9606b
#endef

NEURAL_AMP_MODELER_LV2_FILTERED_FLAGS = -funroll-loops #-fprefetch-loop-arrays -funsafe-loop-optimizations 

# custom optimization flags
NEURAL_AMP_MODELER_LV2_TARGET_OPT = $(filter-out $(NEURAL_AMP_MODELER_LV2_FILTERED_FLAGS),$(subst ",,$(BR2_TARGET_OPTIMIZATION)))
#NEURAL_AMP_MODELER_LV2_TARGET_OPT += -fno-unsafe-loop-optimizations
NEURAL_AMP_MODELER_LV2_TARGET_OPT += -fno-unroll-loops
NEURAL_AMP_MODELER_LV2_TARGET_OPT += -ftree-vectorize -fmove-loop-invariants -fexceptions -funsafe-math-optimizations  
NEURAL_AMP_MODELER_LV2_TARGET_OPT += -fdata-sections -ffunction-sections -pipe -fno-math-errno -fno-trapping-math -falign-functions=16 -falign-loops=16 

NEURAL_AMP_MODELER_LV2_TARGET_OPT += -fsingle-precision-constant
NEURAL_AMP_MODELER_LV2_TARGET_OPT += -pthread

ifndef BR2_SKIP_LTO
NEURAL_AMP_MODELER_LV2_TARGET_OPT += -flto -ffat-lto-objects
endif

# EIGEN
#NEURAL_AMP_MODELER_LV2_TARGET_OPT += -DEIGEN_DEFAULT_L1_CACHE_SIZE=32768
#NEURAL_AMP_MODELER_LV2_TARGET_OPT += -DEIGEN_DEFAULT_L2_CACHE_SIZE=262144
NEURAL_AMP_MODELER_LV2_TARGET_OPT += -DEIGEN_DONT_PARALLELIZE=ON

# pass options into cmake
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(NEURAL_AMP_MODELER_LV2_TARGET_OPT)"
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(NEURAL_AMP_MODELER_LV2_TARGET_OPT)"
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DCMAKE_SHARED_LINKER_FLAGS="$(TARGET_LDFLAGS) $(NEURAL_AMP_MODELER_LV2_TARGET_OPT)"
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DDISABLE_DENORMALS:BOOL=ON
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DBUILD_UTILS=OFF
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DBUILD_NAMCORE=ON
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DBUILD_RTNEURAL=OFF
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DWAVENET_FRAMES=128
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DBUFFER_PADDING=16
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DSMART_BYPASS_ENABLED=OFF
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DBUILD_INTERNAL_STATIC_WAVENET=ON 
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DBUILD_INTERNAL_STATIC_LSTM=OFF 
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DBUILD_STATIC_RTNEURAL=OFF 
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DWAVENET_MATH=FastMath
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DLSTM_MATH=FastMath
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DNAM_ENABLE_A2_FAST=ON
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DNAM_USE_INLINE_GEMM=ON
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DDEFAULT_QUALITY_SCALE="0.49"

# needed for submodules support
NEURAL_AMP_MODELER_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define NEURAL_AMP_MODELER_LV2_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/modgui
	install -m 644 $(@D)/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/*.* $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/
	#install -m 644 $($(PKG)_PKGDIR)/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/*.* $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/
	install -m 644 $(@D)/resources/modgui/*.* $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/modgui/
endef

$(eval $(cmake-package))
