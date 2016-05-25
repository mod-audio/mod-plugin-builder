################################################################################
#
# fftwf
#
################################################################################

FFTWF_VERSION = 3.3.5-2
FFTWF_SITE = https://github.com/falkTX/fftw3/releases/download/fftw-$(FFTWF_VERSION)
FFTWF_SOURCE = fftw-$(FFTWF_VERSION).tar.gz
FFTWF_LICENSE = GPLv2+
FFTWF_LICENSE_FILES = COPYING
FFTWF_INSTALL_STAGING = YES
# FFTWF_DEPENDENCIES = ffmpeg

FFTWF_CONF_OPTS  = --enable-openmp
FFTWF_CONF_OPTS += --enable-threads
FFTWF_CONF_OPTS += --enable-single
FFTWF_CONF_OPTS += --disable-doc
FFTWF_CONF_OPTS += --disable-debug
# FFTWF_CONF_OPTS += --enable-ffmpeg
# FFTWF_CONF_OPTS += --enable-generic-simd128
# FFTWF_CONF_OPTS += --enable-generic-simd256
ifdef BR2_arm
FFTWF_CONF_OPTS += --enable-neon
endif
ifdef BR2_x86_64
FFTWF_CONF_OPTS += --enable-sse
FFTWF_CONF_OPTS += --enable-sse2
endif

FFTWF_CONF_OPTS += CFLAGS="$(TARGET_CFLAGS) -fstrict-aliasing" CXXFLAGS="$(TARGET_CXXFLAGS) -fstrict-aliasing"
ifdef BR2_arm
FFTWF_CONF_OPTS += NEON_CFLAGS="-mfpu=neon-vfpv4"
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
