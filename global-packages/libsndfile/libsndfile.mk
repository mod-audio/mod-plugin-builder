################################################################################
#
# libsndfile
#
################################################################################

LIBSNDFILE_VERSION = 1.0.31
LIBSNDFILE_SITE = https://github.com/libsndfile/libsndfile/releases/download/$(LIBSNDFILE_VERSION)
LIBSNDFILE_SOURCE = libsndfile-$(LIBSNDFILE_VERSION).tar.bz2
LIBSNDFILE_INSTALL_STAGING = YES
LIBSNDFILE_LICENSE = LGPLv2.1+
LIBSNDFILE_LICENSE_FILES = COPYING
LIBSNDFILE_DEPENDENCIES = flac libogg libvorbis opus-custom
LIBSNDFILE_AUTORECONF = YES

LIBSNDFILE_CONF_OPTS = \
	--disable-sqlite \
	--disable-alsa

$(eval $(autotools-package))
