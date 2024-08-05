######################################
#
# dm-tubescreamer
#
######################################

DM_TUBESCREAMER_VERSION = bcedcd32c5ba4b91c8546edb219a3e6f79ee3b87
DM_TUBESCREAMER_SITE = https://github.com/davemollen/dm-TubeScreamer.git
DM_TUBESCREAMER_SITE_METHOD = git
DM_TUBESCREAMER_BUNDLES = dm-TubeScreamer.lv2

# Nightly toolchain is needed to enable simd
define DM_TUBESCREAMER_CONFIGURE_CMDS
	~/.cargo/bin/rustup toolchain install nightly-2024-08-07
	~/.cargo/bin/rustup default nightly-2024-08-07
	~/.cargo/bin/rustup target add $(MOD_PLUGIN_BUILDER_RUST_TARGET)
endef

define DM_TUBESCREAMER_BUILD_CMDS
	rm -f $(@D)/lv2/dm-TubeScreamer.lv2/libdm_tube_screamer.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))
endef

define DM_TUBESCREAMER_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-TubeScreamer.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_tube_screamer.so $(TARGET_DIR)/usr/lib/lv2/dm-TubeScreamer.lv2/
endef

$(eval $(generic-package))
