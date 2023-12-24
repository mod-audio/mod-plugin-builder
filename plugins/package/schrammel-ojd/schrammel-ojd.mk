######################################
#
# schrammel-ojd
#
######################################

SCHRAMMEL_OJD_VERSION = 03c0e84066d443c99c48066cb96335b0dbffab48
SCHRAMMEL_OJD_SITE = https://github.com/JanosGit/Schrammel_OJD.git
SCHRAMMEL_OJD_SITE_METHOD = git
SCHRAMMEL_OJD_DEPENDENCIES = juce-6.1
SCHRAMMEL_OJD_CONF_OPTS = -DCMAKE_TOOLCHAIN_FILE=$(JUCE_6_1_TOOLCHAIN_FILE) -DSKIP_LV2_TTL_GENERATOR=ON
SCHRAMMEL_OJD_BUNDLES = OJD.lv2

# needed for submodules support
SCHRAMMEL_OJD_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define SCHRAMMEL_OJD_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/OJD.lv2
	cp -rL $(@D)/OJD-LV2_artefacts/Release/LV2/OJD.lv2/* $(TARGET_DIR)/usr/lib/lv2/OJD.lv2/
	cp -rL $($(PKG)_PKGDIR)/OJD.lv2/* $(TARGET_DIR)/usr/lib/lv2/OJD.lv2/
endef

$(eval $(cmake-package))
