######################################
#
# juce7
#
######################################

JUCE7_VERSION = bc1a195484d4d58865892adcadf6aa144772cbb3
JUCE7_VERSION_PROJECT = JUCE-7.0.0
JUCE7_SITE = $(call github,DISTRHO,juce,$(JUCE7_VERSION))
JUCE7_DEPENDENCIES = host-juce freetype
JUCE7_INSTALL_STAGING = YES
HOST_JUCE7_DEPENDENCIES = host-cmake host-freetype host-xlib_libX11

# this custom configure follows the same rules as buildroot, with these exceptions:
# - CMAKE_FIND_ROOT_PATH_MODE_PROGRAM="ONLY" (buildroot uses "NEVER")
# - CMAKE_MAKE_PROGRAM="/usr/bin/make" (not needed in buildroot, only for juce)
# - PKG_CONFIG related env vars (buildroot unsets them for the build)
define HOST_JUCE7_CONFIGURE_CMDS
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
		-DCMAKE_CXX_FLAGS="-I$(HOST_DIR)/usr/include -DJUCE_USE_XCURSOR=0 -DJUCE_USE_XINERAMA=0 -DJUCE_USE_XRANDR=0 -DJUCE_USE_XSHM=0" \
		-DJUCE7_BUILD_HELPER_TOOLS=ON \
		-DJUCE7_INSTALL_DESTINATION=lib/cmake/JUCE7 \
	)
endef

define HOST_JUCE7_POST_INSTALL_JUCEAIDE
	$(INSTALL) -m 755 $(@D)/extras/Build/juceaide/juceaide_artefacts/juceaide $(HOST_DIR)/usr/bin/juceaide7
	$(INSTALL) -m 644 $($(PKG)_PKGDIR)/toolchainfile.cmake $(HOST_DIR)/usr/lib/cmake/JUCE7/
endef

define JUCE7_INSTALL_STAGING_CMDS
	install -d $(STAGING_DIR)/usr/include
	install -d $(STAGING_DIR)/usr/lib/cmake
	cp $(HOST_DIR)/usr/bin/juceaide7 $(STAGING_DIR)/usr/bin/
	cp -r $(HOST_DIR)/usr/include/$(JUCE7_VERSION_PROJECT) $(STAGING_DIR)/usr/include/
	cp -r $(HOST_DIR)/usr/lib/cmake/JUCE7 $(STAGING_DIR)/usr/lib/cmake/
	sed -i -e 's|/host/|/staging/|' $(STAGING_DIR)/usr/lib/cmake/JUCE7/JUCEConfig.cmake
	sed -i -e 's|juce::juceaide|juceaide7|' $(STAGING_DIR)/usr/lib/cmake/JUCE7/*.cmake
endef

HOST_JUCE7_POST_INSTALL_HOOKS += HOST_JUCE7_POST_INSTALL_JUCEAIDE

$(eval $(generic-package))
$(eval $(host-cmake-package))
