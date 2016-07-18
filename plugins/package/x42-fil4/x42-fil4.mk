######################################
#
# x42-fil4
#
######################################

X42_FIL4_VERSION = f134780092fe07ff5bfc96bb6ad6612c6e53deb6
X42_FIL4_SITE = $(call github,x42,fil4.lv2,$(X42_FIL4_VERSION))
X42_FIL4_DEPENDENCIES = fftwf
X42_FIL4_BUNDLES = fil4.lv2

X42_FIL4_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" BUILDOPENGL=no BUILDGTK=no HAVE_UI=no PREFIX=/usr -C $(@D)

define X42_FIL4_BUILD_CMDS
	$(X42_FIL4_TARGET_MAKE)
endef

define X42_FIL4_INSTALL_TARGET_CMDS
	$(X42_FIL4_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/fil4.lv2/* $(TARGET_DIR)/usr/lib/lv2/fil4.lv2/
endef

$(eval $(generic-package))
