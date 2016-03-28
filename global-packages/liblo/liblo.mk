################################################################################
#
# liblo
#
################################################################################

LIBLO_VERSION = 0.28
LIBLO_SITE = http://download.sourceforge.net/liblo
LIBLO_SOURCE = liblo-$(LIBLO_VERSION).tar.gz
LIBLO_LICENSE = LGPLv2.1+
LIBLO_LICENSE_FILES = COPYING
LIBLO_INSTALL_STAGING = YES
LIBLO_LIBTOOL_PATCH = NO

LIBLO_CONF_OPTS = --enable-ipv6=no

$(eval $(autotools-package))
$(eval $(host-autotools-package))
