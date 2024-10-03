######################################
#
# dm-stutter
#
######################################

DM_STUTTER_VERSION = e352ade19bdb2b6b66e277fdc0879d4e1a341946
DM_STUTTER_SITE = https://github.com/davemollen/dm-Stutter.git
DM_STUTTER_SITE_METHOD = git
DM_STUTTER_BUNDLES = dm-Stutter.lv2

define DM_STUTTER_BUILD_CMDS
	rm -f $(@D)/lv2/dm-Stutter.lv2/libdm_stutter.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))
endef

define DM_STUTTER_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-Stutter.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_stutter.so $(TARGET_DIR)/usr/lib/lv2/dm-Stutter.lv2/
endef

$(eval $(generic-package))
