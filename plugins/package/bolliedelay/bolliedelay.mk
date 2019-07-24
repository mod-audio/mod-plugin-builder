
######################################
#
# bolliedelay
#
######################################
BOLLIEDELAY_VERSION = c42ae339855b1725d9e0c2c81900151b751af502
BOLLIEDELAY_SITE = $(call github,MrBollie,bolliedelay.lv2,$(BOLLIEDELAY_VERSION))
BOLLIEDELAY_BUNDLES = bolliedelay.lv2

BOLLIEDELAY_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="" PREFIX=/usr -C $(@D)

define BOLLIEDELAY_BUILD_CMDS
	$(BOLLIEDELAY_TARGET_MAKE)
endef

define BOLLIEDELAY_INSTALL_TARGET_CMDS
	$(BOLLIEDELAY_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/bolliedelay.lv2/* $(TARGET_DIR)/usr/lib/lv2/bolliedelay.lv2/
endef

$(eval $(generic-package))

