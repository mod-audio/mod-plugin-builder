######################################
#
# dm-timewarp
#
######################################

DM_TIMEWARP_VERSION = d9f6bbdf5b99ecb66aae4e5d5067547546c07791
DM_TIMEWARP_SITE = https://github.com/davemollen/dm-TimeWarp.git
DM_TIMEWARP_SITE_METHOD = git
DM_TIMEWARP_BUNDLES = dm-TimeWarp.lv2

define DM_TIMEWARP_BUILD_CMDS
	rm -f $(@D)/lv2/dm-TimeWarp.lv2/libdm_time_warp.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))
endef

define DM_TIMEWARP_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-TimeWarp.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_time_warp.so $(TARGET_DIR)/usr/lib/lv2/dm-TimeWarp.lv2/
endef

$(eval $(generic-package))
