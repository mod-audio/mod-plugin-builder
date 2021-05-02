######################################
#
# airwindows
#
######################################

AIRWINDOWS_VERSION = 94a6cc3d6c70883e08fd7be16e9405d44bfb94e5
AIRWINDOWS_SITE = https://code.volse.net/audio/plugins/airwindows-lv2-port.git
AIRWINDOWS_SITE_METHOD = git
AIRWINDOWS_SUBDIR = plugins/LV2
AIRWINDOWS_BUNDLES = airwindows.lv2

define AIRWINDOWS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive $(AIRWINDOWS_SITE) $(@D)
		(cd $(@D) && \
		git reset --hard $(AIRWINDOWS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define AIRWINDOWS_INSTALL_TARGET_CMDS
	cp -rL $(@D)/$(AIRWINDOWS_SUBDIR)/airwindows.lv2 $(TARGET_DIR)/usr/lib/lv2/
# 	cp -rL $($(PKG)_PKGDIR)/airwindows.lv2/*         $(TARGET_DIR)/usr/lib/lv2/airwindows.lv2/
endef

$(eval $(cmake-package))
