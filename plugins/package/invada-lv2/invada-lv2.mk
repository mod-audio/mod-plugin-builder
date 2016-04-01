######################################
#
# invada-lv2
#
######################################

INVADA_LV2_VERSION = 1.2.0
INVADA_LV2_SITE = https://launchpad.net/invada-studio/lv2/1.2/+download/
INVADA_LV2_SOURCE = invada-studio-plugins-lv2_$(INVADA_LV2_VERSION)-nopkg.tgz
INVADA_LV2_BUNDLES = invada.lv2

INVADA_LV2_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) LD=$(TARGET_CC) $(MAKE) -C $(@D)

define INVADA_LV2_BUILD_CMDS
	$(INVADA_LV2_TARGET_MAKE)
endef

define INVADA_LV2_INSTALL_TARGET_CMDS
	$(INVADA_LV2_TARGET_MAKE) install-sys DESTDIR=$(TARGET_DIR) INSTALL_SYS_PLUGINS_DIR=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/invada.lv2/* $(TARGET_DIR)/usr/lib/lv2/invada.lv2/
endef

$(eval $(generic-package))
