######################################
#
# lsp-plugins
#
######################################

LSP_PLUGINS_LABS_VERSION = 6a598435b35e9faf10de621cc40c460021c4eccc
LSP_PLUGINS_LABS_SITE = $(call github,sadko4u,lsp-plugins,$(LSP_PLUGINS_LABS_VERSION))
LSP_PLUGINS_LABS_BUNDLES = lsp-plugins.lv2

ifdef BR2_cortex_a7
LSP_PLUGINS_LABS_BUILD_PROFILE = "armv7ve"
endif

ifdef BR2_cortex_a53
LSP_PLUGINS_LABS_BUILD_PROFILE = "aarch64"
endif

LSP_PLUGINS_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) \
	$(MAKE) -C $(@D) \
	PREFIX=/usr \
	BUILD_MODULES=lv2 BUILD_PROFILE=$(LSP_PLUGINS_LABS_BUILD_PROFILE) \
	BUILD_R3D_BACKENDS= OBJ_UI_CORE= XLIB_HEADERS= XLIB_LIBS=

define LSP_PLUGINS_LABS_BUILD_CMDS
	$(LSP_PLUGINS_LABS_TARGET_MAKE)
endef

define LSP_PLUGINS_LABS_INSTALL_TARGET_CMDS
	$(LSP_PLUGINS_LABS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
# 	cp -rL $($(PKG)_PKGDIR)/lsp-plugins.lv2/* $(TARGET_DIR)/usr/lib/lv2/lsp-plugins.lv2/
endef

$(eval $(generic-package))
