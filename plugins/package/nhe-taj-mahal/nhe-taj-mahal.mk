######################################
#
# nhe-taj-mahal
#
# Taj Mahal by New Horizon Electronics
# https://github.com/Kiwooky/NHE-Taj-Mahal
#
# This file is the plugin's package for mod-plugin-builder
# (plugins/package/nhe-taj-mahal/nhe-taj-mahal.mk). The same file can be
# uploaded to https://builder.mod.audio/buildroot to get an install link.
#
# Set NHE_TAJ_MAHAL_VERSION to the full hash of the commit to build.
#
######################################

NHE_TAJ_MAHAL_VERSION = d7577082eee694ee6ea56cd86525d46b35d8e3ba
NHE_TAJ_MAHAL_SITE = https://github.com/Kiwooky/NHE-Taj-Mahal.git
NHE_TAJ_MAHAL_SITE_METHOD = git
NHE_TAJ_MAHAL_GIT_SUBMODULES = y
# fetch git submodules (DPF), as MOD's own packages do (mod-plugin-builder)
NHE_TAJ_MAHAL_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

NHE_TAJ_MAHAL_BUNDLES = nhe-taj-mahal.lv2

NHE_TAJ_MAHAL_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define NHE_TAJ_MAHAL_BUILD_CMDS
	$(NHE_TAJ_MAHAL_TARGET_MAKE)
endef

define NHE_TAJ_MAHAL_INSTALL_TARGET_CMDS
	$(NHE_TAJ_MAHAL_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
