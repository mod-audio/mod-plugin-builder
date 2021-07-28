######################################
#
# chow-centaur
#
######################################

CHOW_CENTAUR_VERSION = f3bb633a593b6fbb22a44c1ef9d1dbedbfe92d5b
CHOW_CENTAUR_SITE = $(call github,jatinchowdhury18,KlonCentaur,$(CHOW_CENTAUR_VERSION))
# TODO make some libs optional
CHOW_CENTAUR_DEPENDENCIES = freetype jack2mod xlib_libXcursor xlib_libXinerama xlib_libXrandr host-cmake
CHOW_CENTAUR_BUNDLES = ChowCentaur.lv2

# call make with the current arguments and path. "$(@D)" is the build directory.
CHOW_CENTAUR_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

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
		env $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) \
			"$(HOST_DIR)/usr/bin/cmake" . \
			-DCMAKE_C_COMPILER=$(TARGET_CC) \
			-DCMAKE_CXX_COMPILER=$(TARGET_CXX) \
			-DCMAKE_INSTALL_PREFIX="/usr" \
			-DCMAKE_BUILD_TYPE=Release)
endef

define CHOW_CENTAUR_BUILD_CMDS
	$(CHOW_CENTAUR_TARGET_MAKE)
endef

define CHOW_CENTAUR_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/ChowCentaur.lv2
	cp -rL $($(PKG)_PKGDIR)/ChowCentaur.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowCentaur.lv2/
	cp -rL $(@D)/ChowCentaur/ChowCentaur_artefacts/Release/LV2/ChowCentaur.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowCentaur.lv2/
endef

$(eval $(generic-package))
