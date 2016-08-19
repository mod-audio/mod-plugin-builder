######################################
#
# mod-distortion
#
######################################

MOD_DISTORTION_VERSION = 2df0209c516322a087637d43e4194b9922086b9dg
MOD_DISTORTION_SITE_METHOD = local
MOD_DISTORTION_SITE = /home/Jesse/mod-workdir/mod-distortion/
MOD_DISTORTION_BUNDLES = mod-bigmuff.lv2 mod-ds1.lv2

MOD_DISTORTION_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define MOD_DISTORTION_BUILD_CMDS
	$(MOD_DISTORTION_TARGET_MAKE)
endef

define MOD_DISTORTION_INSTALL_TARGET_CMDS
	$(MOD_DISTORTION_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
endef

$(eval $(generic-package))
