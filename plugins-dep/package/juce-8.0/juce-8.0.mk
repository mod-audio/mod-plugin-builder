######################################
#
# juce-8.0
#
######################################

JUCE_8_0_VERSION = 51d11a2be6d5c97ccf12b4e5e827006e19f0555a
JUCE_8_0_VERSION_PROJECT = JUCE-8.0.4
JUCE_8_0_SITE = $(call github,juce-framework,juce,$(JUCE_8_0_VERSION))
JUCE_8_0_DEPENDENCIES = host-juce-8.0 freetype xlib_libX11
JUCE_8_0_INSTALL_STAGING = YES
JUCE_8_0_TOOLCHAIN_FILE = $(STAGING_DIR)/usr/lib/cmake/$(JUCE_8_0_VERSION_PROJECT)/toolchainfile.cmake
HOST_JUCE_8_0_DEPENDENCIES = host-cmake host-freetype host-xlib_libX11

# this custom configure follows the same rules as buildroot, with these exceptions:
# - CMAKE_FIND_ROOT_PATH_MODE_PROGRAM="ONLY" (buildroot uses "NEVER")
# - CMAKE_MAKE_PROGRAM="/usr/bin/make" (not needed in buildroot, only for juce)
# - PKG_CONFIG related env vars (buildroot unsets them for the build)
define HOST_JUCE_8_0_CONFIGURE_CMDS
	(mkdir -p $(@D) && cd $(@D) && rm -f CMakeCache.txt && \
		env PKG_CONFIG_SYSROOT_DIR="$(HOST_DIR)" PKG_CONFIG_PATH="$(HOST_DIR)/usr/lib/pkgconfig" \
		$(HOST_DIR)/usr/bin/cmake $(@D) \
		-DCMAKE_INSTALL_PREFIX=$(HOST_DIR)/usr \
		-DCMAKE_INSTALL_SO_NO_EXE=0 \
		-DCMAKE_FIND_ROOT_PATH="$(HOST_DIR)" \
		-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM="ONLY" \
		-DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE="ONLY" \
		-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE="ONLY" \
		-DCMAKE_MAKE_PROGRAM="/usr/bin/make" \
		-DCMAKE_C_COMPILER="$(HOSTCC)" \
		-DCMAKE_CXX_COMPILER="$(HOSTCXX)" \
		-DCMAKE_CXX_FLAGS="$(HOST_CXXFLAGS) -DJUCE_USE_CURL=0 -DJUCE_USE_XCURSOR=0 -DJUCE_USE_XINERAMA=0 -DJUCE_USE_XRANDR=0 -DJUCE_USE_XSHM=0" \
		-DJUCE_BUILD_HELPER_TOOLS=ON \
		-DJUCE_INSTALL_DESTINATION=lib/cmake/$(JUCE_8_0_VERSION_PROJECT) \
	)
endef

define HOST_JUCE_8_0_POST_INSTALL_JUCEAIDE
	$(INSTALL) -d $(HOST_DIR)/usr/bin/$(JUCE_8_0_VERSION_PROJECT)
	$(INSTALL) -m 755 $(@D)/extras/Build/juceaide/juceaide_artefacts/juceaide $(HOST_DIR)/usr/bin/$(JUCE_8_0_VERSION_PROJECT)
	$(INSTALL) -m 644 $($(PKG)_PKGDIR)/toolchainfile.cmake $(HOST_DIR)/usr/lib/cmake/$(JUCE_8_0_VERSION_PROJECT)/
endef

HOST_JUCE_8_0_POST_INSTALL_HOOKS += HOST_JUCE_8_0_POST_INSTALL_JUCEAIDE

define JUCE_8_0_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/bin/$(JUCE_8_0_VERSION_PROJECT)
	$(INSTALL) -d $(STAGING_DIR)/usr/include
	$(INSTALL) -d $(STAGING_DIR)/usr/lib/cmake
	cp $(HOST_DIR)/usr/bin/$(JUCE_8_0_VERSION_PROJECT)/juceaide $(STAGING_DIR)/usr/bin/$(JUCE_8_0_VERSION_PROJECT)/
	cp $(HOST_DIR)/usr/bin/$(JUCE_8_0_VERSION_PROJECT)/juce_lv2_helper $(STAGING_DIR)/usr/bin/$(JUCE_8_0_VERSION_PROJECT)/
	cp $(HOST_DIR)/usr/bin/$(JUCE_8_0_VERSION_PROJECT)/juce_vst3_helper $(STAGING_DIR)/usr/bin/$(JUCE_8_0_VERSION_PROJECT)/
	cp -r $(HOST_DIR)/usr/include/$(JUCE_8_0_VERSION_PROJECT) $(STAGING_DIR)/usr/include/
	cp -r $(HOST_DIR)/usr/lib/cmake/$(JUCE_8_0_VERSION_PROJECT) $(STAGING_DIR)/usr/lib/cmake/
	ln -sf JUCEConfig.cmake $(STAGING_DIR)/usr/lib/cmake/$(JUCE_8_0_VERSION_PROJECT)/$(JUCE_8_0_VERSION_PROJECT)Config.cmake
endef

$(eval $(generic-package))
$(eval $(host-cmake-package))
