######################################
#
# hylia
#
######################################

HYLIA_VERSION = 3ec0754a701dceb80cd2ee9ee381e1567dcdb77a
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
