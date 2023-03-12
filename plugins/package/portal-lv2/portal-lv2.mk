######################################
#
# portal-lv2
#
######################################

PORTAL_LV2_VERSION = 0836619c9d8bd4cd47238ad7c87da949f31c627d
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
