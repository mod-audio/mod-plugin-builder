################################################################################
#
# zita-convolver
#
################################################################################

ZITA_CONVOLVER_VERSION = 3.1.0
ZITA_CONVOLVER_SITE = http://http.debian.net/debian/pool/main/z/zita-convolver
ZITA_CONVOLVER_SOURCE = zita-convolver_$(ZITA_CONVOLVER_VERSION).orig.tar.bz2
ZITA_CONVOLVER_DEPENDENCIES = ffmpeg
ZITA_CONVOLVER_LICENSE = GPLv3+
ZITA_CONVOLVER_INSTALL_STAGING = YES

ZITA_CONVOLVER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/libs

define ZITA_CONVOLVER_BUILD_CMDS
	$(ZITA_CONVOLVER_TARGET_MAKE)
endef

define ZITA_CONVOLVER_INSTALL_TARGET_CMDS
	$(ZITA_CONVOLVER_TARGET_MAKE) install PREFIX=/usr LIBDIR=lib DESTDIR=$(TARGET_DIR)
endef

define ZITA_CONVOLVER_INSTALL_STAGING_CMDS
	$(ZITA_CONVOLVER_TARGET_MAKE) install PREFIX=/usr LIBDIR=lib DESTDIR=$(STAGING_DIR)
endef

$(eval $(generic-package))
