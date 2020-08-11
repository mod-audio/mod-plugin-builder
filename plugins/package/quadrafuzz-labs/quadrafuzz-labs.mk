######################################
#
# quadrafuzz-labs
#
######################################

QUADRAFUZZ_LABS_VERSION = a7cc7cba0bef09da9e6443e8967366650a372c37
QUADRAFUZZ_LABS_SITE = $(call github,jpcima,quadrafuzz,$(QUADRAFUZZ_LABS_VERSION))
QUADRAFUZZ_LABS_BUNDLES = quadrafuzz.lv2

QUADRAFUZZ_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

# needed for git submodules
define QUADRAFUZZ_LABS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/jpcima/quadrafuzz $(@D)
	(cd $(@D) && \
		git reset --hard $(QUADRAFUZZ_LABS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define QUADRAFUZZ_LABS_BUILD_CMDS
	$(QUADRAFUZZ_LABS_TARGET_MAKE)
endef

define QUADRAFUZZ_LABS_INSTALL_TARGET_CMDS
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
