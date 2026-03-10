################################################################################
#
# lilv
#
################################################################################

LILV_VERSION = 0.26.4
LILV_SITE = https://download.drobilla.net
LILV_SOURCE = lilv-$(LILV_VERSION).tar.xz
LILV_LICENSE = ISC
LILV_LICENSE_FILES = COPYING
LILV_DEPENDENCIES = host-pkgconf lv2 serd sord sratom
LILV_INSTALL_STAGING = YES

LILV_CONF_OPTS += \
	-Dbindings_cpp=disabled \
	-Dbindings_py=disabled \
	-Ddocs=disabled \
	-Ddynmanifest=disabled \
	-Dhtml=disabled \
	-Dlint=false \
	-Dsinglehtml=disabled \
	-Dtests=disabled

ifeq ($(BR2_PACKAGE_LIBSNDFILE),y)
LILV_DEPENDENCIES += libsndfile
endif

$(eval $(meson-package))
