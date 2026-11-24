######################################
#
# cvcurve: bends a 0-10 V CV along an adjustable curve
#
######################################

CVCURVE_LABS_VERSION = 4a037ffaed1d65b6ba7e5e772b87c1531798b559
CVCURVE_LABS_SITE = $(call github,Jesse-Hufstetler,mod-cv-curve,$(CVCURVE_LABS_VERSION))
CVCURVE_LABS_BUNDLES = mod-cv-curve.lv2

# call make with the current arguments and path. "$(@D)" is the build directory.
CVCURVE_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

# build command
define CVCURVE_LABS_BUILD_CMDS
	$(CVCURVE_LABS_TARGET_MAKE)
endef

# install command (the bundle includes its own modgui)
define CVCURVE_LABS_INSTALL_TARGET_CMDS
	$(CVCURVE_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

# import everything else from the buildroot generic package
$(eval $(generic-package))
