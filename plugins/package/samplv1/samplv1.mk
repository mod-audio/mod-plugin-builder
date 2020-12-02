######################################
#
# samplv1
#
######################################

SAMPLV1_VERSION = 0.9.18
SAMPLV1_SITE = http://download.sourceforge.net/samplv1/
SAMPLV1_SOURCE = samplv1-$(SAMPLV1_VERSION).tar.gz
SAMPLV1_BUNDLES = samplv1.lv2
SAMPLV1_AUTORECONF = YES

SAMPLV1_CONF_OPTS=--disable-jack --disable-lv2-ui-x11 --disable-lv2-ui-external

$(eval $(autotools-package))
