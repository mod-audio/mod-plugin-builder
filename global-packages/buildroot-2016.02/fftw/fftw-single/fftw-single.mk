################################################################################
#
# fftw-single
#
################################################################################

FFTW_SINGLE_VERSION = $(FFTW_VERSION)
FFTW_SINGLE_SOURCE = fftw-$(FFTW_VERSION).tar.gz
FFTW_SINGLE_SITE = $(FFTW_SITE)
FFTW_SINGLE_DL_SUBDIR = fftw
FFTW_SINGLE_INSTALL_STAGING = $(FFTW_INSTALL_STAGING)
FFTW_SINGLE_LICENSE = $(FFTW_LICENSE)
FFTW_SINGLE_LICENSE_FILES = $(FFTW_LICENSE_FILES)

FFTW_SINGLE_CONF_ENV = $(FFTW_COMMON_CONF_ENV)

FFTW_SINGLE_CONF_OPTS = \
	$(FFTW_COMMON_CONF_OPTS) \
	CFLAGS="$(FFTW_SINGLE_CFLAGS)" \
	--enable-single

FFTW_SINGLE_CFLAGS = $(FFTW_COMMON_CFLAGS)

# x86 optimisations
FFTW_SINGLE_CONF_OPTS += \
	$(if $(BR2_X86_CPU_HAS_SSE),--enable,--disable)-sse \
	$(if $(BR2_X86_CPU_HAS_SSE2),--enable,--disable)-sse2

# ARM optimisations
ifeq ($(BR2_ARM_CPU_HAS_NEON):$(BR2_ARM_SOFT_FLOAT),y:)
FFTW_SINGLE_CONF_OPTS += --enable-neon
else
FFTW_SINGLE_CONF_OPTS += --disable-neon
endif

ifdef BR2_arm
ifdef BR2_cortex_a7
FFTW_SINGLE_CFLAGS += -mfpu=neon-vfpv4
FFTW_SINGLE_CONF_OPTS += NEON_CFLAGS="-mfpu=neon-vfpv4"
endif
ifdef BR2_cortex_a53
FFTW_SINGLE_CFLAGS += -mfpu=neon-fp-armv8
FFTW_SINGLE_CONF_OPTS += NEON_CFLAGS="-mfpu=neon-fp-armv8"
endif
endif

FFTW_SINGLE_POST_PATCH_HOOKS += FFTW_APPLY_MOD_PATCHES

$(eval $(autotools-package))
$(eval $(host-autotools-package))
