######################################
#
# mod-arpeggiator
#
######################################

MOD_ARPEGGIATOR_VERSION = 03d8afe12e51fc67a49a4c6a94c319d21e1dd9c8
MOD_ARPEGGIATOR_SITE = $(call github,moddevices,mod-arpeggiator-lv2,$(MOD_ARPEGGIATOR_VERSION))
MOD_ARPEGGIATOR_BUNDLES = mod-arpeggiator.lv2

# dependencies (list of other buildroot packages, separated by space)
MOD_ARPEGGIATOR_DEPENDENCIES =

# call make with the current arguments and path. "$(@D)" is the build directory.
MOD_ARPEGGIATOR_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true HAVE_CAIRO=false HAVE_GL=false -C $(@D)

define MOD_ARPEGGIATOR_BUILD_CMDS
	$(MOD_ARPEGGIATOR_TARGET_MAKE)
endef

define MOD_ARPEGGIATOR_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/mod-arpeggiator.lv2           $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-arpeggiator.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-arpeggiator.lv2/
endef

$(eval $(generic-package))
