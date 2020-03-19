######################################
#
# lsp-plugins
#
######################################

LSP_PLUGINS_VERSION = 0c1fac8937456571caec0d0964e6202d2f3a753f
LSP_PLUGINS_SITE = $(call github,sadko4u,lsp-plugins,$(LSP_PLUGINS_VERSION))
LSP_PLUGINS_BUNDLES = lsp-plugins.lv2

ifdef BR2_cortex_a7
LSP_PLUGINS_BUILD_PROFILE = "armv7ve"
endif

ifdef BR2_cortex_a53
LSP_PLUGINS_BUILD_PROFILE = "aarch64"
endif

LSP_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) \
	$(MAKE) -C $(@D) \
	BUILD_MODULES=lv2 BUILD_PROFILE=$(LSP_PLUGINS_BUILD_PROFILE) BUILD_R3D_BACKENDS= \
	LV2_UI=0 PREFIX=/usr XLIB_HEADERS= XLIB_LIBS=

define LSP_PLUGINS_BUILD_CMDS
	$(LSP_PLUGINS_TARGET_MAKE)
endef

define LSP_PLUGINS_INSTALL_TARGET_CMDS
	$(LSP_PLUGINS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
# 	cp -rL $($(PKG)_PKGDIR)/lsp-plugins.lv2/* $(TARGET_DIR)/usr/lib/lv2/lsp-plugins.lv2/
endef

$(eval $(generic-package))
