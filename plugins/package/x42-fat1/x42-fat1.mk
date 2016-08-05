######################################
#
# x42-fat1
#
######################################

X42_FAT1_VERSION = 699a74881b8253a1662002f50dfedd8981834df1
X42_FAT1_SITE = $(call github,x42,fat1.lv2,$(X42_FAT1_VERSION))
X42_FAT1_DEPENDENCIES = fftwf
X42_FAT1_BUNDLES = fat1.lv2

X42_FAT1_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" BUILDOPENGL=no BUILDJACKAPP=no PREFIX=/usr -C $(@D)

define X42_FAT1_BUILD_CMDS
	$(X42_FAT1_TARGET_MAKE)
endef

define X42_FAT1_INSTALL_TARGET_CMDS
	$(X42_FAT1_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/fat1.lv2/* $(TARGET_DIR)/usr/lib/lv2/fat1.lv2/
endef

$(eval $(generic-package))
