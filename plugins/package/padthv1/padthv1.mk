######################################
#
# padthv1
#
######################################

PADTHV1_VERSION = 0.9.11
PADTHV1_SITE = http://download.sourceforge.net/padthv1/
PADTHV1_SOURCE = padthv1-$(PADTHV1_VERSION).tar.gz
PADTHV1_BUNDLES = padthv1.lv2
PADTHV1_AUTORECONF = YES

PADTHV1_CONF_OPTS=--disable-jack --disable-lv2-ui-x11 --disable-lv2-ui-external

$(eval $(autotools-package))
