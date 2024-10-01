######################################
#
# dm-rat
#
######################################

DM_RAT_VERSION = e4bd43cc7dba45465e11a894e255cbf1c4d1e503
DM_RAT_SITE = https://github.com/davemollen/dm-Rat.git
DM_RAT_SITE_METHOD = git
DM_RAT_BUNDLES = dm-Rat.lv2

define DM_RAT_BUILD_CMDS
	~/.cargo/bin/rustup default nightly

	rm -f $(@D)/lv2/dm-Rat.lv2/libdm_rat.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))

	~/.cargo/bin/rustup default stable
endef

define DM_RAT_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-Rat.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_rat.so $(TARGET_DIR)/usr/lib/lv2/dm-Rat.lv2/
endef

$(eval $(generic-package))
