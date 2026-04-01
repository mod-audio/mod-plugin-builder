################################################################################
#
# gawk
#
################################################################################

GAWK_VERSION = 5.2.2
GAWK_SOURCE = gawk-$(GAWK_VERSION).tar.xz
GAWK_SITE = $(BR2_GNU_MIRROR)/gawk
GAWK_DEPENDENCIES = host-gawk
GAWK_LICENSE = GPL-3.0+
GAWK_LICENSE_FILES = COPYING

ifeq ($(BR2_PACKAGE_LIBSIGSEGV),y)
GAWK_DEPENDENCIES += libsigsegv
endif

# --with-mpfr requires an argument so just let
# configure find it automatically
ifeq ($(BR2_PACKAGE_MPFR),y)
GAWK_DEPENDENCIES += mpfr
else
GAWK_CONF_OPTS += --without-mpfr
endif

# --with-readline requires an argument so just let
# configure find it automatically
ifeq ($(BR2_PACKAGE_READLINE),y)
GAWK_DEPENDENCIES += readline
else
GAWK_CONF_OPTS += --without-readline
endif

# gcc-15 defaults to -std=gnu23 which is incorrectly detected and
# generates build failures in the gnulib copy included in
# m4-1.4.19. We workaround this by forcing the previous gcc default
# standard, which is -std=gnu17 only when host gcc is >= 15. This
# workaround can be removed when m4 will be updated to a version
# including a fix for gcc-15.
ifeq ($(BR2_HOST_GCC_AT_LEAST_11),y)
HOST_GAWK_CONF_ENV = CFLAGS="$(HOST_CFLAGS) -std=gnu17"
endif

HOST_GAWK_CONF_OPTS = --without-readline --without-mpfr

define GAWK_CREATE_SYMLINK
	ln -sf gawk $(TARGET_DIR)/usr/bin/awk
endef

GAWK_POST_INSTALL_TARGET_HOOKS += GAWK_CREATE_SYMLINK

define HOST_GAWK_CREATE_SYMLINK
	ln -sf gawk $(HOST_DIR)/bin/awk
endef

HOST_GAWK_POST_INSTALL_HOOKS += HOST_GAWK_CREATE_SYMLINK

$(eval $(autotools-package))
$(eval $(host-autotools-package))
