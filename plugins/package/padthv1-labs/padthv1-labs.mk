######################################
#
# padthv1-labs
#
######################################

PADTHV1_LABS_VERSION = 0.9.11
PADTHV1_LABS_SITE = http://download.sourceforge.net/padthv1/
PADTHV1_LABS_SOURCE = padthv1-$(PADTHV1_LABS_VERSION).tar.gz
PADTHV1_LABS_BUNDLES = padthv1.lv2
PADTHV1_LABS_AUTORECONF = YES

PADTHV1_LABS_CONF_OPTS=--disable-jack --disable-lv2-ui-x11 --disable-lv2-ui-external

$(eval $(autotools-package))
