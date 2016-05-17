######################################
#
# eg-amp-lv2
#
######################################

# where to find the source code - locally in this case
EG_AMP_LV2_SITE_METHOD = file
EG_AMP_LV2_SITE = .
EG_AMP_LV2_SOURCE = .

# even though this is a local build, we still need a version number
EG_AMP_LV2_VERSION = 1

# dependencies (list of other buildroot packages, separated by space)
EG_AMP_LV2_DEPENDENCIES =

# LV2 bundles that this package generates (space separated list)
EG_AMP_LV2_BUNDLES = eg-amp.lv2

# call make with the current arguments and path. "$(@D)" is the build directory.
EG_AMP_LV2_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/source/


# instead of extracting code tarball (which doesn't exist), copy the local contents to the build dir
# this makes sure the build is always clean
define EG_AMP_LV2_EXTRACT_CMDS
	cp -r $($(PKG)_PKGDIR)/* $(@D)
endef

# build command
define EG_AMP_LV2_BUILD_CMDS
	$(EG_AMP_LV2_TARGET_MAKE)
endef

# install command
define EG_AMP_LV2_INSTALL_TARGET_CMDS
	$(EG_AMP_LV2_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef


# import everything else from the buildroot generic package
$(eval $(generic-package))
