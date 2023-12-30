######################################
#
# shiro-plugins
#
######################################

SHIRO_PLUGINS_VERSION = 60a678ca6abdb7fa10b0ac8dd87e0e41052abe78
SHIRO_PLUGINS_SITE = https://github.com/ninodewit/SHIRO-Plugins.git
SHIRO_PLUGINS_SITE_METHOD = git
SHIRO_PLUGINS_BUNDLES = Harmless.lv2 Larynx.lv2 Modulay.lv2 Shiroverb.lv2
SHIRO_PLUGINS_CXXFLAGS = -std=gnu++11

SHIRO_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

# needed for submodules support
SHIRO_PLUGINS_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define SHIRO_PLUGINS_BUILD_CMDS
	$(SHIRO_PLUGINS_TARGET_MAKE)
endef

define SHIRO_PLUGINS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/Harmless.lv2
	install -d $(TARGET_DIR)/usr/lib/lv2/Larynx.lv2
	install -d $(TARGET_DIR)/usr/lib/lv2/Modulay.lv2
	install -d $(TARGET_DIR)/usr/lib/lv2/Shiroverb.lv2
	install -m 644 $(@D)/bin/Harmless.lv2/*.* $(TARGET_DIR)/usr/lib/lv2/Harmless.lv2/
	install -m 644 $(@D)/bin/Larynx.lv2/*.* $(TARGET_DIR)/usr/lib/lv2/Larynx.lv2/
	install -m 644 $(@D)/bin/Modulay.lv2/*.* $(TARGET_DIR)/usr/lib/lv2/Modulay.lv2/
	install -m 644 $(@D)/bin/Shiroverb.lv2/*.* $(TARGET_DIR)/usr/lib/lv2/Shiroverb.lv2/
	cp -rL $($(PKG)_PKGDIR)/Harmless.lv2/*  $(TARGET_DIR)/usr/lib/lv2/Harmless.lv2/
	cp -rL $($(PKG)_PKGDIR)/Larynx.lv2/*    $(TARGET_DIR)/usr/lib/lv2/Larynx.lv2/
	cp -rL $($(PKG)_PKGDIR)/Modulay.lv2/*   $(TARGET_DIR)/usr/lib/lv2/Modulay.lv2/
	cp -rL $($(PKG)_PKGDIR)/Shiroverb.lv2/* $(TARGET_DIR)/usr/lib/lv2/Shiroverb.lv2/
endef

$(eval $(generic-package))
