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

$(eval $(autotools-package))
