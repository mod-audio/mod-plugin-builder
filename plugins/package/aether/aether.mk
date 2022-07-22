######################################
#
# aether
#
######################################

AETHER_VERSION = 2ccae056a612d2075650f2913a93cc4aa0df95ad
AETHER_SITE = https://github.com/Dougal-s/Aether.git
AETHER_SITE_METHOD = git
AETHER_CONF_OPTS = -DBUILD_GUI="Off" -DFORCE_DISABLE_DENORMALS="Off"
AETHER_BUNDLES = aether.lv2

# needed for submodules support
AETHER_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define AETHER_INSTALL_TARGET_CMDS
	cp -rL $(@D)/aether.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(cmake-package))
