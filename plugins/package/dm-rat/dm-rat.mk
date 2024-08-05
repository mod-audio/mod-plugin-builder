######################################
#
# dm-rat
#
######################################

DM_RAT_VERSION = ee6b6ebffde6a3ff9128de1f9e4f37cb0a7f1dc9
DM_RAT_SITE = https://github.com/davemollen/dm-Rat.git
DM_RAT_SITE_METHOD = git
DM_RAT_BUNDLES = dm-Rat.lv2

# Nightly toolchain is needed to enable simd
define DM_RAT_CONFIGURE_CMDS
	~/.cargo/bin/rustup toolchain install nightly-2024-08-07
	~/.cargo/bin/rustup default nightly-2024-08-07
	~/.cargo/bin/rustup target add $(MOD_PLUGIN_BUILDER_RUST_TARGET)
endef

define DM_RAT_BUILD_CMDS
	rm -f $(@D)/lv2/dm-Rat.lv2/libdm_rat.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))
endef

define DM_RAT_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-Rat.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_rat.so $(TARGET_DIR)/usr/lib/lv2/dm-Rat.lv2/
endef

$(eval $(generic-package))
