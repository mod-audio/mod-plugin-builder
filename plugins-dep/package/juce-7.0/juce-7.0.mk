######################################
#
# juce-7.0
#
######################################

JUCE_7_0_VERSION = 76a34204602b6a2a46b64bf3eb3ccb0e3c41b9f8
JUCE_7_0_VERSION_PROJECT = JUCE-7.0.9
JUCE_7_0_SITE = $(call github,DISTRHO,juce,$(JUCE_7_0_VERSION))
JUCE_7_0_DEPENDENCIES = host-juce-7.0 freetype
JUCE_7_0_INSTALL_STAGING = YES
JUCE_7_0_TOOLCHAIN_FILE = $(STAGING_DIR)/usr/lib/cmake/$(JUCE_7_0_VERSION_PROJECT)/toolchainfile.cmake
HOST_JUCE_7_0_DEPENDENCIES = host-cmake host-freetype host-xlib_libX11

# this custom configure follows the same rules as buildroot, with these exceptions:
# - CMAKE_FIND_ROOT_PATH_MODE_PROGRAM="ONLY" (buildroot uses "NEVER")
# - CMAKE_MAKE_PROGRAM="/usr/bin/make" (not needed in buildroot, only for juce)
# - PKG_CONFIG related env vars (buildroot unsets them for the build)
define HOST_JUCE_7_0_CONFIGURE_CMDS
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
		-DJUCE_BUILD_HELPER_TOOLS=ON \
		-DJUCE_INSTALL_DESTINATION=lib/cmake/$(JUCE_7_0_VERSION_PROJECT) \
	)
endef

define HOST_JUCE_7_0_POST_INSTALL_JUCEAIDE
	$(INSTALL) -m 755 $(@D)/extras/Build/juceaide/juceaide_artefacts/juceaide $(HOST_DIR)/usr/bin/juceaide70
	$(INSTALL) -m 644 $($(PKG)_PKGDIR)/toolchainfile.cmake $(HOST_DIR)/usr/lib/cmake/$(JUCE_7_0_VERSION_PROJECT)/
endef

define JUCE_7_0_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/bin/$(JUCE_7_0_VERSION_PROJECT)
	$(INSTALL) -d $(STAGING_DIR)/usr/include
	$(INSTALL) -d $(STAGING_DIR)/usr/lib/cmake
	cp $(HOST_DIR)/usr/bin/juceaide70 $(STAGING_DIR)/usr/bin/
	cp $(HOST_DIR)/usr/bin/$(JUCE_7_0_VERSION_PROJECT)/juce_lv2_helper $(STAGING_DIR)/usr/bin/$(JUCE_7_0_VERSION_PROJECT)/
	cp -r $(HOST_DIR)/usr/include/$(JUCE_7_0_VERSION_PROJECT) $(STAGING_DIR)/usr/include/
	cp -r $(HOST_DIR)/usr/lib/cmake/$(JUCE_7_0_VERSION_PROJECT) $(STAGING_DIR)/usr/lib/cmake/
	ln -sf JUCEConfig.cmake $(STAGING_DIR)/usr/lib/cmake/$(JUCE_7_0_VERSION_PROJECT)/$(JUCE_7_0_VERSION_PROJECT)Config.cmake
	sed -i -e 's|/host/|/staging/|' $(STAGING_DIR)/usr/lib/cmake/$(JUCE_7_0_VERSION_PROJECT)/JUCEConfig.cmake
	sed -i -e 's|juce::juceaide|juceaide70|' $(STAGING_DIR)/usr/lib/cmake/$(JUCE_7_0_VERSION_PROJECT)/*.cmake
endef

HOST_JUCE_7_0_POST_INSTALL_HOOKS += HOST_JUCE_7_0_POST_INSTALL_JUCEAIDE

$(eval $(generic-package))
$(eval $(host-cmake-package))
