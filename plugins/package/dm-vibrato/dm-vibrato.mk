######################################
#
# dm-vibrato
#
######################################

DM_VIBRATO_VERSION = 47b2454afe37cf7d85f079e911fcbec433fc0b8d
DM_VIBRATO_SITE = https://github.com/davemollen/dm-Vibrato.git
DM_VIBRATO_SITE_METHOD = git
DM_VIBRATO_BUNDLES = dm-Vibrato.lv2

define DM_VIBRATO_BUILD_CMDS
	rm -f $(@D)/lv2/dm-Vibrato.lv2/libdm_vibrato.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))
endef

define DM_VIBRATO_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-Vibrato.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_vibrato.so $(TARGET_DIR)/usr/lib/lv2/dm-Vibrato.lv2/
endef

$(eval $(generic-package))
