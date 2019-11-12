######################################
#
# synthv1
#
######################################

SYNTHV1_VERSION = 0.9.11
SYNTHV1_SITE = http://download.sourceforge.net/synthv1/
SYNTHV1_SOURCE = synthv1-$(SYNTHV1_VERSION).tar.gz
SYNTHV1_BUNDLES = synthv1.lv2
SYNTHV1_AUTORECONF = YES

SYNTHV1_CONF_OPTS=--disable-jack --disable-lv2-ui-x11 --disable-lv2-ui-external

# define SYNTHV1_CONFIGURE_TARGET_CMDS_EXTRA
# 	rm -f $(@D)/src/synthv1.lv2/synthv1_ui.ttl
# endef

$(eval $(autotools-package))
