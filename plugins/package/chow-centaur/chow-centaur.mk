######################################
#
# chow-centaur
#
######################################

CHOW_CENTAUR_VERSION = ff62afe2f612e00a47ac00eb885e3c193db20428
CHOW_CENTAUR_SITE = $(call github,jatinchowdhury18,KlonCentaur,$(CHOW_CENTAUR_VERSION))
CHOW_CENTAUR_BUNDLES = ChowCentaur.lv2

# call make with the current arguments and path. "$(@D)" is the build directory.
CHOW_CENTAUR_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) CXXFLAGS="$(TARGET_CXXFLAGS) -DJUCE_AUDIOPROCESSOR_NO_GUI"

# needed for git submodules
define CHOW_CENTAUR_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/jatinchowdhury18/KlonCentaur $(@D)
	(cd $(@D) && \
		git reset --hard $(CHOW_CENTAUR_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define CHOW_CENTAUR_CONFIGURE_CMDS
	(cd $(@D) && \
		rm -f CMakeCache.txt && \
		"$(HOST_DIR)/usr/bin/cmake" . \
			-DCMAKE_C_COMPILER=$(TARGET_CC) \
			-DCMAKE_CXX_COMPILER=$(TARGET_CXX) \
			-DCMAKE_INSTALL_PREFIX="/usr" \
			-DCMAKE_BUILD_TYPE=Release \
			-DBUILD_SHARED_LIBS=ON)
		
endef

define CHOW_CENTAUR_BUILD_CMDS
	$(CHOW_CENTAUR_TARGET_MAKE)
endef

define CHOW_CENTAUR_INSTALL_TARGET_CMDS
	$(CHOW_CENTAUR_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/ChowCentaur_artefacts/Release/LV2/ChowCentaur.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowCentaur.lv2/
endef

$(eval $(generic-package))
