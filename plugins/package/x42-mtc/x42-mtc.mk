######################################
#
# x42-mtc
#
######################################

X42_MTC_VERSION = 917a8a60f6262c3ac870deb03596312f84acef69
X42_MTC_SITE = $(call github,x42,mtc.lv2,$(X42_MTC_VERSION))
X42_MTC_BUNDLES = mtc.lv2

X42_MTC_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" BUILDOPENGL=no BUILDGTK=no HAVE_UI=no PREFIX=/usr -C $(@D)

define X42_MTC_BUILD_CMDS
	$(X42_MTC_TARGET_MAKE)
endef

define X42_MTC_INSTALL_TARGET_CMDS
	$(X42_MTC_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
