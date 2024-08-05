######################################
#
# dm-lfo
#
######################################

DM_LFO_VERSION = f9ed8f76f96e993a738f1df19dee42d65439e9be
DM_LFO_SITE = https://github.com/davemollen/dm-LFO.git
DM_LFO_SITE_METHOD = git
DM_LFO_BUNDLES = dm-LFO.lv2

define DM_LFO_CONFIGURE_CMDS
	~/.cargo/bin/rustup default stable
endef

define DM_LFO_BUILD_CMDS
	rm -f $(@D)/lv2/dm-LFO.lv2/libdm_lfo.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))
endef

define DM_LFO_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-LFO.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_lfo.so $(TARGET_DIR)/usr/lib/lv2/dm-LFO.lv2/
endef

$(eval $(generic-package))
