######################################
#
# alo: multi looper with bpm sync
#
######################################

ALO_LABS_VERSION = 44f50586eb67455fccd53b736d47365419aec806
ALO_LABS_BUNDLES = alo.lv2

ALO_LABS_SITE = $(call github,devcurmudgeon,alo,$(ALO_LABS_VERSION))
# or for local development ...
#ALO_LABS_SITE_METHOD = local
#ALO_LABS_SITE = /tmp/moddevices/alo/

# call make with the current arguments and path. "$(@D)" is the build directory.
ALO_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/source

# build command
define ALO_LABS_BUILD_CMDS
	$(ALO_LABS_TARGET_MAKE)
endef

# install command
define ALO_LABS_INSTALL_TARGET_CMDS
	$(ALO_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

# import everything else from the buildroot generic package
$(eval $(generic-package))
