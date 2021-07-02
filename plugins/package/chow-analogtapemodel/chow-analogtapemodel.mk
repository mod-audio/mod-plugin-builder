######################################
#
# chow-analogtapemodel
#
######################################

CHOW_ANALOGTAPEMODEL_VERSION = b3d284be1f0e391c72eb22d05953f8047a7a03eb
CHOW_ANALOGTAPEMODEL_SITE = $(call github,jatinchowdhury18,AnalogTapeModel,$(CHOW_ANALOGTAPEMODEL_VERSION))
CHOW_ANALOGTAPEMODEL_BUNDLES = ChowAnalogTapeModel.lv2

# call make with the current arguments and path. "$(@D)" is the build directory.
CHOW_ANALOGTAPEMODEL_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/Plugin CXXFLAGS="$(TARGET_CXXFLAGS) -DJUCE_AUDIOPROCESSOR_NO_GUI"

# needed for git submodules
define CHOW_ANALOGTAPEMODEL_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/jatinchowdhury18/AnalogTapeModel $(@D)
	(cd $(@D) && \
		git reset --hard $(CHOW_ANALOGTAPEMODEL_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define CHOW_ANALOGTAPEMODEL_CONFIGURE_CMDS
	(cd $(@D)/Plugin && \
		rm -f CMakeCache.txt && \
		"$(HOST_DIR)/usr/bin/cmake" . \
			-DCMAKE_C_COMPILER=$(TARGET_CC) \
			-DCMAKE_CXX_COMPILER=$(TARGET_CXX) \
			-DCMAKE_INSTALL_PREFIX="/usr" \
			-DCMAKE_BUILD_TYPE=Release \
			-DBUILD_SHARED_LIBS=ON)
		
endef

define CHOW_ANALOGTAPEMODEL_BUILD_CMDS
	$(CHOW_ANALOGTAPEMODEL_TARGET_MAKE)
endef

define CHOW_ANALOGTAPEMODEL_INSTALL_TARGET_CMDS
	$(CHOW_ANALOGTAPEMODEL_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/ChowCentaur_artefacts/Release/LV2/ChowCentaur.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowCentaur.lv2/
endef

$(eval $(generic-package))
