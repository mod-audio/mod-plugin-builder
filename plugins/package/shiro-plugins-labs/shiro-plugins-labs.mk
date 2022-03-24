######################################
#
# shiro-plugins-labs
#
######################################

SHIRO_PLUGINS_LABS_VERSION = 60a678ca6abdb7fa10b0ac8dd87e0e41052abe78
SHIRO_PLUGINS_LABS_SITE = $(call github,ninodewit,SHIRO-Plugins,$(SHIRO_PLUGINS_LABS_VERSION))
SHIRO_PLUGINS_LABS_BUNDLES = Pitchotto.lv2

SHIRO_PLUGINS_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

# needed for git submodules
define SHIRO_PLUGINS_LABS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone https://github.com/ninodewit/SHIRO-Plugins.git $(@D)
	git clone https://github.com/DISTRHO/DPF.git $(@D)/dpf
	(cd $(@D) && \
		git reset --hard $(SHIRO_PLUGINS_LABS_VERSION) && \
		git submodule init && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define SHIRO_PLUGINS_LABS_BUILD_CMDS
	$(SHIRO_PLUGINS_LABS_TARGET_MAKE)
endef

define SHIRO_PLUGINS_LABS_INSTALL_TARGET_CMDS
	$(SHIRO_PLUGINS_LABS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/Pitchotto.lv2/* $(TARGET_DIR)/usr/lib/lv2/Pitchotto.lv2/
endef

$(eval $(generic-package))
