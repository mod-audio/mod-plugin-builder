################################################################################
#
# vamp-sdk
#
################################################################################

VAMP_SDK_VERSION = 2.6
VAMP_SDK_SITE = https://code.soundsoftware.ac.uk/attachments/download/1520
VAMP_SDK_SOURCE = vamp-plugin-sdk-$(VAMP_SDK_VERSION).tar.gz
VAMP_SDK_DEPENDENCIES = libglib2 libsndfile
VAMP_SDK_INSTALL_STAGING = YES
VAMP_SDK_CONF_OPTS  = --enable-programs=no

define VAMP_SDK_POST_BUILD_TOUCH
	touch $(@D)/host/vamp-simple-host
endef

$(eval $(autotools-package))
