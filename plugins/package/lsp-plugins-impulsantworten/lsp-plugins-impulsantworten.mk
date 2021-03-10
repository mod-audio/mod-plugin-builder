######################################
#
# lsp-plugins-impulsantworten
#
######################################

LSP_PLUGINS_IMPULSANTWORTEN_VERSION = 663223c8075c3b4476f06c7d712c2716cec9daa5
LSP_PLUGINS_IMPULSANTWORTEN_SITE = $(call github,sadko4u,lsp-plugins,$(LSP_PLUGINS_IMPULSANTWORTEN_VERSION))
LSP_PLUGINS_IMPULSANTWORTEN_BUNDLES = lsp-plugins-impulsantworten.lv2

ifdef BR2_cortex_a7
LSP_PLUGINS_IMPULSANTWORTEN_BUILD_PROFILE = "armv7ve"
else
LSP_PLUGINS_IMPULSANTWORTEN_BUILD_PROFILE = "aarch64"
endif

LSP_PLUGINS_IMPULSANTWORTEN_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) \
	$(MAKE) -C $(@D) \
	BUILD_MODULES=lv2 \
	BUILD_PROFILE=$(LSP_PLUGINS_IMPULSANTWORTEN_BUILD_PROFILE) \
	BUILD_R3D_BACKENDS= \
	JACK_HEADERS= \
	JACK_LIBS= \
	LV2_UI=0 \
	PREFIX=/usr \
	XLIB_HEADERS= \
	XLIB_LIBS=

define LSP_PLUGINS_IMPULSANTWORTEN_BUILD_CMDS
	$(LSP_PLUGINS_IMPULSANTWORTEN_TARGET_MAKE)
endef

define LSP_PLUGINS_IMPULSANTWORTEN_INSTALL_TARGET_CMDS
	$(LSP_PLUGINS_IMPULSANTWORTEN_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	# Special case needed for renamed bundle
	# 1st, delete target bundle in case it already exists
	rm -rf $(TARGET_DIR)/usr/lib/lv2/$(LSP_PLUGINS_IMPULSANTWORTEN_BUNDLES)/
	# 2nd, rename original bundle to our custom name
	mv $(TARGET_DIR)/usr/lib/lv2/lsp-plugins.lv2 $(TARGET_DIR)/usr/lib/lv2/$(LSP_PLUGINS_IMPULSANTWORTEN_BUNDLES)
	# 3rd, delete all ttl files inside, as it contains plugins we do not want
	rm $(TARGET_DIR)/usr/lib/lv2/$(LSP_PLUGINS_IMPULSANTWORTEN_BUNDLES)/*.ttl
	# 4th, install our custom ttl
	cp -rL $($(PKG)_PKGDIR)/$(LSP_PLUGINS_IMPULSANTWORTEN_BUNDLES)/* $(TARGET_DIR)/usr/lib/lv2/$(LSP_PLUGINS_IMPULSANTWORTEN_BUNDLES)/
endef

$(eval $(generic-package))
