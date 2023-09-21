######################################
#
# zam-plugins
#
######################################

ZAM_PLUGINS_VERSION = 3501810d403fdf5c35031dc3ac65ad56c13a8d2a
ZAM_PLUGINS_SITE = https://github.com/zamaudio/zam-plugins.git
ZAM_PLUGINS_SITE_METHOD = git
ZAM_PLUGINS_BUNDLES = ZamComp.lv2 ZamCompX2.lv2

ZAM_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

# needed for submodules support
ZAM_PLUGINS_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define ZAM_PLUGINS_BUILD_CMDS
	$(ZAM_PLUGINS_TARGET_MAKE)
endef

define ZAM_PLUGINS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/ZamComp.lv2
	install -d $(TARGET_DIR)/usr/lib/lv2/ZamCompX2.lv2
	install -m 644 $(@D)/bin/ZamComp.lv2/*.* $(TARGET_DIR)/usr/lib/lv2/ZamComp.lv2/
	install -m 644 $(@D)/bin/ZamCompX2.lv2/*.* $(TARGET_DIR)/usr/lib/lv2/ZamCompX2.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamComp.lv2/*       $(TARGET_DIR)/usr/lib/lv2/ZamComp.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamCompX2.lv2/*     $(TARGET_DIR)/usr/lib/lv2/ZamCompX2.lv2/
endef

$(eval $(generic-package))
