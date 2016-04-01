######################################
#
# calf-bad
#
######################################

CALF_BAD_VERSION = 0.0.60
CALF_BAD_SITE = http://calf-studio-gear.org/files/
CALF_BAD_SOURCE = calf-$(CALF_BAD_VERSION).tar.gz
CALF_BAD_DEPENDENCIES = cairo expat libglib2 host-calf-bad
CALF_BAD_BUNDLES = 

CALF_BAD_HOST_MAKE   = $(HOST_MAKE_ENV)   $(HOST_CONFIGURE_OPTS)   $(MAKE) -C $(@D)
CALF_BAD_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

CALF_BAD_HOST_MAKERDF = $(HOST_DIR)/calf-host-makerdf

# needed in order to regenerate the configure file
CALF_BAD_AUTORECONF = YES

define HOST_CALF_BAD_BUILD_CMDS
	# Normal build
	$(CALF_BAD_HOST_MAKE) -j $(PARALLEL_JOBS)

	# Save makerdf tool
	cp $(@D)/src/calfmakerdf $(CALF_BAD_HOST_MAKERDF)
endef

define CALF_BAD_INSTALL_TARGET_CMDS
	# Use host makerdf tool
	cp $(CALF_BAD_HOST_MAKERDF) $(@D)/src/calfmakerdf

	# This should work now
	$(CALF_BAD_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) -j 1

	# Cleanup
	rm $(CALF_BAD_HOST_MAKERDF)

	# Install custom ttl files
	mv $(TARGET_DIR)/usr/lib/lv2/calf.lv2 $(TARGET_DIR)/usr/lib/lv2/calf-bad.lv2
	cp -rL $($(PKG)_PKGDIR)/calf-bad.lv2/* $(TARGET_DIR)/usr/lib/lv2/calf-bad.lv2/
endef

$(eval $(autotools-package))
$(eval $(host-autotools-package))
