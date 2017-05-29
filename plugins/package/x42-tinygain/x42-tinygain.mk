######################################
#
# x42-tinygain
#
######################################

X42_TINYGAIN_VERSION = 7da2876da03a443cb08b27f0c4d3f24633ed91c4
X42_TINYGAIN_SITE = $(call github,x42,tinyamp.lv2,$(X42_TINYGAIN_VERSION))
X42_TINYGAIN_BUNDLES = tinygain.lv2

X42_TINYGAIN_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" PREFIX=/usr -C $(@D)

define X42_TINYGAIN_BUILD_CMDS
	$(X42_TINYGAIN_TARGET_MAKE)
endef

define X42_TINYGAIN_INSTALL_TARGET_CMDS
	$(X42_TINYGAIN_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
