######################################
#
# zam-plugins
#
######################################

ZAM_PLUGINS_VERSION = 3501810d403fdf5c35031dc3ac65ad56c13a8d2a
ZAM_PLUGINS_SITE = $(call github,zamaudio,zam-plugins,$(ZAM_PLUGINS_VERSION))
ZAM_PLUGINS_BUNDLES = ZamAutoSat.lv2 ZamComp.lv2 ZamCompX2.lv2 ZamDelay.lv2 ZamEQ2.lv2 ZamGate.lv2 ZamGateX2.lv2 ZamGEQ31.lv2 ZamHeadX2.lv2 ZaMaximX2.lv2 ZaMultiComp.lv2 ZaMultiCompX2.lv2 ZamTube.lv2 ZamDynamicEQ.lv2 ZamPhono.lv2

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
	# TODO ZamDynamicEQ.lv2 ZamPhono.lv2
	cp -rL $($(PKG)_PKGDIR)/ZamAutoSat.lv2/*    $(TARGET_DIR)/usr/lib/lv2/ZamAutoSat.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamComp.lv2/*       $(TARGET_DIR)/usr/lib/lv2/ZamComp.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamCompX2.lv2/*     $(TARGET_DIR)/usr/lib/lv2/ZamCompX2.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamDelay.lv2/*      $(TARGET_DIR)/usr/lib/lv2/ZamDelay.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamEQ2.lv2/*        $(TARGET_DIR)/usr/lib/lv2/ZamEQ2.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamGate.lv2/*       $(TARGET_DIR)/usr/lib/lv2/ZamGate.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamGateX2.lv2/*     $(TARGET_DIR)/usr/lib/lv2/ZamGateX2.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamGEQ31.lv2/*      $(TARGET_DIR)/usr/lib/lv2/ZamGEQ31.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamHeadX2.lv2/*     $(TARGET_DIR)/usr/lib/lv2/ZamHeadX2.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZamTube.lv2/*       $(TARGET_DIR)/usr/lib/lv2/ZamTube.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZaMaximX2.lv2/*     $(TARGET_DIR)/usr/lib/lv2/ZaMaximX2.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZaMultiComp.lv2/*   $(TARGET_DIR)/usr/lib/lv2/ZaMultiComp.lv2/
	cp -rL $($(PKG)_PKGDIR)/ZaMultiCompX2.lv2/* $(TARGET_DIR)/usr/lib/lv2/ZaMultiCompX2.lv2/
endef

$(eval $(generic-package))
