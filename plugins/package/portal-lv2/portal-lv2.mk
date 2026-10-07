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
	# ship the user manual, shown as "See Documentation" for both plugins
	install -m 644 $($(PKG)_PKGDIR)/documentation.pdf $(TARGET_DIR)/usr/lib/lv2/portal.lv2/modgui/
	sed -i 's|^\( *\)modgui:discussionURL|\1modgui:documentation <modgui/documentation.pdf> ;\n\1modgui:discussionURL|' \
		$(TARGET_DIR)/usr/lib/lv2/portal.lv2/modgui.ttl
endef

$(eval $(generic-package))
