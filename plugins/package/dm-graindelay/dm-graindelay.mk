######################################
#
# dm-graindelay
#
######################################

DM_GRAINDELAY_VERSION = 910f0f210a7ac2992d5250952d9bbbd18a5e5962
DM_GRAINDELAY_SITE = https://github.com/davemollen/dm-GrainDelay.git
DM_GRAINDELAY_SITE_METHOD = git
DM_GRAINDELAY_BUNDLES = dm-GrainDelay.lv2

# define DM_GRAINDELAY_CONFIGURE_CMDS
# 	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y --no-modify-path --profile minimal
# 	~/.cargo/bin/rustup target add $(MOD_PLUGIN_BUILDER_RUST_TARGET)
# endef

define DM_GRAINDELAY_BUILD_CMDS
	rm -f $(@D)/lv2/dm-GrainDelay.lv2/libdm_graindelay.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))
endef

define DM_GRAINDELAY_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-GrainDelay.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_graindelay.so $(TARGET_DIR)/usr/lib/lv2/dm-GrainDelay.lv2/
endef

$(eval $(generic-package))
