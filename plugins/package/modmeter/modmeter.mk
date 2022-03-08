######################################
#
# modmeter
#
######################################

MODMETER_VERSION = 5c6e81456cb1ca17bb516bd45e2f423d9ab09f3b
MODMETER_SITE = $(call github,x42,modmeter.lv2,$(MODMETER_VERSION))
MODMETER_BUNDLES = modmeter.lv2

MODMETER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 -C $(@D)

define MODMETER_BUILD_CMDS
	$(MODMETER_TARGET_MAKE)
endef

define MODMETER_INSTALL_TARGET_CMDS
	$(MODMETER_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
endef

$(eval $(generic-package))
