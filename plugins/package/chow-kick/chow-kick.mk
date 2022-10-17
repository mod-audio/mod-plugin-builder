######################################
#
# chow-kick
#
######################################

CHOW_KICK_VERSION = 632c6ee3ae9d43cbbc21e5d2e372ceee1f7d8cfb
CHOW_KICK_SITE = https://github.com/Chowdhury-DSP/ChowKick.git
CHOW_KICK_SITE_METHOD = git
CHOW_KICK_DEPENDENCIES = juce
CHOW_KICK_CONF_OPTS = -DCMAKE_TOOLCHAIN_FILE=$(BR2_EXTERNAL)/../plugins-dep/package/juce/toolchainfile.cmake 
# -DSKIP_LV2_TTL_GENERATOR=ON
CHOW_KICK_BUNDLES = ChowKick.lv2

# needed for submodules support
CHOW_KICK_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define CHOW_KICK_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/ChowKick.lv2
	cp -rL $(@D)/ChowKick_artefacts/Release/LV2/ChowKick.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowKick.lv2/
	cp -rL $($(PKG)_PKGDIR)/ChowKick.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowKick.lv2/
endef

$(eval $(cmake-package))
