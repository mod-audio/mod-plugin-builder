######################################
#
# x42-zconvo
#
######################################

# NOTE if updating, make sure to revert 2ba6328a4b15cca07d493fa14edcf5ab367b92fc (unwanted in MOD)
X42_ZCONVO_VERSION = f40007767b11b5a1eddbdb1fdc5dc9f1387b45a1
X42_ZCONVO_SITE = $(call github,x42,zconvo.lv2,$(X42_ZCONVO_VERSION))
X42_ZCONVO_DEPENDENCIES = fftw-single libsamplerate libsndfile
X42_ZCONVO_BUNDLES = zeroconvo.lv2

X42_ZCONVO_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only -DNDEBUG" PREFIX=/usr -C $(@D)

define X42_ZCONVO_BUILD_CMDS
	$(X42_ZCONVO_TARGET_MAKE)
endef

define X42_ZCONVO_INSTALL_TARGET_CMDS
	$(X42_ZCONVO_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(TARGET_DIR)/usr/lib/lv2/zeroconvo.lv2/ir
	cp -rL $($(PKG)_PKGDIR)/zeroconvo.lv2/* $(TARGET_DIR)/usr/lib/lv2/zeroconvo.lv2/
endef

$(eval $(generic-package))
