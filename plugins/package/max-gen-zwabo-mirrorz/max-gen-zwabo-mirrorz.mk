######################################
#
# max-gen-zwabo-mirrorz
#
######################################

MAX_GEN_ZWABO_MIRRORZ_VERSION = 24eff0f7f85126a8adcdcbe8b38e5cf9e814e3d2
MAX_GEN_ZWABO_MIRRORZ_SITE = https://github.com/moddevices/max-gen-plugins.git
MAX_GEN_ZWABO_MIRRORZ_SITE_METHOD = git
MAX_GEN_ZWABO_MIRRORZ_BUNDLES = zwabo-mirrorz.lv2

# needed for submodules support
MAX_GEN_ZWABO_MIRRORZ_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

MAX_GEN_ZWABO_MIRRORZ_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define MAX_GEN_ZWABO_MIRRORZ_BUILD_CMDS
	$(MAX_GEN_ZWABO_MIRRORZ_TARGET_MAKE)
endef

define MAX_GEN_ZWABO_MIRRORZ_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2
	cp -r $(@D)/bin/$(MAX_GEN_ZWABO_MIRRORZ_BUNDLES) $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
