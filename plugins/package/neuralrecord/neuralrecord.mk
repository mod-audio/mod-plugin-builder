######################################
#
# neuralrecord
#
######################################

NEURALRECORD_VERSION = 92d50ec48554256e25b0b5918d3699fabae14f56
NEURALRECORD_SITE = https://github.com/brummer10/neuralrecord.git
NEURALRECORD_SITE_METHOD = git
NEURALRECORD_BUNDLES = neuralrecord.lv2

# needed for submodules support
NEURALRECORD_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

NEURALRECORD_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) NOOPT=true

define NEURALRECORD_BUILD_CMDS
	$(NEURALRECORD_TARGET_MAKE) mod
endef

define NEURALRECORD_INSTALL_TARGET_CMDS
	$(NEURALRECORD_TARGET_MAKE) install-mod DESTDIR=$(TARGET_DIR) LV2_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
