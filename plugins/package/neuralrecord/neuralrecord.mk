######################################
#
# neuralrecord
#
######################################

NEURALRECORD_VERSION = 91d7551190bc796b0f1ed4a397b6ce6de33ae158
NEURALRECORD_SITE = https://github.com/brummer10/neuralrecord.git
NEURALRECORD_BUNDLES = neuralrecord.lv2

NEURALRECORD_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

# needed for git submodules
define NEURALRECORD_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive $(NEURALRECORD_SITE) $(@D)
	(cd $(@D) && \
		git reset --hard $(NEURALRECORD_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef


define NEURALRECORD_BUILD_CMDS
	$(NEURALRECORD_TARGET_MAKE) mod
endef

define NEURALRECORD_INSTALL_TARGET_CMDS
	$(NEURALRECORD_TARGET_MAKE) install-mod DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
