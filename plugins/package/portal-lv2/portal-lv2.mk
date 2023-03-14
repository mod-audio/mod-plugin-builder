######################################
#
# portal-lv2
#
######################################

PORTAL_LV2_VERSION = 0c3599f723de46d09f15d99db9885f03a8d2c3fd
PORTAL_LV2_SITE = $(call github,falkTX,portal-lv2,$(PORTAL_LV2_VERSION))
PORTAL_LV2_BUNDLES = portal.lv2

PORTAL_LV2_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define PORTAL_LV2_BUILD_CMDS
	$(PORTAL_LV2_TARGET_MAKE)
endef

define PORTAL_LV2_INSTALL_TARGET_CMDS
	$(PORTAL_LV2_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
