######################################
#
# x42-xfade
#
######################################

X42_XFADE_VERSION = 96a0d05a002829b1bb59c0e260adbb8a2fb36d11
X42_XFADE_SITE = $(call github,x42,xfade.lv2,$(X42_XFADE_VERSION))
X42_XFADE_BUNDLES = xfade.lv2

X42_XFADE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" BUILDOPENGL=no BUILDGTK=no HAVE_UI=no PREFIX=/usr -C $(@D)

define X42_XFADE_BUILD_CMDS
	$(X42_XFADE_TARGET_MAKE)
endef

define X42_XFADE_INSTALL_TARGET_CMDS
	$(X42_XFADE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/xfade.lv2/* $(TARGET_DIR)/usr/lib/lv2/xfade.lv2/
endef

$(eval $(generic-package))
