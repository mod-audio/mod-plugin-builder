######################################
#
# dm-whammy
#
######################################

DM_WHAMMY_VERSION = 76fa750a16bf07a1ed6e551736a138bbabbe067c
DM_WHAMMY_SITE = https://github.com/davemollen/dm-Whammy.git
DM_WHAMMY_SITE_METHOD = git
DM_WHAMMY_BUNDLES = dm-Whammy.lv2

define DM_WHAMMY_BUILD_CMDS
	rm -f $(@D)/lv2/dm-Whammy.lv2/libdm_whammy.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))
endef

define DM_WHAMMY_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-Whammy.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_whammy.so $(TARGET_DIR)/usr/lib/lv2/dm-Whammy.lv2/
endef

$(eval $(generic-package))
