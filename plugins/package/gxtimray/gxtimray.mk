######################################
#
# gxtimray
#
######################################

GXTIMRAY_VERSION = efda5914b784093d409b03d96393fe5bc1be9fe6
GXTIMRAY_SITE = $(call github,brummer10,GxTimRay.lv2,$(GXTIMRAY_VERSION))
GXTIMRAY_BUNDLES = gx_timray.lv2

GXTIMRAY_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D)

define GXTIMRAY_BUILD_CMDS
	$(GXTIMRAY_TARGET_MAKE) mod
endef

define GXTIMRAY_INSTALL_TARGET_CMDS
	$(GXTIMRAY_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
