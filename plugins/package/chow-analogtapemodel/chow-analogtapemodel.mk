######################################
#
# chow-analogtapemodel
#
######################################

CHOW_ANALOGTAPEMODEL_VERSION = 139ab8b5c2030d432ec258887f852a274582a862
CHOW_ANALOGTAPEMODEL_SITE = https://github.com/jatinchowdhury18/AnalogTapeModel.git
CHOW_ANALOGTAPEMODEL_SITE_METHOD = git
CHOW_ANALOGTAPEMODEL_DEPENDENCIES = juce host-juce
CHOW_ANALOGTAPEMODEL_CONF_ENV = MOD_TOOLCHAIN_FILE=$(BR2_EXTERNAL_PLUGINS_DEP)/package/juce/toolchain.cmake
# CHOW_ANALOGTAPEMODEL_CONF_OPTS = -DRTNEURAL_EIGEN=ON
CHOW_ANALOGTAPEMODEL_SUBDIR = Plugin
CHOW_ANALOGTAPEMODEL_BUNDLES = CHOWTapeModel.lv2

# needed for submodules support
CHOW_ANALOGTAPEMODEL_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define CHOW_ANALOGTAPEMODEL_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/CHOWTapeModel.lv2
	cp -rL $($(PKG)_PKGDIR)/CHOWTapeModel.lv2/* $(TARGET_DIR)/usr/lib/lv2/CHOWTapeModel.lv2/
	cp -rL $(@D)/Plugin/CHOWTapeModel_artefacts/Release/LV2/CHOWTapeModel.lv2/* $(TARGET_DIR)/usr/lib/lv2/CHOWTapeModel.lv2/
endef

$(eval $(cmake-package))
