######################################
#
# juce
#
######################################

JUCE_VERSION = d10bc63cd1d9959e15f4713b15ebe0199e1ca996
JUCE_SITE = $(call github,DISTRHO,juce,$(JUCE_VERSION))
JUCE_DEPENDENCIES = freetype xlib_libXcursor

$(eval $(generic-package))
$(eval $(host-generic-package))

# Configure build with library components only
# cmake -B cmake-build-install -DCMAKE_INSTALL_PREFIX=/path/to/JUCE/install
# Run the installation
# cmake --build cmake-build-install --target install

# plugin side
# find_package(JUCE CONFIG REQUIRED)

# $(eval $(cmake-package))
# $(eval $(host-cmake-package))
