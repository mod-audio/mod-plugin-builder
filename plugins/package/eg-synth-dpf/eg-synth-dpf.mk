######################################
#
# eg-synth-dpf
#
######################################

# where to find the source code - locally in this case
EG_SYNTH_DPF_SITE_METHOD = local
EG_SYNTH_DPF_SITE = $($(PKG)_PKGDIR)/

# even though this is a local build, we still need a version number
# bump this number if you need to force a rebuild
EG_SYNTH_DPF_VERSION = 1

# dependencies (list of other buildroot packages, separated by space)
# on this package we need to depend on the host version of ourselves to be able to run the ttl generator
EG_SYNTH_DPF_DEPENDENCIES = host-eg-synth-dpf

# LV2 bundles that this package generates (space separated list)
EG_SYNTH_DPF_BUNDLES = DPF-Synth.lv2

# call make with the current arguments and path. "$(@D)" is the build directory.
EG_SYNTH_DPF_HOST_MAKE   = $(HOST_MAKE_ENV)   $(HOST_CONFIGURE_OPTS)   $(MAKE) -C $(@D)/source
EG_SYNTH_DPF_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/source

# temp dir where we place the generated ttls
EG_SYNTH_DPF_TMP_DIR = $(HOST_DIR)/tmp-eg-synth-dpf


# build plugins in host to generate ttls
define HOST_EG_SYNTH_DPF_BUILD_CMDS
	# build everything
	$(EG_SYNTH_DPF_HOST_MAKE)

	# delete binaries
	rm $(@D)/source/build/*.lv2/*.so

	# create temp dir
	rm -rf $(EG_SYNTH_DPF_TMP_DIR)
	mkdir -p $(EG_SYNTH_DPF_TMP_DIR)

	# copy the generated bundles without binaries to temp dir
	cp -r $(@D)/source/build/*.lv2 $(EG_SYNTH_DPF_TMP_DIR)
endef

# build plugins in target skipping ttl generation
define EG_SYNTH_DPF_BUILD_CMDS
	# create dummy generator
	mkdir -p $(@D)/source/build
	touch $(@D)/source/build/lv2_ttl_generator
	chmod +x $(@D)/source/build/lv2_ttl_generator

	# copy previously generated bundles
	cp -r $(EG_SYNTH_DPF_TMP_DIR)/*.lv2 $(@D)/source/build/

	# now build in target
	$(EG_SYNTH_DPF_TARGET_MAKE)

	# cleanup
	rm $(@D)/source/build/lv2_ttl_generator
	rm -r $(EG_SYNTH_DPF_TMP_DIR)
endef

# install command
define EG_SYNTH_DPF_INSTALL_TARGET_CMDS
	$(EG_SYNTH_DPF_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef


# import everything else from the buildroot generic package
$(eval $(generic-package))
# import host version too
$(eval $(host-generic-package))
