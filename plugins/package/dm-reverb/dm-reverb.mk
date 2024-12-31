######################################
#
# dm-reverb
#
######################################

DM_REVERB_VERSION = 6d01e3cc8a3bfaf0e74d35783e5f328bdc6be6dc
DM_REVERB_SITE = https://github.com/davemollen/dm-Reverb.git
DM_REVERB_SITE_METHOD = git
DM_REVERB_BUNDLES = dm-Reverb.lv2

define DM_REVERB_BUILD_CMDS
	~/.cargo/bin/rustup default nightly

	rm -f $(@D)/lv2/dm-Reverb.lv2/libdm_reverb.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))

	~/.cargo/bin/rustup default stable
endef

define DM_REVERB_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-Reverb.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_reverb.so $(TARGET_DIR)/usr/lib/lv2/dm-Reverb.lv2/
endef

$(eval $(generic-package))
