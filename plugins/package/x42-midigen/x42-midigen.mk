######################################
#
# x42-midigen
#
######################################

X42_MIDIGEN_VERSION = b95a0af1523c14ce4481daa9792ed9619832e7a3
X42_MIDIGEN_SITE = $(call github,x42,midigen.lv2,$(X42_MIDIGEN_VERSION))
X42_MIDIGEN_BUNDLES = midigen.lv2

X42_MIDIGEN_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" BUILDOPENGL=no BUILDGTK=no HAVE_UI=no PREFIX=/usr -C $(@D)

define X42_MIDIGEN_BUILD_CMDS
	$(X42_MIDIGEN_TARGET_MAKE)
endef

define X42_MIDIGEN_INSTALL_TARGET_CMDS
	$(X42_MIDIGEN_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/midigen.lv2/* $(TARGET_DIR)/usr/lib/lv2/midigen.lv2/
endef

$(eval $(generic-package))
