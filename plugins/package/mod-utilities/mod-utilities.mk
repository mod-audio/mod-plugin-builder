######################################
#
# mod-utilities
#
######################################

MOD_UTILITIES_VERSION = a5ad804274909b850ada6aeebae981e28a7bc920
MOD_UTILITIES_SITE = $(call github,moddevices,mod-utilities,$(MOD_UTILITIES_VERSION))
MOD_UTILITIES_DEPENDENCIES = alsa-lib
MOD_UTILITIES_BUNDLES = mod-bpf.lv2 mod-bypass.lv2 mod-crossover2.lv2 mod-crossover3.lv2 mod-gain.lv2 mod-gain2x2.lv2 mod-hpf.lv2 mod-lpf.lv2 mod-switchbox2.lv2 mod-switchtrigger4.lv2 mod-toggleswitch4.lv2

MOD_UTILITIES_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true MOD=1 -C $(@D)

define MOD_UTILITIES_BUILD_CMDS
	$(MOD_UTILITIES_TARGET_MAKE)
endef

define MOD_UTILITIES_INSTALL_TARGET_CMDS
	$(MOD_UTILITIES_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/mod-bpf.lv2/*            $(TARGET_DIR)/usr/lib/lv2/mod-bpf.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-bypass.lv2/*         $(TARGET_DIR)/usr/lib/lv2/mod-bypass.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-crossover2.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-crossover2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-crossover3.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-crossover3.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-gain.lv2/*           $(TARGET_DIR)/usr/lib/lv2/mod-gain.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-gain2x2.lv2/*        $(TARGET_DIR)/usr/lib/lv2/mod-gain2x2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-hpf.lv2/*            $(TARGET_DIR)/usr/lib/lv2/mod-hpf.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-lpf.lv2/*            $(TARGET_DIR)/usr/lib/lv2/mod-lpf.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-switchbox2.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-switchbox2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-switchtrigger4.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-switchtrigger4.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-toggleswitch4.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-toggleswitch4.lv2/
endef

$(eval $(generic-package))
