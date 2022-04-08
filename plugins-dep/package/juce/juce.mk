######################################
#
# juce
#
######################################

JUCE_VERSION = 8c4318e6e472ffa5d9d73ef8428e51ca0425a3c7
JUCE_SITE = $(call github,DISTRHO,juce,$(JUCE_VERSION))
JUCE_DEPENDENCIES = host-cmake freetype
HOST_JUCE_DEPENDENCIES = host-cmake host-freetype

# this custom configure follows the same rules as buildroot, with these exceptions:
# - CMAKE_FIND_ROOT_PATH_MODE_PROGRAM="ONLY" (buildroot uses "NEVER")
# - CMAKE_MAKE_PROGRAM="/usr/bin/make" (not needed in buildroot, only for juce)
# - PKG_CONFIG related env vars (buildroot unsets them for the build)
define HOST_JUCE_CONFIGURE_CMDS
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
		-DJUCE_BUILD_HELPER_TOOLS=ON \
		-DJUCE_INSTALL_DESTINATION=lib/cmake/JUCE \
	)
endef

define HOST_JUCE_POST_INSTALL_JUCEAIDE
	$(INSTALL) -m 755 $(@D)/extras/Build/juceaide/juceaide_artefacts/juceaide $(HOST_DIR)/usr/bin/
	$(INSTALL) -m 755 $($(PKG)_PKGDIR)/toolchainfile.cmake $(HOST_DIR)/usr/lib/cmake/JUCE/
endef

HOST_JUCE_POST_INSTALL_HOOKS += HOST_JUCE_POST_INSTALL_JUCEAIDE

$(eval $(generic-package))
$(eval $(host-cmake-package))
