######################################
#
# dpf-plugins
#
######################################

DPF_PLUGINS_VERSION = 0e92714525c0334908a0eb79d6760e06316c2148
DPF_PLUGINS_SITE = $(call github,DISTRHO,DPF-Plugins,$(DPF_PLUGINS_VERSION))
DPF_PLUGINS_BUNDLES = Kars.lv2 MVerb.lv2 Nekobi.lv2 PingPongPan.lv2

DPF_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) CROSS_COMPILING=true NOOPT=true HAVE_CAIRO=false HAVE_DGL=false HAVE_OPENGL=false -C $(@D)

define DPF_PLUGINS_BUILD_CMDS
	$(DPF_PLUGINS_TARGET_MAKE)
endef

define DPF_PLUGINS_INSTALL_TARGET_CMDS
	$(DPF_PLUGINS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/Kars.lv2/*             $(TARGET_DIR)/usr/lib/lv2/Kars.lv2/
	cp -rL $($(PKG)_PKGDIR)/MVerb.lv2/*            $(TARGET_DIR)/usr/lib/lv2/MVerb.lv2/
	cp -rL $($(PKG)_PKGDIR)/Nekobi.lv2/*           $(TARGET_DIR)/usr/lib/lv2/Nekobi.lv2/
	cp -rL $($(PKG)_PKGDIR)/PingPongPan.lv2/*      $(TARGET_DIR)/usr/lib/lv2/PingPongPan.lv2/
endef

$(eval $(generic-package))
