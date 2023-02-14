######################################
#
# dm-graindelay
#
######################################

DM_GRAINDELAY_VERSION = a28fd85b618ceaeab07c0f605c4028e2a956d531
DM_GRAINDELAY_SITE = https://github.com/davemollen/dm-GrainDelay.git
DM_GRAINDELAY_SITE_METHOD = git
DM_GRAINDELAY_BUNDLES = dm-GrainDelay.lv2

ifdef BR2_cortex_a7
DM_GRAINDELAY_RUST_FLAGS = ["-Ctarget-cpu=cortex-a7","-Ctarget-feature=+a7,+neonfp,+vfp4sp"]
DM_GRAINDELAY_RUST_TARGET = armv7-unknown-linux-gnueabihf
else ifdef BR2_cortex_a35
DM_GRAINDELAY_RUST_FLAGS = ["-Ctarget-cpu=cortex-a35","-Ctarget-feature=+a35,-fix-cortex-a53-835769,+neon,+fp-armv8"]
DM_GRAINDELAY_RUST_TARGET = aarch64-unknown-linux-gnu
else ifdef BR2_aarch64
DM_GRAINDELAY_RUST_FLAGS = ["-Ctarget-cpu=cortex-a53","-Ctarget-feature=+a53,+fix-cortex-a53-835769,+neon,+fp-armv8"]
DM_GRAINDELAY_RUST_TARGET = aarch64-unknown-linux-gnu
else ifdef BR2_x86_64
DM_GRAINDELAY_RUST_FLAGS = []
DM_GRAINDELAY_RUST_TARGET = x86_64-unknown-linux-gnu
endif

define DM_GRAINDELAY_CONFIGURE_CMDS
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y --no-modify-path --profile minimal
	~/.cargo/bin/rustup target add $(DM_GRAINDELAY_RUST_TARGET)
endef

define DM_GRAINDELAY_BUILD_CMDS
	(cd $(@D)/lv2 && \
		~/.cargo/bin/cargo build \
			--release \
			--target $(DM_GRAINDELAY_RUST_TARGET) \
			--config 'target.$(DM_GRAINDELAY_RUST_TARGET).rustflags=$(DM_GRAINDELAY_RUST_FLAGS)' \
			--config 'target.$(DM_GRAINDELAY_RUST_TARGET).linker="$(TARGET_CC)"')
endef

define DM_GRAINDELAY_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/lv2
	cp -rv $(@D)/lv2/dm-GrainDelay.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
