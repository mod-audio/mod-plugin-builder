######################################
#
# zeroconvo-labs
#
######################################

ZEROCONVO_LABS_VERSION = 35248cdaa4b04fcbdcc0f9a7873cccd066fcf3b6
ZEROCONVO_LABS_SITE = git://gareus.org/zeroconvo.lv2
ZEROCONVO_LABS_SITE_METHOD = git
ZEROCONVO_LABS_BUNDLES = zeroconvo.lv2

# extra IR files not present in source code
ZEROCONVO_LABS_IRS_TARBALL = sisel4-ir.tar.xz
ZEROCONVO_LABS_IRS_URL = https://x42-plugins.com/tmp/$(ZEROCONVO_LABS_IRS_TARBALL)

ZEROCONVO_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) STATICZITA=yes OPTIMIZATIONS="-fno-finite-math-only -DNDEBUG" -C $(@D)


define ZEROCONVO_LABS_BUILD_CMDS
	$(ZEROCONVO_LABS_TARGET_MAKE)

	# Download and import IRs
	(cd $(@D) && \
		wget $(ZEROCONVO_LABS_IRS_URL) && \
		tar xf $(ZEROCONVO_LABS_IRS_TARBALL) && \
		mv sisel4-ir.lv2/*.wav build/ir/ && \
		cat sisel4-ir.lv2/manifest.ttl | tail -n +7 >> build/manifest.ttl && \
		cat sisel4-ir.lv2/presets.ttl | tail -n +10 >> build/presets.ttl && \
		rm -r $(ZEROCONVO_LABS_IRS_TARBALL) sisel4-ir.lv2 \
	)
endef

define ZEROCONVO_LABS_INSTALL_TARGET_CMDS
	$(ZEROCONVO_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr

	# Tweak path in presets
	sed -e "s|#ir> <|#ir> <ir/|" -i $(TARGET_DIR)/usr/lib/lv2/zeroconvo.lv2/presets.ttl
endef

$(eval $(generic-package))
