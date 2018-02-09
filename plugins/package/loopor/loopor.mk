######################################
#
# loopor
#
######################################

LOOPOR_VERSION = f89802c87db3b360c20af50ef2adedf60dcc9171
LOOPOR_SITE = $(call github,stevie67,loopor,$(LOOPOR_VERSION))
LOOPOR_BUNDLES = loopor.lv2

LOOPOR_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/loopor-lv2/source

define LOOPOR_BUILD_CMDS
	$(LOOPOR_TARGET_MAKE)
endef

define LOOPOR_INSTALL_TARGET_CMDS
	$(LOOPOR_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
