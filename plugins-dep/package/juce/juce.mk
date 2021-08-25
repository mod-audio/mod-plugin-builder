######################################
#
# juce
#
######################################

JUCE_VERSION = d10bc63cd1d9959e15f4713b15ebe0199e1ca996
JUCE_SITE = $(call github,DISTRHO,juce,$(JUCE_VERSION))
JUCE_DEPENDENCIES = freetype xlib_libXcursor

$(eval $(cmake-package))
$(eval $(host-cmake-package))
