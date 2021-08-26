######################################
#
# chow-kick
#
######################################

CHOW_KICK_VERSION = c9b6834deb133104c02baedaadd1dedfdd6e4c8e
CHOW_KICK_SITE = https://github.com/Chowdhury-DSP/ChowKick.git
CHOW_KICK_SITE_METHOD = git
CHOW_KICK_DEPENDENCIES = juce host-juce
# TODO make some jack2mod optional
CHOW_KICK_DEPENDENCIES += jack2mod
CHOW_KICK_CONF_ENV = MOD_TOOLCHAIN_FILE=/home/builder/mod-plugin-builder/toolchainfile.cmake
CHOW_KICK_CONF_OPTS = -DCMAKE_CXX_FLAGS="-fno-lto"
CHOW_KICK_BUNDLES = ChowKick.lv2

# needed for submodules support
CHOW_KICK_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define CHOW_KICK_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/ChowKick.lv2
	cp -rL $($(PKG)_PKGDIR)/ChowKick.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowKick.lv2/
	cp -rL $(@D)/ChowKick_artefacts/Release/LV2/ChowKick.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowKick.lv2/
endef

$(eval $(cmake-package))
