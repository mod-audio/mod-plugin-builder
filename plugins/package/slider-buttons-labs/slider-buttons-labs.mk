######################################
#
# slider-buttons: two momentary buttons that ramp a CV up and down
#
######################################

SLIDER_BUTTONS_LABS_VERSION = c3b7d0e6f325602ad91def35dcef2a56b02bc390
SLIDER_BUTTONS_LABS_SITE = $(call github,Jesse-Hufstetler,slider-buttons,$(SLIDER_BUTTONS_LABS_VERSION))
SLIDER_BUTTONS_LABS_BUNDLES = slider-buttons.lv2

# call make with the current arguments and path. "$(@D)" is the build directory.
SLIDER_BUTTONS_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

# build command
define SLIDER_BUTTONS_LABS_BUILD_CMDS
	$(SLIDER_BUTTONS_LABS_TARGET_MAKE)
endef

# install command (the bundle includes its own modgui)
define SLIDER_BUTTONS_LABS_INSTALL_TARGET_CMDS
	$(SLIDER_BUTTONS_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

# import everything else from the buildroot generic package
$(eval $(generic-package))
