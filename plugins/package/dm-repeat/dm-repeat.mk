######################################
#
# dm-repeat
#
######################################

DM_REPEAT_VERSION = ebe7d6f1ea3e0412169e8356a153c7c0e4fb770d
DM_REPEAT_SITE = https://github.com/davemollen/dm-Repeat.git
DM_REPEAT_SITE_METHOD = git
DM_REPEAT_BUNDLES = dm-Repeat.lv2

define DM_REPEAT_BUILD_CMDS
	rm -f $(@D)/lv2/dm-Repeat.lv2/libdm_repeat.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))
endef

define DM_REPEAT_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-Repeat.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_repeat.so $(TARGET_DIR)/usr/lib/lv2/dm-Repeat.lv2/
endef

$(eval $(generic-package))
