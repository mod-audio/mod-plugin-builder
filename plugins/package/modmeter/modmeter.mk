######################################
#
# modmeter
#
######################################

MODMETER_VERSION = a06806593e719fc8d357ef73a62cab03c11a2f37
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
