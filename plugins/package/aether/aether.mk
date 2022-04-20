######################################
#
# aether
#
######################################

AETHER_VERSION = c85b83e072a294f1b71151f5c5b6c46e27afd566#
AETHER_SITE = https://github.com/Dougal-s/Aether.git
AETHER_SITE_METHOD = git
AETHER_CONF_OPTS = -DBUILD_GUI="Off"
AETHER_BUNDLES = aether.lv2

# needed for submodules support
AETHER_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define AETHER_INSTALL_TARGET_CMDS
	cp -rL $(@D)/aether.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(cmake-package))
