######################################
#
# channelb-lv2-labs
#
######################################

# where to find the source code
PLUJAIN_CHANNELB_LABS_VERSION = 167b7cf301459e6adbff7e3b82b34353e3bf7f18
PLUJAIN_CHANNELB_LABS_SITE = $(call github,Houston4444,plujain-channelb,$(PLUJAIN_CHANNELB_LABS_VERSION))
# PLUJAIN_CHANNELB_LABS_SITE_METHOD = local
# PLUJAIN_CHANNELB_LABS_SITE = $($(PKG)_PKGDIR)/

# even though this is a local build, we still need a version number
# bump this number if you need to force a rebuild
# PLUJAIN_CHANNELB_LABS_VERSION = 1

# dependencies (list of other buildroot packages, separated by space)
PLUJAIN_CHANNELB_LABS_DEPENDENCIES =

# LV2 bundles that this package generates (space separated list)
PLUJAIN_CHANNELB_LABS_BUNDLES = plujain-channelb.lv2

# call make with the current arguments and path. "$(@D)" is the build directory.
PLUJAIN_CHANNELB_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)


# build command
define PLUJAIN_CHANNELB_LABS_BUILD_CMDS
	$(PLUJAIN_CHANNELB_LABS_TARGET_MAKE)
endef

# install command
define PLUJAIN_CHANNELB_LABS_INSTALL_TARGET_CMDS
	$(PLUJAIN_CHANNELB_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef


# import everything else from the buildroot generic package
$(eval $(generic-package))
