################################################################################
#
# libgig
#
################################################################################

LIBGIG_VERSION = 2855
LIBGIG_SITE = https://download.mod.audio/mirror
LIBGIG_INSTALL_STAGING = YES
LIBGIG_DEPENDENCIES = libsndfile
LIBGIG_AUTORECONF = YES

$(eval $(autotools-package))
