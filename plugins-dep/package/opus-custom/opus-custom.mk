################################################################################
#
# opus-custom
#
################################################################################

OPUS_CUSTOM_VERSION = 1.1.4
OPUS_CUSTOM_SITE = http://downloads.xiph.org/releases/opus
OPUS_CUSTOM_SOURCE = opus-$(OPUS_CUSTOM_VERSION).tar.gz
OPUS_CUSTOM_LICENSE = BSD-3c
OPUS_CUSTOM_LICENSE_FILES = COPYING
OPUS_CUSTOM_INSTALL_STAGING = YES
OPUS_CUSTOM_AUTORECONF = YES

OPUS_CUSTOM_CONF_OPTS += --enable-custom-modes
OPUS_CUSTOM_CONF_OPTS += --enable-float-approx

$(eval $(autotools-package))
