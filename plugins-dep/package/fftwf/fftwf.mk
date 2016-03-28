################################################################################
#
# fftwf
#
################################################################################

FFTWF_VERSION = 3.3.4+git20151030
FFTWF_SITE = http://web1.moddevices.com/shared
FFTWF_SOURCE = fftw-$(FFTWF_VERSION).tar.gz
FFTWF_LICENSE = GPLv2+
FFTWF_LICENSE_FILES = COPYING
FFTWF_INSTALL_STAGING = YES

FFTWF_CONF_OPTS  = --enable-openmp
FFTWF_CONF_OPTS += --enable-threads
FFTWF_CONF_OPTS += --enable-single
FFTWF_CONF_OPTS += --disable-doc
FFTWF_CONF_OPTS += --disable-debug
ifdef BR2_arm
FFTWF_CONF_OPTS += --enable-neon
endif
ifdef BR2_x86_64
FFTWF_CONF_OPTS += --enable-sse
FFTWF_CONF_OPTS += --enable-sse2
endif

FFTWF_CONF_OPTS += CFLAGS="$(TARGET_CFLAGS) -fstrict-aliasing" CXXFLAGS="$(TARGET_CXXFLAGS) -fstrict-aliasing"

$(eval $(autotools-package))
$(eval $(host-autotools-package))
