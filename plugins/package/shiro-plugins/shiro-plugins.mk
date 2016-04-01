######################################
#
# shiro-plugins
#
######################################

SHIRO_PLUGINS_VERSION = 7026047bace2d7d9a1da824d127823c3c3125cff
SHIRO_PLUGINS_SITE = $(call github,ninodewit,SHIRO-Plugins,$(SHIRO_PLUGINS_VERSION))
SHIRO_PLUGINS_DEPENDENCIES = host-shiro-plugins
SHIRO_PLUGINS_BUNDLES = Larynx.lv2 Modulay.lv2 Pitchotto.lv2 Shiroverb.lv2

SHIRO_PLUGINS_HOST_MAKE   = $(HOST_MAKE_ENV)   $(HOST_CONFIGURE_OPTS)   $(MAKE) NOOPT=true -C $(@D)
SHIRO_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

SHIRO_PLUGINS_TMP_DIR = $(HOST_DIR)/tmp-shiro-plugins

# needed for git submodules
define SHIRO_PLUGINS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/ninodewit/SHIRO-Plugins $(@D)
	(cd $(@D) && \
		git reset --hard $(SHIRO_PLUGINS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define HOST_SHIRO_PLUGINS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/ninodewit/SHIRO-Plugins $(@D)
	(cd $(@D) && \
		git reset --hard $(SHIRO_PLUGINS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

# build plugins in host to generate ttls
define HOST_SHIRO_PLUGINS_BUILD_CMDS
	# build everything
	$(SHIRO_PLUGINS_HOST_MAKE)

	# delete binaries
	rm $(@D)/bin/*.lv2/*.so

	# create temp dir
	rm -rf $(SHIRO_PLUGINS_TMP_DIR)
	mkdir -p $(SHIRO_PLUGINS_TMP_DIR)

	# copy the generated bundles without binaries to temp dir
	cp -r $(@D)/bin/*.lv2 $(SHIRO_PLUGINS_TMP_DIR)
endef

# build plugins in target skipping ttl generation
define SHIRO_PLUGINS_BUILD_CMDS
	# create dummy generator
	touch $(@D)/dpf/utils/lv2_ttl_generator
	chmod +x $(@D)/dpf/utils/lv2_ttl_generator

	# copy previously generated bundles
	cp -r $(SHIRO_PLUGINS_TMP_DIR)/*.lv2 $(@D)/bin/

	# now build in target
	$(SHIRO_PLUGINS_TARGET_MAKE)

	# cleanup
	rm $(@D)/dpf/utils/lv2_ttl_generator
	rm -r $(SHIRO_PLUGINS_TMP_DIR)
endef

define SHIRO_PLUGINS_INSTALL_TARGET_CMDS
	$(SHIRO_PLUGINS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/Larynx.lv2/*    $(TARGET_DIR)/usr/lib/lv2/Larynx.lv2/
	cp -rL $($(PKG)_PKGDIR)/Modulay.lv2/*   $(TARGET_DIR)/usr/lib/lv2/Modulay.lv2/
	cp -rL $($(PKG)_PKGDIR)/Pitchotto.lv2/* $(TARGET_DIR)/usr/lib/lv2/Pitchotto.lv2/
	cp -rL $($(PKG)_PKGDIR)/Shiroverb.lv2/* $(TARGET_DIR)/usr/lib/lv2/Shiroverb.lv2/
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
