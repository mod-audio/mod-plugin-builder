######################################
#
# calf
#
######################################

CALF_VERSION = 0.0.60
CALF_SITE = http://calf-studio-gear.org/files/
CALF_SOURCE = calf-$(CALF_VERSION).tar.gz
CALF_DEPENDENCIES = cairo expat libglib2 host-calf
CALF_BUNDLES = 

CALF_HOST_MAKE   = $(HOST_MAKE_ENV)   $(HOST_CONFIGURE_OPTS)   $(MAKE) -C $(@D)
CALF_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

CALF_HOST_MAKERDF = $(HOST_DIR)/calf-host-makerdf

# needed in order to regenerate the configure file
CALF_AUTORECONF = YES

define HOST_CALF_BUILD_CMDS
	# Normal build
	$(CALF_HOST_MAKE) -j $(PARALLEL_JOBS)

	# Save makerdf tool
	cp $(@D)/src/calfmakerdf $(CALF_HOST_MAKERDF)
endef

define CALF_INSTALL_TARGET_CMDS
	# Use host makerdf tool
	cp $(CALF_HOST_MAKERDF) $(@D)/src/calfmakerdf

	# This should work now
	$(CALF_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) -j 1

	# Cleanup
	rm $(CALF_HOST_MAKERDF)

	# Install custom ttl files
	cp -rL $($(PKG)_PKGDIR)/calf.lv2/* $(TARGET_DIR)/usr/lib/lv2/calf.lv2/
endef

$(eval $(autotools-package))
$(eval $(host-autotools-package))
