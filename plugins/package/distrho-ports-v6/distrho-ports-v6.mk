######################################
#
# distrho-ports-v6
#
######################################

DISTRHO_PORTS_V6_VERSION = 9f93a1966f70d65ad661ce0aeaf70305bc2d9d35
DISTRHO_PORTS_V6_SITE = $(call github,DISTRHO,DISTRHO-Ports,$(DISTRHO_PORTS_V6_VERSION))
DISTRHO_PORTS_V6_DEPENDENCIES = fftw-single
DISTRHO_PORTS_V6_BUNDLES = SwankyAmp.lv2 vitalium.lv2

define DISTRHO_PORTS_V6_CONFIGURE_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) meson setup $(@D)/build $(@D) \
		--buildtype release \
		--prefix /usr \
		-Dlinux-embed=true \
		-Doptimizations=false \
		-Dbuild-lv2=true \
		-Dbuild-vst2=false \
		-Dbuild-vst3=false \
		-Dplugins=swankyamp,vitalium
endef

define DISTRHO_PORTS_V6_BUILD_CMDS
	ninja -C $(@D)/build
endef

define DISTRHO_PORTS_V6_INSTALL_TARGET_CMDS
	DESTDIR=$(TARGET_DIR) ninja -C $(@D)/build install
	cp -rL $($(PKG)_PKGDIR)/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
