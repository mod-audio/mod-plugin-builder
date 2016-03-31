######################################
#
# freaked
#
######################################

FREAKED_VERSION = 7f4fca70d7d424ddd353347bafb68e62aba0e043
FREAKED_SITE = $(call github,pjotrompet,freaked,$(FREAKED_VERSION))
FREAKED_BUNDLES = 

FREAKED_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) NOOPT=true

define FREAKED_BUILD_CMDS
	$(FREAKED_TARGET_MAKE)
endef

define FREAKED_INSTALL_TARGET_CMDS
	$(FREAKED_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
	cp -rL $($(PKG)_PKGDIR)/Freakclip.lv2/*  $(TARGET_DIR)/usr/lib/lv2/Freakclip.lv2/
	cp -rL $($(PKG)_PKGDIR)/Freaktail.lv2/*  $(TARGET_DIR)/usr/lib/lv2/Freaktail.lv2/
	cp -rL $($(PKG)_PKGDIR)/Granulator.lv2/* $(TARGET_DIR)/usr/lib/lv2/Granulator.lv2/
	cp -rL $($(PKG)_PKGDIR)/Prefreak.lv2/*   $(TARGET_DIR)/usr/lib/lv2/Prefreak.lv2/
endef

$(eval $(generic-package))
