#############################################################
#
# p7zip-light
#
#############################################################

P7ZIP_LIGHT_VERSION = 9.20.1
P7ZIP_LIGHT_SOURCE = p7zip_$(P7ZIP_LIGHT_VERSION)_src_all.tar.bz2
P7ZIP_LIGHT_SITE = http://download.sourceforge.net/p7zip/
P7ZIP_LIGHT_LICENSE = LGPLv2.1+

define HOST_P7ZIP_LIGHT_BUILD_CMDS
	$(MAKE) CFLAGS="-D_7ZIP_LARGE_PAGES -fPIC" \
		CXXFLAGS="-D_7ZIP_LARGE_PAGES -fPIC" \
		-C $(@D) 7za 7z \
		$(if $(BR2_PACKAGE_P7ZIP_LIGHT_SFX),sfx) \
		$(if $(BR2_PACKAGE_P7ZIP_LIGHT_7ZR),7zr)
endef

define P7ZIP_LIGHT_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" \
		CXX="$(TARGET_CXX)" CXXFLAGS="$(TARGET_CXXFLAGS)" \
		-C $(@D) 7za 7z \
		$(if $(BR2_PACKAGE_P7ZIP_LIGHT_SFX),sfx) \
		$(if $(BR2_PACKAGE_P7ZIP_LIGHT_7ZR),7zr)
endef

define HOST_P7ZIP_LIGHT_INSTALL_CMDS
	(cd $(@D); \
		make install DEST_DIR=$(HOST_DIR) DEST_HOME=/usr DEST_MAN=/usr/share/man \
	)
	sed -i "s|/usr/lib|$(HOST_DIR)/usr/lib|" $(HOST_DIR)/usr/bin/7z*
endef

define P7ZIP_LIGHT_INSTALL_TARGET_CMDS
	(cd $(@D); \
		make install DEST_DIR=$(TARGET_DIR) DEST_HOME=/usr DEST_MAN=/usr/share/man \
	)
endef

define P7ZIP_LIGHT_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/bin/7z{,a,r}
	rm -rf $(TARGET_DIR)/usr/lib/p7zip
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
