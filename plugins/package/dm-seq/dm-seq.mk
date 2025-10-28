######################################
#
# dm-seq
#
######################################

DM_SEQ_VERSION = 680b9cab50f7dc536a8cde109dceaae7f6a9f393
DM_SEQ_SITE = https://github.com/davemollen/dm-Seq.git
DM_SEQ_SITE_METHOD = git
DM_SEQ_BUNDLES = dm-Seq.lv2

define DM_SEQ_BUILD_CMDS
	rm -f $(@D)/lv2/dm-Seq.lv2/libdm_seq.so
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build $(MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS))
endef

define DM_SEQ_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-Seq.lv2 $(TARGET_DIR)/usr/lib/lv2/
	$(INSTALL) -m 644 $(@D)/lv2/target/$(MOD_PLUGIN_BUILDER_RUST_TARGET)/release/libdm_seq.so $(TARGET_DIR)/usr/lib/lv2/dm-Seq.lv2/
endef

$(eval $(generic-package))
