################################################################################
#
# zita-resampler
#
################################################################################

ZITA_RESAMPLER_VERSION = 1.6.0
ZITA_RESAMPLER_SOURCE = zita-resampler-$(ZITA_RESAMPLER_VERSION).tar.bz2
ZITA_RESAMPLER_SITE = $(BR2_EXTERNAL)/package/zita-resampler
ZITA_RESAMPLER_SITE_METHOD = file
ZITA_RESAMPLER_DEPENDENCIES = fftw-single
ZITA_RESAMPLER_LICENSE = GPLv3+
ZITA_RESAMPLER_LICENSE_FILES = COPYING
ZITA_RESAMPLER_INSTALL_STAGING = YES

ZITA_RESAMPLER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/libs

define ZITA_RESAMPLER_BUILD_CMDS
	$(ZITA_RESAMPLER_TARGET_MAKE)
endef

define ZITA_RESAMPLER_INSTALL_TARGET_CMDS
	$(ZITA_RESAMPLER_TARGET_MAKE) install PREFIX=/usr LIBDIR=lib DESTDIR=$(TARGET_DIR)
endef

define ZITA_RESAMPLER_INSTALL_STAGING_CMDS
	$(ZITA_RESAMPLER_TARGET_MAKE) install PREFIX=/usr LIBDIR=lib DESTDIR=$(STAGING_DIR)
endef

$(eval $(generic-package))
