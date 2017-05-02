######################################
#
# x42-mclk
#
######################################

X42_MCLK_VERSION = e3d22b9a415637c274617fc797474783a5d067f8
X42_MCLK_SITE = $(call github,x42,mclk.lv2,$(X42_MCLK_VERSION))
X42_MCLK_BUNDLES = mclk.lv2

X42_MCLK_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" BUILDOPENGL=no BUILDGTK=no HAVE_UI=no PREFIX=/usr -C $(@D)

define X42_MCLK_BUILD_CMDS
	$(X42_MCLK_TARGET_MAKE)
endef

define X42_MCLK_INSTALL_TARGET_CMDS
	$(X42_MCLK_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
