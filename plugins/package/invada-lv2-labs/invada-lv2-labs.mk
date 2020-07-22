######################################
#
# invada-lv2-labs
#
######################################

INVADA_LV2_LABS_VERSION = 1.2.0
INVADA_LV2_LABS_SITE = https://launchpad.net/invada-studio/lv2/1.2/+download/
INVADA_LV2_LABS_SOURCE = invada-studio-plugins-lv2_$(INVADA_LV2_LABS_VERSION)-nopkg.tgz
INVADA_LV2_LABS_BUNDLES = invada-labs.lv2

INVADA_LV2_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) LD=$(TARGET_CC) $(MAKE) -C $(@D)

define INVADA_LV2_LABS_BUILD_CMDS
	$(INVADA_LV2_LABS_TARGET_MAKE)
endef

define INVADA_LV2_LABS_INSTALL_TARGET_CMDS
	$(INVADA_LV2_LABS_TARGET_MAKE) install-sys DESTDIR=$(TARGET_DIR) INSTALL_SYS_PLUGINS_DIR=/usr/lib/lv2
	mv $(TARGET_DIR)/usr/lib/lv2/invada.lv2 $(TARGET_DIR)/usr/lib/lv2/invada-labs.lv2
	cp -rL $($(PKG)_PKGDIR)/invada-labs.lv2/* $(TARGET_DIR)/usr/lib/lv2/invada-labs.lv2/
endef

$(eval $(generic-package))
