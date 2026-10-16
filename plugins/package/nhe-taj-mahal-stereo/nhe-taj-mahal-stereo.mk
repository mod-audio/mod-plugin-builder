######################################
#
# nhe-taj-mahal-stereo
#
# Taj Mahal Stereo by New Horizon Electronics: stereo in, stereo out.
# Built from the same repo as the mono Taj Mahal (same source, same face).
#
# This file is the plugin's package for mod-plugin-builder
# (plugins/package/nhe-taj-mahal-stereo/nhe-taj-mahal-stereo.mk). The same file
# can be uploaded to https://builder.mod.audio/buildroot to get an install link.
#
# Push, then set NHE_TAJ_MAHAL_STEREO_VERSION to the FULL 40-character commit hash.
# The filename must match the variable prefix: nhe-taj-mahal-stereo.mk -> NHE_TAJ_MAHAL_STEREO_.
#
######################################

NHE_TAJ_MAHAL_STEREO_VERSION = f87e733eb5413f45bbf567d6beed890a3b2a6b33
NHE_TAJ_MAHAL_STEREO_SITE = https://github.com/Kiwooky/NHE-Taj-Mahal.git
NHE_TAJ_MAHAL_STEREO_SITE_METHOD = git
NHE_TAJ_MAHAL_STEREO_GIT_SUBMODULES = y
# fetch git submodules (DPF), as MOD's own packages do (mod-plugin-builder)
NHE_TAJ_MAHAL_STEREO_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

NHE_TAJ_MAHAL_STEREO_BUNDLES = nhe-taj-mahal-stereo.lv2

NHE_TAJ_MAHAL_STEREO_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true NAME=nhe-taj-mahal-stereo -C $(@D)

define NHE_TAJ_MAHAL_STEREO_BUILD_CMDS
	$(NHE_TAJ_MAHAL_STEREO_TARGET_MAKE)
endef

define NHE_TAJ_MAHAL_STEREO_INSTALL_TARGET_CMDS
	$(NHE_TAJ_MAHAL_STEREO_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
