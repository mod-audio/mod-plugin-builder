######################################
#
# mod-plugin-builder
#
######################################

MOD_PLUGIN_BUILDER_VERSION = 1
MOD_PLUGIN_BUILDER_SOURCE = .
MOD_PLUGIN_BUILDER_SITE = .
MOD_PLUGIN_BUILDER_SITE_METHOD = file
MOD_PLUGIN_BUILDER_DEPENDENCIES = host-cmake

ifdef BR2_cortex_a7
MOD_PLUGIN_BUILDER_RUST_FLAGS = ["-Ctarget-cpu=cortex-a7","-Ctarget-feature=+a7,+neonfp,+vfp4sp"]
MOD_PLUGIN_BUILDER_RUST_TARGET = armv7-unknown-linux-gnueabihf
else ifdef BR2_cortex_a35
MOD_PLUGIN_BUILDER_RUST_FLAGS = ["-Ctarget-cpu=cortex-a35","-Ctarget-feature=+a35,-fix-cortex-a53-835769,+neon,+fp-armv8"]
MOD_PLUGIN_BUILDER_RUST_TARGET = aarch64-unknown-linux-gnu
else ifdef BR2_aarch64
MOD_PLUGIN_BUILDER_RUST_FLAGS = ["-Ctarget-cpu=cortex-a53","-Ctarget-feature=+a53,+fix-cortex-a53-835769,+neon,+fp-armv8"]
MOD_PLUGIN_BUILDER_RUST_TARGET = aarch64-unknown-linux-gnu
else ifdef BR2_x86_64
MOD_PLUGIN_BUILDER_RUST_FLAGS = []
MOD_PLUGIN_BUILDER_RUST_TARGET = x86_64-unknown-linux-gnu
endif

MOD_PLUGIN_BUILDER_RUST_BUILD_FLAGS = --release \
	--target $(MOD_PLUGIN_BUILDER_RUST_TARGET) \
	--config 'target.$(MOD_PLUGIN_BUILDER_RUST_TARGET).rustflags=$(MOD_PLUGIN_BUILDER_RUST_FLAGS)' \
	--config 'target.$(MOD_PLUGIN_BUILDER_RUST_TARGET).linker="$(TARGET_CC)"'

define MOD_PLUGIN_BUILDER_EXTRACT_CMDS
endef

define MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES
	if [ ! -e $($(PKG)_DL_DIR).tar.gz ]; then                             \
		rm -rf $(@D);                                                 \
		git clone --recursive $($(PKG)_SITE) $(@D);                   \
		git -C $(@D) reset --hard $($(PKG)_VERSION);                  \
		git -C $(@D) submodule update --init --recursive;             \
		tar --exclude=".git" -czf $($(PKG)_DL_DIR).tar.gz -C $(@D) .; \
		touch $(@D)/.stamp_downloaded $(@D)/.stamp_extracted;         \
	fi
endef

$(eval $(generic-package))
