######################################
#
# mod-volume
#
######################################

MOD_VOLUME_VERSION = bc55d4f336b00a8766817f65121b9ec59d20f98d
MOD_VOLUME_SITE = $(call github,moddevices,mod-volume-lv2,$(MOD_VOLUME_VERSION))
MOD_VOLUME_BUNDLES = mod-volume.lv2 mod-volume-2x2.lv2

# dependencies (list of other buildroot packages, separated by space)
MOD_VOLUME_DEPENDENCIES =

# call make with the current arguments and path. "$(@D)" is the build directory.
MOD_VOLUME_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define MOD_VOLUME_BUILD_CMDS
	$(MOD_VOLUME_TARGET_MAKE)
endef

define MOD_VOLUME_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/volume/source/*.lv2    				$(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/volume-2x2/source/*.lv2  			$(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-volume.lv2/*        $(TARGET_DIR)/usr/lib/lv2/mod-volume.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-volume-2x2.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-volume-2x2.lv2/
endef

$(eval $(generic-package))
