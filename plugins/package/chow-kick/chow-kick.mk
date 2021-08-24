######################################
#
# chow-kick
#
######################################

CHOW_KICK_VERSION = c9b6834deb133104c02baedaadd1dedfdd6e4c8e
CHOW_KICK_SITE = $(call github,Chowdhury-DSP,ChowKick,$(CHOW_KICK_VERSION))
# TODO make some libs optional
CHOW_KICK_DEPENDENCIES = freetype jack2mod xlib_libXcursor xlib_libXinerama xlib_libXrandr host-cmake
CHOW_KICK_BUNDLES = ChowKick.lv2

# call make with the current arguments and path. "$(@D)" is the build directory.
CHOW_KICK_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

# needed for git submodules
define CHOW_KICK_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git@github.com:Chowdhury-DSP/ChowKick.git $(@D)
	(cd $(@D) && \
		git reset --hard $(CHOW_KICK_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define CHOW_KICK_CONFIGURE_CMDS
	(cd $(@D) && \
		rm -f CMakeCache.txt && \
		"$(HOST_DIR)/usr/bin/cmake" . \
			-DCMAKE_C_COMPILER=$(TARGET_CC) \
			-DCMAKE_CXX_COMPILER=$(TARGET_CXX) \
			-DCMAKE_INSTALL_PREFIX="/usr" \
			-DCMAKE_BUILD_TYPE=Release)
endef

define CHOW_KICK_BUILD_CMDS
	$(CHOW_KICK_TARGET_MAKE)
endef

define CHOW_KICK_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2/ChowKick.lv2
	cp -rL $($(PKG)_PKGDIR)/ChowKick.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowKick.lv2/
	cp -rL $(@D)/ChowKick_artefacts/Release/LV2/ChowKick.lv2/* $(TARGET_DIR)/usr/lib/lv2/ChowKick.lv2/
endef

$(eval $(generic-package))
