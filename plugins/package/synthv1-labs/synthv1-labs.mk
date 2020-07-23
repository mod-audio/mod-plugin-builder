######################################
#
# synthv1-labs
#
######################################

SYNTHV1_LABS_VERSION = 0.9.11
SYNTHV1_LABS_SITE = http://download.sourceforge.net/synthv1/
SYNTHV1_LABS_SOURCE = synthv1-$(SYNTHV1_LABS_VERSION).tar.gz
SYNTHV1_LABS_BUNDLES = synthv1.lv2
SYNTHV1_LABS_AUTORECONF = YES

SYNTHV1_LABS_CONF_OPTS=--disable-jack --disable-lv2-ui-x11 --disable-lv2-ui-external

$(eval $(autotools-package))
