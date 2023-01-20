######################################
#
# bolliedelayxt
#
######################################

BOLLIEDELAYXT_VERSION = 49c488523c8fb71cb2222d41f9f66ee0cb6b6d82
BOLLIEDELAYXT_SITE = $(call github,MrBollie,bolliedelayxt.lv2,$(BOLLIEDELAYXT_VERSION))
BOLLIEDELAYXT_BUNDLES = bolliedelayxt.lv2

BOLLIEDELAYXT_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) OPTIMIZATIONS="" PREFIX=/usr -C $(@D)

define BOLLIEDELAYXT_BUILD_CMDS
	$(BOLLIEDELAYXT_TARGET_MAKE)
endef

define BOLLIEDELAYXT_INSTALL_TARGET_CMDS
	$(BOLLIEDELAYXT_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
# 	cp -rL $($(PKG)_PKGDIR)/bolliedelayxt.lv2/* $(TARGET_DIR)/usr/lib/lv2/bolliedelayxt.lv2/
endef

$(eval $(generic-package))

