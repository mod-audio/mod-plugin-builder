######################################
#
# mod-cv-curve: bends a 0-10 V CV along an adjustable curve
#
######################################

MOD_CV_CURVE_LABS_VERSION = c4ae42ec05834cb149df31f9313f184587940821
MOD_CV_CURVE_LABS_SITE = $(call github,Jesse-Hufstetler,mod-cv-curve,$(MOD_CV_CURVE_LABS_VERSION))
MOD_CV_CURVE_LABS_BUNDLES = mod-cv-curve.lv2

# call make with the current arguments and path. "$(@D)" is the build directory.
MOD_CV_CURVE_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

# build command
define MOD_CV_CURVE_LABS_BUILD_CMDS
	$(MOD_CV_CURVE_LABS_TARGET_MAKE)
endef

# install command (the bundle includes its own modgui)
define MOD_CV_CURVE_LABS_INSTALL_TARGET_CMDS
	$(MOD_CV_CURVE_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

# import everything else from the buildroot generic package
$(eval $(generic-package))
