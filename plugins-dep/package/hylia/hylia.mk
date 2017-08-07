######################################
#
# hylia
#
######################################

HYLIA_VERSION = 44579665050dc0472aedf3daf6114dddda8d3db8
HYLIA_SITE = $(call github,falkTX,Hylia,$(HYLIA_VERSION))
HYLIA_INSTALL_STAGING = YES

HYLIA_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true PREFIX=/usr -C $(@D)

define HYLIA_BUILD_CMDS
	$(HYLIA_TARGET_MAKE)
endef

define HYLIA_INSTALL_TARGET_CMDS
	$(HYLIA_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

define HYLIA_INSTALL_STAGING_CMDS
	$(HYLIA_TARGET_MAKE) install DESTDIR=$(STAGING_DIR)
endef

$(eval $(generic-package))
