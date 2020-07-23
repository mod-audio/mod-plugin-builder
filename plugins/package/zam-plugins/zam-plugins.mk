######################################
#
# zam-plugins
#
######################################

ZAM_PLUGINS_VERSION = 3501810d403fdf5c35031dc3ac65ad56c13a8d2a
ZAM_PLUGINS_SITE = $(call github,zamaudio,zam-plugins,$(ZAM_PLUGINS_VERSION))
ZAM_PLUGINS_BUNDLES = ZamComp.lv2 ZamCompX2.lv2

ZAM_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

# needed for git submodules
define ZAM_PLUGINS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/zamaudio/zam-plugins $(@D)
	(cd $(@D) && \
		git reset --hard $(ZAM_PLUGINS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define ZAM_PLUGINS_BUILD_CMDS
	$(ZAM_PLUGINS_TARGET_MAKE)
endef

define ZAM_PLUGINS_INSTALL_TARGET_CMDS
	$(ZAM_PLUGINS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/ZamComp.lv2/*       $(TARGET_DIR)/usr/lib/lv2/ZamComp.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamCompX2.lv2/*     $(TARGET_DIR)/usr/lib/lv2/ZamCompX2.lv2/
endef

$(eval $(generic-package))
