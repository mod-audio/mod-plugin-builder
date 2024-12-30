######################################
#
# dm-spaceecho
#
######################################

DM_SPACEECHO_VERSION = 2f2373601ec5480c234aa07ad8d4ca90debad3b2
DM_SPACEECHO_SITE = https://github.com/davemollen/dm-SpaceEcho.git
DM_SPACEECHO_SITE_METHOD = git
DM_SPACEECHO_BUNDLES = dm-SpaceEcho.lv2

define DM_SPACEECHO_BUILD_CMDS
	~/.cargo/bin/rustup default nightly

	rm -f $(@D)/lv2/dm-SpaceEcho.lv2/libdm_space_echo.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))

	~/.cargo/bin/rustup default stable
endef

define DM_SPACEECHO_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-SpaceEcho.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_space_echo.so $(TARGET_DIR)/usr/lib/lv2/dm-SpaceEcho.lv2/
endef

$(eval $(generic-package))
