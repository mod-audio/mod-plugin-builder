######################################
#
# x42-midigen
#
######################################

X42_MIDIGEN_VERSION = 82a79c0cd3f020de4d3ac2255886c494d8a0bf9a
X42_MIDIGEN_SITE = $(call github,x42,midigen.lv2,$(X42_MIDIGEN_VERSION))
X42_MIDIGEN_BUNDLES = midigen.lv2

X42_MIDIGEN_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE1) OPTIMIZATIONS="-fno-finite-math-only" PREFIX=/usr -C $(@D)

define X42_MIDIGEN_BUILD_CMDS
	$(X42_MIDIGEN_TARGET_MAKE)
endef

define X42_MIDIGEN_INSTALL_TARGET_CMDS
	$(X42_MIDIGEN_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/midigen.lv2/* $(TARGET_DIR)/usr/lib/lv2/midigen.lv2/
endef

$(eval $(generic-package))
