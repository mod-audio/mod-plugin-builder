######################################
#
# infamous-plugins
#
######################################

INFAMOUS_PLUGINS_VERSION = 0.1.2
INFAMOUS_PLUGINS_SITE = https://github.com/ssj71/infamousPlugins/archive/
INFAMOUS_PLUGINS_SOURCE = v$(INFAMOUS_PLUGINS_VERSION).tar.gz
INFAMOUS_PLUGINS_BUNDLES = 

$(eval $(cmake-package))
