################################################################################
#
# fftw
#
################################################################################

# ifeq ($(BR2_cortex_a7),y)
# FFTW_VERSION = 3.3.5+
# FFTW_SITE = https://github.com/moddevices/fftw3-duo/releases/download/fftw-$(FFTW_VERSION)
# else
FFTW_VERSION = 3.3.8
FFTW_SITE = http://www.fftw.org
# endif

FFTW_INSTALL_STAGING = YES
FFTW_LICENSE = GPL-2.0+
FFTW_LICENSE_FILES = COPYING

FFTW_COMMON_CONF_OPTS += --disable-debug
FFTW_COMMON_CONF_OPTS += --disable-doc

# fortran support only enables generation and installation of fortran sources
ifeq ($(BR2_TOOLCHAIN_HAS_FORTRAN),y)
FFTW_COMMON_CONF_OPTS += --enable-fortran
FFTW_COMMON_CONF_ENV += FLIBS="-lgfortran -lm"
else
FFTW_COMMON_CONF_OPTS += --disable-fortran
endif

FFTW_COMMON_CFLAGS = $(TARGET_CFLAGS) -fstrict-aliasing

ifeq ($(BR2_PACKAGE_FFTW_FAST),y)
FFTW_COMMON_CFLAGS += -O3 -ffast-math
endif

# Generic optimisations
ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
FFTW_COMMON_CONF_OPTS += --enable-threads
# On the Duo and Duo X we need a separate library for the threads!
FFTW_COMMON_CONF_OPTS += --without-combined-threads
else
FFTW_COMMON_CONF_OPTS += --disable-threads
endif
FFTW_COMMON_CONF_OPTS += $(if $(BR2_GCC_ENABLE_OPENMP),--enable,--disable)-openmp

# Patch sources depending on platform
define FFTW_APPLY_MOD_PATCHES
	(cd $(@D) && \
		for p in `find $(BR2_EXTERNAL)/../global-packages/fftw/patches/$(FFTW_VERSION) -name "*.patch"`; \
			do echo Applying `basename $$p`; \
			patch -p1 -i $$p; \
		done)
endef

include $(sort $(wildcard package/fftw/*/*.mk))
