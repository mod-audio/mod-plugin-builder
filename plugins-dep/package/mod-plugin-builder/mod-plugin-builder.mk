######################################
#
# mod-plugin-builder
#
######################################

MOD_PLUGIN_BUILDER_VERSION = 1
MOD_PLUGIN_BUILDER_SOURCE = .
MOD_PLUGIN_BUILDER_SITE = .
MOD_PLUGIN_BUILDER_SITE_METHOD = file
MOD_PLUGIN_BUILDER_DEPENDENCIES = host-cmake

define MOD_PLUGIN_BUILDER_EXTRACT_CMDS
endef

define MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES
	if [ ! -e $($(PKG)_DL_DIR).tar.gz ]; then                         \
		rm -rf $(@D);                                                 \
		git clone --recursive $($(PKG)_SITE) $(@D);                   \
		git -C $(@D) reset --hard $($(PKG)_VERSION);                  \
		git -C $(@D) submodule update;                                \
		tar --exclude=".git" -czf $($(PKG)_DL_DIR).tar.gz -C $(@D) .; \
		touch $(@D)/.stamp_downloaded $(@D)/.stamp_extracted;         \
	fi
endef

$(eval $(generic-package))
