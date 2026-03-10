################################################################################
#
# lv2
#
################################################################################

LV2_VERSION = 1.18.10
LV2_SITE = https://lv2plug.in/spec
LV2_SOURCE = lv2-$(LV2_VERSION).tar.xz
LV2_LICENSE = ISC
LV2_LICENSE_FILES = COPYING
LV2_DEPENDENCIES = host-pkgconf
LV2_INSTALL_STAGING = YES

LV2_CONF_OPTS += \
	-Ddocs=disabled \
	-Dtests=disabled

# always off
LV2_CONF_OPTS += -Dplugins=disabled

$(eval $(meson-package))
