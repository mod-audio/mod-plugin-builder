######################################
#
# chow-centaur
#
######################################

CHOW_CENTAUR_VERSION = f3bb633a593b6fbb22a44c1ef9d1dbedbfe92d5b
CHOW_CENTAUR_SITE = https://github.com/jatinchowdhury18/KlonCentaur.git
CHOW_CENTAUR_SITE_METHOD = git
CHOW_CENTAUR_DEPENDENCIES = juce6
CHOW_CENTAUR_CONF_OPTS = -DCMAKE_TOOLCHAIN_FILE=$(JUCE6_TOOLCHAIN_FILE) -DSKIP_LV2_TTL_GENERATOR=ON
CHOW_CENTAUR_BUNDLES = ChowCentaur.lv2

# needed for submodules support
CHOW_CENTAUR_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define CHOW_CENTAUR_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/ChowCentaur.lv2
	cp -rL $(@D)/ChowCentaur/ChowCentaur_artefacts/Release/LV2/ChowCentaur.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowCentaur.lv2/
	cp -rL $($(PKG)_PKGDIR)/ChowCentaur.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowCentaur.lv2/
endef

$(eval $(cmake-package))
