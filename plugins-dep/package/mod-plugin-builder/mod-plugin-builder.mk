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

$(eval $(generic-package))
