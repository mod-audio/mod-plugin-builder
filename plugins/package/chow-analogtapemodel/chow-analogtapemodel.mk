######################################
#
# chow-analogtapemodel
#
######################################

CHOW_ANALOGTAPEMODEL_VERSION = 74764d9933f4f8075a27d81d835ab23bf1c53de8
CHOW_ANALOGTAPEMODEL_SITE = https://github.com/jatinchowdhury18/AnalogTapeModel.git
CHOW_ANALOGTAPEMODEL_SITE_METHOD = git
CHOW_ANALOGTAPEMODEL_DEPENDENCIES = juce
CHOW_ANALOGTAPEMODEL_CONF_OPTS = -DCMAKE_TOOLCHAIN_FILE=$(BR2_EXTERNAL)/../plugins-dep/package/juce/toolchainfile.cmake
# -DSKIP_LV2_TTL_GENERATOR=ON
# -DRTNEURAL_EIGEN=ON
CHOW_ANALOGTAPEMODEL_SUBDIR = Plugin
CHOW_ANALOGTAPEMODEL_BUNDLES = CHOWTapeModel.lv2

# needed for submodules support
CHOW_ANALOGTAPEMODEL_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define CHOW_ANALOGTAPEMODEL_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/CHOWTapeModel.lv2
	cp -rL $(@D)/Plugin/CHOWTapeModel_artefacts/Release/LV2/CHOWTapeModel.lv2/* $(TARGET_DIR)/usr/lib/lv2/CHOWTapeModel.lv2/
	cp -rL $($(PKG)_PKGDIR)/CHOWTapeModel.lv2/* $(TARGET_DIR)/usr/lib/lv2/CHOWTapeModel.lv2/
endef

$(eval $(cmake-package))
