######################################
#
# x42-mtc
#
######################################

X42_MTC_VERSION = c34f31bd14f9e8105d093377119c633fbb1bd1fb
X42_MTC_SITE = $(call github,x42,mtc.lv2,$(X42_MTC_VERSION))
X42_MTC_BUNDLES = mtc.lv2

X42_MTC_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" BUILDOPENGL=no BUILDGTK=no HAVE_UI=no PREFIX=/usr -C $(@D)

define X42_MTC_BUILD_CMDS
	$(X42_MTC_TARGET_MAKE)
endef

define X42_MTC_INSTALL_TARGET_CMDS
	$(X42_MTC_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/mtc.lv2/* $(TARGET_DIR)/usr/lib/lv2/mtc.lv2/
endef

$(eval $(generic-package))
